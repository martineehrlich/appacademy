Pokedex.Models.Pokemon = Backbone.Model.extend({
  urlRoot: "/pokemon",

  toys: function () {
    if (!this._toys) {
      this._toys = new Pokedex.Collections.Toys([], {pokemon: this});
    }
    return this._toys;
  },

  parse: function (payload) {
    if (payload.toys) {
      this.toys().set(payload.toys);
      delete payload.toys;
    }
    return payload;
  }
});
