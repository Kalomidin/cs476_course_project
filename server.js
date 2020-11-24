//! Entry point for the node server
//!
//! author @kalo

const express = require('express')
const morgan = require('morgan')
const cors = require('cors')
const connectDB = require('./config/db')
const passport = require('passport')
const bodyParser = require('body-parser')
const routes = require('./routes/index')

connectDB()

const app = express()

if(process.env.NODE_ENV === 'development') {
    app.use(morgan('dev'))
}

app.use(cors())

app.use(bodyParser.urlencoded({extended: false}))
app.use(bodyParser.json())

app.use(routes)

const PORT = process.env.PORT || 3000

app.listen(PORT, console.log(`Server connected to MongoDB is running:\n NODE ENVIRONMENT: ${process.env.NODE_ENV} \n PORT: ${PORT}`))