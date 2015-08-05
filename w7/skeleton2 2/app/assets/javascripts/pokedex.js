window.Pokedex = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function () {
    Pokedex.pokemonTypes = pokemonTypes;
    new Pokedex.Routers.Router ();
    Backbone.history.start();
    // var $el = $('#pokedex');
    // view = new Pokedex.Views.Pokemon({ el: $el });
    // view.refreshPokemon();
  }
};

$(document).ready(function () {
  Pokedex.initialize();
});
