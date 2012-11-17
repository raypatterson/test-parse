_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ 'Models' ]
_VIEWS = @__get_project_namespace__ [ 'Views' ]

_log = _NS.log "Views"

_tempView = new _VIEWS.BaseView

# _initView = (id, View, callback, views) ->

#   _log 'View Init'

#   properties = 
#     id : id
#     el : $ "##{id}"

#   if views then properties.views = views

#   new View properties, ->

#     _VIEWS[id] = @

#     _log '--- View Rendered ---', @, '--- View Rendered ---'
    
#     callback()

#     @
    
#   @

_initView = (id, callback, views) ->

  _log 'View Init'

  _tempView.addView id, callback, views
    
  @


_init = (callback) ->
  
  _log "init"
  
  _mainModel = _MODELS.mainModel
  
  if _NS.Config.touchOS is true then $('body').addClass 'touch'
  
  Nimble.series [
    _initOverlayView
    _initHeaderView
    _initMainView
    _initFooterView
    ], callback
    
  @
  
_initOverlayView = (callback) ->
  _initView 'overlay-view', callback
  # _initView 'overlay-view', _VIEWS.OverlayView, callback
  @  
  
_initHeaderView = (callback) ->
  _initView 'header-view', callback
  # _initView 'header-view', _VIEWS.HeaderView, callback
  @  

_initMainView = (callback) ->
  _log 'Main View'

  views = [ 
      id : 'upload-view' 
      views : [
        id : 'help-view' 
      ,
        id : 'show-view'
      ]
    ]

  _initView 'main-view', callback, views
  # _initView 'main-view', _VIEWS.MainView, callback, views

  @  

_initFooterView = (callback) ->
  _initView 'footer-view', callback
  # _initView 'footer-view', _VIEWS.FooterView, callback
  @
  
_ob = @__get_project_namespace__ [ "Startup" ]
_ob.add _init