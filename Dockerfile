# IMAGE PULL
FROM python:3.11

# # FILE MOVE
# COPY src ./src
# COPY ./requirements.txt ./
# COPY src/app/main.py ./

# Install the PostgreSQL development libraries
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /app

# Copy the requirements folder into the container
COPY requirements /app/requirements

# Install the dependencies specified in the local.txt, base.txt, and prod.txt files
RUN pip install --no-cache-dir -r requirements/local.txt \
    && pip install --no-cache-dir -r requirements/base.txt \
    && pip install --no-cache-dir -r requirements/production.txt

# Copy the rest of the application code into the container
COPY . .

# ENVIRONMENT SETUP - SERVER
ENV MONEY_MITRA_ACTIVE_PROFILE=dev
EXPOSE 8000

# ACTIONABLE
ENTRYPOINT python main.py

