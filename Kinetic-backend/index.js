//DEPENDENCIES
const express = require('express');
const config = require('./config');
const vbc = require('./bigchain_caller');

var CAR = new vbc();

//SETUP
const app = express();

app.engine('html', require('ejs-locals'));
app.use(express.static('views'));

// LOGIN PAGE
app.get('/', (req,res) => {
	console.log("Serving login site..")
	res.render("login.html");
})

// CAR DASHBOARD
app.get('/dashboard', (req,res) => {
	console.log("Serving dashboard site..")
	res.render("dashboard.html");
})

// UPDATES THE STATUS OF THE AVAILABILITY
app.get('/get_status', (req,res) => {
	res.send('200', CAR.getVehicleState()['state']);
});

app.get('/get_log', (req,res) => {
	res.send('200', JSON.stringify(CAR.getDemoLog()));
});

// BOOKING ENDPOINT
app.get('/bookcar', (req,res) => {
	let newState = req.query.state;
	let metaData = JSON.parse(JSON.stringify(CAR.getVehicleState()));
	metaData.state = newState;
	CAR.updateVehicleState(metaData);
    res.send('200', 'car status processed');
})

// console.log(CAR.getVehicleStateHistory());

app.listen(config.port, () => console.log("Started listening on port 3000.."));