local list = require('completion.list')

LRU = {
  capacity = 1000,
}

function LRU:new(capacity)
  local o = {}
  setmetatable(o, self)
  self.__index = self
  self.capacity = capacity or 1000
  self.data = list.create_list()
  self.index = {}
  return o
end

function LRU:add_data(data)
  if self.index[data] then
    local node = self.index[data]
    self.data:remove_node(node)
    self.data:add_data(data)
    self.index[data] = self.data.tail
  else
    self.data:add_data(data)
    self.index[data] = self.data.tail
    if self.data.size > self.capacity then
      local node = self.data.head
      if node then
        self.index[node.data] = nil
      end
      self.data:pop_front()
    end
  end
end

function LRU:get_keys()
  local result = {}
  for word, node in pairs(self.index) do
    if node then
      result[word] = true
    end
  end
  return result
end

local M = {}

M.create_lru = function(capacity)
  return LRU:new(capacity)
end

return M;
