-- # tableok : unit tests for table

require "show"	
local R=  require "random"
local the=  require "config"
local O=    require "tests"	
local TBL=  require "tbl"
local ROW=  require "row"
local LST=require "lists"
----------------------------------------------------------
-- process 14 rows
 local function _test0()
   local t=TBL.create(the.here .. "/data/weather.csv")
  print(t.spec)
   assert(#t.rows==14)
   assert(t.rows[14].cells[1]=="rainy")
   assert(O.nstr(t.all.nums[1].mu,4) == O.nstr(73.5714,4))
   assert(O.nstr(t.all.nums[1].sd,4) ==  O.nstr(6.5717,4))
   assert(t.x.syms[1].counts["overcast"] == 4)
   assert(t.x.syms[2].counts["TRUE"]==6)
end
----------------------------------------------------------
-- process 400 rows
local function _test3()
  print(22)
  local dom={}
  local t=TBL.create(the.here .. "/data/auto.csv")
  for j,row in pairs(t.rows) do
      dom[row.id] = ROW.dominate(row,t) end
  table.sort(t.rows, function (x,y)
              return dom[x.id] > dom[y.id] end)
  print(t.spec)
  for j=1,5               do print(t.rows[j]) end
  print("")
  for j=#t.rows-5,#t.rows do print(t.rows[j]) end
end 
----------------------------------------------------------
local function _test4(f,y)
   y = y or "dom"
   -- local function y(r,t) return row.dominate(r,t) end
   f = f or "/data/auto.csv"
   local t1=TBL.create(the.here .. f)
   print(f,#t1.rows)
   local t2=TBL.discretize(t1, y) -- tbl[y](t1)) --  y, false)
   for _,r1 in pairs(t1.rows) do
     local found = false
     for _,r2 in pairs(t2.rows) do
       if r2.id == r1.id then
         found= true end end
     if not found then print("????") end end
   for _,head in pairs(t2.x.cols) do
     if head.bins then
       print(#head.bins,head.txt) end end
   --for k=1,5 do print(t1.rows[k].cells) end
   --print("")
   --for k=1,5 do print(t2.rows[k].cells) end
end
---------------------------------------------
--
local function _test6(show,f)
   y = y or "goal1"
   -- local function y(r,t) return row.dominate(r,t) end
   f = f or "/data/weather.csv"
   local t1=TBL.create(the.here .. f)
   print("")
   for _,row1 in pairs(t1.rows) do
      local row2=TBL.nearest(t1,row1)
      local row3=TBL.furthest(t1,row1)
      io.write(".")
      if show then
        print("")
        print(row1.cells)
        print(row2.cells ,"nearest")
        print(row3.cells,"furthest") end
   end 
end 
local function _test7(f)
   f = f or "/data/weather.csv"
   local t1=TBL.create(the.here .. f)
   TBL.show(t1)
end 
R.r(1)

local function _test1(f) _test4(f) end
local function _test2() _test4("/data/xomo_all_short.csv") end
local function _test5() _test4("/data/POM3A_short.csv") end

O.k{_test0,_test1,_test2,_test3,_test5}
_test6(true)
_test6(false,"/data/auto.csv")
_test6(false,"/data/xomo_all_short.csv")
_test7("/data/auto.csv")
