Pokedex.Views.PokemonIndex = Backbone.View.extend({
  initialize: function () {
    this.collection = new Pokedex.Collections.Pokemon();
    this.listenTo(this.collection, "sync", this.render);
    this.listenTo(this.collection, "add", this.addPokemonToList);
  },

  events: {
    "click li": "selectPokemonFromList"
  },


  selectPokemonFromList: function (event) {
    var id = $(event.currentTarget).data('id');
    // var poke = this.collection.get(id);
    Backbone.history.navigate("/pokemon/" + id, { trigger: true });
  },

  render: function () {
    this.$el.empty();
    var view = this;
    this.collection.forEach(function(poke) {
      view.addPokemonToList(poke);
    });
  },

  addPokemonToList: function (pokemon) {
    var content = JST['pokemonListItem']({ pokemon: pokemon });

    this.$el.append(content);
    // return this;
  },

  refreshPokemon: function (callback) {
    this.collection.fetch({success: function () {
        if (callback) {
          callback();
        }
      }
    });
  }
});
