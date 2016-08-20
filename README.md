# SQLite3 for Lua
An SQLite3 Library for Lua

##Installation and Setup
Copy the **sqlite3** folder and all its contents to your project.

Edit the **sqlite3.lua** file and set the following variable in the **tSettings** table to folderdirectory contianing this plugin:
- SQLite3Path

*Note*: this path must be an absolute path on the system such as "C:\\MyPath\\MyProject\\plugins".
There are various ways to do this depending on what system is being used. For example, if using LOVE and placing the plugin in directory named 'plugins', you can simply type **love.filesystem.getRealDirectory("plugins/sqlite3/sqlite3.lua")**.

- Require the scipt file.

require('pathtoyourscripts.sqlite3.sqlite3');

##Documentation
https://www.sqlite.org/

##Additional Contributors
DLLs provided by josefnpat
https://love2d.org/forums/viewtopic.php?f=5&t=38486&hilit=sqlite3

##License
  The MIT License (MIT)

  Copyright (c) 2016 Centauri Soldier

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
