# Use Python 3.9 slim base image
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the project files into the container
COPY requirements.txt . 

# Install dependencies from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY service/ ./service/

# Create a non-root user and switch to it
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# Expose port
EXPOSE 8080

# Use Gunicorn to serve the Flask app
CMD ["gunicorn", "--bind=0.0.0.0:8080", "service:app"]
