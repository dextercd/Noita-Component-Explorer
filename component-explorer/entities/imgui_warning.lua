run_count = run_count or 0

local msg = "CE: Couldn't find ImGui. Make sure it's installed and ABOVE Component Explorer in load order"

print(msg)
GamePrint(msg)

run_count = run_count + 1

if run_count > 5 then
    EntityKill(GetUpdatedEntityID())
end
