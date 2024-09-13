local databaseTables = {
    [[
    CREATE TABLE IF NOT EXISTS lunar_contracts (
        id INT AUTO_INCREMENT PRIMARY KEY,
        data LONGTEXT,
        extra_data LONGTEXT
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    ]],
    [[
    CREATE TABLE IF NOT EXISTS lunar_contracts_profiles (
        identifier VARCHAR(50) PRIMARY KEY,
        username VARCHAR(255) NOT NULL UNIQUE,
        image VARCHAR(255),
        firstLogin INT,
        completedContracts INT,
        lastActive INT,
        crypto INT,
        xp INT
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    ]]
}

MySQL.ready(function()
    for i = 1, #databaseTables do
        MySQL.query.await(databaseTables[i])
    end
end)