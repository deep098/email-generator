FROM python:3.13

RUN python -m pip install --upgrade pip

RUN pip install poetry
RUN poetry config virtualenvs.create false
RUN apt-get clean

WORKDIR /home

COPY poetry.lock pyproject.toml /home/
COPY ./src /home/src
COPY ./README.md /home/

RUN poetry install
COPY ./test_file.py /home/
CMD [ "poetry" ,"run", "python", "test_file.py" ]