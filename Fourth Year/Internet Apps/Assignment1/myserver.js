import fetch from "node-fetch";
import express from "express";
import dotenv from "dotenv";
import cors from 'cors';
dotenv.config();


var app = express()
app.use(cors())
const port = 3000;
const API_KEY = '4c4b8e439cc42171116fe5870881340d';

// This function works by scanning through all the weather data looking to see of the weather is "Rain". Despite there being rain
// this function never returns true and I am not sure why. 
function willRainNext5Days(weather){
    const weatherArr=[];
    weather.forEach((element) => {
        if(element["weather"][0]["main"]){
            console.log("IT IS RAINING")
            return true;
        }
        weatherArr.push(element["weather"][0]["main"]);
    });
    console.log(weather.includes("Rain"))
    return weather.includes("Rain");
}

function getTempMax(weather){
    const maxTempArr=[];
    weather.forEach((element) => {
        let maxTemp = element["main"]["temp_max"];
        //console.log("max temp: "+maxTemp);
        maxTempArr.push(maxTemp );
    });
    maxTempArr.sort();
    //console.log(maxTempArr.pop());
    return Math.round((maxTempArr.pop()- 273.15)*100)/100;
}

function range(weather){
    let min = getTempMin(weather)
    let max = getTempMax(weather)
    return getTempRange(min, max)
}
function getTempMin(weather){
    const minTempArr=[];
    weather.forEach((element) => {
        let minTemp = element["main"]["temp_min"];
        //console.log("min temp: "+minTemp);
        minTempArr.push(minTemp );
    });
    minTempArr.sort();
    //console.log(minTempArr.pop());
    return Math.round((minTempArr[0]- 273.15)*100)/100;
}

function getTempRange(min, max){
    let range = "";
    if(getRange(min)==getRange(max)){
        return "It will be "+getRange(min);
    }else{
        return "It will range from "+getRange(min)+" to "+getRange(max);
    }
    
}

function getRange(temp){
    if(temp<10){
        return "cold";
    }else if(temp >=10 && temp <=20){
        return "warm"
    }
    return "hot";
}



// This function states if a user should wear a mask i.e. pm2_5 level is greater than 10
function airReportNext5Days(airPollution){
    const airPollArr=[];
    airPollution.forEach(element => {
        airPollArr.push(element["components"]["pm2_5"]);
    });
    return airPollArr.some(el => el > 10);
}


app.get('/test', async function (req, res) {
    if(req.query["city"]==undefined || req.query["city"].length==0){
        res.status(400);
        res.json({error : "Invalid city, please try again"});
        return;
    }

    let city = req.query["city"];
    let cityCoords = `https://api.openweathermap.org/data/2.5/forecast?q=${city}&appid=${API_KEY}`;
    let response = await fetch(cityCoords);
    if(response.status == 200){
        let data = await response.json();
        let weather = data["list"];
        
        let lat = data["city"]["coord"]["lat"];
        let long = data["city"]["coord"]["lon"];

        let dailyWeatherUrl = `https://api.openweathermap.org/data/2.5/onecall?lat=${lat}&lon=${long}&exclude=current,minutely,hourly,alerts&appid=${API_KEY}`
        let responseDaily = await fetch(dailyWeatherUrl)
        let dailyWeatherData = await responseDaily.json();
      
        dailyWeatherData = dailyWeatherData["daily"]
        console.log(dailyWeatherData["weather"]);
        
        let airPollutionUrl = `http://api.openweathermap.org/data/2.5/air_pollution?lat=${lat}&lon=${long}&appid=${API_KEY}`;
        let airResponse = await fetch(airPollutionUrl);
        let airData = await airResponse.json();
        let airPollution = airData["list"];
        console.log(willRainNext5Days(dailyWeatherData))
        res.status(200);
        res.json({
            rain : willRainNext5Days(weather),
            tempRange : range(weather),
            weather : dailyWeatherData,
            airQuality : airReportNext5Days(airPollution),
        });
        return;
    }else{
        res.status(500);
        res.json({
            error : "Something went wrong!"
        })
        return;
    }
});

app.listen(port, function () {
  console.log(`listening on ${port}`);
});