-- # sdtree : iterative divisions to minimize sd

-- Assumes discrete data

require "show"
local the=require "config"
local num=require "num"
local lst=require "lists"
local row=require "row"
------------------------------------------------
local function create(t0,rows)  return {
  here=tbl.copy(t0,rows),
  breaks={}}
end
------------------------------------------------
return function (t,y,z,     cols) 
  y = y or function (_) return row.dominate(_,t) end
  z = z or function (_) return _.sd end
  -----------------------------------------------
  local function xpect(col)
    if not col._score then
      col._score=0
      for _,num in pairs(col.nums) do
        col._score = col._score+ z(num)* num.n / col.n end end
    return col._score end
  -----------------------------------------------
  local function whatif(head)
    local col = {pos=head.pos, nums={},_score=nil,n=0} 
    for _,row in pairs(t.rows) do
       local x = row.cells[col.pos]
       print(row, y(row))
       if x ~= the.ignore then
         col.n = col.n + 1
         col.nums[x] = num.update(col.nums[x] or num.create(), 
                                  y(row))  end end
    return col end
  -------------------  
  return lst.sort( lst.collect(t.x.cols, whatif),
                   function(a,b) 
                     return xpect(a) < xpect(b) end)
end
