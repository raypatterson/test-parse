_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ 'Models' ]
_ob = @__get_project_namespace__ [ "Helpers", "Parse" ]

_log = _NS.log "Parse"

_ShowClassName = 'Show'
_userModel = undefined
_userRoute = ''
_showModel = undefined

_hashToken = window.__unique_session__

$.parse.init
  app_id : "djGfQwNkc2UF7rtTKK5UauwpjURlAQeolix6s5tg"
  rest_key : "9lKZhpdHggkde7VSkOIFhy0vv6gJGZzq4j1kf3wh"

_ob.addShow = ( properties, success, failure ) ->
  _log 'addShow called'

  

  properties = 
    description : "It's the #{_hashToken} show on Earth."

  $.parse.post _ShowClassName, properties

  , 

  ( response ) ->
    _log 'addShow success', response

    success? response

    _showModel = new _MODELS.BaseModel response


    properties = 
      show :
        __op : "AddRelation"
        objects : [
          __type: "Pointer"
          className : _ShowClassName
          objectId : response.objectId
        ]

    $.parse.put _userRoute, properties

  ,

  ( response ) ->
    _log 'addShow failure', response
    failure? response


_ob.signup = ( properties, success, failure ) ->
  _log 'signup called'

  if _NS.Config.debug
    
    properties.username ||= "Banksy Maybe #{_hashToken}"
    properties.password ||= 'admin'
    properties.email ||= "#{_hashToken}@akqa.com"

  _log properties

  $.parse.signup properties

  , 

  ( response ) ->
    _log 'signup success', response

    success? response

    _userRoute = "users/#{response.objectId}"

    $.parse.setSessionToken response.sessionToken

    _userModel = new _MODELS.BaseModel response

    _log '_userRoute', _userRoute
    _log '_userModel', _userModel

    _ob.addShow()

  ,

  ( response ) ->
    _log 'signup failure', response
    failure? response