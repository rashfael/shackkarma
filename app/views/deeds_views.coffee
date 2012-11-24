mediator = require 'mediator'
PageView = require 'views/base/page_view'
CollectionView = require 'views/base/collection_view'
View = require 'views/base/view'

class DeedListItemView extends View
	template: require 'views/templates/deed_list_item'
	tagName: 'tr'

	events:
		'click': 'click'

	click: (event) =>
		event.preventDefault()
		mediator.publish '!router:route', '/deeds/' + @model.id

class DeedsCollectionView extends CollectionView
	template: require 'views/templates/deedTable'
	tagName: 'table'
	className: 'table table-striped table-hover'
	itemView: DeedListItemView
	listSelector: 'tbody'

module.exports.PageView = class DeedsPageView extends PageView
	template: require 'views/templates/deeds'
	className: 'deeds-page'

	initialize: (options) =>
		super
		@deedsCollectionView = new DeedsCollectionView
			collection: options.collection

	render: () =>
		super
		@deedsCollectionView.container = @$ '#deeds'
		@deedsCollectionView.render()
		@deedsCollectionView.renderAllItems()

module.exports.AddView = class DeedsAddView extends PageView
	template: require 'views/templates/deed_add'

	events:
		'submit form': 'save'

	save: (event) =>
		event.preventDefault()
		@trigger 'added', @$('form').serializeArray()
		return false

module.exports.ItemView = class DeedItemView extends PageView
	template: require 'views/templates/deed_item'