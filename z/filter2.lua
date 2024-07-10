function Table(el)
  -- Create a new header with "No." column if it doesn't exist
  if #el.headers == 0 then
    -- Create a new header row with the "No." column
    el.headers = { pandoc.TableHead{pandoc.Row{pandoc.Plain{pandoc.Str("No.")}}} }
  else
    -- Insert the "No." column into the existing header
    table.insert(el.headers[1].cells, 1, pandoc.Plain{pandoc.Str("No.")})
  end

  -- Number the rows
  for i, row in ipairs(el.rows) do
    table.insert(row.cells, 1, pandoc.Plain{pandoc.Str(tostring(i))})
  end
  return el
end

