# deed
mongoose = require 'mongoose'
Schema = mongoose.Schema

schema = new Schema
	name: String
	description: String
	karma: Number

module.exports = mongoose.model 'Deed', schema, 'deeds'