# Recreating the ping command using assembly language (x64)
## Following <a href="https://www.youtube.com/watch?v=SxtX0VWZuME">this video</a>

### What is a ping command ? 
The ping utility serves a way to try to contact another devices by sending him an ICMPv4 packet named *Echo Request*.
This way, you can check if this machine is "alive" if it responds with an *Echo Reply* packets back.
Sometimes, devices are parametered to not send back *Echo Reply* back for multiple reason (try to trick hacker into thinking that the device is off, privacy etc...)

### Summary
|Function|
|---|
|socket|
|sendto|
|recvfrom|
