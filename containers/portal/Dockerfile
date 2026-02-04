# n01d-portal - Container Management Dashboard
# bad-antics

FROM python:3.11-slim

LABEL maintainer="bad-antics"
LABEL description="n01d-portal - Unified Docker Container Dashboard"

WORKDIR /app

# Install dependencies
RUN pip install --no-cache-dir \
    flask \
    flask-socketio \
    docker \
    gunicorn \
    eventlet

# Copy application
COPY app.py .
COPY templates templates/

# Expose port
EXPOSE 8888

# Run with gunicorn for production
CMD ["gunicorn", "--worker-class", "eventlet", "-w", "1", "-b", "0.0.0.0:8888", "app:app"]
