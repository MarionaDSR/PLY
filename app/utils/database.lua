local sqlite3 = require("sqlite3")
require("utils.files")

local database = {}

function database.copyDatabaseTo(filename, destination)
    assert(type(filename) == "string", "string expected for the first parameter but got " .. type(filename) .. " instead.")
    assert(type(destination) == "table", "table expected for the second paramter but bot " .. type(destination) .. " instead.")
    local sourceDBpath = system.pathForFile(filename, system.ResourceDirectory)
    -- io.open opens a file at path; returns nil if no file found
    local readHandle, errorString = io.open(sourceDBpath, "rb")
    assert(readHandle, "Database at " .. filename .. " could not be read from system.ResourceDirectory ")
    assert(type(destination.filename) == "string", "filename should be a string, its a " .. type(destination.filename))
    assert(type(destination.baseDir) == "userdata", "baseName should be a valid system directory")
    local destinationDBpath = system.pathForFile(destination.filename, destination.baseDir)
    local writeHandle, writeErrorString = io.open(destinationDBpath, "wb")
    assert(writeHandle, "Could not open " .. destination.filename .. " for writing. ")
    local contents = readHandle:read("*a")
    writeHandle:write(contents)
    io.close(writeHandle)
    io.close(readHandle)
    return true
end

function database.copyDatabaseToDocumentsOnlyOnce(filename)
    local baseDir = system.DocumentsDirectory
     
    -- Open "data.db". If the file doesn't exist, it will be created
    local path = system.pathForFile(filename, baseDir)
    local doesExist = io.open(path, "r")
    if not doesExist then
        local result = database.copyDatabaseTo(filename, { filename=filename, baseDir=system.DocumentsDirectory })
        assert(result, "Database failed to copy. Check the logs.")
    else
        io.close(doesExist)
    end
end

function database.exportDB(db)
    local cvsFile = "Nombre,Apellido,Email,Celular,Fecha Nacimiento,Carné Identidad"
    local query = "SELECT * FROM Jugador"
    for row in db:nrows(query) do
        local jugador = row.nombre..","..row.apellido..","..row.email..","..row.celular..","..row.fechaNacimiento..","..row.carneIdentidad
        cvsFile = cvsFile.."\n"..jugador
    end
    return cvsFile
end

function database.openDB(dbFile)
    database.copyDatabaseToDocumentsOnlyOnce(dbFile)
    local path = system.pathForFile(dbFile, system.DocumentsDirectory )
    local db = sqlite3.open(path)
    return db
end

function database.testDB()
    local db = database.openDB("jugadores.db")
    local csvData = database.exportDB(db)
    writeToFile(csvData, "jugadores.csv")
end

return database

