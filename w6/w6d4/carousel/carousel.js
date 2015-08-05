(function ($) {
  $.Carousel = function (el) {
    this.$el = $(el);
    this.activeIdx = 3; // remember to reset to 0
    this.transitioning = false;
    this.$activeImg = $(".items").children().eq(this.activeIdx).addClass("active");
    $(".slide-right").on("click", this.slide.bind(this, -1));
    $(".slide-left").on("click", this.slide.bind(this, 1));
  };

  $.Carousel.prototype.slide = function (dir) {
    var direc, oppositeDirec;
    if (this.transitioning) { return; }

    this.transitioning = true;
    if (dir === -1) {
      direc = "right";
      oppositeDirec = "left";
    } else {
      direc = "left";
      oppositeDirec = "right";
    }

    this.$activeImg.addClass(oppositeDirec);
    var $oldImg = this.$activeImg;
    this.activeIdx = (this.activeIdx += dir) % this.$el.find("img").length;
    this.$activeImg = this.$el.find(".items").children().eq(this.activeIdx);
    this.$activeImg.addClass("active " + direc);
    var activeImg = this.$activeImg;

    setTimeout(function () {
      activeImg.removeClass(direc + " " + oppositeDirec);
    }, 0);
    var carousel = this;
    $oldImg.one("transitionend", function () {
      $oldImg.removeClass("active " + oppositeDirec);
      carousel.transitioning = false;
    });
  };

  $.fn.carousel = function () {
    return this.each(function () {
      new $.Carousel(this);
    });
};

}(jQuery));
