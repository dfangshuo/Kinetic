// big chain api imports
const BigchainDB = require('bigchaindb-driver')
const bip39 = require('bip39')

// program constants
const API_PATH = 'https://test.bigchaindb.com/api/v1/'
const CONN = new BigchainDB.Connection(API_PATH, {
	app_id: '58b2db76',
	app_key: '5b04f68b0811ebc5f93a79e0089758fb'
})


class VehicleBigchain {
	constructor() {
		this.local_cache = [];
		this.owner = new BigchainDB.Ed25519Keypair()
		const vehicle_asset_data = {
			'car': {
					'serial_number': 'abcd1234',
					'manufacturer': 'Tesla',
			}
		}

		const vehicle_initial_state = {
			'driver_id': '-',
			'time_stamp': '-',
			'state': 'available',
			'third_party_tx_id': '-',
			'miles_driven': 0,
			'lat': 37.419752,
			'lng': -122.135094
		}

		this._createVehicle(vehicle_asset_data, vehicle_initial_state);
		this._populateDemoData();
	}

	_createVehicle(vehicle_asset_data, vehicle_initial_state) {
		const txCreateVehicle = BigchainDB.Transaction.makeCreateTransaction(
				vehicle_asset_data,
				vehicle_initial_state,

				// A transaction needs an output
				[ BigchainDB.Transaction.makeOutput(
						BigchainDB.Transaction.makeEd25519Condition(this.owner.publicKey))
				],
				this.owner.publicKey
		)
		const txCreateVehicleSigned = BigchainDB.Transaction.signTransaction(txCreateVehicle, this.owner.privateKey)
		// cache a local copy
		this.local_cache.push(txCreateVehicleSigned)
		// post transaction to the public blockchain
		CONN.postTransactionCommit(txCreateVehicleSigned)
	}

	getVehicleState() {
		// returns the latest state of the vehicle
		// CONN.getTransaction(this.local_cache[this.local_cache.length - 1].id) // retrieval from blockchain
		// latest transaction is retrieved from cache for faster access
		var latest_tx = this.local_cache[this.local_cache.length - 1]
		return latest_tx.metadata
	}

	getVehicleStateHistory() {
		// returns a history of the vehicle's state
		var history = [];
		for (var i = 0; i < this.local_cache.length; i++) {
			history.push(this.local_cache[i].metadata);
		}
		return history
	}

	updateVehicleState(new_vehicle_state) {
		// update the state of the vehicle
		// gets the transaction from latest entry
		// CONN.getTransaction(this.local_cache[this.local_cache.length - 1].id)
		var latest_tx = this.local_cache[this.local_cache.length - 1]
		const txUpdateState = BigchainDB.Transaction.makeTransferTransaction(
		        // signedTx to transfer and output index
		        [{ tx: latest_tx, output_index: 0 }],
		        [BigchainDB.Transaction.makeOutput(BigchainDB.Transaction.makeEd25519Condition(this.owner.publicKey))],
		        // metadata
		        new_vehicle_state
		);
		// sign transaction to authorize update
		const txUpdateStateSigned = BigchainDB.Transaction.signTransaction(txUpdateState, this.owner.privateKey);
		// cache a local copy
		this.local_cache.push(txUpdateStateSigned)
		// post transaction to the public blockchain
		CONN.postTransactionCommit(txUpdateStateSigned)
	}

	getDemoLog() {
		return this.demo_log;
	}

	_populateDemoData() {
		this.demo_log = [];
		// YING HANG
		this.updateVehicleState({
			'driver_id': '14',
			'time_stamp': '-',
			'state': 'repair',
			'third_party_tx_id': '1023',
			'miles_driven': 10,
			'lat': 37.419752,
			'lng': -122.135094
		});


		this.updateVehicleState({
			'driver_id': '-',
			'time_stamp': '-',
			'state': 'available',
			'third_party_tx_id': '-',
			'miles_driven': 20,
			'lat': 37.419752,
			'lng': -122.135094
		});

		for (var i = 1 ; i < 9; i ++) {
			const dist = Math.random() * 50;
			var latest_state = JSON.parse(JSON.stringify(this.getVehicleState()));
			
			// when driver books the car
			latest_state['driver_id'] = i.toString();
			latest_state['state'] = 'booked';
			this.updateVehicleState(latest_state);

			var latest_state = JSON.parse(JSON.stringify(this.getVehicleState()));
			// when driver enters the car
			latest_state['state'] = 'driving';
			this.updateVehicleState(latest_state);

			var latest_state = JSON.parse(JSON.stringify(this.getVehicleState()));
			// when driver leaves the car
			latest_state['driver_id'] = '-';
			latest_state['state'] = 'available';
			latest_state['miles_driven'] = latest_state['miles_driven'] + dist;
			this.updateVehicleState(latest_state);

			this.demo_log.push({
				'id': i,
				'miles': dist
			});
		}

		
		var last_state = JSON.parse(JSON.stringify(this.getVehicleState()));
		last_state['state'] = 'repair';
		last_state['third_party_tx_id'] = '1300';
		last_state['miles_driven'] = 10 + last_state['miles_driven'];

		this.updateVehicleState(last_state);
	}
}

module.exports = VehicleBigchain;