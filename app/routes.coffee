module.exports = (match) ->
  match '', 'home#index'
  match 'deeds', 'deeds#index'
  match 'deeds/add', 'deeds#add'
  match 'deeds/:id', 'deeds#item'
