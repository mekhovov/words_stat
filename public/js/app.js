
$(document).ready(function() {

  var options = {
      success:       showResponse
  };

  $('#text_form').submit(function() {
      $(this).ajaxSubmit(options);
      return false;
  });

  $("#limit-slider").slider({
    orientation: "vertical",
    range: "min",
    min: 0,
    max: 20,
    value: 5,
    slide: function (event, ui) {
        $("#limit").val(ui.value);
    }
  });

  $("#limit").val($("#limit-slider").slider("value"));

});


function showResponse(response)  {
  var words = $.parseJSON(response);
  $('#words_stat').html("");
  for(key in words) {
    $('#words_stat').append('' +
        '<li class="tag">' +
          '<a href="#">' +
            '<span class="tag-button">' +
              '<span class="tag-count">' + words[key] + '</span>' +
              '<span class="tag-name">' + key +'</span>' +
            '</span>' +
          '</a>' +
        '</li>'
    );
  }
}

