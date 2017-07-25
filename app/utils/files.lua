function writeToFile(text, file)
	local path = system.pathForFile(file, system.DocumentsDirectory)
    -- Open the file handle
    local file, errorString = io.open(path, "w")

    if not file then
        -- Error occurred; output the cause
        print("File error: " .. errorString)
    else
        -- Write data to file
        file:write(text)
        -- Close the file handle
        io.close(file)
    end

    file = nil
end