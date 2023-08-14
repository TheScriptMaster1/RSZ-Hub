local supported_games = {
	11251823801, -- Slap Battles but Bad
        11251988911 -- Slap Royale but Bad
}

if table.find(supported_games, game.PlaceId) then
   loadstring(game:HttpGet("https://raw.githubusercontent.com/TheScriptMaster1/RSZ-Hub/main/"..game.PlaceId..".lua"))()
end
