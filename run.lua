print("run.lua")
LeweiMqtt.init(userKey,gateWay)
LeweiMqtt.connect()

sendTimer = tmr.create()
sendTimer:register(60000, tmr.ALARM_AUTO, function() 

sensors = LeweiMqtt.getSensorValues()
count = 0
for i,v in pairs(sensors) do
          count = count + 1
end

index = 0
for i,v in pairs(sensors) do
     index = index + 1
     print(i,v,index,count)
     if(index == count) then
     print("S")
          LeweiMqtt.sendSensorValue(i,v)
     else
     print("A")
          LeweiMqtt.appendSensorValue(i,v)
     end
end
end)
sendTimer:start()
