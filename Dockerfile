FROM python:3.11.1-alpine3.17 AS build

ENV PYTHONUNBUFFERED=1

COPY ./requirements.txt /requirements.txt

RUN apk add --update --no-cache postgresql-client build-base postgresql-dev

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /requirements.txt

FROM python:3.11.1-alpine3.17

ENV PYTHONUNBUFFERED=1

COPY --from=build /py /py

RUN apk add --update --no-cache postgresql-client

RUN adduser -D user
USER user

COPY --chown=user:user ./scripts /scripts
RUN chmod +x /scripts/*

ENV PATH="/scripts:py/bin:$PATH"

COPY --chown=user:user ./app /app
WORKDIR /app

EXPOSE 80

CMD ["/scripts/run.sh"]