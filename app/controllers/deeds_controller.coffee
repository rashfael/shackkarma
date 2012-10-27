Controller = require 'controllers/base/controller'
DeedsPageView = require 'views/deeds_views'

module.exports = class DeedsController extends Controller
  historyURL: 'deeds'

  index: ->
    @view = new DeedsPageView()
