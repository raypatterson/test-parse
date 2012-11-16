_VIEWS = @__get_project_namespace__ ['Views']

_setup = ->
  @log 'setup'


  $('#file').customFileInput
    button_position : 'right'

  $form = $ '#upload-view form'

  @log '$form', $form
  
  $form.submit ( event ) =>
    event.preventDefault()
    @log 'upload submit'
    @log $form
    @log $form.find('input[type=file]')[0].value
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

class _VIEWS.UploadView extends _VIEWS.BaseView

  className : 'UploadView'

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