ListNode = {
  next = nil,
  prev = nil,
  data = nil,
}

List = {
  size = 0,
  head = nil,
  tail = nil,
}

function ListNode:new(data)
  local o = {}
  setmetatable(o, self)
  self.__index = self
  self.data = data
  return o
end

function List:new()
  local o = {}
  setmetatable(o, self)
  self.__index = self
  self.size = 0
  self.head = nil
  self.tail = nil
  return o
end

function List:add_data(data)
  if not self.head then
    self.head = ListNode:new(data)
    self.tail = self.head
  else
    local new_node = ListNode:new(data)
    new_node.prev = self.tail
    self.tail.next = new_node
    self.tail = new_node
  end
  self.size = self.size + 1
end

function List:remove_node(node)
  local prev_node = node.prev
  local next_node = node.next
  if prev_node then
    prev_node.next = next_node
  end
  if next_node then
    next_node.prev = prev_node
  end
  self.size = self.size - 1
end

function List:pop_front()
  if not self.head then
    return
  end

  if self.head == self.tail then
    self.head = nil
    self.tail = nil
  else
    self.head = self.head.next
  end
end

function List:pop_back()
  if not self.tail then
    return
  end

  if self.tail == self.head then
    self.head = nil
    self.tail = nil
  else
    self.tail = self.tail.prev
  end
end

function List:find_node(data)
  local it = self.head
  while (it)
  do
    if it.data == data then
      return it
    end
    it = it.next
  end
end

local M = {}

M.create_node = function(data)
  return ListNode:new(data)
end

M.create_list = function()
  return List:new()
end

return M
