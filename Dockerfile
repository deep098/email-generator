FROM python:3.13

RUN apt-get update && apt-get install -y --no-install-recommends  \
    curl libpq-dev gcc build-essential && \
    pip3 install --upgrade setuptools &&\
    python -m pip install --upgrade pip

RUN curl -sSL https://install.python-poetry.org | python3 -
RUN poetry config virtualenvs.create false
RUN apt-get clean

WORKDIR /home

COPY poetry.lock pyproject.toml /home/
COPY ./src /home/src
COPY ./README.md /home/

RUN poetry install
COPY ./test_file.py /home/
CMD [ "poetry run test_file" ]