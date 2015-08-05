(function ($) {
  $.Thumbnails = function (el) {
    this.$el = $(el);
    this.$gutterImages = $(".gutter-images").children();
    this.$activeImage = this.$gutterImages.eq(0);
    this.activate(this.$activeImage);
    var thumbnail = this;

    $(".gutter-images").on("click", "img", function (event) {
      event.preventDefault();
      var $currentImage = $(event.currentTarget);
      thumbnail.$activeImage = $currentImage;
      $("div.active").empty();
      thumbnail.activate($currentImage);
    });

    $(".gutter-images").on("mouseenter", "img", function (event) {
      event.preventDefault();
      $("div.active").empty();
      thumbnail.activate($(event.currentTarget));
    });

    $(".gutter-images").on("mouseleave", "img", function (event) {
      event.preventDefault();
      $("div.active").empty();
      thumbnail.activate(thumbnail.$activeImage);
    });
  };

  $.Thumbnails.prototype.activate = function ($img) {
      $("div.active").append($img.clone());

  };

  $.fn.thumbnails = function () {
    return this.each(function () {
      new $.Thumbnails(this);
    });
  };
}(jQuery));
