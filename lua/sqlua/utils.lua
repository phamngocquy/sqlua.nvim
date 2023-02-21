local M = {}

P = function(v)
  print(vim.inspect(v))
  return v
end

RELOAD = function(...)
  return require("plenary.reload").reload_module(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end

local sep = (function()
    ---@diagnostic disable-next-line: undefined-global
    if jit then
        ---@diagnostic disable-next-line: undefined-global
        local os = string.lower(jit.os)
        if os == "linux" or os == "osx" or os == "bsd" then
            return "/"
        else
            return "\\"
        end
    else
        return string.sub(package.config, 1, 1)
    end
end)()

---@param path_components string[]
---@return string
function M.concat(path_components)
    return table.concat(path_components, sep)
end


local exists = function(file)
  local ok, err, code = os.rename(file, file)
  if not ok then
    if code == 13 then
      return true
    end
  end
  if ok == nil then 
    return false
  end
  return true
end

isDir = function(path)
  return exists(path .. '/')
end

return M