Pokedex.Views.PokemonDetail = Backbone.View.extend({
  template: JST['pokemonDetail'],

  events: {
    "click li": "selectToyFromList"
  },

  initialize: function() {
    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    this.$el.html(this.template({pokemon: this.model}));

    this.model.toys().each(function(toy) {
      $(".toys").append(JST["toyListItem"]({toy: toy}));
    }.bind(this));
    return this;
  },

  // selectToyFromList: function (event) {
  //   var toyId = $(event.currentTarget).data('toy-id');
  //   var pokemonId = $(event.currentTarget).data('pokemon-id');
  //   var toy = this.pokes.get(pokemonId).toys().get(toyId);
  //
  //   this.renderToyDetail(toy);
  // }

  selectToyFromList: function (event) {
    var toyId = $(event.currentTarget).data('toy-id');
    var toy = this.model.toys().get(toyId);
    var toyView = new Pokedex.Views.ToyDetail({model: toy});

    $("#pokedex .toy-detail").html(toyView.render().$el);

    // this.renderToyDetail(toy);
  }

});
