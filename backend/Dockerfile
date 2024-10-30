# Use a lightweight Python image
FROM python:3.10-alpine

# Set the working directory for the container
WORKDIR /app/backend

# Copy the Python dependency file into the container
COPY dependencies.txt .

# Install system dependencies required for your application
RUN apk update && \
    apk add --no-cache gcc musl-dev && \
    pip install --no-cache-dir gunicorn

# Install Python dependencies from requirements
RUN pip install --no-cache-dir -r dependencies.txt

# Copy the entire project into the container
COPY . .

# Copy the wait-for-sqlite.sh script into the container and make it executable
COPY wait-for-sqlite.sh /wait-for-sqlite.sh
RUN chmod +x /wait-for-sqlite.sh

# Copy the entrypoint.sh script into the container and make it executable
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set environment variables
ARG DJANGO_SECRET_KEY
ARG FRONTEND_URL
ENV DJANGO_SECRET_KEY=${DJANGO_SECRET_KEY}
ENV FRONTEND_URL=${FRONTEND_URL}

# Run Django collectstatic command
RUN python manage.py collectstatic --noinput

EXPOSE 8000

# Set the container's entrypoint to the entrypoint.sh script
ENTRYPOINT ["/entrypoint.sh"]
