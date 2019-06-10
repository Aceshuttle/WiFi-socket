print('Setting up WIFI...')
wifi.setmode(wifi.STATIONAP)
station_cfg={}
station_cfg.ssid="NALAN"
station_cfg.pwd="123456789"
station_cfg.save=false
wifi.sta.config(station_cfg)
wifi.sta.connect()
pin=4
gpio.mode(pin,gpio.OUTPUT)
tmr.alarm(1, 1000, tmr.ALARM_AUTO, function()
    if wifi.sta.getip() == nil then
        print('Waiting for IP ...')
    else
        print('IP is ' .. wifi.sta.getip())
        dofile("HS_demo.lua")
    tmr.stop(1)
    end
end)

