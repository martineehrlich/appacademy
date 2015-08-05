# w7d1 Backbone Pokedex

**Gotta Fetch 'em All**

In this project, we'll write an app to manage your `Pokemon` and their
`Toy`s. We've already setup migrations/models/controllers for you to
start with in a skeleton that we will email to you at the beginning of
the day.  **Set things up with a `bundle install`, then `rake db:setup` (this is equivalent to `rake
db:create db:migrate db:seed`)**.

Take a look at the schema and the routes file to get yourself oriented.

**Note the `defaults: {format: :json}`**. This means that HTTP
requests that Rails handles for the `pokemon` resource should be
assumed to be asking for a JSON response instead of HTML. When we
render a template, instead of looking for `template.html.erb`, Rails
will look for `template.json.jbuilder`. We'll see that soon!

**Also**: the root url `localhost:3000` will be the home of
our JS application. We have provided this controller and view
for you.

## Phase 0A: JBuilder

In `app/views/pokemon/`, create three jbuilder files - one each for
 `show` and `index`, and a partial called `_pokemon`. Remember to
use the extension `.json.jbuilder`. Your `show` and `index` files 
should both call the partial to render individual Pokemon. Render all 
the attributes of the `Pokemon`:

```json
{ "id":1,
  "attack":125,
  "defense":100,
  "image_url":"/assets/pokemon_snaps/127.png",
  "moves":["vicegrip"],
  "name":"Pinsir",
  "poke_type":"bug" }
```

Refer to [this excellent simple documentation][jbuilder-doc]. You'll
use `json.array!` `json.partial!` and `json.extract!` in your JBuilder
templates. These are all the major JBuilder options!

**Test your views by visiting `/pokemon/123` and `/pokemon`. Call your
TA to review.**

[jbuilder-doc]: https://github.com/rails/jbuilder

## Phase 0B: `Models.Pokemon` and `Collections.Pokemon`

In `app/assets/javascripts/models/pokemon.js`, let's write a `Pokemon`
model.  The purpose of this model class is to allow us to easily
interact with our Rails API without having to manually make `$.ajax`
requests each time we want to fetch data from the server or push
changes. This `ajax` work will be done for us by a base class,
`Backbone.Model`.

So, let's write our new `Pokedex.Models.Pokemon` class. Instead of
just creating a new function, let's `extend` the base class:
`Backbone.Model`. Now, we can selectively overwrite and add properties
and functions. Since most of the base class will perfectly fit our
needs, we only need to overwrite one default property: `urlRoot`.

The `urlRoot` property specifies the base path of where the `ajax`
operations need to go.  For example: creating a new pokemon would
necessitate a `POST` to `/pokemon`, and updating the first pokemon
would need a `PATCH` to /pokemon/1. The _root_ of all operations
involving pokemon is `/pokemon`, so this will be our `urlRoot`.

Now we also need to write a `Pokedex.Collections.Pokemon` class that
will store all of our 'Pokemon' models and allow us to manage them as 
a group. We'll put it in 'app/assets/javascripts/collections/pokemons.js'.
To write this class, like our model, we will `extend` a `Backbone` base 
class, `Backbone.Collection`.  We will need to overwrite the `url` and
`model` properties. The `url` will be the same value as
`Pokedex.Models.Pokemon`'s `urlRoot` property. The `model` property
will be set to the `Pokemon` model class we created above. This tells the
base class that when we `fetch` all the pokemon from the server and
store them in individual models, we should use instances of the
`Pokemon` model as the class to store them in.

We've written and defined a view class in 'assets/javascripts/views/
pokemon.js'. This will be responsible for listening to user clicks and
displaying Pokemon data. Look at the class, but there is nothing to write 
for it just yet.

**Test your model and collection.** Navigate to the
[root url](http://localhost:3000).  Once you are there, in the Chrome
console, run the following commands and ensure they work as expected.

```js
var pokemon = new Pokedex.Models.Pokemon({ id: 1 });
pokemon.fetch({ success: function () {
  console.log(pokemon.toJSON());
}});

var pokemons = new Pokedex.Collections.Pokemon();
pokemons.fetch({ success: function () {
  console.log(pokemons.toJSON());
}});
```

## Phase 1A: `refreshPokemon` and `addPokemonToList`

**Pokedex.Views.Pokemon.addPokemonToList**

The first thing to do is get your `Pokemon` view displaying `Pokemon`. To do
this, we should first add an `addPokemonToList(pokemon)` method in `pokemon.js`
that takes an instance of `Pokedex.Models.Pokemon` as an
argument. Create an `li` with jQuery, and list a few high-level
details of the Pokemon: `name` and `poke_type`. This is just an index
of Pokemon, so we won't display all data here. Append your `li` to
`this.$pokeList`.

If you give your `li` a class of `poke-list-item`, it'll style nicely
with the CSS rules we've provided. You can look at `application.css`
to check them out.

You can test your method in the console like so:

```js
var pokemon = new Pokedex.Models.Pokemon({ id: 1 });
pokemon.fetch({
  success: function () {
    var view = new window.Pokedex.Views.Pokemon({ el: $('#pokedex') });
    view.addPokemonToList(pokemon);
  }
});
```

Does a Pokemon get added to the list?

**Pokedex.Views.Pokemon.refreshPokemon**

Next, write a `refreshPokemon` method. This method should fetch all the
Pokemon by fetching `this.pokemon`. Iterate through the `this.pokemon`,
calling `addPokemonToList`.

In 'app/assets/javascripts/pokedex.js', at the end of 'window.Pokedex.initialize',
add a call to refreshPokemon. 

You can verify this is working by reloading the page; your Pokemon
should appear!

## Phase 1B: `renderPokemonDetail` and `selectPokemonFromList`

**Pokedex.Views.Pokemon.renderPokemonDetail**

What we're going to do next is allow ourselves to see more detail
about a `Pokemon` by selecting it from the index.

We're going to show the details of the `Pokemon` in the
`this.$pokeDetail`. In `renderPokemonDetail` create a `div.detail`
using jQuery. Add an image tag with the Pokemon's photo; iterate
through all the Pokemon properties, adding each to the `div.detail`.
It might be useful to iterate over the keys in the 'attributes' property of the 
pokemon. Set the content of `this.$pokeDetail` to be the `div.detail`.

You can verify this is working:

```javascript
var pokemon = new Pokedex.Models.Pokemon({ id: 1 });
pokemon.fetch({
  success: function () {
    var view = new Pokedex.Views.Pokemon({ el: $('#pokedex') });
    view.renderPokemonDetail(pokemon);
  }
});
```

**Pokedex.Views.Pokemon.selectPokemonFromList**

We want to call `renderPokemonDetail` in response to clicks. However,
when a user clicks on a pokemon list item in the `this.$pokeList`,
we need to figure out what `Pokemon` they are clicking on, so that we
can pass that pokemon object to `renderPokemonDetail`.

To do this, modify your `addPokemonToList` method to also set an `id`
data-attribute on the Pokemon list item. Next, in `Pokemon.initialize`, add a
listener that calls 'selectPokemonFromList' on a click on `this.$pokeList`.
Delegate to `li.poke-list-item`. 
In the click handler, recover the `id`from 
`event.currentTarget`; look up the `Pokemon` in `this.pokemon` with the
id. Finally, use `renderPokemonDetail` to display the Pokemon.

**Test it out; you should be able to click a Pokemon and see more
details about it.**

## Phase IC: `createPokemon` and `submitPokemonForm`

**Pokedex.Views.Pokemon.createPokemon**

As you encounter new Pokemon, you will want to record your findings
and share your wisdom with other poke-scientists. For this reason, we
have provided you with a form in 'app/views/static_pages/root.html.erb'. 
It doesn't do anything yet.

Before we play with the form, let's write a
`createPokemon(attributes)` method. This should build a new `Pokemon`
model and save it. You'll want to manually add the pokemon to the
`this.pokes` collection and call `addPokemonToList`. Do both of these
in the success callback; that way, you don't add the pokemon to the
collection or list **unless it was saved properly**.

You can test it:

```javascript
var view = new Pokedex.Views.Pokemon({ $el: $('#pokedex') }); 
view.createPokemon({
  name: "PikachuAndAsh",
  image_url: "http://upload.wikimedia.org/wikipedia/en/9/92/Pok%C3%A9mon_episode_1_screenshot.png",
  poke_type: "bug",
  attack: 0,
  defense: 0,
  moves: ["spinning!", "twirling!"]
});
```

Verify that a new pokemon is added to the list. Likewise, make sure a
new pokemon **is not added to the list** for an invalid pokemon:

```javascript
var view = new Pokedex.Views.Pokemon({ $el: $('#pokedex') });
view.createPokemon({
  name: "EvilTwin",
  // No image! Invalid!
  poke_type: "bug",
  attack: 1,
  defense: 0,
  moves: ["cackling!", "smirking!"]
});
```

**Pokedex.Views.Pokemon.submitPokemonForm**

Again, we want to improve our user interface so the user can create a
Pokemon through the form, not the console.

To do this, write a `submitPokemonForm` method; in the `Pokemon`
constructor, install this as a submit handler on the form. In the
handler, first 'event.preventDefault();' so that a post request isn't
automatically made. Next, use `serializeJSON` on the target to extract the data from
the form and convert it to a JS object. Then call your `createPokemon`
method.

Your `Pokedex.Views.Pokemon` class is getting a little large and unwieldy
by now. Don't worry; tomorrow we'll see how to refactor this beast into
smaller, more manageable files and classes.

**Display Details of Newly Created Pokemon**

Lastly, we'd like to to display the Pokemon details when creating a
new Pokemon. Modify your `createPokemon` method so that it accepts two
arguments: attributes, and a callback. On successful save of a newly
created Pokemon, your `createPokemon` method should call the callback,
passing the newly created Pokemon as the argument.

The `submitPokemonForm` method can now pass `this.renderPokemonDetail`
(after properly binding it).

Adding callback arguments to asynchronous methods is extremely common,
because it gives the caller flexibility to optionally do more work
**after** the asynchronous work of the method is completed.

**Call your TA over to check your work and to revel in your success!**

## Phase 2A: Rendering Toys

Pokemon love to play, so we've seeded the database with some toys. Our
first step is to update our JBuilder templates to render not just the
Pokemon, but also their Toys.

To do this, first write a `toys/_toy.json.jbuilder` partial template,
even though we won't write a `ToysController`. Write your template to
display the attributes of a toy: `id`, `happiness`, `image_url`,
`name`, `pokemon_id`, and `price`.

Modify your `pokemon/_pokemon` partial using `json.toys` to display a
list of toys. We want to add a `toys` key to our pokemon json object which
points to an array of json objects representing the toys. Do this using 
blocks. Render the partial (using `json.partial!`) for each of the toys 
of the Pokemon.

There is a caveat: we want to display the toys when we go to
`/pokemon/123`, **but not when we go to `/pokemon`**. When you are
writing a large application, it is not possible to send *all* the data
down in a single JSON response. Therefore, `/pokemon` should just
list the pokemons, while fetching a single Pokemon can additionally
request further, more specific data.

For that reason, change your `pokemon/_pokemon` template so that
`pokemon/show` can **optionally** specify the toys to be rendered. You
can have it do this by passing a partial variable `display_toys:
true`. If `display_toys`, render the toys in `pokemon/_pokemon`, else
don't. You can write an if statement right in your JBuilder!

**Check that this is working by loading `/pokemon` and
`/pokemon/123`.** Call your TA over to check.

## Phase 2B: Write a `Toy` Model, `Toys` Collection

We're ready to write our `Toy` model in `models/toy.js` and our 
`Toys` collection in `collections/toys.js`. At this point, 
they need only extend their respective Backbone classes. Additionally, set 
the `model` property of `Toys`.

On the server side a Pokemon model has a `has_many` toys association.
Backbone does not have a built in mechanism for representing
associations, so we'll wire up our own. Write a `toys` method on
`Pokemon` that memoizes a `Toys` collection. Javascript doesn't
have an `||=` operator so we'll need to check: if `this._toys` is
undefined, set `this._toys` equal to a new instance of `Toys`.
Finally return `this._toys`.

Now each `Pokemon` has a `toys` association. You might be wondering:
how is this association collection populated?

The Backbone `parse` method gives us the opportunity to massage an
incoming Javascript object into the attributes our Backbone model will have.
`parse` is called after the JSON string received from Rails is translated
into a Javascript object, but before the Javascript object's properties
become the Backbone model's attributes. For this reason, `parse` happens 
to be a great place to intercept any nested data and use that data to 
populate associated collections.

Write a `parse(payload)` method on `Pokemon`. `payload` here is the
raw Javascript object. The `parse` method will be called by backbone when
parsing a single model, or a collection of models returned from the
server during a fetch. **Remember** we're including `toys` in the
`show` action, but _not_ the `index` action.  Our `parse` method needs
to handle either case. If `payload` has a `toys` property, use the
array of `toys` to populate the `PokemonToys` collection returned by
the `toys()` method using [`Collection#set`][collection-set].

Finally, we must return a Javascript object from `parse`. This object will
be used to set the attributes of the `Pokemon`. We prefer using our
shiny new `toys()` association over a raw array of toy Javascript objects,
so lets be sure to `delete` the `toys` property from the `payload`
before returning the `payload`.

If you're still a bit fuzzy on how parse works, review [the
reading][parse-reading].

To test that `toys` and `parse` are up and running, try this in the
Chrome console:

```js
var pokemon = new Pokedex.Models.Pokemon({ id: 1 });
pokemon.fetch({
  success: function () {
    console.log(pokemon.toys().length); // SHOULD BE 3+
  }
});
```

## Phase 2C: Displaying Toys in Pokemon Detail View

**Pokedex.Views.Pokemon.renderPokemonDetail**

First, in your `renderPokemonDetail` method (in `pokemon.js`),
build and append a `ul.toys` to `this.$pokeDetail`. We'll display the 
toys inside this `ul` inside the detail view.

Next, still in the `renderPokemonDetail`, instigate a fetch of the
`Pokemon`, so that we can pull down the Pokemon's toys. For now, in
the success callback, just `console.log` each of the fetched
`pokemon.toys()`. Verify that the toys are fetched properly.

**Pokedex.Views.Pokemon.addToyToList**

Instead of `console.log`ing the toys, we want to add them to the toys
list ul we've built. To do this, we'll write an `addToyToList(toy)`
method.

In this method, construct an `li` for the Toy. If you give it a class of
'toy-list-item', the css we've provided will style it nicely. Display 
basic info about the toy: it's `name`, `happiness`, and `price`. Add the 
`li` to the `ul.toys` inside of the `this.$pokeDetail` element.

Last, modify `renderPokemonDetail` one last time to call `addToyToList`
for each toy, instead of logging.

**Pokedex.Views.Pokemon.renderToyDetail and Pokedex.Views.Pokemon.selectToyFromList**

We want to be able to show more detailed attributes of the Toy; in
particular its image. Write the `renderToyDetail(toy)` method, which
should make a `div.detail` and place it in `this.$toyDetail`.

Likewise, write a click handler `selectToyFromList` as before. You
will need a `toy-id` data-attribute as before, but you should also set
a `pokemon-id`, so that you can look up the `toy-id` in the
appropriate collection of `pokemon.toys()`.

Note that this is kind of messy. We're adding two data attributes just for
easy access to information when a list item is clicked. Don't worry, we'll
see how to clean this up in a few days.

[collection-set]: http://backbonejs.org/#Collection-set
[parse-reading]: https://github.com/appacademy/backbone-curriculum/blob/268498c3e594fa9bfa5f87825295ca8dd1d84d60/w7d3/backbone-model-ii.md

## Bonus: Phase III

**ToysController**

We'd like to add the option to re-assign a `Toy` from one Pokemon to
another. The first step is to write a `ToysController` with an `update` 
action, and add a resource for toys in the routes
file. You'll also want to write a `toys/show.json.jbuilder` for your
`ToysController#update` to render; this can use your
`_toy.json.jbuilder` partial.

Verify this is working like so:

```javascript
var toy = new Pokedex.Models.Toy({ id: 1 });
// we'll be setting this toy to be owned by Pokemon #1
toy.set("pokemon_id", 1);
toy.save({}, {
  success: function () {
    // after updating the toy, print the toy out.
    console.log(toy.toJSON());
  }
});
```

Notice that the first argument to `save` is blank, while the second
argument is an options hash that specifies the success callback. The
`save` method's first argument can contain some attributes to update
on the server, but I rarely use this, instead I just `set` the
attributes I want to, and call `save` with a blank object.

**reassignToy**

Modify your `renderToyDetail` to display a `select` box. Give it both
`data-pokemon-id` and `data-toy-id` data-attributes.

Iterate through `this.pokes`, creating an `option` for each of the
Pokemon. Set the `value` attribute of the `option` to
`pokemon.id`. Set the `text` of the `option` to the Pokemon's
name. Append each `option` to the `select`. Append the `select` to the
Toy detail element.

Also, set the `selected` property of the option for the currently
assigned pokemon, so that the right option is selected initially.

Reload your code to make sure you see the options box, with the list
of pokemon.

Next, add a handler for the change event on your select box. You should
write a `reassignToy` method. For now, just print the id of the old pokemon 
saved in `data-pokemon-id`, the id of the toy saved in `data-toy-id` 
and the id of the newly selected Pokemon (the `val` of the `select` 
element). Verify this is working.

Next, in the `reassignToy` handler, we want to do a few things:

* Lookup the `pokemon-id` in `this.pokes` to get the old Pokemon.
* Lookup the `toy-id` to get the Toy in `pokemon.toys()`.
* Set the Toy's `pokemon_id` to the new Pokemon.
* Save the `Toy`. In the success callback:
    * Remove the toy from `pokemon.toys()`, since it is no longer
      assigned to this Pokemon.
    * Call `renderPokemonDetail` to re-render the Pokemon's smaller
      list of toys.
    * Empty the `$toyDetail` since this toy is no longer selected.

**renderToysList**

One last thought. It's kind of nasty to have to call
`renderPokemonDetail`, which fetches the `pokemon`. Instead, let's
write a `renderToysList(toys)` method. In `renderToysList`, we can
iterate through the toys, calling `addToyToList` on each.

* Make sure to clear out `this.$pokeDetail.find(".toys")` first in
  `renderToysList`.
* Change `renderPokemonDetail` to call `renderToysList` in the
  success callback to `pokemon.fetch`.
* Change `reassignToy` from directly calling `renderPokemonDetail` to calling
  `renderToysList`.

## Bonus: Phase IV

**update and destroy**

Convert your Pokemon Detail and Toy Detail into forms. Instead of just listing the model's attributes , put the attributes in the values of the form inputs, and let the user 'update' their model on the server. Add the corresponding routes and controller actions. It may come in handy to use...
