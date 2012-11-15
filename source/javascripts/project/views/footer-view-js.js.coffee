_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]
_VIEWS = @__get_project_namespace__ [ "Views" ]

_mainModel = undefined

class _VIEWS.FooterView extends _VIEWS.BaseView

  className : 'FooterView'

  initialize : ( properties, @onReady ) ->
    
    super properties, @onReady

    @log 'init'
    
    _mainModel = _MODELS.mainModel
      
    @ready()
    
    @
    
  render : ->
    @

    
  @