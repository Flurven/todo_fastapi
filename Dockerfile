FROM mcr.microsoft.com/devcontainers/python:0-3.11

ENV PYTHONUNBUFFERED 1

#This if for railway deployment only
WORKDIR /code/app

# [Optional] If your requirements rarely change, uncomment this section to add them to the image.
COPY ./requirements.txt /code/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# COPY requirements.txt /tmp/pip-tmp/
# RUN pip3 --disable-pip-version-check --no-cache-dir install -r /tmp/pip-tmp/requirements.txt \
#     && rm -rf /tmp/pip-tmp

# [Optional] Uncomment this section to install additional OS packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
     && apt-get -y install --no-install-recommends libsqlite3-dev
# RUN apt-get update && apt-get upgrade 
# && sudo apt-get install libsqlite3-dev && sudo apt-get install sqlite3

# Next section is for Railway deployment setup
COPY ./app /code/app

# CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
CMD uvicorn main:app --host 0.0.0.0 --port $PORT

