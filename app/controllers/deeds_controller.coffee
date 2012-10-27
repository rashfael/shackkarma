Controller = require 'controllers/base/controller'
DeedsPageView = require 'views/deeds_views'
{Deed, Deeds} = require 'models/deeds'

module.exports = class DeedsController extends Controller
	historyURL: 'deeds'

	index: ->
		deeds = new Deeds()
		deeds.fetch
			success: (data) ->
				console.log data
		@view = new DeedsPageView
			collection: deeds