Model = global.mongoose.model 'Deed'
Crud = require './Crud'

module.exports = class ModelRouter extends Crud
	model: Model
	prefix: 'deeds'
