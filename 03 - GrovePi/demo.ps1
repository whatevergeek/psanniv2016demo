#01 show message
Invoke-RestMethod ("http://<IP of Raspberry Pi running Grove Pi Rest Service>:5000/displaymessage/" + "Powershell is       Awesome!!!")

#02 get light sensor
for(1 -eq 1){
    $sensor_value = (Invoke-RestMethod ("http://<IP of Raspberry Pi running Grove Pi Rest Service>:5000/lightsensor")).results.sensor_value
    Write-Host ("Sensor Value: " + $sensor_value)

    if($sensor_value -gt 50) {
        Invoke-RestMethod "http://<IP of NodeMCU Rest Service>/cmd?led=1"
    }
    else {
        Invoke-RestMethod "http://<IP of NodeMCU Rest Service>/cmd?led=0"
    }

    Start-Sleep -m 500
}

#03 show how it works