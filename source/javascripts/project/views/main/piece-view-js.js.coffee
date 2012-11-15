_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]
_VIEWS = @__get_project_namespace__ [ "Views" ]

_model = undefined

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

class _VIEWS.PieceView extends _VIEWS.BaseView

  className : 'PieceView'

  initialize : ( properties, @onReady ) ->

    super properties, @onReady

    @log 'init'

    @ready()

    @

  addEvents : ->
    super

    @

  render : ->
    _render.call @
    @
    
  @