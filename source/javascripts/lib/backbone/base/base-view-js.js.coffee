_NS = @__get_project_namespace__()
_HELPERS = @__get_project_namespace__ [ "Helpers" ]
_MODELS = @__get_project_namespace__ [ "Models" ]
_VIEWS = @__get_project_namespace__ [ "Views" ]

_setup = ->  
  @ROUTER = _NS.navigationRouter
  @EVENTBUS = _NS.eventBus
  @touchOS = _NS.Config.touchOS

_init = ->
  @addProperties()
  @addEvents()


class _VIEWS.BaseView extends Backbone.View
  
  className : "BaseView"
  NS : _NS
  HELPERS : _HELPERS
  MODELS : _MODELS
  VIEWS : _VIEWS
  visibility : true
    
  initialize : ( properties, @onReady ) ->
    super properties, @onReady

    @className = if @el then "#{@className} ##{@el.id}" or "#{@className} .#{el.className}" else @className
    @log = _NS.log @className

    _setup.call @
    _init.call @
    
    @
  
  hide : (speed = 0, delay = 0) ->
    @log 'hide'
    # if @visibility is false then return @
    if speed isnt 0
      @$el.delay(delay).fadeOut(speed, => @visibility = false)
    else
      @$el.delay(delay).hide()
      @visibility = false
    @
  
  show : (speed = 0, delay = 0) ->
    @log 'show'
    # if @visibility is true then return @
    if speed isnt 0
      @$el.delay(delay).fadeIn(speed, => @visibility = true)
    else
      @$el.delay(delay).show()
      @visibility = true
    @
    
  resize : (w, h) ->
    # @log "width: #{w}, height: #{h}"

  addEvents : ->
    @EVENTBUS.bind @EVENTBUS.eventTypes.WINDOW_RESIZE, (w, h) => @resize w, h
    @

  addProperties : ->
    @

  addViews : ( views, callback ) ->
    @log 'addViews'

    i = 0
    I = views.length

    items = []

    getFunc = ( ob ) => ( callback ) => 
        @addView ob.id, ob.klass, -> callback()

    while i < I
      items.push ( getFunc views[ i ] )
      i++

    Nimble.series items, => callback()
      
    @

  addView : (id, klass, callback) ->
    @log "add #{id}"
    
    properties = 
      id : id
      el : $ "##{id}"

    view = new klass properties, ->
      _VIEWS[id] = view
      callback?()
      @
      
    @

  ready : ->
    @log 'ready'
    @onReady?()
    @