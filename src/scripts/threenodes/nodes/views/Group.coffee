define [
  'Underscore',
  'Backbone',
  'cs!threenodes/models/Node',
  'cs!threenodes/views/NodeView',
  "colorpicker",
], (_, Backbone) ->
  #"use strict"

  namespace "ThreeNodes.nodes.views",
    Group: class Group extends ThreeNodes.NodeView
      initialize: (options) =>
        super
        @views = []
        console.log options.model.nodes
        _.each(options.model.nodes.models, @renderNode)

      renderNode: (node) =>
        nodename = node.constructor.name

        if ThreeNodes.nodes.views[nodename]
          # If there is a view associated with the node model use it
          viewclass = ThreeNodes.nodes.views[nodename]
        else
          # Use the default view class
          viewclass = ThreeNodes.NodeView
        view = new viewclass
          model: node
          isSubNode: true

        view.$el.appendTo(@$el.find("> .options"))

        # Save the nid and model in the data attribute
        view.$el.data("nid", node.get("nid"))
        view.$el.data("object", node)
        @views.push(view)

      remove: () =>
        super
