require("Oled")
require("SensorDetector")
require("keyDetector")
KeyDetector.enableTrig()

if( file.open("webConfigRequest.lua") ~= nil) then
     print("web config request")
     require("EasyWebConfig")
     EasyWebConfig.addVar("ssid")
     EasyWebConfig.addVar("password")
     OLED.showInfo("http://192.168.4.1/",5)
else
     print("show sensors")
     OLED.showInfo("LEWEI50 SENSOR HUB",5,SensorDetector.detectSensor)
     require("LeweiMqtt")
     if( file.open("network_user_cfg.lua") ~= nil) then
          require("EasyWebConfig")
          EasyWebConfig.doMyFile("run.lua")
     end
end
--require("Socket")

--SensorDetector.stopAllOutPut()
--
