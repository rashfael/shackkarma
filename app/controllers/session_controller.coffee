mediator = require 'mediator'
Controller = require 'controllers/base/controller'
User = require 'models/user'
LoginView = require 'views/login_view'

module.exports = class SessionController extends Controller
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
    # @subscribeEvent '!logout', @triggerLogout

    # Determine the logged-in state
    @getSession()

  # Instantiate the user with the given data
  createUser: (userData) ->
    mediator.user = new User userData

  # Try to get an existing session from one of the login providers
  getSession: =>
    $.ajax
      type: 'POST'
      url: '/authenticate'
      data: '{}'
      dataType: 'json'
      contentType: 'application/json'
      statusCode:
        401: =>
          @showLoginView()
      success: (data) ->

  # Handler for the global !showLoginView event
  showLoginView: =>
    @view = new LoginView()
