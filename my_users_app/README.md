# Welcome to My Users App
My User App
***qwasar***

## Task
For each exercise, you will have to create a folder and in this folder, you will have additional files that contain your work. 
Folder names are provided at the beginning of each exercise under submit directory and specific file names for each exercise are also provided at the beginning of each exercise under submit file(s).

***qwasar***

## Description
Create a class User, it will be your interface in order to
create user
find user
get all users
update user
destroy user in sqlite.
You will use the gem sqlite3.
The sqlite filename will be named db.sql.

***qwasar***

## Installation
Your table will be name users and will have multiple attributes:
firstname as string
lastname as string
age as integer
password as string
email as string

***qwasar***

## Usage
Your class will have the following methods:
def create(user_info)
It will create a user. User info will be: firstname, lastname, age, password and email
And it will return a unique ID (a positive integer)
def find(user_id)
It will retrieve the associated user and return all information contained in the database.
def all
It will retrieve all users and return a hash of users.
def update(user_id, attribute, value)
It will retrieve the associated user, update the attribute send as parameter with the value and return the user hash.
def destroy(user_id)
It will retrieve the associated user and destroy it from your database.

***qwasar***

```
./my_project argument1 argument2
```

### The Core Team


<span><i>Made at <a href='https://qwasar.io'>Qwasar SV -- Software Engineering School</a></i></span>
<span><img alt='Qwasar SV -- Software Engineering School's Logo' src='https://storage.googleapis.com/qwasar-public/qwasar-logo_50x50.png' width='20px'></span>
