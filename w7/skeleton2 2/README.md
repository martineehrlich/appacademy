# Pokedex: Templates, Views and Routing!

## Phase 4: Templates

We've mixed our HTML code very heavily into our JavaScript; our
`Pokedex.Views.Pokemon` methods use jQuery to build all the HTML of the
page.

This is not very nice; it's really hard for us to read the code and
know that it is generating the right HTML. It also makes it hard to
see what the `Pokedex.Views.Pokemon` is doing, because we have to look past
a bunch of spaghetti logic to build HTML.

The traditional solution is to use *client-side templates*. What Rails
calls a *view* (`index.html.erb`, `index.json.jbuilder`) is more
properly called a *template*. We will start out this project building
templates. The big difference is that these templates **will not be
evaluated by the server**, but instead be _rendered_ by the client to
generate HTML.

Start by looking at the file `app/assets/templates/pokemonForm.jst.ejs`. We've
moved the form for creating pokemon out of `app/views/static_pages/root.html.erb` and
into this file. We've also changed the `refreshPokemon` function in `Pokedex.Views.Pokemon`
to render this template.

Let's understand how that works by writing our own template. Create a file 
`app/assets/templates/pokemonDetail.jst.ejs`. In it we will put a template that, 
when evaluated with a `pokemon` local variable, will produce html. The `backbone-on-rails` gem creates a JST (JavaScript Template) 
namespace, and populates it with template functions created from the files in 
`app/assets/templates/`. The function `JST['pokemonDetail']`, when called and passed 
`{ pokemon: pokemon }` as an argument, should return the actual rendered html.

Write the template code to display a single Pokemon.

When you have written this, check that the following code works:

```javascript
var template = JST['pokemonDetail'];
var pokemon = new Pokedex.Models.Pokemon({ id: 1 });
pokemon.fetch({
  success: function () {
    console.log(template({ pokemon: pokemon }));
  }
});
```

Last, modify your `renderPokemonDetail` to use
`JST["pokemonDetail"]`. As mentioned above, `JST["pokemonDetail"]` stores
a function that, when called and passed `{ pokemon: pokemon }` as the argument,
will return the rendered template: actual HTML code. Instead of creating
the div using jQuery and adding elements one after another like yesterday,
we are going to render our template and let it fill out the HTML for us!

For example:
```html
    var content = JST['pokemonDetail']({ pokemon: pokemon });
```

In the snippet above, we are _rendering_ the template and passing
`pokemon` as a _local variable_ to the template. If this succeeds,
`content` will be the entire HTML content of the
rendered template. We should be able to put content directly into the
`html` of some element without problem.

You'll still have jQuery code for building the
list of toys, but this should reduce the amount of jQuery code. Verify
that this works correctly as before.

## Phase 4B: More Templates!

Just as you wrote `pokemonDetail`, write the following
templates, along the way changing the relevant method to use the
template:

* Change `addPokemonToList` to use a template `pokemonListItem`.
* Extend your `pokemonDetail` template to hold an empty
  `ul.toys`. Then write a template `toyListItem` and update
  `addToyToList`.
* Change `renderToyDetail` to use a template `toyDetail`.
    * Write the `select` tag! You'll want to pass `this.pokes` into
      the template so it can iterate through the pokemons and make an
      `option` for each.

## Phase 5: Views

Our `Pokedex.Views.Pokemon` contains basically all the logic of our
application. We will break it up into three main view classes. Don't delete 
'pokemon.js' yet, but do create three more files in 
`app/assets/javascripts/views/`, each containing a class extending 
`Backbone.View`: 

* `Pokedex.Views.PokemonIndex`
* `Pokedex.Views.PokemonDetail`
* `Pokedex.Views.ToyDetail`

We're going to slowly eliminate `Views.Pokemon`. Let's start with the
`PokemonIndex`. Comment out the initialization code in `pokedex.js`:

```javascript
/*
var $el = $('#pokedex');
view = new Pokedex.Views.Pokemon({ $el: $el });
view.refreshPokemon();
*/
```

In a `PokemonIndex#initialize` method, build an empty `Pokemon` collection
and save it to `this.collection`. Next, `listenTo` a `sync` event on
the collection. This event should cause the view to `render`, so that the
information displayed in the DOM stays current whenever the collection is 
fetched from the server.

In the `PokemonIndex#render` method, first empty out the
`this.$el`. Then iterate through the collection, calling
`#addPokemonToList`. Your `#addPokemonToList` method should render the
`pokemonListItem` template, appending it to `this.$el`.

You'll also want to call `#addPokemonToList` on an `add` event to the collection,
so that any additions to the collection show up immediately in the DOM. Using `listenTo`, the
`pokemon` model that is added will automatically be passed along as an argument
to `addPokemonToList`.

Finally, write a `PokemonIndex#refreshPokemon` method that fetches 
`this.collection`.

You can test your code:
```javascript
var pokemonIndex = new Pokedex.Views.PokemonIndex();
pokemonIndex.refreshPokemon();
$("#pokedex .pokemon-list").html(pokemonIndex.$el);
```

**You should be able to see the index of pokemon. Call your TA
over to look over your code.**

**PokemonList Events**

We want to restore the functionality of being able to click on a
pokemon to display it. To do this, add an `events` hash that listens
for a `click` on a `li` in the view. Tell it to call the
`selectPokemonFromList` event handler.

To start out, let's write `selectPokemonFromList` to just find the
pokemon that was clicked on and print out its name. Check that this
works.

For now, every time you refresh the page, you will have to run this code in the
console to see the pokemon list:
```javascript
var pokemonIndex = new Pokedex.Views.PokemonIndex();
pokemonIndex.refreshPokemon();
$("#pokedex .pokemon-list").html(pokemonIndex.$el);
```

**PokemonDetail**

To actually display the details of the selected pokemon, let's
instantiate a `PokemonDetail` view in the `#selectPokemonFromList`
method. Pass in the selected pokemon as the
`model` parameter. Insert the view's `.$el` into `$("#pokedex
.pokemon-detail")`. Last, call `render` on the `pokemonDetail` view.

We have to write the render method. Set the `template` field of 
`PokemonDetail` to `JST['pokemonDetail]`. In 'PokemonDetail#render', insert 
`this.template` into `this.$el`. We'll just display just the pokemon details 
for now, not any toys. 
**Check that this works**.

Next, we have to render the toys. Let's change our
`PokemonIndex#selectPokemonFromList` code so that instead of calling
`PokemonDetail#render` directly, it instead fetches the pokemon.

In `PokemonDetail`, add a `listenTo` in `initialize` that listens for a `sync` 
on `this.model`. Extend your `#render` method to display the toys, by iterating 
through `model.toys()` and using your `toyListItem` template.

You should now be able to see a list of toys. They don't yet respond to clicks.

**PokemonDetail Events**

Add a click handler for a click on `li`. Use
`PokemonDetail#selectToyFromList` as a click handler. In it, instantiate a
`ToyDetail` view, inserting its $el into `$("#pokedex .toy-detail")` and
calling `ToyDetail#render`.

You'll have to write the `ToyDetail#render` method. When calling the template 
function, just pass an empty array for the `pokemon`
parameter for now. We'll fix the dropdown to reassign the pokemon
later.

## Phase 6: Routing

**PokemonIndex, PokemonDetail**

In the previous section, when you click a pokemon, our `PokemonIndex`
view constructs a `PokemonDetail` view and inserts it into the
DOM. This is not great style; instead, the view should navigate to a
new URL, and a `Router` should construct the new view and insert it.

To begin, extend the `Backbone.Router` class to create `Pokedex.Routers.Router` 
in `app/assets/javascripts/routers/router.js`. Add some intialization logic in `
pokedex.js`: you'll want `new Pokedex.Routers.Router();` and 
`Backbone.history.start()`.

Write a route in the router that maps the root URL to the `pokemonIndex` 
method. In the `pokemonIndex` function, create a new `PokemonIndex` view. Call 
`refreshPokemon` on it, and set the html of `$(#pokedex .pokemon-list)` to its 
$el. Now you won't have to manually run that code anymore. Check that you can 
refresh your page and see the list of pokemon.

Next, we'll change `PokemonIndex#selectPokemonFromList`. Instead of
creating a view, use `Backbone.history.navigate` to move to a
`pokemon/:id` URL. Next, write a second route in the router to
construct/insert the `PokemonDetail` view. Your route function should
accept an `id` parameter. To start, just use `console.log` to verify
the route is invoked, and print out the `id` to check that the id is
set correctly. Remember to pass `{ trigger: true }` as an option to
`Backbone.history.navigate`.

Okay! Now we need to construct the `PokemonDetail` view. This mostly
involves moving the old code from `PokemonIndex#selectPokemonFromList`
to `Pokedex.Routers.Router#pokemonDetail`. The tricky step is getting access to
a collection of all pokemon. To get a collection of all pokemon, have your 
`Router#pokemonIndex` method save the `PokemonIndex` view as 
an instance variable of the router called `this._pokemonIndex`. Then you can 
access `this._pokemonIndex.collection` in `#pokemonDetail`.

**Fixing Direct Navigation to PokemonDetail**

You'll notice that if you go directly to
`http://localhost:3000/#pokemon/1`, nothing will work. That's because
this will invoke `Router#pokemonDetail` when there is no
`this._pokemonIndex`. To solve this, in `#pokemonDetail`, check if there
is a `this._pokemonIndex` saved. If not, call `#pokemonIndex`.

This should get your Pokemon index rendering again, but you won't be
able to see your `PokemonDetail` still. That's because we have to wait
until after the `this._pokemonIndex` is fully fetched. To ensure this,
add a callback argument to `Router#pokemonIndex`; pass this as a
success callback to `PokemonIndex#refreshPokemon`. You'll want to
modify your `PokemonIndex#refreshPokemon` to take a callback and call
it, if present, on a successful fetch.

Test this callback works properly by passing a simple success callback
to `Router#pokemonIndex` in `pokemonDetail`. Just have it print an alert after the index
is rendered.

When this is working, change your `Router#pokemonDetail` so that the
callback passed to `Router#pokemonIndex` will **rerun** the
`pokemonDetail` method. What else do you need to do inside of the `if`
statement to make sure the rest of the `pokemonDetail` method is not run?

**ToyDetail**

Finally, let's write a `pokemon/:pokemonId/toys/:toyId` route. As
before, change `PokemonDetail#selectToyFromList` to use
`Backbone.history.navigate` (don't forget `{ trigger: true }`!).

Your `Router#toyDetail(pokemonId, toyId)` method should first get the
Toy from `this._pokemonDetail.model.toys()`. Therefore, have your
`Router#pokemonDetail` save a `_pokemonDetail` view.

Now you no longer need to keep track of a `pokemon-id` data attribute for each
toy list item.

Again, you'll have to deal with direct navigation to
`http://localhost:3000#pokemon/123/toys/456`. Use the same callback
trick with `Router#pokemonDetail` that you used on
`Router#pokemonIndex`.

What happens to a visible toy detail when you click on a new pokemon?

## Phase 7: Write `PokemonForm` View

**PokemonForm**

The last view to migrate is the `PokemonForm`. Previously, we were
handling the `submit` of the form in `Pokedex.Views.Pokemon` using jQuery.
Now we're going to write a Backbone view to deal with our form
submission.

Write the `pokemonForm` function in the router. It should
initialize a `PokemonForm` view. Typically form views take both a new
model and a collection. We'll see why we need to pass the
collection in a bit. Construct the form view with a new `Pokemon` as the
model, and the `this._pokemonIndex.collection` as the collection. Render
the view and populate `$('#pokedex .pokemon-form')` with it's `$el`.

Call `pokemonForm` in `Router#pokemonIndex`. This will ensure the form
view is rendered for every route.

Next, write the `PokemonForm` view. In the `render` method populate the
`$el` using `this.template`, set to `JST['pokemonForm']`. Pass in `this.model`
as `pokemon`. Remember, we've already written the template for you.

At this point you should be able to refresh your browser and see the
form. Woot!

**Submit**

Add a `submit` handler for the `form` to the `events` hash that calls `savePokemon`.
It should serialize the form data using `serializeJSON` on the
`currentTarget`. Just log it to the console for now and go give it a
test drive.

*See how the object has a key of `pokemon`?*

In `savePokemon` update the model with our serialized data and `save`.
You'll want to use the `pokemon` property of the serialized data.
On successful save of the pokemon, add the model to `this.collection`
and navigate to the pokemon detail page using
`Backbone.history.navigate`. Also, clear the form by re-rendering, and reset the view's model.

At this point, you should be able to delete `app/assets/javascripts/views/pokemon.js` as
well as the commented out lines in `app/assets/javascripts/pokedex.js`.

## Bonus; Phase 8: Toy Reassignment Dropdown

**TODO**

