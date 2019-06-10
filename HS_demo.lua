local tt=false
gpio.mode(3,gpio.OUTPUT)      --设置8266模块的GPIO01脚用作HS01的控制
gpio.mode(4,gpio.OUTPUT)      --设置8266模块的GPIO02脚用作HS02的控制
local userkey="687b0a91ba7043c6bfe08dfab369986d"
require("LeweiTcpClient")
LeweiTcpClient.init("02",userkey)     ---两个参数，分别是设备标识和UserKey
function test01(pl)
if pl=="1" then
   gpio.write(3,gpio.HIGH)
else
   gpio.write(3,gpio.LOW)
end
local vl=gpio.read(3)
print("test function!GPIO01: "..vl)
end
function test02(pl)
if pl=="1" then
   gpio.write(4,gpio.LOW)
else
   gpio.write(4,gpio.HIGH)
end
local vl=gpio.read(4)
print("test function!GPIO02: "..vl)
end
LeweiTcpClient.addUserSwitch(test01,"HS01",tostring(gpio.read(3)))
LeweiTcpClient.addUserSwitch(test02,"HS02",tostring(gpio.read(4)))

require("LeweiHttpClient")
LeweiHttpClient.init("02",userkey)

tmr.alarm(0, 30000, 1, function()
local vB ="{"..tostring(gpio.read(3))..","..tostring(gpio.read(4)).."}"
print(">>>>>>>>Set Sensor to: "..vB)
--添加数据，等待上传
LeweiHttpClient.appendSensorValue("SC-SH",vB)
--实际发送数据
LeweiHttpClient.sendSensorValue("SC-SH",vB)
end)
