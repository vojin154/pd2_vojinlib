--[[
    color (Color) --Doesn't seem to be used
    row_item_color (Color) --Color of the text
    hightlight_color (Color) --Color of the text on mouse hover (highlighted)
    disabled_color (Color) --Color of the text if disabled
    marker_color (Color) --Color of the text ON mouse hover (highlighted)
    marker_disabled_color --Seems to be unused, item's colour AND highlight colour are managed by disabled_color
    font (String) --Font of the text
    font_size (Number) --Size of the text/whole item
    text (String) --What the text should say
    help_text (String) --Text, that is shown on hover, on top of the screen as a "help text" or a description, of what the item does
    align (String) --Set to "left" to align left or anything else to align to right
    halign (String) --Same as align?
    vertical (String) --Set to "center" to align to center or anything else to ignore 
    to_upper (Boolean) --Set to true for capital/uppercase letters or false to ignore
    color_ranges = params.color_ranges or self.color_ranges or nil --???? Unsure what it does and testing it gets me with a crash
]]

if not VojinLIB then
    return
end

VojinLIB.MenuItem = {}
local menu_item = VojinLIB.MenuItem

function menu_item:get_item_index(node, name, after)
    for i, v in pairs(node:items()) do
        if v:parameters().name == "achievements" then
            if after then
                return i + 1
            else
                return i - 1
            end
        end
    end
end

local function set_parameter(row_item, type, value)
    if row_item and type and value then
        row_item:set_parameter(type, value)
    end
end

--core\lib\managers\menu\items\coremenuitem.lua
--core\lib\managers\menu\reference_renderer\coremenunodegui.lua
menu_item.Item = {}
local item = menu_item.Item
function item:set_text_color(row_item, color)
    set_parameter(row_item, "row_item_color", color)
end

function item:set_highlight_color(row_item, color)
    set_parameter(row_item, "highlight_color", color)
end

function item:set_highlight_text_color(row_item, color)
    set_parameter(row_item, "marker_color", color)
end
function item:set_disabled_color(row_item, color)
    set_parameter(row_item, "disabled_color", color)
end

function item:set_font(row_item, font)
    --[[if type_name(font) == "string" then
        font = Idstring(font)
    end]]

    set_parameter(row_item, "font", font)
end

function item:set_font_size(row_item, size)
    set_parameter(row_item, "size", tonumber(size))
end

function item:set_text(row_item, text)
    set_parameter(row_item, "text", text)
end

function item:set_help_text(row_item, text)
    set_parameter(row_item, "help_text", text)
end
function item:set_align(row_item, left)
    set_parameter(row_item, "align", left)
end

function item:set_vertical(row_item, bool)
    set_parameter(row_item, "vertical", bool)
end

function item:to_upper(row_item, bool)
    set_parameter(row_item, "to_upper", bool)
end

menu_item.Option = {}
local option = menu_item.Option


--core\lib\managers\menu\items\coremenuitemslider.lua
menu_item.Slider = {}
local slider = menu_item.Slider

--core\lib\managers\menu\items\coremenuitemtoggle.lua
menu_item.Toggle = {}
local toggle = menu_item.Toggle