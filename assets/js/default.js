$(function() {
  $("a[href^=http]").click(function() {
    if(this.href.indexOf(location.hostname) == -1) {
      $(this).attr({ target: "_blank", title: "Opens in a new window" });
    }
  })
})