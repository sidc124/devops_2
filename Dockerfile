FROM python:3.11-alpine
WORKDIR /app
COPY app.py .
USER 10001
CMD ["python", "app.py"]
