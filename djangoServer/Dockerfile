FROM python:3.11.4

COPY . /app
WORKDIR /app

RUN apt-get -y update
RUN apt-get -y install vim

RUN pip3 install -r requirements.txt

# Make sure the entrypoint.sh file is executable
RUN chmod +x entrypoint.sh

RUN exec python manage.py migrate

EXPOSE 8000

ENTRYPOINT [ "python", "manage.py", "runserver", "0.0.0.0:8000"]