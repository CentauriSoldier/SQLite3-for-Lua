# SQLite3 for Lua
An SQLite3 Library for Lua

## Installation and Setup
- Download **sqlite3.lua**.

- Copy the **sqlite3.lua** file to your project.

- Edit the **sqlite3.lua** file and set the *SQLite3Path* variable in the **tSettings** table to the directory where the Sqlite3 plugin can write the library file. 

*Note*: the application **must** have write access to the path. The user data folder is usually a good place for the Sqlite3 plugin to write the library file.

There are various ways to do this depending on what system is being used. For example, if you're using [LÖVE](https://love2d.org/), you can simply type **love.filesystem.getSaveDirectory()**.

- Require the scipt file.
```lua
require('pathtoyourscripts.sqlite3');
```
## Usage Example
```lua  
    --create/open database
    local hDB = sqlite3.open("mydatabase.db");

      if hDB then
      local sQuery = "CREATE TABLE test (id INTEGER PRIMARY KEY   AUTOINCREMENT, name CHAR(20));";
      hDB:execute(sQuery);
      
      hDB:close();
      end
```
## Documentation
https://www.sqlite.org/

## Additional Contributors
DLLs provided by josefnpat

https://love2d.org/forums/viewtopic.php?f=5&t=38486&hilit=sqlite3


All base64 code by Ernest R. Ewert

https://github.com/ErnieE5/ee5_base64

## License
  The MIT License (MIT)

  Copyright (c) 2016 Centauri Soldier

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
