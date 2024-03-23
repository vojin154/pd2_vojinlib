if not VojinLIB then
    return
end

VojinLIB.Hooks = {}
local hooks = VojinLIB.Hooks

---Is used as a base to add some type of an update function
---@param type string @String, that defines which update function to hook to
---@param id string @String to use for the hook id
---@param clbk function @Function to call with the hook
local function _add_update(type, id, clbk)
    Hooks:Add(type, id, clbk)
end

---Hooks a callback with an id to an update function using bases "GameSetupUpdate" Hook
---@param id string @String to use for the hook id
---@param clbk function @Function to call with the hook
function hooks:add_update(id, clbk)
    _add_update("GameSetupUpdate", id, clbk)
end

---Hooks a callback with an id to an update function using bases "MenuUpdate" Hook
---@param id string @String to use for the hook id
---@param clbk function @Function to call with the hook
function hooks:add_menu_update(id, clbk)
    _add_update("MenuUpdate", id, clbk)
end

---Removes the specified update hook to be no longer called
---@param id string @String to specify which hook to remove using the id
function hooks:remove_update(id)
    Hooks:Remove(id)
end