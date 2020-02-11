! fortran.f90
module fortran
    use, intrinsic :: iso_c_binding, only: c_int, c_funloc, c_ptr
    use :: lua
    implicit none

    public :: luaopen_fortran   ! Module registration function.
    public :: hello             ! Routine callable from Lua.
contains
    function luaopen_fortran(l) bind(c)
        !! Utility function to register the Fortran routine `hello()`.
        type(c_ptr), intent(in), value :: l
        integer(kind=c_int)            :: luaopen_fortran

        call lua_register(l, &
                          'hello', &        ! Name of the Fortran routine.
                          c_funloc(hello))  ! Function pointer to the Fortran routine.
        luaopen_fortran = 1
    end function luaopen_fortran

    subroutine hello(l) bind(c)
        !! The Fortran routine callable from Lua.
        type(c_ptr), intent(in), value :: l

        print '(a)', 'Hello from Fortran!'
    end subroutine hello
end module fortran
