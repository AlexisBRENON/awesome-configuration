local setmetatable = setmetatable
local math = math
local base = require( "radical.base" )
local color     = require( "gears.color"      )
local cairo     = require( "lgi"              ).cairo
local print = print

local module = {
  margins = {
    TOP    = 4,
    BOTTOM = 4,
    RIGHT  = 4,
    LEFT   = 4
  }
}

local focussed,default = nil, nil

local function gen(item_height,bg_color,border_color)
  local img = cairo.ImageSurface(cairo.Format.ARGB32, item_height,item_height)
  local cr = cairo.Context(img)
  local rad = corner_radius or 3
  cr:set_source(color(bg_color))
  cr:arc(rad,rad,rad,0,2*math.pi)
  cr:arc(item_height-rad,rad,rad,0,2*math.pi)
  cr:arc(rad,item_height-rad,rad,0,2*math.pi)
  cr:arc(item_height-rad,item_height-rad,rad,0,2*math.pi)
  cr:fill()
  cr:rectangle(0,rad, item_height, item_height-2*rad)
  cr:rectangle(rad,0, item_height-2*rad, item_height)
  cr:fill()
  return cairo.Pattern.create_for_surface(img)
end

local function widget_draw(self, w, cr, width, height)
  self:_drawrounded(w, cr, width, height)
  local overlay = self._item and self._item.overlay
  if overlay then
    overlay(self._item._menu,self._item,cr,width,height)
  end
end

local function draw(item,args)
  local args = args or {}

  if not item.widget._overlay_init then
    item.widget._drawrounded = item.widget.draw
    item.widget.draw = widget_draw
    item.widget._overlay_init = true
  end

  local ih = item.height
  if not focussed or not focussed[ih] then
    if not focussed then
      focussed,default={},{}
    end
    local bc = item.border_color
    focussed[ih] = gen(ih,item.bg_focus,bc)
    default [ih] = gen(ih,item.bg,bc)
  end

  local state = item.state or {}
  local current_state = state._current_key or nil
  local state_name = base.colors_by_id[current_state]

  if current_state == base.item_flags.SELECTED or (item._tmp_menu) then
    item.widget:set_bg(focussed[ih])
    item.widget:set_fg(item["fg_focus"])
  elseif state_name then --TODO incomplete
    item.widget:set_bg(args.color or item["bg_"..state_name])
    item.widget:set_fg(              item["fg_"..state_name])
  else
    item.widget:set_bg(default[ih])
    item.widget:set_fg(item["fg_normal"])
  end
end

return setmetatable(module, { __call = function(_, ...) return draw(...) end })
-- kate: space-indent on; indent-width 2; replace-tabs on;
