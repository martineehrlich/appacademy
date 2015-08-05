Pokedex.Views.ToyDetail = Backbone.View.extend({
  template: JST['toyDetail'],

  render: function () {

    var content = this.template({toy: this.model, pokemon: []});
    this.$el.html(content);
    return this;
  }
});
