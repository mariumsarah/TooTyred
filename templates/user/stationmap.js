/*
 * Copyright 2017 Google Inc. All rights reserved.
 *
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this
 * file except in compliance with the License. You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software distributed under
 * the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
 * ANY KIND, either express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */

// Style credit: https://snazzymaps.com/style/1/pale-dawn


function initMap() {

var geocoder = new google.maps.Geocoder();

  // Create the map.
   map = new google.maps.Map(document.getElementsByClassName('map')[0], {
    zoom: 13,
    center: {lat: 55.950190, lng: -3.187550} ,
     });


  // Load the stores GeoJSON onto the map.


//Location to provide bicycle map
var bikeLayer = new google.maps.BicyclingLayer();
        bikeLayer.setMap(map);

//Shows traffic
var trafficLayer = new google.maps.TrafficLayer();
trafficLayer.setMap(map);
const apiKey = 'AIzaSyB_ItPKqeOzT7ZXw3pQOAIiHRWXo63Q7Qg';
infoWindow = new google.maps.InfoWindow();
infoWindow.setOptions({pixelOffset: new google.maps.Size(0, -30)});
}
