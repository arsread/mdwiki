  var Filter = new function() {
  var $ = jQuery;
  var $this = this;

  this.bind = function(input) {
    $(input).bind('keyup'  ,function(e) { onkeyup(e, filter); } )
  };

  var onkeyup = function(e, filter) {
    switch(e.keyCode) {
      case 37: //Event.KEY_LEFT:
      case 38: //Event.KEY_UP:
      case 39: //Event.KEY_RIGHT:
      case 40: //Event.KEY_DOWN:
      case 9:  //Event.KEY_TAB:
      case 91: //meta
      case 16: //shift
      case 17: //ctrl
      case 18: //alt
      case 19: //ctrl
        if (e.charCode == 0) { return; }
    }

    $this.current = e.target.value;
    $this.matches = [];
    if ($this.z) clearTimeout($this.z);
    $this.z = setTimeout(function() { filter(e.target.value) }, 10)
  }

  var filter = function(match) {
    if (match == null || match == '' || match.lenght == 0) {
      $('#all_items').removeClass('none')
        $('#search_results').addClass('none')
    } else {
      $('#all_items').addClass('none')
        $('#search_results').removeClass('none')
        $('#search_results').html('')

        if ($this.z) clearTimeout($this.z);
      $this.z = setTimeout(function() { filterer(match, 0); }, 10);
    }

    var filterer = function(match, pos) {
      var count = pos;
      var m = [];
      while(true) {
        if (pos >= wiki_items.length) break;
        if ($this.current != match) break;
        if ($this.matches.length >= 15) break;
        var s = wiki_items[pos];
        if (s && s.toLowerCase().indexOf(match.toLowerCase()) >= 0) {
          $this.matches.push(s);
          m.push(s);
        }
        pos++;
        if (pos - count >= 200) { 
          if ($this.z) clearTimeout($this.z);
          $this.z = setTimeout(function() { filterer(match, pos) }, 10);
          break;
        }
      }
      $('#search_results').append(Table(m.reverse()));
    }
  }
};

var Table = function(data) {
  var html = '';
  for(var i = 0; i < data.length; i++ ) {
    var s = data[ data.length - i - 1 ];
    html += '' +
      '<tr id="' + s + '">' +
      '<td class="name">' + '<a href="http://arsread.wicp.net/wiki/#!' + s + '.md">' + s + '</a></td>' +
      '</tr>'
  }
  return html;
}

var wiki_items = [];

jQuery(function($) {

  $.ajax({
    type: "GET",
    url: "items.json",
    dataType: "json",
    success: function(data) { 
      wiki_items = data; 
      Filter.bind(jQuery('#filter'));
      $('#filter').attr('value', window.location.search.replace('?',''))
      $('#filter').trigger('keyup');
      $('#filter').focus();
      setTimeout(function() {$('#all_items').html(Table(wiki_items))}, 10);
    }
  });
});
