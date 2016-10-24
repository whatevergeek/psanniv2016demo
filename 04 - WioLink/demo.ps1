#01 what if i don't wanna write in other languages
#distance sensor
Invoke-RestMethod ("https://us.wio.seeed.io/v1/node/GroveUltraRangerD2/range_in_cm?access_token=<Your WioLink Access Token>")

#02 turn on the LED
Invoke-RestMethod ("https://us.wio.seeed.io/v1/node/GenericDOutD1/onoff/0?access_token=<Your WioLink Access Token>") -method POST

#03 turn off the LED
Invoke-RestMethod ("https://us.wio.seeed.io/v1/node/GenericDOutD1/onoff/1?access_token=<Your WioLink Access Token>") -method POST

#04 distance/light
for(1 -eq 1){
    $sensor_value = (Invoke-RestMethod ("https://us.wio.seeed.io/v1/node/GroveUltraRangerD2/range_in_cm?access_token=<Your WioLink Access Token>")).range_cm
    Write-Host ("Sensor Value: " + $sensor_value)

    if($sensor_value -gt 10) {
        #03 turn off the LED
        Invoke-RestMethod ("https://us.wio.seeed.io/v1/node/GenericDOutD1/onoff/1?access_token=<Your WioLink Access Token>") -method POST
    }
    else {
        #02 turn on the LED
        Invoke-RestMethod ("https://us.wio.seeed.io/v1/node/GenericDOutD1/onoff/0?access_token=<Your WioLink Access Token>") -method POST
    }
}