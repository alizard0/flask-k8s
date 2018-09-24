FROM python:2.7-alpine
MAINTAINER Andre Lizardo <me@lizardo.xyz>

RUN mkdir -p /usr/src/ws
WORKDIR /usr/src/ws

COPY requirements.txt /usr/src/ws/
RUN pip install --no-cache-dir -r requirements.txt

COPY ws.py /usr/src/ws
EXPOSE 5000

CMD ["python", "ws.py"]
