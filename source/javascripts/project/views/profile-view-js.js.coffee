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

class _VIEWS.ProfileView extends _VIEWS.BaseView

  className : 'ProfileView'

  initialize : ( properties, @onReady ) ->
    
    super properties, @onReady

    # @log 'initialize'

    _setup.call @

    @ready()
    
    @
    
  render : ->
    _render.call @
    @
    
  @