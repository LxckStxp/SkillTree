-- UIElements.lua

local UIElements = {}

function UIElements.Create(type, props)
    local element = Instance.new(type)
    for k, v in pairs(props) do element[k] = v end
    return element
end

return UIElements
