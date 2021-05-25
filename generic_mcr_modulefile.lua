-- This file is a symlink target from the module tree.
-- Works for any MATLAB version so long as the module and install dir are named like previous versions.

local version = myModuleVersion():gsub('%.', '')

local root = '/opt/nesi/mahuika/MATLAB/R' .. version
conflict("MATLAB")
conflict("MCR")
-- setenv("_JAVA_OPTIONS", "-Xmx256m")

setenv("MCR_ROOT", root)
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "runtime/glnxa64"))
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "bin/glnxa64"))
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "sys/os/glnxa64"))
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "sys/opengl/lib/glnxa64"))

-- prepend_path("PATH", pathJoin(root, "bin"))


help([[The Matlab Compiler Runtime is required for running compiled MATLAB executables without MATLAB itself.
 - Homepage: https://www.mathworks.com/products/compiler/mcr.html]])
whatis([[Name: MCR]])
whatis([[Description: The Matlab Compiler Runtime is required for running compiled MATLAB executables without MATLAB itself.]])
whatis([[Homepage: http://www.mathworks.com/products/compiler/mcr.html]])


