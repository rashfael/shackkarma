# Initialize loggers.
log4js = require 'log4js'
appLogger = log4js.getLogger 'app'
accessLogger = log4js.getLogger 'access'
appLogger.setLevel if process.isTest then 'FATAL' else 'DEBUG'
accessLogger.setLevel if process.isTest then 'FATAL' else 'DEBUG'

express = require 'express'
path = require 'path'

app = module.exports = express()

# Load db stuff

mongoose = require 'mongoose'
mongoose.connect 'mongodb://localhost/shackkarma'
global.mongoose = mongoose

User = require './schemas/User'
Deed = require './schemas/Deed'

# Server config

sessionStore = new express.session.MemoryStore
	reapInterval: 60000 * 10
app.configure ->
	app.use express.bodyParser()
	app.use express.methodOverride()
	app.use express.cookieParser()
	app.use express.session
		store: sessionStore
		key: 'sid'
		secret: 'QWoHD3JsKg1TdhnD'
	app.use log4js.connectLogger accessLogger
	app.use express.static __dirname + '/../public'
	app.use app.router

app.configure 'development', ->
	app.use express.errorHandler {dumpExceptions: true, showStack:true }

app.configure 'production', ->
	app.use express.errorHandler()

app.get '*', (req, res) ->
	res.sendfile path.normalize __dirname + '/../public/index.html'

server = app.listen 9000, ->
	appLogger.info "Express server listening on port %d in %s mode", 9000, app.settings.env

# io = require('socket.io').listen server

# io.sockets.on 'message', (msg) ->
# 	console.log 'message', msg

# io.sockets.on 'connection', (socket) ->
# 	socket.on 'projects/list', (msg) ->
# 		console.log 'on', msg
# 	socket.on 'message', (msg) ->
# 		console.log 'msgsock', msg
# 	new IoRouter socket


# Attach Socket.IO to server.
io = require('socket.io').listen server,
	logger:
		debug: ->
			accessLogger.debug.apply accessLogger, arguments
		info: ->
			accessLogger.info.apply accessLogger, arguments
		warn: ->
			accessLogger.warn.apply accessLogger, arguments
		error: ->
			accessLogger.error.apply accessLogger, arguments

io.set 'authorization', (handshakeData, cb) ->
	if not handshakeData.headers.cookie
		handshakeData.session = {}
		return cb null, true
	cookieParser = require 'express/node_modules/cookie'
	connectUtils = require 'express/node_modules/connect/lib/utils'
	signedCookies = cookieParser.parse handshakeData.headers.cookie
	handshakeData.cookies = connectUtils.parseSignedCookies signedCookies, 'QWoHD3JsKg1TdhnD'

	sessionId = handshakeData.cookies['sid']
	sessionStore.get sessionId, (err, session) ->
		return cb 'no session found', false if err or not session
		handshakeData.session = session
		handshakeData.sessionId = sessionId
		return cb null, true

DeedRouter = require './routers/Deed'


io.sockets.on 'connection', (socket) ->
	# TODO block unauthd access
	# socket.on 'message', ->
	# 	console.log 'message', message
	# 	socket.disconnect()
	socket.on 'login', (user, cb) ->
		session = socket.handshake.session
		if not user
			if session.user
				cb session.user
			else
				cb null
				return
		else
			session.user = user
			if socket.handshake.sessionId?
				sessionStore.set socket.handshake.sessionId, session, ->
					cb user
			else
				cb user
		deedRouter = new DeedRouter socket, session
	socket.on 'logout', (cb) ->
		sessionStore.destroy socket.handshake.sessionId, cb