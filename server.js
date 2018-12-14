var http = require('http');
var mysql = require('mysql');
var express = require('express');
var bodyParser = require('body-parser');

const customer = express();
customer.disable('etag');
customer.use(bodyParser.json()); // support json encoded bodies
customer.use(bodyParser.urlencoded({ extended: true })); // support encoded bodies

const seller = express();
seller.disable('etag');
seller.use(bodyParser.json()); // support json encoded bodies
seller.use(bodyParser.urlencoded({ extended: true })); // support encoded bodies


var customerPort = 3000;
var sellerPort = 3001;

var connection = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "12345",
  database : 'stadium',
  multipleStatements: true
});

connection.connect();


customer.listen(customerPort, (err) => {
    if (err) {
      return console.log('something bad happened', err)
    }
  
    console.log(`customer is listening on ${customerPort}`)
})


seller.listen(sellerPort, (err) => {
    if (err) {
      return console.log('something bad happened', err)
    }
  
    console.log(`seller is listening on ${sellerPort}`)
})

seller.post('/userCreate', (request, response) => {
    console.log(request.body);
    connection.query("SET @result = 'Success';call update_user('"+request.body.username +"','"+request.body.password+"','"+request.body.role+"',@result);SELECT @result;", function (error, results) {
        if (error) throw error;
        response.status(200).send(results[2]);
        response.end();
      });
})


seller.post('/eventCreate', (request, response) => {
    console.log(request.query);
    console.log(request.body);
    console.log("call update_events('"+request.query.username +"','"+request.query.password+"','"+request.body.eventname+"','"+request.body.location+"',"+request.body.totalrows+","+request.body.seats+","+request.body.price+",@result)")
    connection.query("SET @result = 'Success';call update_events('"+request.query.username +"','"+request.query.password+"','"+request.body.eventname+"','"+request.body.location+"',"+request.body.totalrows+","+request.body.seats+","+request.body.price+",@result);SELECT @result;", function (error, results) {
        if (error) throw error;
        response.status(200).send(results[2]);
        response.end();
      });
})


customer.post('/allocateSeat', (request, response) => {
    console.log(request.query);
    console.log(request.body);
    console.log("call allocate_seat('"+request.query.username +"','"+request.query.password+"','"+request.body.eventname+"','"+request.body.location+"',"+request.body.rownumber+","+request.body.seatnumber+",@result);SELECT @result;")
    connection.query("SET @result = 'Success';call allocate_seat('"+request.query.username +"','"+request.query.password+"','"+request.body.eventname+"','"+request.body.location+"',"+request.body.rownumber+","+request.body.seatnumber+",@result);SELECT @result;", function (error, results) {
        if (error) throw error;
        response.status(200).send(results[2]);
        response.end();
      });
})


customer.get('/availableSeats', (request, response) => {
    console.log("call get_availableseats('"+request.query.username +"','"+request.query.password+"','"+request.query.eventname+"','"+request.query.location+"',@result, @seats);SELECT @result;select @seats;");
    connection.query("SET @result = 'Success';call get_availableseats('"+request.query.username +"','"+request.query.password+"','"+request.query.eventname+"','"+request.query.location+"',@result);SELECT @result;", function (error, results) {
        if (error) throw error;
        response.status(200).send(results[1][0]);
        response.end();
      });
})


seller.post('/PostNewSeat', (request, response) => {
    console.log("call post_seat('"+request.query.username +"','"+request.query.password+"','"+request.body.eventname+"','"+request.body.location+"',"+request.body.rownumber+",@result, @seats)")
    connection.query("SET @result = 'Success';call post_seat('"+request.query.username +"','"+request.query.password+"','"+request.body.eventname+"','"+request.body.location+"',"+request.body.rownumber+",@result);SELECT @result;", function (error, results) {
        if (error) throw error;
        response.status(200).send(results[2]);
        response.end();
      });
})


seller.delete('/DeleteSeat', (request, response) => {
    connection.query("SET @result = 'Success';call delete_seat('"+request.query.username +"','"+request.query.password+"','"+request.body.eventname+"','"+request.body.location+"',"+request.body.rownumber+",@result);SELECT @result;", function (error, results) {
        if (error) throw error;
        response.status(200).send(results[2]);
        response.end();
      });
})

customer.get('/BestSeat', (request, response) => {
    console.log("call best_seat('"+request.query.username +"','"+request.query.password+"','"+request.query.eventname+"','"+request.query.location+"',@result)")
    connection.query("SET @result = 'Success';call best_seat('"+request.query.username +"','"+request.query.password+"','"+request.query.eventname+"','"+request.query.location+"',@result);SELECT @result;", function (error, results) {
        if (error) throw error;
        response.status(200).send(results[1][0]);
        response.end();
      });
})
