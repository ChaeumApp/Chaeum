FROM python:3.11.4

COPY . /app
WORKDIR /app
RUN pip3 install -r requirements.txt

# Make sure the entrypoint.sh file is executable
RUN chmod +x /app/entrypoint.sh

CMD ["entrypoint.sh"]

EXPOSE 8000