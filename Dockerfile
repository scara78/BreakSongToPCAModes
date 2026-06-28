FROM python:3.10-slim

# Instalare dependințe de sistem pentru soundfile
RUN apt-get update && apt-get install -y --no-install-recommends \
    libsndfile1 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Director pentru salvarea locală a fișierelor (poate fi montat ca volum)
RUN mkdir -p /app/outputs

EXPOSE 7860
ENV GRADIO_SERVER_NAME="0.0.0.0"

CMD ["python", "app.py"]