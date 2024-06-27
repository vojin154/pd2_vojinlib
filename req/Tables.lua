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
    local new_tbl = {}

    local new_meta = {
        __index = old_meta,
        __newindex = function(t, k, v)
            old_meta[k] = v
            clbk(k, v)
        end
    }

    get_method("changed")[id] = {
        tbl = tbl,
        old = old_meta,
        new = new_meta
    }

    setmetatable(tbl, new_meta)
end

local function disconnect_changed(id)
    local method = get_method("changed")
    local entry = method[id]

    if not entry then
        return
    end

    setmetatable(entry.tbl, entry.old)
    method[id] = nil
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