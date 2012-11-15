_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]

_flag = ( flags ) ->
  _.each flags, ( flag ) => if @has flag then @set ( @get flag ), true
  @
  
class _MODELS.FeedItemModel extends Backbone.Model

  className : "FeedItemModel"
  
  initialize : ( data, @onReady ) ->
    
    super data, @onReady

    _flag.call @, [ 'post_image', 'service' ]

    @

  @