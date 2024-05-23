// https://api.openweathermap.org/data/2.5/weather?lat=35.8301498&lon=127.1365699&appid=9e9bd3ff3286421c3fbdc567b6aab1f7&units=metric

function onGeoOk(position){
	const API_KEY = "9e9bd3ff3286421c3fbdc567b6aab1f7";
    const lat = position.coords.latitude;
    const lon = position.coords.longitude;
    const url = `https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=${API_KEY}&units=metric`;
    fetch(url).then((response) => response.json()).then((data) => {
		const city = document.querySelector("#location span");
		const temp = document.querySelector("#temp span");
		const weather = document.querySelector("#weather span:last-child");
    	city.innerText = data.name;
    	weather.innerText = `${data.weather[0].main}`
		temp.innerText = `${data.main.temp}`+"℃";
		const weatherIcon = `${data.weather[0].icon}`;
		const weatherIconAdrs = `https://openweathermap.org/img/wn/${weatherIcon}@2x.png`;
		
		const iconImage = document.createElement("img");
		iconImage.src = weatherIconAdrs;
        iconImage.alt = "Weather Icon";
        document.querySelector("#weatherIcon").appendChild(iconImage);
    });
}

function onGeoError(){
    let weather = document.getElementById("weather");
    weather.innerHTML = "위치를 가져올 수 없습니다.";
}

navigator.geolocation.getCurrentPosition(onGeoOk, onGeoError);
