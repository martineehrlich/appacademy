$.TweetCompose = function (el) {
  this.$el = $(el);
  this.inProgress = false;
    // $('.user-list').on("click", ".follow-unfollow", this.handleClick.bind(this));
  this.$el.on('submit', this.submit.bind(this));
};

$.TweetCompose.prototype.clearInput = function () {
  $(":input").empty();
};

$.TweetCompose.prototype.handleSuccess = function (tweet) {
  this.clearInput();
  this.inProgress = false;
  debugger
  // $("#feed").append(<li>)
};



$.TweetCompose.prototype.submit = function (event) {
    debugger
    event.preventDefault();
    if (this.inProgress === true) { return; }


    var $form = $(event.currentTarget);
    var formData = $form.serializeJSON();

    this.inProgress = true;

    $.ajax({
      url: "/tweets",
      type: "post",
      data: formData,
      success: function (tweet, statusText, jqXHR) {
        var tweetEl = tweet;
        this.handleSuccess(tweetEl);


        // $form.find("textarea").val("");

        // previously, we built the new comment's element with jQuery; in the
        // final implementation, we use an Underscore template.
        // var $commentEl = $("<li></li>");
        // $commentEl.append("<span>" + comment.body + "</span>");
        // $commentEl.append('<button class="delete-comment" data-id="' + comment.id + '">Delete</button>');
      }.bind(this),
      error: function (jqXHR, errorText, somethingElse) {
        debugger;
      }
    });
};

$.fn.TweetCompose = function (options) {
  return this.each(function () {
    new $.TweetCompose(this, options);
  });
};

$(function () {
  $("button.tweet-compose").TweetCompose();
});
