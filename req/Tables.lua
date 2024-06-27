local tables = VojinLIB:create_class("Tables")
table._method = {
    changed = {},
}

local function get_method(type)
    return table._method[type:lower()]
end

local function set_metamethod(tbl, meta_tbl)
    local old_meta = getmetatable(tbl) or {}
    local new_meta = meta_tbl or {}

    for i, v in pairs(old_meta) do
        new_meta[i] = v
    end

    return new_meta
end

function tables:changed(tbl, id, clbk)
    if (not tbl) or (not id) or (not clbk) then
        return
    end

    local method = get_method("changed")
    method[id] = method[id] or {}

    local entry = method[id]
    local old_clbk = entry.clbk

    local new_meta = set_metamethod(tbl, {})

    local old_newindex = new_meta.__newindex

    entry = {
        tbl = tbl,
        clbk = clbk or old_clbk,
        old_newindex = old_newindex
    }

    entry.newindex = function(t, i, v)
        if i == "__newindex" then
            entry.old_newindex = v
        elseif old_newindex then
            old_newindex(t, i, v)
        end

        clbk(i, v)
    end

    new_meta.__newindex = entry.newindex

    setmetatable(tbl, new_meta)
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