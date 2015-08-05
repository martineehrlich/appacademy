$.UsersSearch = function (el) {
  this.$el = $(el);
  this.$input = $(".input");
  this.$users = $(".users");

  this.$input.on('input', this.handleInput.bind(this));
};

$.UsersSearch.prototype.handleInput = function (event) {
  event.preventDefault();
  var queryval = this.$input.val();
  var queryobj = { query: queryval};

  $.ajax({
      url: "/users/search",
      type: "get",
      dataType: 'json',
      data: queryobj,
      success: function (data, statusText, jqXHR) {
        this.renderResults(data);
      }.bind(this),
      error: function () {
        console.log(arguments);
      }
    });


};

$.UsersSearch.prototype.renderResults = function (data) {
  this.$users.empty();
  data.forEach(function (el) {

    if (el["followed"]) {
      var followState = "followed";
  } else {
      followState = "unfollowed";
    }


    var $userEl = $("<li></li>");
    var $button = $("<button></button>");
    $userEl.text(el["username"]);

    $button.addClass("follow-unfollow");
    $button.data("follow-state", followState);
    $button.data("user-id", el["id"]);
    $button.followToggle();

    $userEl.append($button);

    this.$users.append($userEl);
    // debugger;
  }.bind(this));


  // this.$users.append()
};

$.fn.UsersSearch = function () {
  return this.each(function () {
    new $.UsersSearch(this);
  });
};

$(function () {
  $("div.users-search").UsersSearch();
});
