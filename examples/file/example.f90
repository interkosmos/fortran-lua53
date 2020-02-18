program main
    use, intrinsic :: iso_c_binding, only: c_null_char, c_ptr
    use :: lua
    implicit none
    type(c_ptr) :: l
    integer     :: rc

    l = lual_newstate()

    call lual_openlibs(l)

    rc = lual_dofile(l, 'fibonacci.lua')
    rc = lua_getglobal(l, 'fib')
    rc = lua_pcall(l, 0, 0, 0)

    call lua_close(l)
end program main
