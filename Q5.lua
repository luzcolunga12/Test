local posTalk = TalkAction("/pos", "!pos")

function posTalk.onSay(player, words, param)
    if player:getGroup():getAccess() and param ~= "" then
        local split = param:split(",")
        player:teleportTo(Position(split[1], split[2], split[3]))
    else
        local position = player:getPosition()
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Your current position is: " .. position.x .. ", " .. position.y .. ", " .. position.z .. ".")
    end
    return false
end

posTalk:separator(" ")
posTalk:register()

local frigoTalk = TalkAction("/frigo", "!frigo") --My original plan was to make a spell that would hit the player with a frigo.
--It's supossed to be a command on the chat like /frigo and it would hit the player with a frigo
--Used the already existing code from the /pos command to make this one and the attack of whirlwind
function frigoTalk.onSay(player, words, param)
    if words:lower() == "frigo" then

        local combat = Combat()
        combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
        combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
        combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_WEAPONTYPE)
        combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
        combat:setParameter(COMBAT_PARAM_USECHARGES, true)

        function onGetFormulaValues(player, skill, attack, factor)
            local min = (player:getLevel() / 5) + (skill * attack * 0.01) + 1
            local max = (player:getLevel() / 5) + (skill * attack * 0.03) + 6
            return -min, -max
        end

        combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")
        combat:execute(player, Variant(player:getPosition()))
    end
    return false
end

frigoTalk:separator(" ")
frigoTalk:register()
