local tSettings = {
	SQLite3Path = "plugins/sqlite3", --Edit	to suit your project: this is case-sensitive on linux!
	SystemType = "Windows", --Edit to suit your project
	SystemBits = "64", --Edit to suit your project
	--<<<< DO NOT EDIT BELOW THIS LINE >>>>
	SystemPaths = { 
		linux = {
			["32"] = "dll/linux_x86/lsqlite3",
			["64"] = "dll/linux_x64/lsqlite3",
		},
		windows = {
			["32"] = "dll/win_x86/lsqlite3",
			["64"] = "dll/win_x86_64/lsqlite3",
		},
		mac = {
			["32"] = "dll/osx_x86+x86_64/lsqlite3",
			["64"] = "dll/osx_x86+x86_64/lsqlite3",
		},
	},
};


--[[*
@module sqlite3
DLLs provided by josefnpat
https://love2d.org/forums/viewtopic.php?f=5&t=38486&hilit=sqlite3
*]]

local function SQLite3Error(sError)
error("SQLite3 init error: "..sError);
end

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
SQLite3Error("Operating System Type '"..tSettings.SystemType.."'".." not recognized or supported. Supported types are 'Linux', 'Mac' and 'Windows'.");
end

--make sure the bit level is supported
if not tSettings.SystemPaths[tSettings.SystemType][tSettings.SystemBits] then
error("Operating System Bit Level '"..tSettings.SystemBits.."'".." not recognized or supported for System Type '"..tSettings.SystemType.."'. Supported bit levels are '32' and '64'.");
end

--get the path to the file to be required
local sPath = love.filesystem.getRealDirectory(tSettings.SQLite3Path.."/sqlite3.lua").."/"..tSettings.SQLite3Path;
sPath = sPath.."/"..tSettings.SystemPaths[tSettings.SystemType][tSettings.SystemBits];

--add that path the package.path
package.path = package.path .. ";"..sPath;

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