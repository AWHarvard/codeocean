$(function() {
  var ANIMATION_DURATION = 500;

  $.isController = function(name) {
    return $('.container[data-controller="' + name + '"]').isPresent();
  };

  $.fn.isPresent = function() {
    return this.length > 0;
  };

  $.fn.scrollTo = function(selector) {
    $(this).animate({
      scrollTop: $(selector).offset().top - $(this).offset().top + $(this).scrollTop()
    }, ANIMATION_DURATION);
  };
});
