_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]

_log = _NS.log "Routes"

_mainModel = undefined
_pageModel = undefined

_default = ->
  _log 'default'
  _pageModel.default()


_update = (activeSectionId, activeSubpageId = undefined, activeContentId = undefined) ->
  _log "#{activeSectionId}/#{activeSubpageId}/#{activeContentId}"
  _pageModel.set 'activeSectionId', activeSectionId
  _pageModel.set 'activeSubpageId', activeSubpageId
  _pageModel.set 'activeContentId', activeContentId
  _pageModel.set 'activeFragments', [ activeSectionId, activeSubpageId, activeContentId ]

_filters = ( filtersId ) ->
  _log "Filters Id : #{featureId}"
  _feedModel.set 'filtersId', filtersId

_feature = ( featureId ) ->
  _log "Feature Id : #{featureId}"
  _feedModel.set 'featureId', featureId

_init = (callback) ->
  
  _log "init"
  
  _mainModel = _MODELS.mainModel
  _pageModel = _mainModel.get 'pageModel'

  config = _NS.Config
  fragments = config.fragments
  matches = config.matches
  routes = config.routes

  router = _NS.navigationRouter
  router.route '*default', 'home', _default
  router.route matches.getFilters(), 'filters', _filters
  router.route matches.getFeature(), 'feature', _feature
  router.route matches.getSection(), 'section', _update
  router.route matches.getSubpage(), 'subpage', _update
  router.route matches.getContent(), 'content', _update
  
  callback()
  
_ob = @__get_project_namespace__ [ "Startup" ]
_ob.add _init