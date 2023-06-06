local marker_id = GetUpdatedEntityID()
local parent_id = EntityGetParent(marker_id)

local text_sprite_comp = EntityGetFirstComponentIncludingDisabled(marker_id, "SpriteComponent")
ComponentSetValue2(text_sprite_comp, "text", parent_id)
EntityRefreshSprite(marker_id, text_sprite_comp)

ComponentSetValue2(GetUpdatedComponentID(), "mNextExecutionTime", 2000000000)
