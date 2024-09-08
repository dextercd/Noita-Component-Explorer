local ffi = require("ffi")

local stl = {}

ffi.cdef([[
struct node_payload { void* align; };

typedef struct std_node {
    struct std_node* left;
    struct std_node* parent;
    struct std_node* right;
    uint8_t color;
    uint8_t isnil;
    struct node_payload payload;
} std_node;

typedef struct std_map {
    std_node* header;
    size_t size;
} std_map;

typedef struct ce_std_string {
    union {
        char* ptr;
        char buf[16];
    };
    size_t size;
    size_t capacity;
} ce_std_string;
]])

local string_meta = {}

function string_meta:__tostring()
    if self.capacity > 0xf then
        return ffi.string(self.ptr, self.size)
    end
    return ffi.string(ffi.cast("char*", self), self.size)
end

stl.String = ffi.metatype("ce_std_string", string_meta)

local function get_nodes_string_keys(node, nil_node, result)
    if node == nil_node then
        return
    end

    local keyvalue = ffi.cast("ce_std_string*", node.payload)
    result[#result + 1] = tostring(keyvalue)

    get_nodes_string_keys(node.left, nil_node, result)
    get_nodes_string_keys(node.right, nil_node, result)
end

---Given a std::map<std::string, Any>, return all std::strings
---@param map any
---@return string[]
function stl.map_string_keys(map)
    local result = {}
    get_nodes_string_keys(map.header.parent, map.header, result)
    return result
end

return stl
