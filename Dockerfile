FROM python:3.11-slim

WORKDIR /app

# System deps for soundfile (libsndfile)
RUN apt-get update && apt-get install -y --no-install-recommends \
    libsndfile1 \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

# Persistent output directory (mount a volume here in EasyPanel)
RUN mkdir -p /data/outputs

EXPOSE 7860

CMD ["python", "app.py"]
