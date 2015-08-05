Pokedex.Routers.Router = Backbone.Router.extend({
  routes: {
    "": "PokemonIndex",
    "pokemon/:id": "PokemonDetail"
  },

  PokemonIndex: function (callback) {
    var view = new Pokedex.Views.PokemonIndex();
    view.refreshPokemon(callback);
    this._pokemonIndex = view;
    $("#pokedex .pokemon-list").html(view.$el);
  },

  PokemonDetail: function (id) {
    if(!this._pokemonIndex) {
      this.PokemonIndex(this.PokemonDetail.bind(this, id));
      return;
    }
    var poke = this._pokemonIndex.collection.get(id);
    var view = new Pokedex.Views.PokemonDetail({model: poke});

    $("#pokedex .pokemon-detail").html(view.render().$el);
  }

});
