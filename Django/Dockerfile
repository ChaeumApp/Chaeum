FROM python:3.11.4
RUN apk add gcc musl-dev

COPY . /app
WORKDIR /app
RUN python3 -m venv venv && . venv/bin/activate
RUN pip3 install -r requirements.txt

WORKDIR /app/mysite
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
EXPOSE 8000