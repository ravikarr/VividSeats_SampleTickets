# vsSampleTickets
data engineering event tickets

################
#Technical requirements (suppoprts on both linux and windows)
################
1.      Install mysql workbench 6.3 CE
2.      Install nodejs latest version
3.      Install postman latest version

##############
#Data model
##############



################
#Instructions for running and building the db and application
################
1.      Execute the queries from backup.sql for creating the tables – events, seats, userInformation, and user_seats_information.
2.      Execute the queries in the storedprocedures from allocate_seat.sql, get_availableseats.sql, update_events.sql, and update_user.sql
3.      Run npm install from terminal or command prompt
4.      Run the server.js script on terminal or command prompt, make sure the file has .js extension else rename it with the extension.
5.      Run the APIs on Postman,

##################
#Examples
##################

POST:
http://localhost:3001/userCreate

PARAMS (PARAMETERS):
JSON(application/json)

BODY:
{
"username": "sell1",
"password": "1",
"role": "seller"
}

STATUS:
[
    {
        "@result": "Success"
    }
]

POST:
http://localhost:3001/eventCreate?username=sell1&password=1

PARAMS (PARAMETERS):
JSON(application/json)

BODY:
{
"eventname": "blackhawks",
"location": "chicago",
"totalrows": 998,
"seats": 1,
"price": 42
}

STATUS:
[
    {
        "@result": "Success"
    }
]

If you execute the same parameters again, then, STATUS is,
[
    {
        "@result": "Eventname and location already exist"
    }
]

POST:
http://localhost:3001/allocateSeat?username=cust1&password=1

PARAMS (PARAMETERS):
JSON(application/json)

BODY:
{
"eventname": "blackhawks",
"location": "chicago",
"rownumber": 406,
"seatnumber": 2
}

STATUS:


POST:
http://localhost:3001/ availableSeats?username=sell1&password=1

PARAMS (PARAMETERS):
JSON(application/json)

BODY:
{
"eventname": "blackhawks",
"location": "chicago",
}

STATUS:
