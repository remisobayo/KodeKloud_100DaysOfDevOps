# Use an official Python runtime as a base image
FROM python:3.11-slim

# Set working directory in the container
WORKDIR /python_app

# Copy requirements file
COPY src/requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY src/ .

# Expose port 5002
EXPOSE 5002

# Command to run the application
CMD ["python", "server.py"]