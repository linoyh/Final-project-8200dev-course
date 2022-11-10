# Final Project - DevOps Bootcamp 

The final project for 8200dev - bynet course is based on attendance applicaion I developed.
Attendance is an app for calculate the Attendance time rates for the Devops 8200-dev-bynet course participants.


## Technologies in use:

- [![Mysql][mysql.dev]][mysql-url]
- [![Flask][flask.dev]][flask-url]
- [![Docker][docker.dev]][docker-url]
- [![Jenkins][jenkins.dev]][jenkins-url]
- [![Aws][aws.dev]][aws-url]
- [![Virtualbox][virtualbox.dev]][virtualbox-url]

[mysql.dev]:https://img.shields.io/badge/Mysql-DD0031?style=for-the-badge&logo=mysql&logoColor=white&color=orange
[mysql-url]: https://www.mysql.com/

[flask.dev]: https://img.shields.io/badge/Flask-563D7C?style=for-the-badge&logo=flask&logoColor=white&color=black
[flask-url]: https://flask.palletsprojects.com/en/2.2.x/

[docker.dev]: https://img.shields.io/badge/Docker-563D7C?style=for-the-badge&logo=docker&logoColor=white&color=9cf 
[docker-url]: https://www.docker.com/

[jenkins.dev]: https://img.shields.io/badge/Jenkins-563D7C?style=for-the-badge&logo=jenkins&logoColor=white&color=red
[jenkins-url]: https://www.jenkins.io/

[aws.dev]: https://img.shields.io/badge/AWS-563D7C?style=for-the-badge&logo=amazon&logoColor=white&color=grey
[aws-url]: https://aws.amazon.com/

[virtualbox.dev]: https://img.shields.io/badge/Virtualbox-563D7C?style=for-the-badge&logo=virtualbox&logoColor=white&color=blue
[virtualbox-url]: https://www.virtualbox.org/


## Installation
cd into the docker-compose direcory location and write the command:

docker-compose up --build

## preparation

####There are 2 docker containers in the project:
#### mysqldb 
pulled from docker hub by docker-compose.
init.sql file do all the db quaries - create linoy_attendance db
using special priviliged user to create attendance_csv table- contain all csv files from the course and final_attendance the main table which contain the proccessed data from the attendance.py script
#### app
created by docker file, build by it and defined in the docker-compose 
 
####Main logics:

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
Contain environment variables for all the scripts and logics 
The file is not uploaded to git hub so all my secrests will be saved
It is cp to test &prod machines in the deploy.sh script

#### deploy.sh 
Usage: deploy.sh [test|prod]

This script deploys the project to test and prod servers 
copy final-project dir on the test or prod server via ssh by scp
ssh to the $machine (test ot prod) and bring the application up
check if the current server is test. if does, runs the test by curl to check if my applicetion is available

#### screenshot of the application
image:
![This ia an image](https://github.com/linoyh/Final-project-8200dev-course/blob/main/screenshots/Attendance-in-browser.JPG)
