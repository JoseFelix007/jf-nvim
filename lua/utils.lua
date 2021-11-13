
function _G.isTable(t) return type(t) == 'table' end

function _G.dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
end

function _G.print_table(t)
    print(dump(t))
end

function _G.table_shallow_copy(t)
    local t2 = {}
    for k,v in pairs(t) do
      t2[k] = v
    end
    return t2
end

function _G.table_copy(obj, seen)
    if type(obj) ~= 'table' then return obj end
    if seen and seen[obj] then return seen[obj] end
    local s = seen or {}
    local res = setmetatable({}, getmetatable(obj))
    s[obj] = res
    for k, v in pairs(obj) do res[table_copy(k, s)] = table_copy(v, s) end
    return res
end

function _G.merge_tables(t1, t2)
    local ct1 = table_copy(t1)
    local ct2 = table_copy(t2)

    for k, v in pairs(ct2) do
        if ct1[k] and isTable(ct1[k]) and isTable(v) then
            ct1[k] = merge_tables(ct1[k], v)
        else
            ct1[k] = v
        end
    end

    return ct1
end

function _G.field_value_to_table(table, field, value)
    local M = table_copy(table)
    if not M[field] then M[field] = {} end

    if isTable(M[field]) and isTable(value) then
        -- M[field] = table_copy(value)
        M[field] = merge_tables(M[field], value)
    else
        M[field] = value
    end
    return M
end
