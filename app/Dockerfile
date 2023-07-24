FROM python:3
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /home/ubuntu/python/
COPY . /home/ubuntu/python/

RUN pip install -r requirements.txt
RUN sed -i "s/ALLOWED_HOSTS = \[\]/ALLOWED_HOSTS = \['*'\]/" setup/settings.py
RUN python3 manage.py migrate
RUN python3 manage.py loaddata clientes.json

ENTRYPOINT python3 manage.py runserver 0.0.0.0:8000
EXPOSE 8000