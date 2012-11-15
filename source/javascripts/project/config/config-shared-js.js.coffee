@__set_project_namespace__ [ "__DO__", "YOU_LIKE_ART" ]

_NS = @__get_project_namespace__()
_ob = @__get_project_namespace__ [ 'Config' ]

_ob.debug = window.__debug_flag__ or false

_ob.FilePaths =
  configData : "data/main.json"

# Url & Model fragments
fragments =
  filters : "filters/"
  feature : "feature/"
  section : "section"
  subpage : "/"
  content : "/"

matches =
  getFilters : -> "#{fragments.filters}:filters"
  getFeature : -> "#{fragments.feature}:feature"
  getSection : -> "#{fragments.section}:section"
  getSubpage : -> "#{fragments.section}:section#{fragments.subpage}:subpage"
  getContent : -> "#{fragments.section}:section#{fragments.subpage}:subpage#{fragments.content}:content"

routes =
  getFilters : ( filters ) -> "#{fragments.filters}#{filters}"
  getFeature : ( feature ) -> "#{fragments.feature}#{feature}"
  getSection : ( section ) -> "#{fragments.section}#{section}"
  getSubpage : ( subpage ) -> "#{fragments.subpage}#{subpage}"
  getContent : ( content ) -> "#{fragments.content}#{content}"

_ob.fragments = fragments
_ob.matches = matches
_ob.routes = routes
  