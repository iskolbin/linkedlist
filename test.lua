local Deque = require 'Deque'

local cases = {
	length = function()
		local self = Deque()
		self:enqueue( 'a' )
		self:push( 'b' )
		self:pushhead( 'c' )
		self:pushtail( 'd' )
		return #self == 4 and self:len() == 4
	end,

	enq_deq = function()
		local self = Deque()
		self:enqueue( 'a' )
		self:enqueue( 'b' )
		self:enqueue( 'c' )
		self:enqueue( 'd' )
		return self:dequeue() == 'a' and self:dequeue() == 'b' and self:dequeue() == 'c' and self:dequeue() == 'd'
	end,

	aliases = function()
		local self = Deque{'a','b'}
		self:push('c')
		self:pushhead('d')
		self:pushtail('e')
		self:enqueue('f')
		self:shift('g')
		return self:peekhead() == 'g' and self:peektail() == 'e' and self:peek() == 'e' and self:len() == 7 and self:pop() == 'e' and self:pophead() == 'g' and self:poptail() == 'c' and self:dequeue() == 'b' and self:unshift() == 'f' and self:pophead() == 'd' and self:len() == 1 and self:pop() == 'a' and self:empty()
	end,

	stack = function()
		local self = Deque()
		local out = {}
		for i = 1, 1000 do
			if math.random() < 0.5 or self:empty() then
				table.insert( out, math.random() )
				self:push( out[#out] )
			else
				local v = table.remove( out )
				if self:pop() ~= v then
					return false
				end
			end
		end
		return true
	end,

	queue = function()
		local self = Deque()
		local out = {}
		for i = 1, 1000 do
			if math.random() < 0.5 or self:empty() then
				table.insert( out, math.random() )
				self:enqueue( out[#out] )
			else
				local v = table.remove( out, 1 )
				if self:dequeue() ~= v then
					return false
				end
			end
		end
		return true
	end,

	pusharray = function()
		local self = Deque.new{'e'}
		self:pusharray{ 'a', 'b','c','d'}
		return self:dequeue() == 'd' and self:dequeue() == 'c' and self:dequeue() == 'b' and self:dequeue() == 'a' 
	end,

	new = function()
		local self = Deque{ 'a', 'b','c','d'}
		return self:dequeue() == 'd' and self:dequeue() == 'c' and self:dequeue() == 'b' and self:dequeue() == 'a'
	end,

	empty = function()
		local self = Deque{ 'a', 'b','c','d'}
		local self2 = Deque.new()
		return not self:empty() and self:dequeue() == 'd' and self:dequeue() == 'c' and self:dequeue() == 'b' and self:dequeue() == 'a'and self:empty() and self2:empty()
	end,
	
	peek = function()
		local self = Deque.new{ 'a', 'b', 'c', 'd' }
		return self:peek() == 'd' and self:dequeue() == 'd' and self:peek() == self:dequeue() 
	end,

	simulation = function()
		local items = {}
		local self = Deque()

		for i = 1, 1000 do
			if #items == 0 or math.random() < 0.5 then
				local item = math.random()
				if math.random() < 0.5 then
					table.insert( items, item )
					self:push( item )
				else
					table.insert( items, 1, item )
					self:enqueue( item )
				end
			else
				if math.random() < 0.5 then
					local item = self:dequeue()
					if item ~= table.remove( items ) then
						return false
					end
				else
					local item = self:pop()
					if item ~= table.remove( items ) then
						return false
					end
				end
			end
		end

		return true
	end,
}

local function runCases( cs )
	local count, passed = 0, 0
	for name, case in pairs( cs ) do
		count = count + 1
		local pass = case()
		if pass then
			passed = passed + 1
		end
		print( name, '=>', pass and 'OK' or 'FAIL' )
	end
	local failed = count - passed
	print( 'Summary:')
	print( 'Passed:', passed )
	print( 'Failed:', failed )
	return passed, failed
end

print( 'Testing deque' )
local passed, failed = runCases( cases )

if failed > 0 then
	error( 'Failed tests: ' .. failed )
else
	print( 'All passed' )
end
