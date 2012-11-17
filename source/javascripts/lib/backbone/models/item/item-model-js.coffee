_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]

_setupRoute = ->
  model = @
  parent = @get 'parent'
  fragments = []
  fragment = model.get 'fragment'
  if fragment then fragments.unshift fragment
  
  while parent isnt undefined
    model = parent
    fragment = model.get 'fragment'
    if fragment then fragments.unshift fragment
    parent = parent.get 'parent'

  @set 'fragments', fragments
    
  @

_setupAttributes = ->
  @createAttributeFromFragments 'dom', '-'
  @createAttributeFromFragments 'route', '/'
  @createAttributeFromFragments 'file', '_'
  @

_setupItems = (callback) ->
  # @log 'Set up items'
  items = @get 'items'
  
  if items
    # @log '> Model has items'
    
    collection = new _MODELS.ItemCollection
    @set 'collection', collection
    @unset 'items'
    
    # Add models
    model = undefined
    itemsReady = 0
    itemsTotal = items.length

    # Add additional attributes
    _.each items, (item, index) =>
      item.index = index
      item.parent = @

      model = new _MODELS.ItemModel item, =>
        itemsReady++
        # @log "#{itemsReady} ready, #{itemsTotal} total"
        if itemsReady is itemsTotal
          # @log '>>> All models are ready'
          callback()
        
      collection.add model
    
  else
    # @log '> Model has no items'
    callback()

  @

_createItems = ->
  item = @get "item"
  if item isnt undefined
    # @log 'Do special nested model stuff'
    @set item
    @unset "item"
    _setupRoute.call @
    _setupAttributes.call @
    _setupItems.call @, => @ready()
  else
    @ready()
  
  @

class _MODELS.ItemModel extends _MODELS.BaseModel

  className : "ItemModel"
    
  addProperties : ->
    # @log "addProperties"
    super
    _createItems.call @
    @
    
  createAttributeFromFragments : (name, separator) ->
    @set name, ( @get 'fragments' ).join separator
    @
      
  @

