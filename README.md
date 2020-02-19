# fortran-lua53
A collection of ISO C binding interfaces to Lua 5.3 for Fortran 2003, to call
Lua from Fortran and vice versa.

Similar projects:

* [AOTUS](https://geb.sts.nt.uni-siegen.de/doxy/aotus/): Library that provides a Fortran wrapper to use Lua scripts as configuration files (MIT).
* [FortLua](https://github.com/adolgert/FortLua): Example that shows how to load Lua configuration files from Fortran, based on AOTUS (MIT).
* [f2k3-lua](https://github.com/MaikBeckmann/f2k3-lua/tree/simple): Lua bindings for loading configuration files only (MIT).
* [luaf](https://bitbucket.org/vadimz/luaf/): Selected bindings to Lua 5.1 (MIT).

## Build
Install Lua 5.3 with development headers. On FreeBSD, run:

```
# pkg install lang/lua53
```

Execute `make` with (optional) parameters to build the interfaces:

```
$ make FC=gfortran9 PREFIX=/usr
```

This will output the object file `lua.o` for linking. Variables are imported
from file `Makefile.inc`. Link your Fortran applications with `-llua-5.3` to
access Lua 5.3.

## Example
The following basic example shows how to call the Lua function `hello()` in
`script.lua` from Fortran.

```lua
-- script.lua
function hello()
    print('Hello from Lua!')
end
```

Make sure that `script.lua` is stored in the same directory as the Fortran
application.

```fortran
! example.f90
program main
    use, intrinsic :: iso_c_binding, only: c_null_char, c_ptr
    use :: lua
    implicit none
    type(c_ptr) :: l
    integer     :: rc

    l = lual_newstate()
    call lual_openlibs(l)

    rc = lual_dofile(l, 'script.lua')
    rc = lua_getglobal(l, 'hello')
    rc = lua_pcall(l, 0, 0, 0)

    call lua_close(l)
end program main
```

Compile, link, and run the example with:

```
$ gfortran -I/usr/local/include/lua53/ -L/usr/local/lib/lua/5.3/ -o example example.f90 lua.o -llua-5.3
$ ./example
Hello from Lua!
```

On Linux, change the prefix `/usr/local` to `/usr`.

## Further Examples
Additional examples can be found in `examples/`.

* **fibonacci:** calls a recursive Lua routine loaded from file.
* **library:** calls a Fortran routine inside a shared library from Lua.
* **string:** runs Lua code stored in a Fortran string.

Compile all examples with:

```
$ make examples
```

Or use the name of a particular example.

## Coverage
| Function Name           | Fortran Interface Name  | Bound |
|-------------------------|-------------------------|-------|
| `lua_arith`             | `lua_arith`             |   ✓   |
| `lua_call`              | `lua_call`              |   ✓   |
| `lua_callk`             | `lua_callk`             |   ✓   |
| `lua_checkstack`        | `lua_checkstack`        |   ✓   |
| `lua_close`             | `lua_close`             |   ✓   |
| `lua_compare`           | `lua_compare`           |   ✓   |
| `lua_concat`            | `lua_concat`            |   ✓   |
| `lua_copy`              | `lua_copy`              |   ✓   |
| `lua_createtable`       | `lua_createtable`       |   ✓   |
| `lua_gc`                | `lua_gc`                |   ✓   |
| `lua_getglobal`         | `lua_getglobal`         |   ✓   |
| `lua_gettop`            | `lua_gettop`            |   ✓   |
| `lua_isboolean`         | `lua_isboolean`         |   ✓   |
| `lua_iscfunction`       | `lua_iscfunction`       |   ✓   |
| `lua_isfunction`        | `lua_isfunction`        |   ✓   |
| `lua_isinteger`         | `lua_isinteger`         |   ✓   |
| `lua_isnil`             | `lua_isnil`             |   ✓   |
| `lua_isnone`            | `lua_isnone`            |   ✓   |
| `lua_isnoneornil`       | `lua_isnoneornil`       |   ✓   |
| `lua_isnumber`          | `lua_isnumber`          |   ✓   |
| `lua_isstring`          | `lua_isstring`          |   ✓   |
| `lua_istable`           | `lua_istable`           |   ✓   |
| `lua_isthread`          | `lua_isthread`          |   ✓   |
| `lua_isuserdata`        | `lua_isuserdata`        |   ✓   |
| `lua_isyieldable`       | `lua_isyieldable`       |   ✓   |
| `lua_load`              | `lua_load`              |   ✓   |
| `lua_newtable`          | `lua_newtable`          |   ✓   |
| `lua_pcall`             | `lua_pcall`             |   ✓   |
| `lua_pcallk`            | `lua_pcallk`            |   ✓   |
| `lua_pop`               | `lua_pop`               |   ✓   |
| `lua_pushboolean`       | `lua_pushboolean`       |   ✓   |
| `lua_pushcclosure`      | `lua_pushcclosure`      |   ✓   |
| `lua_pushfstring`       |                         |       |
| `lua_pushinteger`       | `lua_pushinteger`       |   ✓   |
| `lua_pushlightuserdata` | `lua_pushlightuserdata` |   ✓   |
| `lua_pushlstring`       | `lua_pushlstring`       |   ✓   |
| `lua_pushnil`           | `lua_pushnil`           |   ✓   |
| `lua_pushnumber`        | `lua_pushnumber`        |   ✓   |
| `lua_pushstring`        | `lua_pushstring`        |   ✓   |
| `lua_pushthread`        | `lua_pushthread`        |   ✓   |
| `lua_pushvalue`         | `lua_pushvalue`         |   ✓   |
| `lua_pushvfstring`      |                         |       |
| `lua_register`          | `lua_register`          |   ✓   |
| `lua_setglobal`         | `lua_setglobal`         |   ✓   |
| `lua_settop`            | `lua_settop`            |   ✓   |
| `lua_status`            | `lua_status`            |   ✓   |
| `lua_tostring`          | `lua_tostring`          |   ✓   |
| `lua_type`              | `lua_type`              |   ✓   |
| `lua_typename`          | `lua_typename`          |   ✓   |
| `luaL_dofile`           | `lual_dofile`           |   ✓   |
| `luaL_loadfile`         | `lual_loadfile`         |   ✓   |
| `luaL_loadfilex`        | `lual_loadfilex`        |   ✓   |
| `luaL_loadstring`       | `lual_loadstring`       |   ✓   |
| `luaL_newstate`         | `lual_newstate`         |   ✓   |
| `luaL_openlibs`         | `lual_openlibs`         |   ✓   |

## Licence
ISC
