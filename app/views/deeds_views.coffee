PageView = require 'views/base/page_view'

module.exports = class DeedsPageView extends PageView
  template: require 'views/templates/deeds'
  className: 'deeds-page'
