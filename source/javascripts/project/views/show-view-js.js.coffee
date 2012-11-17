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

class _VIEWS.ShowView extends _VIEWS.BaseView

  className : 'ShowView'

  initialize : ( properties, @onReady ) ->

    super properties, @onReady

    @log 'initialize'

    @ready()

    @

  addEvents : ->
    super

    @

  render : ->
    _render.call @
    @
    
  @