local moduleName = "OLED"
local M = {}
_G[moduleName] = M

local info = ""
local infoTime = 0
local callbackFn = nil
local showSensorValues = false

function M.init_OLED(sda,scl) --Set up the u8glib lib
     sla = 0x3c
     i2c.setup(0, sda, scl, i2c.SLOW)
     disp = u8g.sh1106_128x64_i2c(sla)
     disp:setRot180()
     disp:setFont(u8g.font_6x10)
     disp:setFontRefHeightExtendedText()
     disp:setDefaultForegroundColor()
     disp:setFontPosTop()
end
M.init_OLED(1,2) --Run setting up

rfreshtimer = tmr.create()
rfreshtimer:register(1000, tmr.ALARM_AUTO, function() 
infoTime = infoTime -1
disp:firstPage()
     repeat
          disp:drawStr(5,25,info)
          if(infoTime==0)then
               --info = ""
               rfreshtimer:stop()
          else
          end
     until disp:nextPage() == false
     if(infoTime ==0 and callbackFn~=nil)then
          callbackFn()
      end
end)
rfreshtimer:stop()




local function varChk(data)
     key,val = string.match(data, "setvar:([%w_]+)=(%w+)%&%^%!")
     print(key,val)
     if(key ~= nil and val ~= nil) then
          
          return true
     end
     return false
end
--data = "setvar:user_key=asdfw923842asf342af&^!"
--data = "setvar:userkeasfd!"
--print(varChk(data))

--showInfo(content,showtime,callbackfunction)
function M.showInfo(cnt,count,cbFn)
     info = cnt
     infoTime = count
     callbackFn = cbFn
     rfreshtimer:start()
end

function M.showSensorValues()
     --init_OLED(1,2)
     --LeweiMqtt.appendSensorValue("dust",123)
     --LeweiMqtt.appendSensorValue("AQI",235)
     --LeweiMqtt.appendSensorValue("dust10",130)
     --LeweiMqtt.appendSensorValue("H1",50)
     sla = 0x3c
     i2c.setup(0, 1, 2, i2c.SLOW)
     
     sensors = LeweiMqtt.getSensorValues()
     disp:firstPage()
     
     repeat
     local posX = 5
     local posY = 20
     local offsetX = 64
     local offsetY = 15
     local count = 0
     local line = 0
     for i,v in pairs(sensors) do 
          --M.showInfo("{\"Name\":\""..i.."\",\"Value\":\"" .. v .. "\"},",1)
          --print(posX+count*offsetX,posY+count*offsetY,line,i,v) 
          disp:drawStr(posX+count%2*offsetX,posY+line*offsetY,i..":"..v)
          if(count%2==1)then line = line+1 end
          count = count + 1
     end
     --print("sensors length ==",count)
     until disp:nextPage() == false
     
     
     --[[
     disp:firstPage()
     repeat
          disp:drawStr(5,25,"showSensorValues")
     until disp:nextPage() == false
     ]]--
end

return M
