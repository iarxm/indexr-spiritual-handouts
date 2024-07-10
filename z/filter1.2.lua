local pandoc = require 'pandoc'

local function simpo(tablex)
  local simpleTable = pandoc.utils.to_simple_table(tablex)
  local blocks = pandoc.Blocks{}
  for _, headercell in ipairs(simpleTable.header) do
    blocks:extend(headercell)
  end
  for _, row in ipairs(simpleTable.rows) do
    for _, cell in ipairs(row) do
      blocks:extend(cell)
    end
  end
  print(blocks)
  --return blocks, false
end

-- Debug: Print header information
local function write_head(tablex, filenamex)
  print("Headers:")
  print(ipairs(tablex.head))
  for _, cell in ipairs(tablex.head) do
    local header_str = pandoc.utils.stringify(cell)
    print("cell")
    print(cell)
    --csvfile:write(header_str .. ',')
  end
  --csvfile:write('\n')
end

local function write_bodies(tablex, filenamex)
  for _, row in ipairs(tablex.bodies) do
    local values = {}
    for _, cell in ipairs(row) do
      local cell_str = pandoc.utils.stringify(cell)
      print("cell string:")
      print(cell_str)
      table.insert(values, cell_str)
    end
    csvfile:write(table.concat(values, ',') .. '\n')
  end
  csvfile:close()
end

-- Helper function to write CSV file
local function write_csv(tablex, filenamex)
  local csvfile = io.open(filenamex, 'w')

  write_head(tablex, filenamex)
  --write_bodies(tablex, filenamex)
  
end

-- Helper function to read CSV file
local function read_csv(filename)
  local rows = {}
  for line in io.lines(filename) do
    local fields = {}
    for field in line:gmatch('([^,]+)') do
      table.insert(fields, pandoc.Str(field))
    end
    table.insert(rows, pandoc.Row(fields))
  end
  return rows
end


-- Filter function for converting Markdown tables to CSV and back
function Table (elem)
  -- Debug: Print table structure
  --print("Processing Table:")
  --print(elem)
  --print(elem)
  --print(ipairs(elem.head))
  simpo(elem)

  -- Generate a unique filename for the CSV file
  local filename = 'table_' .. tostring(math.random(1, 1000000)) .. '.csv'

  -- Convert table to CSV and write to file
  --write_csv(elem, filename)

  -- Read the CSV file back into a table
  --local rows = read_csv(filename)

  -- Create a new Pandoc table from the CSV data
  --local new_table = pandoc.Table(elem.caption,
   --                              elem.aligns,
    --                             elem.widths,
     --                            elem.headers,
      --                           rows)

  return new_table
end

return {
  { Table = Table }
}
