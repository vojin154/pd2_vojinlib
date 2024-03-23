---@diagnostic disable: undefined-field
if not _G.VojinLIB then
    _G.VojinLIB = _G.class()
end

--Caching globals
local VojinLIB = _G.VojinLIB
local RequiredScript = _G.RequiredScript
local file = _G.file
local mod_path = _G.ModPath
local save_path = _G.SavePath

function VojinLIB:Setup()
    self._mod_path = mod_path
    self._save_path = save_path
    self._req = {}

    --Now that it has different variables.. NO ONE CAN PROVE ME IT'S STOLEN FROM HOPLIB :teeth:
    function self:run_required(path)
        if not RequiredScript then
            return
        end

        self._required_script = self._required_script or {}

        local file_name = path .. RequiredScript:gsub(".+/(.+)", "%1.lua")
        if self._required_script[file_name] then
            return
        end

        if io.file_is_readable(file_name) then
            dofile(file_name)
        end

        self._required_script[file_name] = true
    end

    local require = mod_path .. "req/"
    for _, v in ipairs(file.GetFiles(require)) do
        if not self._req[v] and io.file_is_readable(require .. v) then
            dofile(require .. v)
            self._req[v] = true --true as in HOOKED = TRUE
        end
    end
end

VojinLIB:Setup()