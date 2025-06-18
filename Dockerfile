FROM python:3
ENV PYTHONUNBUFFERED=1
WORKDIR /app
COPY helpdesk /app 
RUN pip install --upgrade pip
RUN pip3 install -r requirements.txt --no-cache-dir

CMD ["python", "manage.py", "collectstatic", "--noinput"]
