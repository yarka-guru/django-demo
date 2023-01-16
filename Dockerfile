FROM python3.11.1-alpine3.17

ENV PYTHONUNBUFFERED=1

COPY ./requirements.txt /requirements.txt

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /requirements.txt

ENV PATH="/py/bin:$PATH"

COPY ./app /app
WORKDIR /app