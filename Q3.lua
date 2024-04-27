-- Q3 - Fix or improve the name and the implementation of the below method
function do_sth_with_PlayerParty(playerId, membername)

    player = Player(playerId)
    
    local party = player:getParty()
    
     
    
    for k,v in pairs(party:getMembers()) do
    
        if v == Player(membername) then
    
            party:removeMember(Player(membername))
    
        end
    
    end
    
    end

    -- Fixed version: of a function that removes a member from a party
    --This fixed version of the code above, check playerId and party existis to found the member of the party to remove

    function removeMemberFromParty (playerId, membername)
        --This function removes a member from a party, it uses the playerId and the membername to get the player
        local player = Player(playerId)
        if player then --If the player exists already
            local party = player:getParty() --Get the party where they are from
            if party then --If the party exists
                for k, v in pairs(party:getMembers()) do --Iterate through all the members 
                    if v == Player(membername) then --When the member is found 
                        party:removeMember(Player(membername)) --Remove the member from party
                    end
                end
            end
        end
    end