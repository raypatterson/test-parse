_VIEWS = @__get_project_namespace__ ['Views']

_toTitleCase = ( str ) -> 
  # FIXME : [RKP] : Obviously I don't 'get' Regex
  str = str.split('-').join(' ')
  str = str.replace ( /(?:^|\s)\w/g ), ( match ) -> match.toUpperCase()
  str = str.split(' ').join('')
  str

class _VIEWS.MainView extends _VIEWS.BaseView

  className : 'MainView'

  initialize : ( properties, @onReady ) ->
    
    super properties, @onReady

    @log 'init'

    id = 'profile-view'

    klassName = _toTitleCase id

    @log 'klassName', klassName

    views = [
      id : id
      klass : @VIEWS[ 'ProfileView' ]
    ]

    @addViews.call @, views, => @ready()
    
    @
    
  render : ->
    @log 'render'
    @
    
  @