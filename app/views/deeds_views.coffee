PageView = require 'views/base/page_view'
CollectionView = require 'views/base/collection_view'
View = require 'views/base/view'


class DeedItemView extends View
	template: require 'views/templates/deedItem'
	tagName: 'tr'

class DeedsCollectionView extends CollectionView
	template: require 'views/templates/deedTable'
	tagName: 'table'
	className: 'table'
	itemView: DeedItemView
	listSelector: 'tbody'


module.exports = class DeedsPageView extends PageView
	template: require 'views/templates/deeds'
	className: 'deeds-page'

	initialize: (options) =>
		@deedsCollectionView = new DeedsCollectionView
			collection: options.collection

	render: () =>
		super
		@deedsCollectionView.container = @$ '#deeds'
		@deedsCollectionView.render()
		@deedsCollectionView.renderAllItems()
