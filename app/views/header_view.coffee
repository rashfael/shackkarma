mediator = require 'mediator'
View = require 'views/base/view'
template = require 'views/templates/header'

module.exports = class HeaderView extends View
	template: template
	id: 'header'
	className: 'navbar navbar-fixed-top'
	container: '#header-container'
	autoRender: true

	initialize: ->
		super
		@subscribeEvent 'loginStatus', @render
		@subscribeEvent 'startupController', @render

	getTemplateData: =>
		data = super()
		data.user = mediator.user.toJSON()
		return data

	events:
		'click a#logout': 'logout'

	logout: (event) ->
		event.preventDefault()
		mediator.publish '!auth:logout'
