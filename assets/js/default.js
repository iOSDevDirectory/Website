document.addEventListener("DOMContentLoaded", function () {
  document.querySelectorAll('a[href^="http"]').forEach(function (link) {
    if (link.hostname !== location.hostname) {
      link.target = "_blank";
      link.rel = "noopener";
    }
  });
});
