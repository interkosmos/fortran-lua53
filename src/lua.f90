! lua.f90
!
! A collection of ISO C binding interfaces to Lua 5.3 for Fortran 2003.
!
! Author:  Philipp Engel
! Licence: ISC
module lua
    use, intrinsic :: iso_c_binding
    implicit none
    private

    public :: lua_arith
    public :: lua_call
    public :: lua_callk
    public :: lua_checkstack
    public :: lua_close
    public :: lua_compare
    public :: lua_concat
    public :: lua_copy
    public :: lua_createtable
    public :: lua_gc
    public :: lua_getglobal
    public :: lua_isboolean
    public :: lua_iscfunction
    public :: lua_isfunction
    public :: lua_isnil
    public :: lua_isnone
    public :: lua_isnoneornil
    public :: lua_isnumber
    public :: lua_isstring
    public :: lua_istable
    public :: lua_isthread
    public :: lua_isuserdata
    public :: lua_isyieldable
    public :: lua_load
    public :: lua_newtable
    public :: lua_pcall
    public :: lua_register
    public :: lua_setglobal
    public :: lua_status
    public :: lua_tostring
    public :: lua_type
    public :: lua_typename
    public :: lual_dofile
    public :: lual_loadfile
    public :: lual_loadfilex
    public :: lual_loadstring
    public :: lual_newstate
    public :: lual_openlibs

    ! Option for multiple returns in `lua_pcall` and `lua_call`.
    integer(kind=c_int), parameter, public :: LUA_MULTRET = -1

    ! Basic types.
    integer(kind=c_int), parameter, public :: LUA_TNONE          = -1
    integer(kind=c_int), parameter, public :: LUA_TNIL           = 0
    integer(kind=c_int), parameter, public :: LUA_TBOOLEAN       = 1
    integer(kind=c_int), parameter, public :: LUA_TLIGHTUSERDATA = 2
    integer(kind=c_int), parameter, public :: LUA_TNUMBER        = 3
    integer(kind=c_int), parameter, public :: LUA_TSTRING        = 4
    integer(kind=c_int), parameter, public :: LUA_TTABLE         = 5
    integer(kind=c_int), parameter, public :: LUA_TFUNCTION      = 6
    integer(kind=c_int), parameter, public :: LUA_TUSERDATA      = 7
    integer(kind=c_int), parameter, public :: LUA_TTHREAD        = 8

    ! Comparison and arithmetic options.
    integer(kind=c_int), parameter, public :: LUA_OPADD  = 0
    integer(kind=c_int), parameter, public :: LUA_OPSUB  = 1
    integer(kind=c_int), parameter, public :: LUA_OPMUL  = 2
    integer(kind=c_int), parameter, public :: LUA_OPMOD  = 3
    integer(kind=c_int), parameter, public :: LUA_OPPOW  = 4
    integer(kind=c_int), parameter, public :: LUA_OPDIV  = 5
    integer(kind=c_int), parameter, public :: LUA_OPIDIV = 6
    integer(kind=c_int), parameter, public :: LUA_OPBAND = 7
    integer(kind=c_int), parameter, public :: LUA_OPBOR  = 8
    integer(kind=c_int), parameter, public :: LUA_OPBXOR = 9
    integer(kind=c_int), parameter, public :: LUA_OPSHL  = 10
    integer(kind=c_int), parameter, public :: LUA_OPSHR  = 11
    integer(kind=c_int), parameter, public :: LUA_OPUNM  = 12
    integer(kind=c_int), parameter, public :: LUA_OPBNOT = 13

    integer(kind=c_int), parameter, public :: LUA_OPEQ = 0
    integer(kind=c_int), parameter, public :: LUA_OPLT = 1
    integer(kind=c_int), parameter, public :: LUA_OPLE = 2

    ! Garbage-collection options.
    integer(kind=c_int), parameter, public :: LUA_GCSTOP       = 0
    integer(kind=c_int), parameter, public :: LUA_GCRESTART    = 1
    integer(kind=c_int), parameter, public :: LUA_GCCOLLECT    = 2
    integer(kind=c_int), parameter, public :: LUA_GCCOUNT      = 3
    integer(kind=c_int), parameter, public :: LUA_GCCOUNTB     = 4
    integer(kind=c_int), parameter, public :: LUA_GCSTEP       = 5
    integer(kind=c_int), parameter, public :: LUA_GCSETPAUSE   = 6
    integer(kind=c_int), parameter, public :: LUA_GCSETSTEPMUL = 7
    integer(kind=c_int), parameter, public :: LUA_GCISRUNNING  = 9

    ! Thread status.
    integer(kind=c_int), parameter, public :: LUA_OK        = 0
    integer(kind=c_int), parameter, public :: LUA_YIELD     = 1
    integer(kind=c_int), parameter, public :: LUA_ERRRUN    = 2
    integer(kind=c_int), parameter, public :: LUA_ERRSYNTAX = 3
    integer(kind=c_int), parameter, public :: LUA_ERRMEM    = 4
    integer(kind=c_int), parameter, public :: LUA_ERRGCMM   = 5
    integer(kind=c_int), parameter, public :: LUA_ERRERR    = 6

    ! Interfaces to libc.
    interface
        function c_strlen(str) bind(c, name='strlen')
            import :: c_ptr, c_size_t
            type(c_ptr), intent(in), value :: str
            integer(c_size_t)              :: c_strlen
        end function c_strlen
    end interface

    ! Interfaces to Lua 5.3.
    interface
        ! int lua_checkstack(lua_State *L, int n)
        function lua_checkstack(l, n) bind(c, name='lua_checkstack')
            import :: c_int, c_ptr
            type(c_ptr),         intent(in), value :: l
            integer(kind=c_int), intent(in), value :: n
            integer(kind=c_int)                    :: lua_checkstack
        end function lua_checkstack

        ! int lua_compare(lua_State *L, int index1, int index2, int op)
        function lua_compare(l, index1, index2, op) bind(c, name='lua_compare')
            import :: c_int, c_ptr
            type(c_ptr),         intent(in), value :: l
            integer(kind=c_int), intent(in), value :: index1
            integer(kind=c_int), intent(in), value :: index2
            integer(kind=c_int), intent(in), value :: op
            integer(kind=c_int)                    :: lua_compare
        end function lua_compare

        ! int lua_gc(lua_State *L, int what, int data)
        function lua_gc(l, what, data) bind(c, name='lua_gc')
            import :: c_int, c_ptr
            type(c_ptr),         intent(in), value :: l
            integer(kind=c_int), intent(in), value :: what
            integer(kind=c_int), intent(in), value :: data
            integer(kind=c_int)                    :: lua_gc
        end function lua_gc

        ! int lua_getglobal(lua_State *L, const char *name)
        function lua_getglobal_(l, name) bind(c, name='lua_getglobal')
            import :: c_char, c_int, c_ptr
            type(c_ptr),            intent(in), value :: l
            character(kind=c_char), intent(in)        :: name
            integer(kind=c_int)                       :: lua_getglobal_
        end function lua_getglobal_

        ! int lua_iscfunction(lua_State *L, int idx)
        function lua_iscfunction(l, idx) bind(c, name='lua_iscfunction')
            import :: c_int, c_ptr
            type(c_ptr),         intent(in), value :: l
            integer(kind=c_int), intent(in), value :: idx
            integer(kind=c_int)                    :: lua_iscfunction
        end function lua_iscfunction

        ! int lua_isinteger(lua_State *L, int idx)
        function lua_isinteger(l, idx) bind(c, name='lua_isinteger')
            import :: c_int, c_ptr
            type(c_ptr),         intent(in), value :: l
            integer(kind=c_int), intent(in), value :: idx
            integer(kind=c_int)                    :: lua_isinteger
        end function lua_isinteger

        ! int lua_isnumber(lua_State *L, int idx)
        function lua_isnumber(l, idx) bind(c, name='lua_isnumber')
            import :: c_int, c_ptr
            type(c_ptr),         intent(in), value :: l
            integer(kind=c_int), intent(in), value :: idx
            integer(kind=c_int)                    :: lua_isnumber
        end function lua_isnumber

        ! int lua_isstring(lua_State *L, int idx)
        function lua_isstring(l, idx) bind(c, name='lua_isstring')
            import :: c_int, c_ptr
            type(c_ptr),         intent(in), value :: l
            integer(kind=c_int), intent(in), value :: idx
            integer(kind=c_int)                    :: lua_isstring
        end function lua_isstring

        ! int lua_isuserdata(lua_State *L, int idx)
        function lua_isuserdata(l, idx) bind(c, name='lua_isuserdata')
            import :: c_int, c_ptr
            type(c_ptr),         intent(in), value :: l
            integer(kind=c_int), intent(in), value :: idx
            integer(kind=c_int)                    :: lua_isuserdata
        end function lua_isuserdata

        ! int lua_isyieldable(lua_State *L)
        function lua_isyieldable(l) bind(c, name='lua_isyielable')
            import :: c_int, c_ptr
            type(c_ptr), intent(in), value :: l
            integer(kind=c_int)            :: lua_isyieldable
        end function lua_isyieldable

        ! int lua_load(lua_State *L, lua_Reader reader, void *data, const char *chunkname, const char *mode)
        function lua_load(l, reader, data, chunkname, mode) bind(c, name='lua_load')
            import :: c_char, c_funptr, c_int, c_ptr
            type(c_ptr),            intent(in), value :: l
            type(c_funptr),         intent(in), value :: reader
            type(c_ptr),            intent(in), value :: data
            character(kind=c_char), intent(in)        :: chunkname
            character(kind=c_char), intent(in)        :: mode
            integer(kind=c_int)                       :: lua_load
        end function lua_load

        ! int lua_status(lua_State *L)
        function lua_status(l) bind(c, name='lua_status')
            import :: c_int, c_ptr
            type(c_ptr), intent(in), value :: l
            integer(kind=c_int)            :: lua_status
        end function lua_status

        ! const char *lua_tolstring(lua_State *L, int idx, size_t *len)
        function lua_tolstring(l, idx, len) bind(c, name='lua_tolstring')
            import :: c_int, c_ptr
            type(c_ptr),         intent(in), value :: l
            integer(kind=c_int), intent(in), value :: idx
            type(c_ptr),         intent(in), value :: len
            type(c_ptr)                            :: lua_tolstring
        end function lua_tolstring

        ! int lua_type(lua_State *L, int idx)
        function lua_type(l, idx) bind(c, name='lua_type')
            import :: c_int, c_ptr
            type(c_ptr),         intent(in), value :: l
            integer(kind=c_int), intent(in), value :: idx
            integer(kind=c_int)                    :: lua_type
        end function lua_type

        ! const char *lua_typename(lua_State *L, int tp)
        function lua_typename_(l, tp) bind(c, name='lua_typename')
            import :: c_int, c_ptr
            type(c_ptr),         intent(in), value :: l
            integer(kind=c_int), intent(in), value :: tp
            type(c_ptr)                            :: lua_typename_
        end function lua_typename_

        ! int luaL_loadfilex(lua_State *L, const char *filename, const char *mode)
        function lual_loadfilex(l, filename, mode) bind(c, name='luaL_loadfilex')
            import :: c_char, c_int, c_ptr
            type(c_ptr),            intent(in), value :: l
            character(kind=c_char), intent(in)        :: filename
            type(c_ptr),            intent(in), value :: mode
            integer(kind=c_int)                       :: lual_loadfilex
        end function lual_loadfilex

        ! int luaL_loadstring (lua_State *L, const char *s)
        function lual_loadstring_(l, s) bind(c, name='luaL_loadstring')
            import :: c_char, c_int, c_ptr
            type(c_ptr),            intent(in), value :: l
            character(kind=c_char), intent(in)        :: s
            integer(kind=c_int)                       :: lual_loadstring_
        end function lual_loadstring_

        ! lua_State *luaL_newstate(void)
        function lual_newstate() bind(c, name='luaL_newstate')
            import :: c_ptr
            type(c_ptr) :: lual_newstate
        end function lual_newstate

        ! int lua_pcallk(lua_State *L, int nargs, int nresults, int msgh, lua_KContext ctx, lua_KFunction k)
        function lua_pcallk(l, nargs, nresults, msgh, ctx, k) bind(c, name='lua_pcallk')
            import :: c_funptr, c_int, c_intptr_t, c_ptr
            type(c_ptr),              intent(in), value :: l
            integer(kind=c_int),      intent(in), value :: nargs
            integer(kind=c_int),      intent(in), value :: nresults
            integer(kind=c_int),      intent(in), value :: msgh
            integer(kind=c_intptr_t), intent(in), value :: ctx
            type(c_funptr),           intent(in), value :: k
            integer(kind=c_int)                         :: lua_pcallk
        end function lua_pcallk

        ! void lua_arith(lua_State *L, int op)
        subroutine lua_arith(l, op) bind(c, name='lua_arith')
            import :: c_int, c_ptr
            type(c_ptr),         intent(in), value :: l
            integer(kind=c_int), intent(in), value :: op
        end subroutine lua_arith

        ! void lua_call(lua_State *L, int nargs, int nresults)
        subroutine lua_call(l, nargs, nresults) bind(c, name='lua_call')
            import :: c_int, c_ptr
            type(c_ptr),         intent(in), value :: l
            integer(kind=c_int), intent(in), value :: nargs
            integer(kind=c_int), intent(in), value :: nresults
        end subroutine lua_call

        ! void lua_callk(lua_State *L, int nargs, int nresults, int ctx, lua_CFunction k)
        subroutine lua_callk(l, nargs, nresults, ctx, k) bind(c, name='lua_callk')
            import :: c_funptr, c_int, c_intptr_t, c_ptr
            type(c_ptr),              intent(in), value :: l
            integer(kind=c_int),      intent(in), value :: nargs
            integer(kind=c_int),      intent(in), value :: nresults
            integer(kind=c_intptr_t), intent(in), value :: ctx
            type(c_funptr),           intent(in), value :: k
        end subroutine lua_callk

        ! void lua_close(lua_State *L)
        subroutine lua_close(l) bind(c, name='lua_close')
            import :: c_ptr
            type(c_ptr), intent(in), value :: l
        end subroutine lua_close

        ! void lua_concat(lua_State *L, int n)
        subroutine lua_concat(l, n) bind(c, name='lua_concat')
            import :: c_int, c_ptr
            type(c_ptr),         intent(in), value :: l
            integer(kind=c_int), intent(in), value :: n
        end subroutine lua_concat

        ! void lua_copy(lua_State *L, int fromidx, int toidx)
        subroutine lua_copy(l, fromidx, toidx) bind(c, name='lua_copy')
            import :: c_int, c_ptr
            type(c_ptr),         intent(in), value :: l
            integer(kind=c_int), intent(in), value :: fromidx
            integer(kind=c_int), intent(in), value :: toidx
        end subroutine lua_copy

        ! void lua_createtable(lua_State *L, int narr, int nrec)
        subroutine lua_createtable(l, narr, nrec) bind(c, name='lua_creatable')
            import :: c_int, c_ptr
            type(c_ptr),         intent(in), value :: l
            integer(kind=c_int), intent(in), value :: narr
            integer(kind=c_int), intent(in), value :: nrec
        end subroutine lua_createtable

        ! void lua_newtable(lua_State *L)
        subroutine lua_newtable(l) bind(c, name='lua_newtable')
            import :: c_ptr
            type(c_ptr), intent(in), value :: l
        end subroutine lua_newtable

        ! void lua_pop(lua_State *L, int n)
        subroutine lua_pop(l, n) bind(c, name='lua_pop')
            import :: c_int, c_ptr
            type(c_ptr),         intent(in), value :: l
            integer(kind=c_int), intent(in), value :: n
        end subroutine lua_pop

        ! void lua_pushboolean(lua_State *L, int b)
        subroutine lua_pushboolean(l, b) bind(c, name='lua_pushboolean')
            import :: c_int, c_ptr
            type(c_ptr),         intent(in), value :: l
            integer(kind=c_int), intent(in), value :: b
        end subroutine lua_pushboolean

        ! void lua_pushcclosure(lua_State *L, lua_CFunction fn, int n)
        subroutine lua_pushcclosure(l, fn, n) bind(c, name='lua_pushcclosure')
            import :: c_funptr, c_int, c_ptr
            type(c_ptr),         intent(in), value :: l
            type(c_funptr),      intent(in), value :: fn
            integer(kind=c_int), intent(in), value :: n
        end subroutine lua_pushcclosure

        ! void lua_setglobal(lua_State *L, const char *name)
        subroutine lua_setglobal(l, name) bind(c, name='lua_setglobal')
            import :: c_char, c_ptr
            type(c_ptr),            intent(in), value :: l
            character(kind=c_char), intent(in)        :: name
        end subroutine lua_setglobal

        ! void luaL_openlibs(lua_State *L)
        subroutine lual_openlibs(l) bind(c, name='luaL_openlibs')
            import :: c_ptr
            type(c_ptr), intent(in), value :: l
        end subroutine lual_openlibs
    end interface
contains
    ! int lua_getglobal(lua_State *L, const char *name)
    function lua_getglobal(l, name)
        !! Wrapper for `lua_getglobal_()` that null-terminates string `name`.
        type(c_ptr),      intent(in) :: l
        character(len=*), intent(in) :: name
        integer                      :: lua_getglobal

        lua_getglobal = lua_getglobal_(l, name // c_null_char)
    end function lua_getglobal

    ! int lua_isboolean(lua_State *L, int index)
    function lua_isboolean(l, idx)
        !! Macro replacement that returns whether the stack variable is
        !! boolean.
        type(c_ptr), intent(in) :: l
        integer,     intent(in) :: idx
        logical                 :: lua_isboolean

        lua_isboolean = .false.

        if (lua_type(l, idx) == LUA_TBOOLEAN) &
            lua_isboolean= .true.
    end function lua_isboolean

    ! int lua_isfunction(lua_State *L, int index)
    function lua_isfunction(l, idx)
        !! Macro replacement that returns whether the stack variable is a
        !! function.
        type(c_ptr), intent(in) :: l
        integer,     intent(in) :: idx
        logical                 :: lua_isfunction

        lua_isfunction = .false.

        if (lua_type(l, idx) == LUA_TFUNCTION) &
            lua_isfunction = .true.
    end function lua_isfunction

    ! int lua_islightuserdata(lua_State *L, int index)
    function lua_islightuserdata(l, idx)
        !! Macro replacement that returns whether the stack variable is
        !! light user data.
        type(c_ptr), intent(in) :: l
        integer,     intent(in) :: idx
        logical                 :: lua_islightuserdata

        lua_islightuserdata = .false.

        if (lua_type(l, idx) == LUA_TLIGHTUSERDATA) &
            lua_islightuserdata = .true.
    end function lua_islightuserdata

    ! int lua_isnil(lua_State *L, int index)
    function lua_isnil(l, idx)
        !! Macro replacement that returns whether the stack variable is
        !! nil.
        type(c_ptr), intent(in) :: l
        integer,     intent(in) :: idx
        logical                 :: lua_isnil

        lua_isnil = .false.

        if (lua_type(l, idx) == LUA_TNIL) &
            lua_isnil = .true.
    end function lua_isnil

    ! int lua_isnone(lua_State *L, int index)
    function lua_isnone(l, idx)
        !! Macro replacement that returns whether the stack variable is
        !! nil.
        type(c_ptr), intent(in) :: l
        integer,     intent(in) :: idx
        logical                 :: lua_isnone

        lua_isnone = .false.

        if (lua_type(l, idx) == LUA_TNONE) &
            lua_isnone = .true.
    end function lua_isnone

    ! int lua_isnoneornil(lua_State *L, int index)
    function lua_isnoneornil(l, idx)
        !! Macro replacement that returns whether the stack variable is
        !! none or nil.
        type(c_ptr), intent(in) :: l
        integer,     intent(in) :: idx
        logical                 :: lua_isnoneornil

        lua_isnoneornil = .false.

        if (lua_type(l, idx) <= 0) &
            lua_isnoneornil = .true.
    end function lua_isnoneornil

    ! int lua_istable(lua_State *L, int index)
    function lua_istable(l, idx)
        !! Macro replacement that returns whether the stack variable is a
        !! table.
        type(c_ptr), intent(in) :: l
        integer,     intent(in) :: idx
        logical                 :: lua_istable

        lua_istable = .false.

        if (lua_type(l, idx) == LUA_TTABLE) &
            lua_istable = .true.
    end function lua_istable

    ! int lua_isthread(lua_State *L, int index)
    function lua_isthread(l, idx)
        !! Macro replacement that returns whether the stack variable is a
        !! thread.
        type(c_ptr), intent(in) :: l
        integer,     intent(in) :: idx
        logical                 :: lua_isthread

        lua_isthread = .false.

        if (lua_type(l, idx) == LUA_TTHREAD) &
            lua_isthread = .true.
    end function lua_isthread

    ! int lua_pcall(lua_State *L, int nargs, int nresults, int msgh)
    function lua_pcall(l, nargs, nresults, msgh)
        !! Macro replacement that calls `lua_pcallk()`.
        type(c_ptr), intent(in) :: l
        integer,     intent(in) :: nargs
        integer,     intent(in) :: nresults
        integer,     intent(in) :: msgh
        integer                 :: lua_pcall

        lua_pcall = lua_pcallk(l, nargs, nresults, msgh, int(0, kind=8), c_null_ptr)
    end function lua_pcall

    ! const char *lua_tostring(lua_State *L, int index)
    function lua_tostring(l, i)
        !! Wrapper that calls `lua_tolstring()` and converts the returned C
        !! pointer to Fortran string.
        type(c_ptr), intent(in)       :: l
        integer,     intent(in)       :: i
        character(len=:), allocatable :: lua_tostring
        type(c_ptr)                   :: ptr
        integer(kind=8)               :: size

        ptr = lua_tolstring(l, i, c_null_ptr)
        if (.not. c_associated(ptr)) return

        size = c_strlen(ptr)
        allocate (character(len=size) :: lua_tostring)
        call c_f_string_ptr(ptr, lua_tostring)
    end function lua_tostring

    ! const char *lua_typename(lua_State *L, int tp)
    function lua_typename(l, tp)
        !! Wrapper that calls `lua_typename_()` and converts the returned C
        !! pointer to Fortran string.
        type(c_ptr), intent(in)       :: l
        integer,     intent(in)       :: tp
        character(len=:), allocatable :: lua_typename
        type(c_ptr)                   :: ptr
        integer(kind=8)               :: size

        ptr = lua_typename_(l, tp)
        if (.not. c_associated(ptr)) return

        size = c_strlen(ptr)
        allocate (character(len=size) :: lua_typename)
        call c_f_string_ptr(ptr, lua_typename)
    end function lua_typename

    ! int luaL_dofile(lua_State *L, const char *filename)
    function lual_dofile(l, fn)
        !! Macro replacement that calls `lual_loadfile()` and `lua_pcall()`.
        type(c_ptr),      intent(in) :: l
        character(len=*), intent(in) :: fn
        integer                      :: lual_dofile

        lual_dofile = lual_loadfile(l, fn)

        if (lual_dofile == 0) &
            lual_dofile = lua_pcall(l, 0, LUA_MULTRET, 0)
    end function lual_dofile

    ! int luaL_loadfile(lua_State *L, const char *filename)
    function lual_loadfile(l, fn)
        !! Macro replacement that calls `lual_loadfilex()`.
        type(c_ptr),      intent(in) :: l
        character(len=*), intent(in) :: fn
        integer                      :: lual_loadfile

        lual_loadfile = lual_loadfilex(l, fn // c_null_char, c_null_ptr)
    end function lual_loadfile

    ! int luaL_loadstring(lua_State *L, const char *s)
    function lual_loadstring(l, s)
        !! Wrapper for `lual_loadstring()` that null-terminates the given
        !! string.
        type(c_ptr),      intent(in) :: l
        character(len=*), intent(in) :: s
        integer                      :: lual_loadstring

        lual_loadstring = lual_loadstring_(l, s // c_null_char)
    end function lual_loadstring

    ! void lua_pushcfunction(lua_State *L, lua_CFunction f)
    subroutine lua_pushcfunction(l, f)
        type(c_ptr),    intent(in) :: l
        type(c_funptr), intent(in) :: f

        call lua_pushcclosure(l, f, 0)
    end subroutine lua_pushcfunction

    ! void lua_register(lua_State *L, const char *name, lua_CFunction f)
    subroutine lua_register(l, n, f)
        type(c_ptr),      intent(in) :: l
        character(len=*), intent(in) :: n
        type(c_funptr),   intent(in) :: f

        call lua_pushcfunction(l, f)
        call lua_setglobal(l, n // c_null_char)
    end subroutine lua_register

    subroutine c_f_string_ptr(c_string, f_string)
        !! Utility routine that copies a C string, passed as a C pointer, to a
        !! Fortran string.
        type(c_ptr),      intent(in)           :: c_string
        character(len=*), intent(out)          :: f_string
        character(kind=c_char, len=1), pointer :: char_ptrs(:)
        integer                                :: i

        if (.not. c_associated(c_string)) then
            f_string = ' '
        else
            call c_f_pointer(c_string, char_ptrs, [huge(0)])

            i = 1

            do while (char_ptrs(i) /= c_null_char .and. i <= len(f_string))
                f_string(i:i) = char_ptrs(i)
                i = i + 1
            end do

            if (i < len(f_string)) &
                f_string(i:) = ' '
        end if
    end subroutine c_f_string_ptr
end module lua
