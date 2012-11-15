_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]
_VIEWS = @__get_project_namespace__ [ "Views" ]

_views = undefined

class _VIEWS.MainView extends _VIEWS.BaseView

  className : 'MainView'

  initialize : ( properties, @onReady ) ->
    
    super properties, @onReady

    @log 'init'

    _views = [
      id : 'login-view'
      klass : _VIEWS.LoginView
    ,
      id : 'piece-view'
      klass : _VIEWS.PieceView
    ,
      id : 'support-view'
      klass : _VIEWS.SupportView
    ]

    @addViews.call @, _views, => @ready()
    
    @
    
  render : ->
    @log 'render'
    @
    
  @