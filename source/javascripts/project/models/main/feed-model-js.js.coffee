_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]

_items = undefined
_activeIndex = undefined
_activePage = 0
_pageItems = 25

_getModelId = ( m ) -> m.get 'entry_id'

class _MODELS.FeedModel extends _MODELS.BaseModel
  
  className : 'FeedModel'

  initialize : (data, @onReady) ->

    super data, @onReady

    @log 'init'

    @

  addProperties : ->

    super

    @log 'addProperties'

    _items = @get 'collection'

    userIds = {}
    users = new _MODELS.BaseCollection()

    _items.each (model) ->
      userId = model.get 'post_media_handle'
      if userIds[userId] isnt true
        # @log 'userId', userId
        userIds[userId] = true
        users.add model

    @set 'users', users

    # @log '_items', _items
    # @log 'users', users

    @

  addEvents : ->

    super

    @log 'addEvents'

    @on 'change:featureId', ( model ) =>
      
      featureId = @get 'featureId'

      @log "Feature Id has changed --> #{featureId} --> update active model"

      activeItem = _items.find ( m, i ) => 
        _activeIndex = i
        ( _getModelId m ) is featureId

      @set 'activeItem', activeItem

    @

  default : ->
    @log 'default'
    @attributes['filtersId'] = undefined
    @attributes['featureId'] = undefined

    @set 'activeItem', undefined
    
    @

  resetItems : -> _activePage = 0

  getItems : ( callback ) ->

    @log 'getItems'

    items = _items.toJSON()
    startIndex = _activePage * _pageItems
    endIndex = startIndex + _pageItems
    if endIndex > items.length then endIndex = items.length

    items = items.slice startIndex, endIndex

    _activePage++

    callback items

  getNextItemId : ->
    i = _activeIndex + 1
    if i is _items.length then i = 0
    m = _items.at i
    _getModelId m

  getPrevItemId : ->
    i = _activeIndex - 1
    if i is -1 then i = _items.length - 1
    m = _items.at i
    _getModelId m
    