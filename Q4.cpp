#include <iostream>
#include <string>
#include <memory>
// This code uses various  "libraries" that it should be included
// This is how I would add them:
// #include "Game.h"
// #include "Player.h"
// #include "Item.h"
// #include "IOLoginData.h"
//Since I don't have them I will leave them commented out


//Q4 - Assume all method calls work fine. Fix the memory leak issue in below method

void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
 
{

Player* player = g_game.getPlayerByName(recipient);

if (!player) {

player = new Player(nullptr);

if (!IOLoginData::loadPlayerByName(player, recipient)) {

return;

}

}

 

Item* item = Item::CreateItem(itemId);

if (!item) {

    return;

}

 

g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

 

if (player->isOffline()) {

    IOLoginData::savePlayer(player);

}

}


//Improved code
//This code will improve by preventing memory leaks

void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    std::unique_ptr<Player> player(g_game.getPlayerByName(recipient)); //Use unique_ptr (pointer) to manage memory
    bool isNewPlayer = !player; //Checks player's existence

    //Id player is not found, create a new player object
    if(isNewPlayer)
    {
        player.reset(new Player(nullptr)); //Create new player object

        //Attemplts to load player based on name, if it fails, clean up and return
        if(!IOLoginData::loadPlayerByName(player, recipient))
        {
    
            return;
        }
    }

    //Create item objecr
    std::unique_ptr<Item> item(Item::CreateItem(itemId)); //Use unique_ptr (pointer) to manage memory 
    //The main issue with the previous code was the lack of use of pointers to manage the memory
        if(!item)
        {
            return; //If item creation fails, it will exit the function
        }

    //Add item to player's inbox
    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    //If player was ofline clean up and save data
    if(player->isOffline())
    {
        IOLoginData::savePlayer(player);
        
    }
}