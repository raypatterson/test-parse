_VIEWS = @__get_project_namespace__ ['Views']

_setup = ->
  @log 'setup'
  @

_format = ->
  @log 'format'
  @

_show = ->
  @log 'show'
  @

_render = ->
  @log 'render'
  @

class _VIEWS.LandingView extends _VIEWS.BaseView

  className : 'LandingView'

  initialize : ( properties, @onReady ) ->
    
    super properties, @onReady

    @log 'init'

    _setup.call @

    @ready()
    
    @
    
  render : ->
    _render.call @
    @
    
  @