root = exports ? this
class root.Singleton
  @_instance: null
  @getInstance: ->
    @_instance ||= new @ arguments...
