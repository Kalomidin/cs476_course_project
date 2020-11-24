const mongoose = require('mongoose')
const dbConfig = require('./dbconfig')


const connectDB = async() => {
    try {
        const connection = await mongoose.connect(dbConfig.database, {
            useNewUrlParser: true,
            useUnifiedTopology: true,
            useFindAndModify: false
        })
        console.log(`Mongo is connected : ${connection.connection.host}`)
    }
    catch (err) {
        console.log(`Error: : ${err}`)
        process.exit(1)
    }
}

module.exports = connectDB