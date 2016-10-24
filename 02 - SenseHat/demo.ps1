#01 show message
Invoke-RestMethod ("http://<IP of Raspberry Pi running SenseHat Rest Service>:5000/displaymessage/" + "Hello Powershell")

#02 get accelerometer values
for(1 -eq 1){
    $r = (Invoke-RestMethod ("http://<IP of Raspberry Pi running SenseHat Rest Service>:5000/accelerometer")).results
    Write-Host ("x: " + $r.x +", y: " + $r.y + "z: " + $r.z )
    Start-Sleep -m 500
}

#03 show how it works