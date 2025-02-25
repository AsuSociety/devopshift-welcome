# Dockerfile for Frontend Service
FROM python:3.12

WORKDIR /src
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY src/ .
EXPOSE 5002
CMD ["python", "main.py"]

