local xcode = premake.xcode
local solution = premake.solution
local project = premake.project
local tree  = premake.tree
   
function xcode.workspace_head()
	_p('<?xml version="1.0" encoding="UTF-8"?>')
	_p('<Workspace')
		_p(1,'version = "1.0">')

end

function xcode.workspace_tail()
	_p('</Workspace>')
end

function xcode.workspace_file_ref(prj)

		local projpath = path.getrelative(prj.solution.location, prj.location)
		if projpath == '.' then projpath = '' 
		else projpath = projpath ..'/' 
		end
		_p(1,'<FileRef')
			_p(2,'location = "group:%s">',projpath .. prj.name .. '.xcodeproj')
		_p(1,'</FileRef>')
end

function xcode.workspace_generate(sln)
	premake.xcode.preparesolution(sln)
	xcode.workspace_head()
   
	for prj in premake.solution.eachproject(sln) do
		xcode.workspace_file_ref(prj)
	end
	
    xcode.workspace_tail()
end



