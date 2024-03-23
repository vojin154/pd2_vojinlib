if not VojinLIB then
    return
end

VojinLIB.Peer = {}
local peer = VojinLIB.Peer
local session = managers.network:session()

---@param id number @Number of the peer
---@return table|nil peer @Table with peer information or nil
function peer.get_peer(id)
    return session:peer(id)
end

---@param id number @Number of the peer
---@return string name @String of the peers name 
function peer.get_name(id)
    return peer.get_peer(id):name()
end

---@return table peer @Table with local player information
function peer.local_player()
    return session:local_peer()
end