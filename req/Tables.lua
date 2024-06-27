local tables = VojinLIB:create_class("Tables")
table._method = {
    changed = {},
}

local function get_method(type)
    return table._method[type:lower()]
end

function tables:changed(tbl, id, clbk)
    if (not tbl) or (not id) or (not clbk) then
        return
    end

    local old_meta = getmetatable(tbl)
    local meta = old_meta or {}

    local method = get_method("changed")
    method[id] = method[id] or {}

    local entry = method[id]
    local old_clbk = entry.clbk

    local old_newindex = meta.__newindex

    entry = {
        meta = meta,
        clbk = clbk or old_clbk,
        old_newindex = old_newindex
    }

    meta.__newindex = function(t, i, v)
        if old_newindex then
            old_newindex(t, i, v)
        end

        clbk(i, v)
    end

    if not old_meta then
        setmetatable(tbl, meta)
    end

    setmetatable(meta, {
        __newindex = function(t, i, v)
            if i == "__newindex" then
                entry.old_newindex = v
            end
        end
    })
end

local function disconnect_changed(id)
    local method = get_method("changed")
    local entry = method[id]

    if not entry then
        return
    end

    entry.__newindex = entry.old_newindex or nil
end

local function disconnect_all(id)
    for _, v in pairs(table._method) do
        if v[id] then
            v[id] = nil
        end
    end
end

function tables:disconnect(id, method)
    if not method then
        disconnect_all(id)
    elseif method == "changed" then
        disconnect_changed(id)
    end
end