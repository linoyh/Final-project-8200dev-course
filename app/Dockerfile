# Use an official Python image from dockerhub
FROM python:3.7-slim
#ENTRYPOINT [ "/bin/bash", "-l", "-c" ]

# Sets the working directory for following COPY and CMD instructions
# creates a directory with this name if it doesn’t exist
WORKDIR /app

#define the env variables flask use
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

# run a linux commands- for neccesary updates
RUN apt-get update -y && apt-get install build-essential -y && apt-get install apt-utils -y && apt-get install libmariadb-dev -y && apt-get install libmariadb-dev-compat -y

#create a system unpriviliged user for runing my application 1001 = group id and user id
#RUN addgroup --system --gid 1001 attendance_group && adduser --system --uid 1002 attendance_user --gid 1001
#USER attendance_user

#copy requirements.txt to the container
COPY ./requirements.txt .

#run a linux commands- to install all the requirements packages
RUN pip3 install -r requirements.txt

#exposes the specified port and makes it available only for inter-container communication
EXPOSE 5000

# Run app.py when the container launches by the unpriviliged user
#USER root
#CMD ["chmod", "-R", "777", "/app"]

#USER attendance_user

#copy all project dir into the container
COPY . .

#run the app.py script inside the container
CMD ["python3", "./app.py"]





