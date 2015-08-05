window.Pokedex = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function () {
    Pokedex.pokemonTypes = pokemonTypes;
    var $el = $('#pokedex');
    var view = new Pokedex.Views.Pokemon({ el: $el });
    view.refreshPokemon();
  }
};

$(document).ready(function () {
  Pokedex.initialize();
});
