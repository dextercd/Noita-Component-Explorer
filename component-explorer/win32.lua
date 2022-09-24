local ffi = require("ffi")
local C = ffi.C

ffi.cdef([[

typedef int BOOL;
typedef int WINBOOL;
typedef unsigned DWORD, *LPDWORD;

typedef void* HANDLE;
typedef void* PVOID;
typedef void* LPVOID;
typedef HANDLE HLOCAL;
typedef const void* LPCVOID;

typedef char CHAR;
typedef const CHAR *LPCSTR;

typedef unsigned long ULONG_PTR, *PULONG_PTR;
typedef ULONG_PTR SIZE_T, *PSIZE_T;

typedef struct OVERLAPPED;

typedef struct _SECURITY_ATTRIBUTES {
  DWORD nLength;
  LPVOID lpSecurityDescriptor;
  WINBOOL bInheritHandle;
} SECURITY_ATTRIBUTES, *PSECURITY_ATTRIBUTES, *LPSECURITY_ATTRIBUTES;

typedef struct _OVERLAPPED {
  ULONG_PTR Internal;
  ULONG_PTR InternalHigh;
  union {
    struct {
      DWORD Offset;
      DWORD OffsetHigh;
    } DUMMYSTRUCTNAME;
    PVOID Pointer;
  } DUMMYUNIONNAME;
  HANDLE    hEvent;
} OVERLAPPED, *LPOVERLAPPED;

DWORD WaitForMultipleObjects(
  /* in */ DWORD         nCount,
  /* in */ const HANDLE *lpHandles,
  /* in */ BOOL          bWaitAll,
  /* in */ DWORD         dwMilliseconds
);

DWORD WaitForSingleObject(
  /* in */ HANDLE hHandle,
  /* in */ DWORD  dwMilliseconds
);

void SetLastError(
  /* in */ DWORD dwErrCode
);

DWORD GetLastError();

BOOL CloseHandle(
  /* in */ HANDLE hObject
);

HANDLE CreateFileA(
  /* in */           LPCSTR                lpFileName,
  /* in */           DWORD                 dwDesiredAccess,
  /* in */           DWORD                 dwShareMode,
  /* in, optional */ LPSECURITY_ATTRIBUTES lpSecurityAttributes,
  /* in */           DWORD                 dwCreationDisposition,
  /* in */           DWORD                 dwFlagsAndAttributes,
  /* in, optional */ HANDLE                hTemplateFile
);

struct DESIRED_ACCESS {
    static const DWORD GENERIC_READ    = 0x80000000;
    static const DWORD GENERIC_WRITE   = 0x40000000;
    static const DWORD GENERIC_EXECUTE = 0x20000000;
    static const DWORD GENERIC_ALL     = 0x10000000;
};

struct SHARE_MODE {
    static const DWORD FILE_SHARE_READ   = 0x00000001;
    static const DWORD FILE_SHARE_WRITE  = 0x00000002;
    static const DWORD FILE_SHARE_DELETE = 0x00000004;
};

struct CREATION_DISPOSITION {
    static const DWORD CREATE_NEW        = 1;
    static const DWORD CREATE_ALWAYS     = 2;
    static const DWORD OPEN_EXISTING     = 3;
    static const DWORD OPEN_ALWAYS       = 4;
    static const DWORD TRUNCATE_EXISTING = 5;
};

struct FILE_ATTRIBUTE {
    static const DWORD FILE_ATTRIBUTE_ARCHIVE   = 32;
    static const DWORD FILE_ATTRIBUTE_ENCRYPTED = 16384;
    static const DWORD FILE_ATTRIBUTE_HIDDEN    = 2;
    static const DWORD FILE_ATTRIBUTE_NORMAL    = 128;
    static const DWORD FILE_ATTRIBUTE_OFFLINE   = 4096;
    static const DWORD FILE_ATTRIBUTE_READONLY  = 1;
    static const DWORD FILE_ATTRIBUTE_SYSTEM    = 4;
    static const DWORD FILE_ATTRIBUTE_TEMPORARY = 256;

    static const DWORD FILE_FLAG_BACKUP_SEMANTICS   = 0x02000000;
    static const DWORD FILE_FLAG_DELETE_ON_CLOSE    = 0x04000000;
    static const DWORD FILE_FLAG_NO_BUFFERING       = 0x20000000;
    static const DWORD FILE_FLAG_OPEN_NO_RECALL     = 0x00100000;
    static const DWORD FILE_FLAG_OPEN_REPARSE_POINT = 0x00200000;
    static const DWORD FILE_FLAG_OVERLAPPED         = 0x40000000;
    static const DWORD FILE_FLAG_POSIX_SEMANTICS    = 0x01000000;
    static const DWORD FILE_FLAG_RANDOM_ACCESS      = 0x10000000;
    static const DWORD FILE_FLAG_SESSION_AWARE      = 0x00800000;
    static const DWORD FILE_FLAG_SEQUENTIAL_SCAN    = 0x08000000;
    static const DWORD FILE_FLAG_WRITE_THROUGH      = 0x80000000;
};

struct WAIT_RESULT {
    static const DWORD WAIT_ABANDONED = 0x00000080;
    static const DWORD WAIT_OBJECT_0  = 0x00000000;
    static const DWORD WAIT_TIMEOUT   = 0x00000102;
    static const DWORD WAIT_FAILED    = 0xFFFFFFFF;
};

struct WIN_ERROR {
    static const DWORD NO_ERROR                             = 0;
    static const DWORD ERROR_INVALID_FUNCTION               = 1;
    static const DWORD ERROR_NOT_ENOUGH_MEMORY              = 8;
    static const DWORD ERROR_HANDLE_EOF                     = 38;
    static const DWORD ERROR_DEV_NOT_EXIST                  = 55;
    static const DWORD ERROR_INVALID_PARAMETER              = 87;
    static const DWORD ERROR_INSUFFICIENT_BUFFER            = 122;
    static const DWORD ERROR_INVALID_NAME                   = 123;
    static const DWORD ERROR_BUSY                           = 170;
    static const DWORD ERROR_MORE_DATA                      = 234;
    static const DWORD WAIT_TIMEOUT                         = 258;
    static const DWORD ERROR_IO_PENDING                     = 997;
    static const DWORD ERROR_DEVICE_REINITIALIZATION_NEEDED = 1164;
    static const DWORD ERROR_CONTINUE                       = 1246;
    static const DWORD ERROR_NO_MORE_DEVICES                = 1248;
};

HLOCAL LocalFree(
  /* in */ HLOCAL hMem
);

DWORD FormatMessageA(
  /* in */           DWORD   dwFlags,
  /* in, optional */ LPCVOID lpSource,
  /* in */           DWORD   dwMessageId,
  /* in */           DWORD   dwLanguageId,
  /* out */          LPCSTR  lpBuffer,
  /* in */           DWORD   nSize,
  /* in, optional */ va_list *Arguments
);

BOOL ReadFile(
  /* in */                HANDLE       hFile,
  /* out */               LPVOID       lpBuffer,
  /* in */                DWORD        nNumberOfBytesToRead,
  /* out, optional */     LPDWORD      lpNumberOfBytesRead,
  /* in, out, optional */ LPOVERLAPPED lpOverlapped
);

BOOL GetOverlappedResult(
  /* in */  HANDLE       hFile,
  /* in */  LPOVERLAPPED lpOverlapped,
  /* out */ LPDWORD      lpNumberOfBytesTransferred,
  /* in */  BOOL         bWait
);

LPVOID VirtualAlloc(
  /* in, optional */ LPVOID lpAddress,
  /* in */           SIZE_T dwSize,
  /* in */           DWORD  flAllocationType,
  /* in */           DWORD  flProtect
);

]])

DesiredAccess = ffi.new("struct DESIRED_ACCESS")
ShareMode = ffi.new("struct SHARE_MODE")
CreationDisposition = ffi.new("struct CREATION_DISPOSITION")
FileAttribute = ffi.new("struct FILE_ATTRIBUTE")
WinError = ffi.new("struct WIN_ERROR")

INVALID_HANDLE_VALUE = ffi.cast("HANDLE", -1)

function format_message(error_code)
    local flags =
        0x100  + -- FORMAT_MESSAGE_ALLOCATE_BUFFER
        0x1000 + -- FORMAT_MESSAGE_FROM_SYSTEM
        0x200  + -- FORMAT_MESSAGE_IGNORE_INSERTS
        0xff     -- FORMAT_MESSAGE_MAX_WIDTH_MASK

    local message_arr = ffi.new('char*[1]')
    -- When using FORMAT_MESSAGE_ALLOCATE_BUFFER:
    -- Instead of passing a char* we pass a pointer to a char*, the function
    -- allocates the memory it needs and places the pointer to that memory into
    -- the location we pass. Since this function normally takes a char* instead
    -- a char** we need to do this scary cast. We then need to free the memory
    -- with LocalFree.
    local message_ptr = ffi.cast('char*', message_arr)

    C.FormatMessageA(flags, nil, error_code, 0, message_ptr, 0, nil)
    local message = message_arr[0]

    if message == nil then
        -- Well, We couldn't get the error message for some reason. We can
        -- retrieve the error, and then get the error text with FormatMessageA!
        -- Oh wait..
        local err = C.GetLastError()
        error("Couldn't format error code, everything is f'ed: " .. tostring(err))
    end

    local message_string = ffi.string(message)

    C.LocalFree(message)

    return message_string
end

ffi.cdef([[

struct FileLifetime {
    HANDLE handle;
};

]])

local flmt = {
    __gc = function(self)
        if self.handle ~= nil then
            C.CloseHandle(self.handle)
        end
    end
}

FileLifetime = ffi.metatype("struct FileLifetime", flmt)
