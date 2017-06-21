local moduleName = 'Socket'
local M = {}
_G[moduleName] = M


srv = nil
socket = nil
rcv = ""
bIshome = false
isConnected = false

function M.isConnected()
return isConnected
end

function M.send(data)
if(isConnected)then socket:send(data) end
end

wifi.setmode(wifi.STATION)
wifi.sta.eventMonReg(wifi.STA_GOTIP, function()
--print("got IP")
srv = net.createConnection(net.TCP, 0)
srv:on("receive", function(sck, c)
--getFb(10000)
--uart.alt(1)
--uart.write(0,c.."\r\n")
--GPRS.listen()
--GPRS.send(c)
--echo("send :"..c.."\r\n")
--uart.alt(0)
end)
srv:on("connection", function(sck, c)
  -- Wait for connection before sending.
  sck:send("connected!\r\n")
  socket = sck
  isConnected = true
end)
srvIp = "192.168.0.5"
if(bIshome)then srvIp = "192.168.2.5" end
srv:connect(1133,srvIp)
end)
wifi.sta.eventMonStart()

station_cfg={}
station_cfg.ssid="Tenda_01A350"
station_cfg.pwd="ef9daeb093"
if(bIshome) then 
station_cfg.ssid="8#104"
station_cfg.pwd="woshinvwang"
end
wifi.sta.config(station_cfg)
wifi.sta.connect()

--------------------

return M
