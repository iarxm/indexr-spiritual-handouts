local pandoc = require 'pandoc'

-- Helper function to write CSV file
local function write_csv(table, filename)
  local csvfile = io.open(filename, 'w')
  for i, row in ipairs(table.rows) do
    local values = {}
    for j, cell in ipairs(row) do
      table.insert(values, pandoc.utils.stringify(cell))
    end
    csvfile:write(table.concat(values, ',') .. '\n')
  end
  csvfile:close()
end

-- Helper function to read CSV file
local function read_csv(filename)
  local rows = {}
  for line in io.lines(filename) do
    local fields = {}
    for field in line:gmatch('([^,]+)') do
      table.insert(fields, pandoc.Str(field))
    end
    table.insert(rows, fields)
  end
  return rows
end

-- Filter function for converting Markdown tables to CSV and back
function Table (elem)
  -- Generate a unique filename for the CSV file
  local filename = 'table_' .. tostring(elem.attr.identifier) .. '.csv'
  
  -- Convert table to CSV and write to file
  write_csv(elem, filename)
  
  -- Read the CSV file back into a table
  local rows = read_csv(filename)
  
  -- Create a new Pandoc table from the CSV data
  local new_table = pandoc.Table(elem.caption,
                                 elem.aligns,
                                 elem.widths,
                                 elem.headers,
                                 rows)
  
  return new_table
end

return {
  { Table = Table }
}
