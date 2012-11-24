Model = global.mongoose.model 'Deed'
Crud = require './IoCrud'

module.exports = class ModelRouter extends Crud
	model: Model
	prefix: 'deeds'