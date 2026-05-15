-- Inherit shared config from the engine root (supports one- or two-level demo folders)
local candidates = {
	"../engine/.luacheckrc",
	"../../engine/.luacheckrc",
}

for _, path in ipairs(candidates) do
	local f = loadfile(path)
	if f then
		setfenv(f, getfenv())()
		return
	end
end

error("Could not load shared .luacheckrc from ../engine or ../../engine")
