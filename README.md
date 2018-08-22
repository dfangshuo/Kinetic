# Kinetic
*by Alvin, Cong, Fang, Vivian, Ying Hang*

Kinetic is a car-sharing infrastructure envisioned and prototyped at the Wanxiang Blockchain Hackathon 2018. The prompt for the hackathon was to design and create a product for Innova City, a future city built on a blockchain. 

Our team came up with an idea for a car-sharing infrastructure built on the blockchain  as a proof of concept for a larger sharing economy enabled by the blockchain, winning $5,000 and an all-expenses paid invitation to Shanghai International Blockchain Week.

## Features
In 24 hours, our team of 5 conceptualized and implemented an idea for a car-sharing infrastructure built into the very fabric of the city, with 2 key features: a public ledger and a Smart-Car. 

We then prototyped our ideas, ultimately creating an MVP that consisted of a:
- **Smart car:** Prototyped using a Raspberry Pi
- **Decentralized database:** Created with BigChainDB
- **Mobile app:** A means of booking a car
- **Voice app:** An alternate means of booking a car
- **Node.js backend:** Hosted on Heroku
- **Data Visualization Dashboard:** To demonstrate the potential uses for the data collected in our infrastructure

## Implementation
**Languages:** Node.js/JavaScript, Swift     
**Frameworks:** Heroku, Google Dialogflow, BigChainDB

My role consisted chiefly of writing the backend web server and creating the mobile app used to book cars. 

The mobile app made HTTP requests to endpoints on the RESTful Kinetic backend, which either wrote/read information into/from the decentralized BigChainDB database or sent requests to the Raspberry Pi Smart-Car prototype.

Other features I was not personally involved in includes Facial Recognition (through an ML library) and data visualization.
