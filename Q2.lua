-- Q2 - Fix or improve the implementation of the below method
function printSmallGuildNames(memberCount)

    -- this method is supposed to print names of all guilds that have less than memberCount max members
    
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    
    local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
    
    local guildName = result.getString("name")
    
    print(guildName)
    
    end

    -- It can be seen that the code above has some issues, the main one being that it only prints the name of one guild.

-- Fixed version: 
function printSmallGuildNames(memberCount) 
    --function prints members of a Guild that have less than a cerrtain number of maximum members
    --uses memberCount
    -- I can observe that the first code clearly it seems to only print the name of 1 guild, It requires a loop to print all guild names
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < ?" --Here it is used an SQL query it could be different depending on the database or if there's a limit to show the guilds
    -- Using "?" means is a placeholder that will be replaced with the actual value when the query is executed
    -- This is a form of preventing SQL injection, by using this, it will ensure that user-supplied input is never treated as SQL code, making the application more secure
    local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount)) --Its asumed that storeQuery is a function that returns the result of the query
        repeat
            local guildName = resultId.getString("name") 
            print(guildName)
        until not resultId.next() --A loop is used to print guilds that have less than memberCount members
    end
end


    



