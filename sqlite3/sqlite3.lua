--[[
The MIT License (MIT)

Copyright (c) 2016 Centauri Soldier https://github.com/CentauriSoldier/SQLite3-LOVE

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

DLLs provided by josefnpat
https://love2d.org/forums/viewtopic.php?f=5&t=38486&hilit=sqlite3
]]

local tSettings = {
	SQLite3Path = love.filesystem.getRealDirectory("plugins/sqlite3/sqlite3.lua"), --Edit to suit your project:
	--Notes | (1) This is usually case-sensitive on non-Windows machines. (2) This MUST be an absolute (not relative) path.
	
	--<<<< DO NOT EDIT BELOW THIS LINE >>>>
	SystemType = "Not Configured",
	SystemBits = "32",
	SystemPaths = { 
		linux = {
			["32"] = "dll/linux_x86",
			["64"] = "dll/linux_x64",
		},
		windows = {
			["32"] = "dll/win_x86",
			["64"] = "dll/win_x86_64",
		},
		mac = {
			["32"] = "dll/osx_x86+x86_64",
			["64"] = "dll/osx_x86+x86_64",
		},
	},
};

--a pretty error message header
local function SQLite3Error(sError)
error("SQLite3 init error: "..sError);
end

--check for the debug library
if not debug then
SQLite3Error("The 'debug' library is required in order for slqite3 to work. Please use a version of lua that contains that library.");
end

--check for io
if not io then
SQLite3Error("The 'io' library is required in order for slqite3 to work. Please use a version of lua that contains that library.");
end

--check for io.popen
if not io.popen then
SQLite3Error("The 'io.popen' function is required in order for slqite3 to work. Please use a version of lua that contains that function.");
end

--determines the OS type and bit interface
local function getOSInfo()
	
	local hCommand = io.popen("ver");
	local sCommand = hCommand:read("*a");
	
	--test for windows
	local hCommand = io.popen("ver");
	local sCommand = hCommand:read("*a");
		
	if sCommand:lower():find("windows") then
	tSettings.SystemType = "windows";
		
		--test for 64 bit interface
		hCommand = io.popen("echo %PROCESSOR_ARCHITECTURE%");
		sCommand = hCommand:read("*a");
		
		if sCommand:lower():find("64") then		
		tSettings.SystemBits = "64";		
		end
		
	return
	end

	--test for linux
	hCommand = io.popen("uname");
	sCommand = hCommand:read("*a");
		
	if sCommand:lower():find("linux") then
	tSettings.SystemType = "linux";
		
		--test for 64 bit interface
		hCommand = io.popen("uname -m");
		sCommand = hCommand:read("*a");
		
		if sCommand:lower():find("64") then
		tSettings.SystemBits = "64";
		end
		
	return
	end

	--test for mac
	hCommand = io.popen("sw_vers -productVersion");
	sCommand = hCommand:read("*a");
		
	if sCommand:lower():find("mac") then
	tSettings.SystemType = "mac";
	return
	end
	
end

--get and store the OS type and bit interface
getOSInfo();

--check the user path
if not type(tSettings.SystemType) == "string" then
SQLite3Error("SQLite3 path (tSettings.SQLite3Path) must be a string.");
end	

--check the system type data type
if not type(tSettings.SystemType) == "string" then
SQLite3Error("System Type (tSettings.SystemType) must be a string.");
end

--check the system bits data type
if not type(tSettings.SystemBits) == "string" then
SQLite3Error("System Bits (tSettings.SystemBits) must be a string.");
end

--lower the 'SystemType' string
tSettings.SystemType = tSettings.SystemType:lower();

--trim the slashes off the beginning and end of the path
local sStart = tSettings.SQLite3Path:sub(1, 1);
local sEnd = tSettings.SQLite3Path:sub(tSettings.SQLite3Path:len());

if sStart:find("/") or sStart:find("\\") then
tSettings.SQLite3Path = tSettings.SQLite3Path:sub(2);
end

if sEnd:find("/") or sEnd:find("\\") then
tSettings.SQLite3Path = tSettings.SQLite3Path:sub(1, tSettings.SQLite3Path:len() - 1);
end
	
--make sure the OS type is recognized
if not tSettings.SystemPaths[tSettings.SystemType] then
SQLite3Error("Operating System Type '"..tSettings.SystemType.."'".." not recognized or supported. Supported types are 'Linux', 'OS X' and 'Windows'.");
end

--make sure the bit level is supported
if not tSettings.SystemPaths[tSettings.SystemType][tSettings.SystemBits] then
error("Operating System Bit Level '"..tSettings.SystemBits.."'".." not recognized or supported for System Type '"..tSettings.SystemType.."'. Supported bit levels are '32' and '64'.");
end

--get the path to the file to be required
local sPath = tSettings.SQLite3Path.."/"..debug.getinfo(1, "S").source:gsub("sqlite3.lua", ""):gsub("@", "");
sPath = sPath.."/"..tSettings.SystemPaths[tSettings.SystemType][tSettings.SystemBits];
	
	--replace the directory separator and library type if this is a windows machine
	local sDirectorySeparator = package.config:sub(1,1);
	local sLibraryExtension = "so";
	
	if tSettings.SystemType == "windows" then
	sPath = sPath:gsub("/", sDirectorySeparator);
	sLibraryExtension = "dll";
	end
		
	--ensure that the path begins with "/" if this is a linux system
	if tSettings.SystemType == "linux" then
	sPath = "/"..sPath;	
	end

	--purge any double separators
	sPath = sPath:gsub("\\\\", "\\");
	sPath = sPath:gsub("//", "/");
	
--check for the ';' at the end of package.cpath
local sCPathSeparator = ";";
if package.cpath:sub(package.cpath:len()) == ";" then
sCPathSeparator = "";
end

--add that path the package.cpath
package.cpath = package.cpath..sCPathSeparator..sPath..sDirectorySeparator.."?."..sLibraryExtension..";";

--require the dll/so
sqlite3 = require("lsqlite3");

--[[
This removes the read-only properties from
the new sqlite3 table so we can create new
functions.
]]
local tempsqlite3 = {};
sqlite3.__newindex = tempsqlite3.__newindex;
tempsqlite3 = nil;