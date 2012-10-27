Model = require 'models/base/model'

module.exports = class Header extends Model
  defaults:
    items: [
    	{href: '/deeds', title: 'Deeds'}
      {href: './test/', title: 'App Tests'}
    ]
