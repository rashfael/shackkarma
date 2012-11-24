mediator = require 'mediator'
Controller = require 'controllers/base/controller'
User = require 'models/user'
LoginView = require 'views/login_view'

module.exports = class AuthenticationController extends Controller
	initialize: ->
		# Login flow events
		# @subscribeEvent 'serviceProviderSession', @serviceProviderSession

		# Handle login
		# @subscribeEvent 'logout', @logout
		# @subscribeEvent 'userData', @userData

		# Handler events which trigger an action

		# Show the login dialog
		# @subscribeEvent '!showLogin', @showLoginView
		# Try to login with a service provider
		# @subscribeEvent '!login', @triggerLogin
		# Initiate logout
		mediator.subscribe '!auth:logout', @logout

		# Determine the logged-in state
		@getSession()

	# Try to get an existing session from one of the login providers
	getSession: =>
		Backbone.socket.emit 'login', null, (user) ->
			if user?
				mediator.user = new User user
				mediator.publish '!auth:success'
			else
				mediator.user = new User()
				@view = new LoginView
					model: mediator.user
				mediator.user.on 'change', =>
					@view.dispose()
					Backbone.socket.emit 'login', mediator.user.toJSON(), (user) ->
						mediator.publish '!auth:success'

	logout: =>
		Backbone.socket.emit 'logout', () ->
			console.log 'logged out'
			window.location.reload(true)
