# image to use
FROM mcr.microsoft.com/devcontainers/python:3.11

# where to work
WORKDIR /app

# copy and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# copy
COPY . .

# command
CMD [ "python" , "src/main.py"]
