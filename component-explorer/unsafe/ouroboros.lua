local ffi = require("ffi")

local ouroborous = {}

ffi.cdef([[

struct lua_State;
typedef struct lua_State lua_State;

typedef int(*lua_CFunction)(lua_State*L);

typedef uint32_t GCRef;
typedef uint32_t MRef;

#pragma pack(push,1)

struct GCHeader {
    GCRef nextgc;
    uint8_t marked;
    uint8_t gct;
};

struct GCfuncCommon {
    uint8_t ffid;
    uint8_t nupvalues;

    GCRef env;
    GCRef gclist;
    MRef pc;
};

typedef struct GCfuncC {
    struct GCHeader header;
    struct GCfuncCommon common;
    lua_CFunction f;
    // TValue upvalue[1];
} GCfuncC;

typedef struct GCfuncL {
    struct GCHeader header;
    struct GCfuncCommon common;
    GCRef uvptr[1];
} GCfuncL;

typedef union GCfunc {
    GCfuncC c;
    GCfuncL l;
} GCfunc;

#pragma pack(pop)

]])

local FF = {
    LUA = 0,
    C = 1,
}

---@param obj any
---@return integer
local function get_pointer(obj)
    return tonumber(("%p"):format(obj), 16)
end

function ouroborous.func_c_address(func)
    local gcfunc = ffi.cast("GCfunc*", get_pointer(func))
    if gcfunc.c.common.ffid ~= FF.C then
        return nil
    end

    return gcfunc.c.f
end

return ouroborous
