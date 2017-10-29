# Backend

## Installation
Make sure you have a node version supporting ecmascript 6 (6.11.3 recommended), and npm.
In the root directory:
```bash
$ npm install
```

You also need mysql and an account with a password (tested with mysql-server version 5.7).
```bash
$ sudo apt install mysql-server
```

once done that, enter to mysql cli and execute the config/create_db.sql script to
create the databases, tables and populate them. If you run the script again it will
wipe the existing data and create everything again.

```bash
$ mysql -u root -p'root_password_here'
mysql> source config/create_db.sql
```

Now with `npm start` the server should start in port 3000.

## Routes
- / (GET)
  + A list of all registered users (for debuging).
    - {Users: []}
- /signup (POST)
  + Creates a new user if it's a preregistered student.
  + Receives a json of the form:
    - {"id": "A0XXXXX", "email": "email@email.com", "password": "secretish_pass"}
  + Returns the token and user email:
    - {"token": "*token*", "user": "email@email.com"}

- /login (POST)
  + Returns a token that can be used to access protected resources.
    - {"token": "*token*"}
  + Receives a json of the form:
    - {"email": "email@email.com", "password": "secretish_pass"}
- /api/routes (GET)
  + A token is needed in a header with the name "x-access-token".
  + Returs a list of all bus routes.

- /api/admin/register (POST)
  + A token with admin privileges is needed in a header with the name "x-access-token".
  + Receives a json of the form:
    - {"id": "A0XXXXX", "email": "email@email.com", "password": "secretish_pass", "role": "student|admin|driver"}
  + Returns the token and user email:
    - {"token": "*token*", "user": "email@email.com"}
