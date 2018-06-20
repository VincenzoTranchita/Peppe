<%@ page import="java.util.List"%>
<%@ page import="com.virtualpairprogrammers.domain.Car"%>

<!DOCTYPE html>
<html>
<body>

	<%
		List<Car> cars = (List<Car>) request.getAttribute("cars");
	%>

	<h1>Cerca Parcheggio</h1>


	<form action="FindCarPlaceServlet" method="post">
		<input id="autocomplete" style="width: 340px" type="text"
			placeholder="Inserisci destinazione">
		</text>

		<select>
			<%
				for (Car car : cars) {
			%>
			<option value=""><%=car.getName()%></option>
			<%
				}
			%>
		</select>

		

	</form>
	<button id="startsearch" style="width: 55px" type="submit">Cerca</button>
	</br>
	<div id="map" style="width: 600px; height: 600px; background: yellow"></div>


	<script>
		function myMap() {
			var mapOptions = {
				center : new google.maps.LatLng(41.9, 12.48),
				zoom : 10,
				mapTypeId : google.maps.MapTypeId.HYBRID
			}

			var map = new google.maps.Map(document.getElementById("map"),
					mapOptions);

			var geocoder = new google.maps.Geocoder();

// 			google.maps.event.addListener(map, "click", function(event) {
// 				alert("latitude: " + event.latLng.lat() + " longitude: "
// 						+ event.latLng.lng())
// 			});

			var input = document.getElementById('autocomplete');
			var autocomplete = new google.maps.places.Autocomplete(input);

			document.getElementById('startsearch').addEventListener('click',
					function() {
						geocodeAddress(geocoder, map);
					});

		}

		function geocodeAddress(geocoder, resultsMap) {
			var address = document.getElementById('autocomplete').value;
			geocoder
					.geocode(
							{
								'address' : address
							},
							function(results, status) {
								if (status === 'OK') {
									resultsMap
											.setCenter(results[0].geometry.location);
									var marker = new google.maps.Marker({
										map : resultsMap,
										position : results[0].geometry.location
									});
								} else {
									alert('Geocode was not successful for the following reason: '
											+ status);
								}
							});
		}
	</script>

	<script
		src="https://maps.googleapis.com/maps/api/js?sensor=false&libraries=places&language=en&key=AIzaSyDTNgLH1U5z1iVMk8tTV8W8Xo3UFaocHqo&callback=myMap"></script>

</body>
</html>