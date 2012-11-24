# user
mongoose = require 'mongoose'
Schema = mongoose.Schema

schema = new Schema
	_id: String
	displayName: String
	role: 
		type: [String]
		default: ['user']

module.exports = mongoose.model 'User', schema, 'users'