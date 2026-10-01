FROM python:3.12-alpine
RUN addgroup -S weblab && adduser -S -G weblab -u 10001 weblab
WORKDIR /app
COPY --chown=weblab:weblab app.py /app/app.py
ENV PYTHONUNBUFFERED=1
USER weblab
EXPOSE 8080
HEALTHCHECK --interval=10s --timeout=3s --retries=5 CMD python3 -c "import urllib.request; urllib.request.urlopen('http://127.0.0.1:8080/healthz', timeout=2).read()"
CMD ["python3", "/app/app.py"]
