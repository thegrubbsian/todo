// An example generic Mixin that you can add to any component that should
// react to changes in a Backbone component. The use cases we've identified
// thus far are for Collections -- since they trigger a change event whenever
// any of their constituent items are changed there's no need to reconcile for
// regular models. One caveat: this relies on getBackboneCollections() to
// always return the same collection instances throughout the lifecycle of the
// component. If you're using this mixin correctly (it should be near the top
// of your component hierarchy) this should not be an issue.
var BackboneMixin = {
  componentDidMount: function () {
    // Whenever there may be a change in the Backbone data, trigger a
    // reconcile.
    this.getBackboneCollections().forEach(function (collection) {
      // explicitly bind `null` to `forceUpdate`, as it demands a callback and
      // React validates that it's a function. `collection` events passes
      // additional arguments that are not functions
      collection.on('add remove change', this.forceUpdate.bind(this, null));
    }, this);
  },

  componentWillUnmount: function () {
    // Ensure that we clean up any dangling references when the component is
    // destroyed.
    this.getBackboneCollections().forEach(function (collection) {
      collection.off(null, null, this);
    }, this);
  }
};
