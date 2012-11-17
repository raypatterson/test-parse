_NS = @__get_project_namespace__()
_HELPERS = @__get_project_namespace__ [ "Helpers" ]
_MODELS = @__get_project_namespace__ [ "Models" ]
_VIEWS = @__get_project_namespace__ [ "Views" ]

_toTitleCase = ( str ) -> 
  # FIXME : [RKP] : Obviously I don't 'get' Regex
  str = str.split('-').join(' ')
  str = str.replace ( /(?:^|\s)\w/g ), ( match ) -> match.toUpperCase()
  str = str.split(' ').join('')
  str

_setup = ->  
  @ROUTER = _NS.navigationRouter
  @EVENTBUS = _NS.eventBus
  @touchOS = _NS.Config.touchOS
  @addProperties()
  @addEvents()

_init = ->


class _VIEWS.BaseView extends Backbone.View
  
  className : "BaseView"
  NS : _NS
  HELPERS : _HELPERS
  MODELS : _MODELS
  VIEWS : _VIEWS
  visibility : true
    
  initialize : ( properties, @onReady ) ->
    super properties, @onReady

    @setup()
    @init()

    # @log 'initialize'

    @

  setup : ->  
    @className = if @el then "#{@className} ##{@el.id}" or "#{@className} .#{el.className}" else @className
    @log = _NS.log @className
    
    # @log 'setup'

    @ROUTER = _NS.navigationRouter
    @EVENTBUS = _NS.eventBus
    @touchOS = _NS.Config.touchOS

    @addProperties()
    @addEvents()

    @
  
  init : ->
    # @log 'init'

    if @options.views then @addViews @options.views, => @ready()

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
    # @log 'addViews'

    # @log views

    i = 0
    I = views.length

    items = []

    getFunc = ( view ) => ( callback ) => 
        @addView view.id, ( -> callback() ), view.views

    while i < I
      items.push ( getFunc views[ i ] )
      i++

    Nimble.series items, => callback()
      
    @

  addView : ( id, callback, views ) ->
    @log "addView --> #{id}"

    KlassName = _toTitleCase id
    
    properties = 
      id : id
      el : $ "##{id}"

    if views then properties.views = views

    view = new @VIEWS[ KlassName ] properties, ->
      _VIEWS[ id ] = view
      callback?()
      @
      
    @

  ready : ->
    @log 'ready'
    @onReady?()
    @