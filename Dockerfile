FROM ubuntu:24.04

# ================================
# Update OS & install dependencies
# ================================
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 python3-pip python3-venv \
    wget bash curl sudo screen git ca-certificates \
    libomp-dev libomp5 libjansson4 \
    libcurl4-openssl-dev build-essential \
    ocl-icd-opencl-dev \
    graphviz pandoc tini \
    && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g pm2 \
    && rm -rf /var/lib/apt/lists/*

# ================================
# Install Python deps (PyTorch + Ploomber + Data stack)
# ================================
RUN python3 -m pip install --upgrade pip \
    && pip install \
        torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118 \
        jupyter_kernel_gateway ipykernel jupyterlab \
        ploomber ploomber-engine \
        matplotlib seaborn plotly \
        pandas numpy scipy scikit-learn \
        pygraphviz tqdm rich \
        dvc[all] papermill \
        requests pyyaml sqlalchemy joblib

# ================================
# Copy requirements.txt (opsional project-specific)
# ================================
COPY requirements.txt /tmp/requirements.txt
RUN if [ -s /tmp/requirements.txt ]; then pip install -r /tmp/requirements.txt; fi

# ================================
# Set working directory
# ================================
WORKDIR /app

# ================================
# Expose port 80 (Kernel Gateway)
# ================================
EXPOSE 80

# ================================
# Entrypoint: Jupyter Kernel Gateway
# ================================
CMD ["jupyter", "kernelgateway", "--KernelGatewayApp.ip=0.0.0.0", "--KernelGatewayApp.port=80", "--KernelGatewayApp.allow_stdin=True"]
