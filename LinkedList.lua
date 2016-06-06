error( 'Unimplemented' )

local floor, setmetatable = math.floor, setmetatable

local LinkedList = {}

local LinkedListMt

function LinkedList.new( array )
	local self = setmetatable( {
		_size = 0,
		_head = false,
		_tail = false,
	}, LinkedListMt )

	if array then
		self:pusharray( array )
	end

	return self
end

-- TODO
function LinkedList:insert( item_or_index, item_ )
	local item = item_ or item_or_index

	if self._size == 0 then
		self._head = {item, false, false}
		self._tail = self._head
		self._size = 1
	else
		local index = self._size + index + 2
	end
end

-- TODO
function LinkedList:remove( index_ )
	local size = self._size
	local index = index_ or self._size
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

-- TODO
function LinkedList:reverse()
end
	
-- TODO
local function iterator( self, i )
end

-- TODO
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
LinkedList.enqueue = LinkedList.poptail
LinkedList.dequeue = LinkedList.pushhead

LinkedListMt = {
	__index = LinkedList,
	__len = LinkedList.len,
}

return setmetatable( LinkedList, {__call = function( _, ... )
	return LinkedList.new( ... )
end } )
