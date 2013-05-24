EnableDebugPrivileges()
{
    PROCESS_ALL_ACCESS        := 0x001F0FFF
    PROCESS_VM_READ           := 0x10
    PROCESS_QUERY_INFORMATION := 0x400

    TOKEN_ALL_ACCESS        := 0xF01FF
    TOKEN_QUERY             := 0x8
    TOKEN_ADJUST_PRIVILEGES := 0x20

    SE_PRIVILEGE_ENABLED := 2

    Process, Exist
    h := DllCall("OpenProcess", "UInt", PROCESS_QUERY_INFORMATION, "Int", false, "UInt", ErrorLevel, "Ptr")

    DllCall("Advapi32.dll\OpenProcessToken", "Ptr", h, "UInt", TOKEN_ADJUST_PRIVILEGES, "PtrP", t)

    VarSetCapacity(ti, 16, 0)
    NumPut(1, ti, 0, "UInt")

    DllCall("Advapi32.dll\LookupPrivilegeValue", "Ptr", 0, "Str", "SeDebugPrivilege", "Int64P", luid)

    NumPut(luid, ti, 4, "Int64")
    NumPut(SE_PRIVILEGE_ENABLED, ti, 12, "UInt")

    r := DllCall("Advapi32.dll\AdjustTokenPrivileges", "Ptr", t, "Int", false, "Ptr", &ti, "UInt", 0, "Ptr", 0, "Ptr", 0)

    DllCall("CloseHandle", "Ptr", t)
    DllCall("CloseHandle", "Ptr", h)
}