module.exports = class IoCrud

	constructor: (socket) ->
		socket.on "#{@prefix}:list", (query, cb) =>
			@list socket, query, cb
		socket.on "#{@prefix}:create", (obj, cb) =>
			@add socket, obj, cb
		socket.on "#{@prefix}:read", (id, cb) =>
			@item socket, id, cb
		socket.on "#{@prefix}:delete", (_id, cb) =>
			@delete socket, _id, cb
		socket.on "#{@prefix}:update", (id, obj, cb) =>
			@update socket, id, obj, cb

	list: (socket, query, cb) =>
		@model.find query, (err, items) ->
			if err?
				console.log err
				return cb err
			cb null, items

	add: (socket, obj, cb) =>
		item = new @model obj
		item.save (err) ->
			if err?
				console.log err
				return cb err
			cb null, item.toObject()

	item: (socket, id, cb) =>
		@model.findById id, (err, item) ->
			if err?
				console.log err
				return cb err
			cb null, item?.toObject()

	delete: (req, res) =>
		@model.remove {_id: req.params.id}, (err) ->
			if err?
				console.log err
				return cb err
			res.send()
	
	update: (socket, id, obj, cb) =>
		delete obj._id
		@model.update {_id: id}, obj, (err) ->
			if err?
				console.log err
				return cb err
			cb null, obj
