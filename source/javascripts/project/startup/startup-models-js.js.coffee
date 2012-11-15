_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]

_log = _NS.log "Models"

_eventType = undefined
_mainModel = undefined
_pageModel = undefined

_load = (id, url, callback, method = 'getJSON') ->
  
  _NS.DataLoader[method] url, ((response) =>
    
    _log "[ #{id} data loaded ]"

    callback response
    
    ), ((response) ->
      
      _log "[ #{id} data failed to load ]"
      
      callback())
      
  @


_loadConfigData = (callback) ->
  
  id = 'Config'
  url = _NS.Config.FilePaths.configData

  _load id, url, (data) ->
    
    properties = data['root']['item_data']
    
    new _MODELS.PageModel properties, ->

      _MODELS.mainModel.set 'pageModel', @

      @log _MODELS.mainModel

      _log "[ #{id} data modeled ]"

      callback()

  @

_init = (callback) ->

  _log 'init'

  _MODELS.mainModel = new _MODELS.MainModel
  
  Nimble.parallel [
    _loadConfigData
  ], -> callback()
  
  @
  
_ob = @__get_project_namespace__ [ "Startup" ]
_ob.add _init