FROM python:3.11

# Install system dependencies for building Python packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        graphviz \
        libgraphviz-dev \
        build-essential \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip and install Python packages from requirements.txt
COPY requirements.txt /tmp/requirements.txt
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r /tmp/requirements.txt

# Expose port 80 (required by platform)
EXPOSE 80

# Command to run the application
ENTRYPOINT ["streamlit", "run", "app.py", "--server.port=80", "--server.address=0.0.0.0"]
