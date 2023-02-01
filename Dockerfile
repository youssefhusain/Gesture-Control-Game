FROM python:3.10-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libopencv-core-dev \
    libopencv-highgui-dev \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip and install numpy first (critical for mediapipe)
RUN pip install --upgrade pip && \
    pip install numpy==1.23.5  # Specific version that works with Python 3.10

# Install remaining requirements
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]