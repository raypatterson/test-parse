_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]
_VIEWS = @__get_project_namespace__ [ "Views" ]

_mainModel = undefined
$_activeMenuItem = undefined

class _VIEWS.HeaderView extends _VIEWS.BaseView

  className : 'HeaderView'

  initialize : ( properties, @onReady ) ->
    
    super properties, @onReady

    @log 'init'
    
    _mainModel = _MODELS.mainModel
      
    @ready()
    
    @
    
  render : ->
    @
    
  @