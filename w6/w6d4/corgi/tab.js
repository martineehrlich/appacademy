

(function ($) {
$.Tabs = function (el) {
  this.$el = $(el);
  this.$contentTabs = $("#content-tabs");
  this.$activeTab = $(this.$contentTabs.children(".active"));
  var $tabs = $(".tabs");
  $tabs.on("click", "a", this.clickTab.bind(this));
};

$.Tabs.prototype.clickTab = function (event) {
  event.preventDefault();
  this.$activeTab.removeClass("active").addClass("transitioning");
  var $clickedLink = $(event.currentTarget);
  $(".tabs .active").removeClass("active");
  $clickedLink.addClass("active");


  var $oldActive = this.$activeTab;
  this.$activeTab = $($clickedLink.attr("for"));

  var thisActiveTab = this.$activeTab;

  $oldActive.one("transitionend", function () {
    $oldActive.removeClass("transitioning");
    thisActiveTab.addClass("active").addClass("transitioning");
    window.setTimeout(function () {
      thisActiveTab.removeClass("transitioning");
    }, 0);

  });
};

$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};
}(jQuery));
