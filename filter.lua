function Table(el)
  -- Convert to SimpleTable
  local simple_table = pandoc.utils.to_simple_table(el)

  -- Function to remove the fourth column from rows
  local function remove_fourth_column_from_rows(rows)
    
    local new_rows = {}
    local main_counter = 1
    local sub_counter = 0
    
    for i, row in ipairs(rows) do
      table.remove(row, 4)

      local first_cell_content = pandoc.utils.stringify(row[1])

      table.remove(row, 1)

      if string.match(first_cell_content, ".*S") then
        sub_counter = sub_counter + 1
        table.insert(row, 1, pandoc.Plain{pandoc.Str(tostring(main_counter) .. "." ..tostring(sub_counter))})
      else
        sub_counter = 0
        table.insert(row, 1, pandoc.Plain{pandoc.Str(tostring(main_counter))})
        main_counter = main_counter + 1
      end

      --table.insert(row, 1, pandoc.Plain{pandoc.Str(tostring(i))})
      table.insert(new_rows, row)
    end
    return new_rows
  end
  
  local function remove_fourth_column_from_headers(headers)
    local new_headers = {}
      table.remove(headers, 4)
    return headers
  end

  -- Process the rows to remove the fourth column
  if #simple_table.rows > 0 and #simple_table.rows[1] > 3 then
    print(simple_table.rows[1])
    simple_table.rows = remove_fourth_column_from_rows(simple_table.rows)
    simple_table.headers = remove_fourth_column_from_headers(simple_table.headers)
  end

  print(simple_table.widths)
  simple_table.widths = {0.05, 0.15, 0.75}

  return pandoc.utils.from_simple_table(simple_table)
end
