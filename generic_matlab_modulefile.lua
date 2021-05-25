-- This file is a symlink target from the module tree.
-- Works for any MATLAB version so longs as the module and install dir are named like previous versions.
-- Finds the first readable licence file and sets MLM_LICENSE_FILE so lmutil works.

require 'io'
require 'lfs'

local matlab_root = '/opt/nesi/share/MATLAB'
local version = myModuleVersion():gsub('%.', '')
local version_root = pathJoin(matlab_root,'R' .. version) 
local licenses_root = pathJoin(matlab_root, 'Licenses')
local nesi_tools = pathJoin(matlab_root, "NeSI_tools")

function file_readable(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

local license_file = nil
for fn in lfs.dir(licenses_root) do
   if fn:sub(-4) == ".lic" then
      local candidate_licence_file = pathJoin(licenses_root, fn)
      if file_readable(candidate_licence_file) then      
         license_file = candidate_licence_file
         break
      end
   end
end

-- Add everything in nesitools to path.
for fn in lfs.dir(nesi_tools) do	
    prepend_path('MATLABPATH', pathJoin(nesi_tools, fn))
end

if license_file ~= nil then
   setenv('MLM_LICENSE_FILE', license_file)
elseif mode() == "load" then
   LmodError("You do not appear to be a member of any group licensed to use MATLAB")
end


conflict("MATLAB")
prepend_path("PATH", pathJoin(version_root, "bin"))  
prepend_path("PATH", pathJoin(version_root, "etc/glnxa64")) -- for lmutil  
prepend_path("BASEPATHMATLAB", nesi_tools)
setenv("_JAVA_OPTIONS", "-Xmx256m")
setenv("TZ","Pacific/Auckland") --stop annoying parpool warning
setenv("MATLAB_LOG_DIR","/tmp") --put java logs in trash.
help([[MATLAB is a high-level language and interactive environment for numerical computing - Homepage: http://www.mathworks.com/products/matlab]])
whatis([[Name: MATLAB]])
whatis([[Description: A high-level language and interactive environment for numerical computing.]])
whatis([[Homepage: http://www.mathworks.com/products/matlab]])


