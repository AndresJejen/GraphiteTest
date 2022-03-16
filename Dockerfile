FROM python:alpine
RUN apk update
RUN apk add gcc g++ wget build-base

WORKDIR /app
COPY ./app ./app
COPY ./requirements.txt .
RUN pip install --no-cache-dir -r ./requirements.txt
COPY entrypoint.sh .
EXPOSE 5555
ENTRYPOINT ["sh"]
CMD ["entrypoint.sh"]
