 --lua语言中的注释用“--”
 local function test(input, seg)
    if (input == "tt") then         --关键字更改，你也可以用or语句定义多个关键字
       file=io.open("C:/TEMP/test.txt","r")
	   a=file:read()
	   io.close()
       yield(Candidate("time", seg.start, seg._end, a, " "))
    end 
 end
 return test