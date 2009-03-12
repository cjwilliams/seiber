function createMarker(point,html) {
    var marker = new GMarker(point);
    GEvent.addListener(marker, "click", function() {
     marker.openInfoWindowHtml(html);
     });
    return marker;
}

function initialize() {
    var map = new GMap(document.getElementById("map"));
    map.addControl(new GSmallMapControl());
    map.centerAndZoom(new GPoint(<%= @map_center.lng %>,<%= @map_center.lat %>), 4);

    <% @properties.each do |property| %>
    var point = new GPoint(<%= property[:lng] %>,<%= property[:lat] %>);
    var marker = createMarker(point,'<div><%= h property.address %></div>')
    map.addOverlay(marker);
    <% end %>
}