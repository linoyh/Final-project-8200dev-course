# Final Project - DevOps Bootcamp 

The final project for 8200dev - bynet course is based on attendance applicaion I developed.
Attendance is an app for calculate the Attendance time rates for the Devops 8200-dev-bynet course participants.

### Built With

- [![Mysql][mysql.dev]][mysql-url]
- [![Flask][flask.dev]][flask-url]

[mysql.dev]: https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-X26-Y6XCd7mE8yEQlJfLuFVjf4qpU1FScA&usqp=CAU
[mysql-url]: https://www.mysql.com/

[flask.dev]: https://ih1.redbubble.net/image.2488655049.9084/st,small,75x75-pad,80x80,f8f8f8.jpg
[flask-url]: https://flask.palletsprojects.com/en/2.2.x/

image:
![This ia an image](https://github.com/linoyh/Final-project-8200dev-course/blob/main/screenshots/Attendance-inwin-browser.JPG)

## Technologies in use:
- [![Flask][flask.dev]][flask-url]
Docker, Virtualbox, Flask, Jenkins, AWS
[flask.dev]: https://img.shields.io/badge/Flask-563D7C?style=for-the-badge&logo=flask&logoColor=white
[flask-url]: https://flask.palletsprojects.com/en/2.2.x/

## Installation
cd into the docker-compose direcory location and write the command:

docker-compose up --build

## preparation

There are 2 docker containers in the project:
#### mysqldb 
pulled from docker hub by docker-compose.
init.sql file do all the db quaries - create linoy_attendance db
using special priviliged user to create attendance_csv table- contain all csv files from the course and final_attendance the main table which contain the proccessed data from the attendance.py script
#### app
created by docker file, build by it and defined in the docker-compose 
 
#### app.py
activated by the docker file "CMD ["python3", "./app.py"]"

attached to templates directory which contain index.html - our frontend to present the project nicely in the browser
activate 3 scripts:
####* sftp_csv.py- 
takes all the csv files fron the remote course machine into the db container
####* attendance.py-
the main backend script - sum all attendance duration for identical users shown with differant names in all the csv files, calc the % of appearance for each user, write the final csv file to a db table.
####* import_csv_to_db1.py - 
import the final csv file - the final result of the attendance script to the db


#### .env file
Contain  environment variables for all the scripts and logics 

#### deploy.sh 
Usage: deploy.sh [test|prod]

This script deploys the project to test and prod servers 
copy final-project dir on the test or prod server via ssh by scp
copy docker-compose.yaml file to machine final-project dir using scp
ssh to the $machine (test ot prod) and bring the application up
check if the current server is test. if does copy the test.sh script to the project dir and runs it
