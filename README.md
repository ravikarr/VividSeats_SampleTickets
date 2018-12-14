# vsSampleTickets
data engineering event tickets

################
#Technical requirements (suppoprts on both linux and windows)
################
1.      Install mysql workbench 6.3 CE
2.      Install nodejs latest version
3.      Install postman latest version

##############
#Logical model
##############
Check the snapshot (logicalmodel.jpeg)

##############
#Data model
##############
Check the snapshot (datamodel.jpeg)


################
#Instructions for running and building the db and application
################
1.      Execute the queries from backup.sql (or have splitted these tables individually like table_events.sql, table_seats.sql, table_user, table_user_seat.sql) for creating the tables – events, seats, userInformation, and user_seats_information.
2.      Execute the queries in the storedprocedures from allocate_seat.sql, get_availableseats.sql, update_events.sql, and update_user.sql
3.      Run npm install from terminal or command prompt
4.      Run the server.js script on terminal or command prompt, make sure the file has .js extension else rename it with the extension.
5.      Run the APIs on Postman,

##################
#Examples
##################

POST: 
#create user – seller and customer
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

#create event (security-authentication provided such that only seller can create a event)
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

#customer allocates a seat or seats
POST:
http://localhost:3000/allocateSeat?username=cust1&password=1
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
[
    {
        "@result": "Allocated"
    }
]

#customer (and seller) can check the available seats
POST:
http://localhost:3000/ availableSeats?username=sell1&password=1&eventname=blackhawks&location=chicago
PARAMS (PARAMETERS): 
JSON(application/json)
BODY:
{
"eventname": "blackhawks",
"location": "chicago",
}
STATUS:
[
    {
        Total avilableseats": 406
    }
]

#######################
#Tasks (pilot) tried implementing:
#######################
1.	Implemented datetime for eid (event) and store the purchase_time for customer
2.	Allocating the total revenue for seller from the seats purchased by customers for an event
3.	Designed tasks initially with seller, events, customers and seat_availability tables with 2Normalization-factor 
4.	Implemented the referred-by option when customer is creating account and password.

#################
#To do tasks:
#################
1.	Implement datetime for an event
2.	List events for a given date range
3.	Implementation  of Refered-by
