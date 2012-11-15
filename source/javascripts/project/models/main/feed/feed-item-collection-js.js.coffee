_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]

class _MODELS.FeedItemCollection extends Backbone.Collection

  className : "FeedItemCollection"
  model : _MODELS.FeedItemModel