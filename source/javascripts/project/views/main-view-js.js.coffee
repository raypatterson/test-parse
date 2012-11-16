_VIEWS = @__get_project_namespace__ ['Views']

class _VIEWS.MainView extends _VIEWS.BaseView

  className : 'MainView'

  initialize : ( properties, @onReady ) ->
    
    super properties, @onReady

    @log 'init'

    views = [
      id : 'profile-view'
      klass : @VIEWS.ProfileView
    ]

    @addViews.call @, views, => @ready()
    
    @
    
  render : ->
    @log 'render'
    @
    
  @