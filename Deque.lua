local Deque = {}

local DequeMt

function Deque.new( array_ )
	local self = setmetatable( {
		_items = {},
		_size = 0,
		_head = 0,
		_tail = 0,
	}, DequeMt )

	if array_ then
		self:pusharray( array_ )
	end

	return self
end

function Deque:pushhead( item )
	if self:empty() then
		self._items = {item}
		self._head = 1
		self._tail = 1
		self._size = 1
	else
		local head = self._head - 1
		self._head = head
		self._items[head] = item
		self._size = self._size + 1
	end
end

function Deque:pushtail( item )
	if self:empty() then
		self._items = {item}
		self._head = 1
		self._tail = 1
		self._size = 1
	else
		local tail = self._tail + 1
		self._tail = tail
		self._items[tail] = item
		self._size = self._size + 1
	end
end

function Deque:pophead()
	local size = self:len()
	if size == 0 then
		error( 'Deque is empty' )
	else
		local head = self._head
		local item = self._items[head]
		self._items[head] = nil
		self._head = head + 1
		self._size = size - 1
		return item
	end
end

function Deque:poptail()
	local size = self:len()
	if size == 0 then
		error( 'Deque is empty' )
	else
		local tail = self._tail
		local item = self._items[tail]
		self._items[tail] = nil
		self._tail = tail - 1
		self._size = size - 1
		return item
	end
end

function Deque:peekhead()
	return self._items[self._head]
end

function Deque:peektail()
	return self._items[self._tail]
end

function Deque:len()
	return self._size
end

function Deque:empty()
	return self:len() == 0
end

function Deque:reverse()
	local head, tail, items = self._head, self._tail, self._items
	for i = 1, math.floor( self:len() * 0.5 ) do
		items[head+i-1], items[tail-i+1] = items[tail-i+1], items[head+i-1]
	end
end
	
local function iterator( self, i )
	if self._size <= i then
		return nil
	else
		return i + 1, self._items[self._head + i]
	end
end

function Deque:ipairs()
	return iterator, self, 0
end

function Deque:pusharray( array )
	local len = #array
	if len > 0 then
		local items = self._items
		if self:empty() then
			self._head = 1
			self._tail = len
			self._size = len
			for i = 1, len do
				items[i] = array[i]
			end
		else
			local tail = self._tail
			self._tail = tail + len
			self._size = self._size + len
			for i = 1, len do
				items[tail + i] = array[i]
			end
		end
	end
end

-- Aliases
-- ECMA Script arrays
Deque.shift = Deque.pushhead
Deque.unshift = Deque.pophead

-- Stacks, LIFO
Deque.push = Deque.pushtail
Deque.pop = Deque.poptail
Deque.peek = Deque.peektail

-- Queues, FIFO
Deque.enqueue = Deque.pushhead
Deque.dequeue = Deque.poptail

DequeMt = {
	__index = Deque,
	__len = Deque.len,
}

return setmetatable( Deque, {__call = function( _, ... )
	return Deque.new( ... )
end } )
