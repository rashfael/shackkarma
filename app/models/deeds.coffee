Model = require 'models/base/model'
Collection = require 'models/base/collection'

module.exports.Deed = class Deed extends Model
	urlRoot: 'deeds'
	idAttribute: '_id'

module.exports.Deeds = class Deeds extends Collection
	model: Deed
	url: 'deeds'