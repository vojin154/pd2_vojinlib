local peer = VojinLIB:create_class("Peer")

---@param id number @Number of the peer
---@return table|nil peer @Table with peer information or nil
function peer:get_peer(id)
    local session = managers.network:session()
    return session and session:peer(id)
end

---@param id number @Number of the peer
---@return string name @String of the peers name 
function peer:get_name(id)
    return self:get_peer(id):name()
end

---@return table peer @Table with local player information
function peer:local_player()
    local session = managers.network:session()
    return session and session:local_peer()
end