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
1.      Execute the queries in the storedprocedures (normalized to 3NF) from sp_allocate_seat.sql, sp_delete_seat.sql, sp_get_availableseats.sql, sp_get_bestticket.sql, sp_post_seat.sql, sp_update_events.sql, sp_update_user.sql (previously normalized to 2NF allocate_seat.sql, get_availableseats.sql, update_events.sql, and update_user.sql)
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
#Additional examples
#######################
1. Post a new seat (see the snapshot postseat-seller.png)
2. Delete a seat (see the snapshot deleteseat-seller.png)
3. Get the best price for a seat for a event (see the snapshot getbestseat-customer.png)

#######################
#Tasks (pilot programs) tried implementing:
#######################
1.	Implement datetime for eid (event) and store the purchase_time for customer
2.	Allocat the total revenue for seller from the seats purchased by customers for an event
3.	Design tasks initially with seller, events, customers and seat_availability tables with 2Normalization-factor (note: normalized it to 3NF in the current model for scalability and robustness)
4.	Implement the referred-by option when customer is creating account and password for sellers marketing startergy to be improved.

#################
#To do tasks:
#################
1.  List events for a given date range
2.	List Refered-by option
