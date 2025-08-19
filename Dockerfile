FROM python:3.11

# ===============================
# Install Python deps utama
# ===============================
RUN pip install --upgrade pip \
    && pip install --no-cache-dir \
        jupyterlab \
        jupyter_kernel_gateway \
        ipykernel \
        ploomber \
        ploomber-engine \
        matplotlib seaborn plotly \
        pandas numpy scipy scikit-learn \
        pygraphviz tqdm rich \
        dvc[all] papermill \
        requests pyyaml sqlalchemy joblib \
        jupyter_collaboration \
        pyTelegramBotAPI \
        psutil

# ===============================
# Copy requirements project (opsional)
# ===============================
COPY requirements.txt /tmp/requirements.txt
RUN if [ -s /tmp/requirements.txt ]; then pip install --no-cache-dir -r /tmp/requirements.txt; fi

# ===============================
# Copy Jupyter server config
# ===============================
COPY jupyter_server_config.py /root/.jupyter/jupyter_server_config.py

# ===============================
# Workdir
# ===============================
WORKDIR /app

# ===============================
#
