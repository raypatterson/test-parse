_VIEWS = @__get_project_namespace__ ['Views']
_PARSE = @__get_project_namespace__ [ "Helpers", "Parse" ]

_getProperties = ( $form ) ->

  s = $form.serialize()

  @log s

  properties = {}
  pairs = s.split '&'
  pair = undefined
  
  @log pairs
  _.each pairs, ( val, key ) ->
    pair = val.split '='
    @log 'pair', pair
    properties[ pair[ 0 ] ] = pair[ 1 ]

  properties


_setup = ->
  @log 'setup'

  $form = $ '#login-view form'

  $form.submit ( event ) =>
    event.preventDefault()
    @log 'form submit'
    properties = _getProperties $form
    @log properties

    _PARSE.signup properties

    , 

      ( response ) ->
        @log 'Signup success'

    , 

      ( response ) ->
        @log 'Signup failure' 
      

    false

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

class _VIEWS.SignupView extends _VIEWS.BaseView

  className : 'SignupView'

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