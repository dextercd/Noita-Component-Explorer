local ffi = require("ffi")

ffi.cdef([[

struct CE_MemoryType {
    static const int bool_ = 1;
    static const int int_ = 2;
    static const int uint32_t = 3;
    static const int float_ = 4;
    static const int double_ = 5;
    static const int std_string = 6;
    static const int int8_t = 7;
    static const int uint8_t = 8;
};

]])

CE_MemoryType = ffi.new("struct CE_MemoryType")
