Pokedex.Views.Pokemon = Backbone.View.extend({
  initialize: function () {
    this.$pokeList = this.$el.find('.pokemon-list');
    this.$pokeDetail = this.$el.find('.pokemon-detail');
    this.$newPoke = this.$el.find('.new-pokemon');
    this.$toyDetail = this.$el.find('.toy-detail');

    this.pokemon = new Pokedex.Collections.Pokemon();

    $('form.new-pokemon').on("submit", this.submitPokemonForm.bind(this));
    this.$pokeList.on("click", "li.poke-list-item", this.selectPokemonFromList.bind(this));
    this.$pokeDetail.on("click", "li.toy-list-item", this.selectToyFromList.bind(this));
    this.$toyDetail.on("change", 'select', this.reassignToy.bind(this));
  },

  addPokemonToList: function (pokemon) {
    var $li = $('<li class="poke-list-item">');
    $li.data("id", pokemon.id);
    $li.text("Name: " + pokemon.escape("name") + " | Type: " + pokemon.escape("poke_type"));
    this.$pokeList.append($li);
  },

  refreshPokemon: function () {
    var view = this;
    this.pokemon.fetch({
      success: function () {
        view.pokemon.each(view.addPokemonToList.bind(view));
      }
    });
  },

  renderPokemonDetail: function (pokemon) {
    var $div = $('<div class="detail">');
    $div.html('<img src="' + pokemon.get("image_url") + '">');
    _.each(pokemon.attributes, function (val, key) {
      if (key !== 'id' && key !== 'image_url') {
        var $p = $('<p>' + key + ': ' + val + '</p>');
        $div.append($p);
      }
    });

    var $pokeToys = $('<ul class="toys">');
    $div.append($pokeToys);
    pokemon.fetch({
      success: function () {
        this.renderToysList(pokemon.toys());
      }.bind(this)
    });
    this.$pokeDetail.html($div);
  },

  addToyToList: function (toy) {
    var $li = $('<li class="toy-list-item">');
    $li.data("id", toy.id);
    $li.data("pokemon-id", toy.get("pokemon_id"));
    _.each(toy.attributes, function (val, key) {
      if (key === 'name') {
        var $p = $('<p>' + key + ': ' + val + '</p>');
        $li.append($p);
      }
    });
    this.$pokeDetail.find('ul.toys').append($li);
  },

  renderToyDetail: function (toy) {
    var $div = $('<div class="detail">');
    $div.html('<img src="' + toy.get("image_url") + '">');
    $div.append($('<p>Name: ' + toy.get("name") + '</p>'));
    $div.append($('<p>Happiness: ' + toy.get("happiness") + '</p>'));
    $div.append($('<p>Price: ' + toy.get("price") + '</p>'));
    var $selectBox = $('<select>');
    $selectBox.data("pokemon-id", toy.get("pokemon_id"));
    $selectBox.data("toy-id", toy.id);
    this.pokemon.forEach(function(pokemon) {
      var $option = $('<option>');
      if (pokemon.id === toy.get("pokemon_id")) {
        $option.attr("selected", true);
      }
      $option.attr("value", pokemon.id);
      $option.text(pokemon.get("name"));
      $selectBox.append($option);
    });
    $div.append($selectBox);
    this.$toyDetail.html($div);
  },

  reassignToy: function (event) {
    var $select = $(event.currentTarget);
    var toyId = $select.data("toy-id");
    var oldPokemonId = $select.data("pokemon-id");
    var oldPoke = this.pokemon.get(oldPokemonId);
    var toy = oldPoke.toys().get(toyId);
    var newPokeId = $select.val();
    toy.set("pokemon_id", newPokeId);
    toy.save({}, {
      success: function () {
        oldPoke.toys().remove(toyId);
        this.renderToysList(oldPoke.toys());
        this.$toyDetail.empty();
      }.bind(this)
    });
  },

  renderToysList: function (toys) {
    this.$pokeDetail.find(".toys").empty();
    toys.forEach(this.addToyToList.bind(this));
  },


  selectToyFromList: function (event) {
    var toyId = $(event.currentTarget).data("id");
    var pokemonId = $(event.currentTarget).data("pokemon-id");
    this.renderToyDetail(this.pokemon.get(pokemonId).toys().get(toyId));
  },

  selectPokemonFromList: function (event) {
    var pokeId = $(event.currentTarget).data("id");
    this.renderPokemonDetail(this.pokemon.get(pokeId));
  },

  createPokemon: function (attributes, callback) {
    var newPoke = new Pokedex.Models.Pokemon();
    newPoke.save(attributes, {
      success: function () {
        this.pokemon.add(newPoke);
        this.addPokemonToList(newPoke);
        callback(newPoke);
      }.bind(this)
    });
  },

  submitPokemonForm: function (event) {
    event.preventDefault();
    var attributes = $(event.currentTarget).serializeJSON().pokemon;
    this.createPokemon(attributes, this.renderPokemonDetail.bind(this));
  }
 });
