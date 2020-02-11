program main
    use, intrinsic :: iso_c_binding, only: c_null_char, c_ptr
    use :: lua
    implicit none
    type(c_ptr) :: l
    integer     :: rc

    l = lual_newstate()

    call lual_openlibs(l)

    rc = lual_dofile(l, 'examples/lua/hello.lua')
    rc = lua_getglobal(l, 'hello')
    rc = lua_pcall(l, 0, 0, 0)

    call lua_close(l)
    ! print '(2a)', 'Cannot run function: ', trim(lua_tostring(l, -1))
end program main
