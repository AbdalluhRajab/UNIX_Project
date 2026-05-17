# UNIX Project Recommendation App

## Overview

This project is a simple recommendation web application

The user enters a keyword and the system returns a related recommendation from the database

Example

Input hot  
Output Summer

## Project Idea

The application stores keywords and recommendations in a MySQL database

The user writes a keyword in the web page

PHP connects to the database and searches for the keyword

If the keyword exists the recommendation is shown

If the keyword does not exist a message is shown

## Technologies Used

PHP  
MySQL  
Apache  
Docker  
Docker Compose  
Jenkins  
Git  
GitHub  
Bash scripts

## Main Files

db init sql creates the database table and inserts sample data

html index php is the main page and contains the form

html db php connects the application to the database

html style css controls the page design

Dockerfile builds the PHP Apache container

docker compose yml runs the web app database and phpMyAdmin

Jenkinsfile contains the CI CD pipeline

scripts as sh changes the Git identity

scripts push sh automates add commit and push

## How To Run

Clone the repository

```bash
git clone https://github.com/AbdalluhRajab/UNIX_Project.git
