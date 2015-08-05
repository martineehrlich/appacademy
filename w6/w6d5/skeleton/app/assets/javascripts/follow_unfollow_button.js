$.FollowToggle = function (el, options) {
  this.$el = $(el);
  this.userId = this.$el.data("user-id");
  this.followState = this.$el.data("follow-state");
  this.inProgress = false;
  this.render();

  // $('.user-list').on("click", ".follow-unfollow", this.handleClick.bind(this));
  this.$el.on('click', this.handleClick.bind(this));
};

$.FollowToggle.prototype.render = function () {
  console.log("rendering: " + this.followState);
  if (this.followState === "unfollowed") {
    this.$el.html("Follow!");
  }
  else {
    this.$el.html("Unfollow!");
  }
};

$.FollowToggle.prototype.handleClick = function (event) {
  event.preventDefault();

  if (this.inProgress === true) {return;}
  this.inProgress = true;
  var request, state;

  if (this.followState === "followed"){
    request = "delete";
    state = "unfollowed";
  } else {
    request = "post";
    state = "followed";
  }

  this.followState = "following";

  $.ajax({
      url: "/users/" + this.userId + "/follow",
      type: request,
      dataType: 'json',
      success: function (data, statusText, jqXHR) {
        // $target.data(".follow-state", state);
        this.followState = state;
        this.render();
        this.inProgress = false;
      }.bind(this),
      error: function () {
        console.log(arguments);
      }
    });

};

$.fn.followToggle = function (options) {
  return this.each(function () {
    new $.FollowToggle(this, options);
  });
};

$(function () {
  $("button.follow-unfollow").followToggle();
});
