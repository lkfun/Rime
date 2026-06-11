-- lua语言中的注释用“--”
local http = require("simplehttp")
local json = require("json")
local function test(input, seg)
    if (input == "tt") then -- 关键字更改，你也可以用or语句定义多个关键字
        file = io.open("C:/TEMP/test.txt", "r")
        a = file:read()
        io.close()
        yield(Candidate("time", seg.start, seg._end, a, " "))
    elseif input == "tq" then
        local body, code = http.request("http://t.weather.itboy.net/api/weather/city/101230101")
        if code == 200 then
            local data = json.decode(body)
            if data and data.status == 200 and data.data then
                local d = data.data
                local current_temp = d.wendu -- 当前温度
                local today = d.forecast[1] -- 今天
                local tomorrow = d.forecast[2] -- 明天
                local text = string.format("福州 %s℃ %s｜今 %s-%s｜明 %s-%s %s", current_temp, today.type,
                    today.low:gsub('低温 ', ''), today.high:gsub('高温 ', ''), tomorrow.low:gsub('低温 ', ''),
                    tomorrow.high:gsub('高温 ', ''), tomorrow.type)
                yield(Candidate("weather", seg.start, seg._end, text, ""))
            end
        end
    end
end
return test
