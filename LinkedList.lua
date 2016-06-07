error( 'Unimplemented' )

local floor, setmetatable = math.floor, setmetatable

local Nil = {}
Nil[1] = Nil
Nil[2] = Nil
Nil[3] = Nil

local LinkedList = {}

local LinkedListMt

function LinkedList.new( array )
	local self = setmetatable( {
		_size = 0,
		_head = Nil,
		_tail = Nil,
	}, LinkedListMt )

	if array then
		self:pusharray( array )
	end

	return self
end

local function insertbefore( self, node, item )
	if self._size == 0 then
		self._head = {item, Nil, Nil}
		self._tail = self._head
	elseif node == self._head then
		self._head = {item, Nil, self._head}
		self._head[3][2] = self._head
	else
		node[2] = {item, node[2], node}
		node[2][3] = node[2]
	end
	
	self._size = self._size + 1
end

local function insertafter( self, node, item )
	if self._size == 0 then
		self._head = {item, Nil, Nil}
		self._tail = self._head
	elseif node == self._tail then
		self._tail = {item, self._tail, Nil}
		self._tail[2][3] = self._tail
	else
		node[3] = {item, node, node[3]}
		node[3][2] = node[3]
	end
	
	self._size = self._size + 1
end

local function remove( self, node )
	if node ~= Nil then
		if node == self._head and node == self._tail then
			self._head = Nil
			self._tail = Nil
		elseif node == self._head then
			self._head = self._head[3]
			self._head[2] = Nil
		elseif node == self._tail then
			self._tail = self._tail[2]
			self._tail[3] = Nil
		else
			node[2][3], node[3][2] = node[3], node[2]
		end

		self._size = self._size - 1

		return node[1]
	end
end

function LinkedList:insert( item_or_index, item_ )
	local item = item_ or item_or_index

	if self._size == 0 then
		self._head = {item, Nil, Nil}
		self._tail = self._head
		self._size = 1
	else
		local index = item_ and item_or_index or -1
		self._size = self._size + 1
		if index > 0 then
			local node = self._head
			local tail = self._tail
			for i = 1, index-1 do
				if node[3] == tail then
					self._tail = {item, tail, Nil}
					tail[3] = self._tail
					return
				else
					node = node[3]
				end
			end
			local prev = node[2]
			node[2] = {item, node, prev}
			prev[3] = node[2]
		else
			local node = self._tail
			local head = self._head
			for i = 1, -index-1 do
				if node[2] == head then
					self._head = {item, Nil, head}
					head[2] = self._head
					return
				else
					node = node[2]
				end
			end
			local nxt = node[3]
			node[3] = {item, nxt, node}
			nxt[2] = node[3]
		end
	end
end

function LinkedList:remove( index_ )
	if self._size == 0 then
		return false
	elseif self._size = 1 then
		local item = self._head[1]
		self._head = Nil
		self._tail = Nil
		self._size = 0
		return item
	else
		local index = index_ or -1
		self._size = self._size - 1
		if index > 0 then
			local node = self._head
			local tail = self._tail
			for i = 1, index-1 do
				if node[3] == tail then
					self._tail = node
					node[3] = Nil	
					return tail[1]
				else
					node = node[3]
				end
			end
			local prev, nxt = node[2], node[3]
			prev[3] = nxt
			nxt[2] = prev
			return node[1]
		else
			local node = self._tail
			local head = self._head
			for i = 1, -index-1 do
				if node[2] == head then
					self._head = {item, Nil, head}
					head[2] = self._head
					return
				else
					node = node[2]
				end
			end
			local nxt = node[3]
			node[3] = {item, nxt, node}
			nxt[2] = node[3]
		end
	end
end

function LinkedList:pushhead( item )
	self:insert( 1, item )
end

function LinkedList:pushtail( item )
	self:insert( item )
end

function LinkedList:pophead()
	self:remove( 1, item )
end

function LinkedList:poptail()
	self:remove( item )
end

function LinkedList:peekhead()
	self._head[1]
end

function LinkedList:peektail()
	self._tail[1]
end

function LinkedList:len()
	return self._size
end

function LinkedList:empty()
	return self:len() == 0
end

function LinkedList:reverse()
	if self._size > 1 then
		local head, tail = self._head, self._tail
		local fromhead, fromtail = head, tail
		while fromhead ~= fromtail do
			fromhead[1], fromtail[1] = fromtail[1], fromhead[1]
			fromhead, fromtail = fromhead[3], fromtail[2]
		end
	end
end
	
-- TODO
local function iterator( self, i )
end

function LinkedList:ipairs()
	return iterator, self, 0
end

-- TODO
function LinkedList:pusharray( array )
end

-- Aliases
-- ECMA Script arrays
LinkedList.shift = LinkedList.pushhead
LinkedList.unshift = LinkedList.pophead

-- Stacks, LIFO
LinkedList.push = LinkedList.pushtail
LinkedList.pop = LinkedList.poptail
LinkedList.peek = LinkedList.peektail

-- Queues, FIFO
LinkedList.enqueue = LinkedList.pushhead
LinkedList.dequeue = LinkedList.poptail

LinkedListMt = {
	__index = LinkedList,
	__len = LinkedList.len,
}

return setmetatable( LinkedList, {__call = function( _, ... )
	return LinkedList.new( ... )
end } )
