mediator = require 'mediator'
utils = require 'lib/utils'
PageView = require 'views/base/page_view'
template = 

module.exports = class LoginView extends PageView
	template: require 'views/templates/login'

	events:
		'submit form': 'submit'

	submit: (event) =>
		event.preventDefault()
		@model.set 'username', @$('#username').val()
		return false
