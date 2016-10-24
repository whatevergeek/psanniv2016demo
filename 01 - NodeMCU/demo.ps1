#01 - Turn on the light
Invoke-RestMethod "http://<IP of NodeMCU Rest Service>/cmd?led=1"

#02 - Turn off the light
Invoke-RestMethod "http://<IP of NodeMCU Rest Service>/cmd?led=0"

#03 - Blinky
for(1 -eq 1){
    Invoke-RestMethod "http://<IP of NodeMCU Rest Service>/cmd?led=1"
    Start-Sleep -m 500
    Invoke-RestMethod "http://<IP of NodeMCU Rest Service>/cmd?led=0"
    Start-Sleep -m 500
}

#04 Show how it works