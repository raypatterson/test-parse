_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]

class _MODELS.UserModel extends _MODELS.BaseModel
  
  className : 'UserModel'
  
  initialize : (data, @onReady) ->
    super data, @onReady
    @

  addProperties : ->
    super

    @set 'isSignedUp', false
    @set 'isLoggedIn', false

    @