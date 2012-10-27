# deed
mongoose = require 'mongoose'
Schema = mongoose.Schema

schema = new Schema
	name: String
	description: String

module.exports = schema