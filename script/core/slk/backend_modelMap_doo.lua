local mt = {}
mt.__index = mt

function mt:add(format, ...)
    self.hexs[#self.hexs+1] = (format):pack(...)
end

function mt:add_head()
    self:add('c4LL', 'W3do', 8, 11)
end

function mt:add_data()
    self:add('L', 0)
end

--这个保存仅能够补充缺失而使用
return function(self)
    local tbl = setmetatable({}, mt)
    tbl.hexs = {}
    tbl.self = self

    tbl:add('c4LL', 'W3do', 8, 11)
    tbl:add('L', 0)

    --write_special_version
    tbl:add('L', 0)
    --special_doodads
    tbl:add('L', 0)

    return table.concat(tbl.hexs)
end
