_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]

_collection = undefined

_getSubpageItems = (activeSectionId) ->
  model = _itemCollection.find (model) -> ( model.get 'fragment' ) is activeSectionId
  model.get 'collection'

_getContentItems = (activeSectionId, activeSubpageId) ->
  model = ( _getSubpageItems.call @, activeSectionId ).find (model) -> ( model.get 'fragment' ) is activeSubpageId
  model.get 'collection'
  
_getDomIds = (ids) ->
  _ids = []
  _.each ids, (id) => _ids.push ( @get id )
  _ids.join '-'

class _MODELS.PageModel extends _MODELS.ItemModel
  
  className : 'PageModel'
  activeFragments : []
  activeSectionId : undefined
  activeSubpageId : undefined
  activeContentId : undefined
  
  initialize : (data, @onReady) ->
    super data, @onReady
    @
  
  ready : ->
    _collection = @get 'collection'
    super
    @

  default : ->
    # Reset
    @attributes['activeContentId'] = undefined
    @attributes['activeSubpageId'] = undefined
    # Update
    @set 'activeSectionId', ( _collection.at 0 ).get 'fragment'
    @
    
  getSection : -> _collection.toJSON()
  
  getSubpage : -> 
    activeSectionId = @get 'activeSectionId'
    if activeSectionId
      return ( _getSubpageItems.call @, activeSectionId ).toJSON()
    else
      return undefined
      
  getContent : -> 
    activeSectionId = @get 'activeSectionId'
    activeSubpageId = @get 'activeSubpageId'
    if activeSectionId and activeSubpageId
      return ( _getContentItems.call @, activeSectionId, activeSubpageId ).toJSON()
    else 
      return undefined
      
  getContentRange : -> 
    activeContentId = @get 'activeContentId'
    content = @getContent()
    activeIndex = undefined
      
    if content
      _.find content, (val, key) =>
        # @log 'val', val
        # @log 'key', key
        activeIndex = key
        val[ 'fragment' ] == activeContentId
      
      lastIndex = if activeIndex - 1 isnt -1 then activeIndex - 1 else content.length - 1
      nextIndex = if activeIndex + 1 isnt content.length then activeIndex + 1 else 0
       
      # @log 'activeIndex', activeIndex
      # @log 'lastIndex', lastIndex
      # @log 'nextIndex', nextIndex
      
      items =
        active : content[ activeIndex ]
        last : if lastIndex isnt nextIndex then content[ lastIndex ] else undefined
        next : if nextIndex isnt activeIndex then content[ nextIndex ] else undefined
    else 
      return undefined
      
  getContentLast : -> 
    activeSectionId = @get 'activeSectionId'
    activeSubpageId = @get 'activeSubpageId'
    if activeSectionId and activeSubpageId
      return ( _getContentItems.call @, activeSectionId, activeSubpageId ).toJSON()
    else 
      return undefined
    
  getContentById : (id) -> _.find @getVideos(), (model) -> model['videoId'] is videoId
  
  getActiveSectionDomId : -> _getDomIds.call @, [ 'activeSectionId' ] 
  getActiveSubpageDomId : -> _getDomIds.call @, [ 'activeSectionId', 'activeSubpageId' ]
  getActiveContentDomId : -> _getDomIds.call @, [ 'activeSectionId', 'activeSubpageId', 'activeContentId' ]

@
