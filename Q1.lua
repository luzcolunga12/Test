-- Q1 - Fix or improve the name and the implementation of the below method
local function releaseStorage(player)

    player:setStorageValue(1000, -1)
    
    end
    
    function onLogout(player)
    
    if player:getStorageValue(1000) == 1 then
    
    addEvent(releaseStorage, 1000, player)
    
    end
    
    return true
    
    end

--
--This code is improved compared to the original code, it adds a delay to reset the storage value of a player when they log out
--It adds constats to make the code easier to read and understand, also can be helpful it it needs to me modified

--make constant for storage key
--make constant for delay time
local STORAGE_KEY = 1000 
local DELAY_TIME = 1000

--The funcion resets the storage value of a player
local function relesePlayerStorage(player)
    local result = player:setStorageValue(STORAGE_KEY, -1)
end

--The function is called when a player logs out
function onLogout(player)
    --Check if player's storage value is 1, then it will reset after delay
    if player:getStorageValue(STORAGE_KEY) == 1 then
        addEvent(relesePlayerStorage, DELAY_TIME, player)
    end
    return true
end

