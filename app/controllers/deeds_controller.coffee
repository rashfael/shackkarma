Controller = require 'controllers/base/controller'
{PageView, AddView, ItemView} = require 'views/deeds_views'
{Deed, Deeds} = require 'models/deeds'
mediator = require 'mediator'

module.exports = class DeedsController extends Controller
	historyURL: 'deeds'

	index: ->
		deeds = new Deeds()
		deeds.fetch
			success: (data) ->
				console.log data
		@view = new PageView
			collection: deeds

	add: ->
		model = new Deed()
		@view = new AddView
			model: model
		@view.on 'added', (rawData) =>
			# unpack that data
			data = {}
			for rawItem in rawData
				data[rawItem.name] = rawItem.value
			model.save data,
				success: =>
					mediator.publish '!router:route', '/deeds/' + model.id

	item: (params) ->
		model = new Deed()
		model.id = decodeURIComponent params.id
		model.fetch
			success: =>
				@view = new ItemView
					model: model
