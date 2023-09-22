FROM python:3.11.4

COPY . /app
WORKDIR /app
RUN pip3 install -r requirements.txt

WORKDIR /app
CMD ["python3", "manage.py", "runserver", "0:8000"]
EXPOSE 8000