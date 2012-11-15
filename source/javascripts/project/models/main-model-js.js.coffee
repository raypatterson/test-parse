_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]

class _MODELS.MainModel extends _MODELS.BaseModel
  
  className : 'MainModel'
  
  initialize : (data) ->
    super data
    
    @
