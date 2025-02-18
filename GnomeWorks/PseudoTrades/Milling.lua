

do
	local millingBrackets = {
		[39151] = { [39151] = 3 },
		[43105] = { { [43105] = 0.5, [39339] = 2.5 } , { [43105] = 1, [39339] = 3 } },
	}

	local millingResults = {
		[3818] = { -- Fadeleaf
			[43105] = 0.5, --Indigo Pigment
			[39339] = 2.5, --Emerald Pigment
		},
		[3821] = { -- Goldthorn
			[43105] = 0.5, --Indigo Pigment
			[39339] = 2.5, --Emerald Pigment
		},

		[3358] = { -- Khadgar\'s Whisker
			[43105] = 1, --Indigo Pigment
			[39339] = 3, --Emerald Pigment
		},
		[3819] = { -- Wintersbite
			[43105] = 1, --Indigo Pigment
			[39339] = 3, --Emerald Pigment
		},



		[765] = { -- Silverleaf
			[39151] = 3, --Alabaster Pigment
		},
		[2449] = { -- Earthroot
			[39151] = 3, --Alabaster Pigment
		},
		[2447] = { -- Peacebloom
			[39151] = 3, --Alabaster Pigment
		},

		[8831] = { -- Purple Lotus
			[39340] = 2.5, --Violet Pigment
			[43106] = 0.5, --Ruby Pigment
		},
		[8836] = { -- Arthas\' Tears
			[39340] = 2.5, --Violet Pigment
			[43106] = 0.5, --Ruby Pigment
		},
		[8838] = { -- Sungrass
			[39340] = 2.5, --Violet Pigment
			[43106] = 0.5, --Ruby Pigment
		},
		[4625] = { -- Firebloom
			[39340] = 2.5, --Violet Pigment
			[43106] = 0.5, --Ruby Pigment
		},
		[8839] = { -- Blindweed
			[39340] = 3, --Violet Pigment
			[43106] = 1, --Ruby Pigment
		},
		[8845] = { -- Ghost Mushroom
			[39340] = 3, --Violet Pigment
			[43106] = 1, --Ruby Pigment
		},
		[8846] = { -- Gromsblood
			[39340] = 3, --Violet Pigment
			[43106] = 1, --Ruby Pigment
		},

		[785] = { -- Mageroyal
			[43103] = 0.5, --Verdant Pigment
			[39334] = 2.5, --Dusky Pigment
		},
		[2453] = { -- Bruiseweed
			[43103] = 1, --Verdant Pigment
			[39334] = 3, --Dusky Pigment
		},
		[3820] = { -- Stranglekelp
			[43103] = 1, --Verdant Pigment
			[39334] = 3, --Dusky Pigment
		},
		[2450] = { -- Briarthorn
			[43103] = 0.5, --Verdant Pigment
			[39334] = 3, --Dusky Pigment
		},
		[2452] = { -- Swiftthistle
			[43103] = 0.5, --Verdant Pigment
			[39334] = 3, --Dusky Pigment
		},


		[13463] = { -- Dreamfoil
			[39341] = 2.5, --Silvery Pigment
			[43107] = 0.5, --Sapphire Pigment
		},
		[13464] = { -- Golden Sansam
			[39341] = 2.5, --Silvery Pigment
			[43107] = 0.5, --Sapphire Pigment
		},
		[13465] = { -- Mountain Silversage
			[39341] = 3, --Silvery Pigment
			[43107] = 1, --Sapphire Pigment
		},
		[13466] = { -- Plaguebloom
			[39341] = 3, --Silvery Pigment
			[43107] = 1, --Sapphire Pigment
		},
		[13467] = { -- Icecap
			[39341] = 3, --Silvery Pigment
			[43107] = 1, --Sapphire Pigment
		},


		[39969] = { -- Fire Seed
			[43109] = 0.5, --Icy Pigment
			[39343] = 2.5, --Azure Pigment
		},
		[36901] = { -- Goldclover
			[43109] = 0.5, --Icy Pigment
			[39343] = 2.5, --Azure Pigment
		},
		[36907] = { -- Talandra\'s Rose
			[43109] = 0.5, --Icy Pigment
			[39343] = 2.5, --Azure Pigment
		},
		[39970] = { -- Fire Leaf
			[43109] = 0.5, --Icy Pigment
			[39343] = 2.5, --Azure Pigment
		},
		[37921] = { -- Deadnettle
			[43109] = 0.5, --Icy Pigment
			[39343] = 3, --Azure Pigment
		},
		[36904] = { -- Tiger Lily
			[43109] = 0.5, --Icy Pigment
			[39343] = 3, --Azure Pigment
		},
		[36905] = { -- Lichbloom
			[43109] = 1, --Icy Pigment
			[39343] = 3, --Azure Pigment
		},
		[36906] = { -- Icethorn
			[43109] = 1, --Icy Pigment
			[39343] = 3, --Azure Pigment
		},
		[36903] = { -- Adder\'s Tongue
			[43109] = 1.25, --Icy Pigment
			[39343] = 3, --Azure Pigment
		},



		[22789] = { -- Terocone
			[39342] = 2.5, --Nether Pigment
			[43108] = 0.5, --Ebon Pigment
		},
		[22786] = { -- Dreaming Glory
			[39342] = 2.5, --Nether Pigment
			[43108] = 0.5, --Ebon Pigment
		},
		[22787] = { -- Ragveil
			[39342] = 2.5, --Nether Pigment
			[43108] = 0.5, --Ebon Pigment
		},
		[22785] = { -- Felweed
			[39342] = 3, --Nether Pigment
			[43108] = 0.5, --Ebon Pigment
		},
		[22790] = { -- Ancient Lichen
			[39342] = 3, --Nether Pigment
			[43108] = 1, --Ebon Pigment
		},
		[22792] = { -- Nightmare Vine
			[39342] = 3, --Nether Pigment
			[43108] = 1, --Ebon Pigment
		},
		[22793] = { -- Mana Thistle
			[39342] = 3, --Nether Pigment
			[43108] = 1, --Ebon Pigment
		},
		[22791] = { -- Netherbloom
			[39342] = 3, --Nether Pigment
			[43108] = 1, --Ebon Pigment
		},



		[3355] = { -- Wild Steelbloom
			[43104] = 0.5, --Burnt Pigment
			[39338] = 2.5, --Golden Pigment
		},
		[3369] = { -- Grave Moss
			[43104] = 0.5, --Burnt Pigment
			[39338] = 2.5, --Golden Pigment
		},
		[3357] = { -- Liferoot
			[43104] = 1, --Burnt Pigment
			[39338] = 3, --Golden Pigment
		},

		[3356] = { -- Kingsblood
			[43104] = 1, --Burnt Pigment
			[39338] = 3, --Golden Pigment
		},
	}

	local millBrackets =
	{
		[2449] = 1,
		[2447] = 1,
		[765] = 1,

		[2450] = 25,
		[2453] = 25,
		[785] = 25,
		[3820] = 25,
		[2452] = 25,

		[3369] = 75,
		[3356] = 75,
		[3357] = 75,
		[3355] = 75,

		[3818] = 125,
		[3821] = 125,
		[3358] = 125,
		[3819] = 125,

		[8836] = 175,
		[8839] = 175,
		[4625] = 175,
		[8845] = 175,
		[8846] = 175,
		[8831] = 175,
		[8838] = 175,

		[13463] = 225,
		[13464] = 225,
		[13467] = 225,
		[13465] = 225,
		[13466] = 225,

		[22790] = 275,
		[22786] = 275,
		[22785] = 275,
		[22793] = 275,
		[22791] = 275,
		[22792] = 275,
		[22787] = 275,
		[22789] = 275,

		[36903] = 325,
		[37921] = 325,
		[39970] = 325,
		[36901] = 325,
		[36906] = 325,
		[36905] = 325,
		[36907] = 325,
		[36904] = 325,
	}


	local millingLevels = { 1,25,75,125,175,225,275,325 }


	local pigmentSources = {}

	local millingReagents = {}

	local millingNames = {}


	local skillList = {}

	local api = {}



	-- spoof recipes for milled herbs -> pigments
	GnomeWorks:RegisterMessageDispatch("AddSpoofedRecipes", function ()
		local trade,recipeList  = GnomeWorks:AddPseudoTrade(51005, api)
		local millGroup = 1

		for k,bracket in pairs(millingLevels) do
			skillList[#skillList + 1] = "Milling Group "..millGroup

			millGroup = millGroup +1

			for herbID, pigmentTable in pairs(millingResults) do
				if millBrackets[herbID] == bracket then
					skillList[#skillList + 1] = -herbID

					recipeList[-herbID] = trade

					millingReagents[-herbID] = { [herbID] = 5 }
					millingNames[-herbID] = string.format("Mill %s",GetItemInfo(herbID) or "item:"..herbID)

					GnomeWorks:AddToReagentCache(herbID, -herbID, 5)

					for pigmentID, numMade in pairs(pigmentTable) do
						GnomeWorks:AddToItemCache(pigmentID, -herbID, numMade)
					end
				end
			end
		end

		trade.skillList = skillList

		return true
	end)



	api.DoTradeSkill = function(recipeID)
		CastSpellByName("/use "..GetSpellInfo(-recipeID))
	end

	api.GetRecipeName = function(recipeID)
		if type(recipeID) == "string" then
			return recipeID
		end

		if millingNames[recipeID] then
			return millingNames[recipeID]
		end
	end

	api.GetRecipeData = function(recipeID)
		if millingResults[-recipeID] then
			return millingResults[-recipeID], millingReagents[recipeID], 51005
		end
	end



	api.GetNumTradeSkills = function()
		return #skillList
	end


	api.GetTradeSkillItemLink = function(index)
		local recipeID = skillList[index]

		if type(recipeID) == "string" then
			return
		end

		local itemID = next(millingResults[-recipeID])

		local _,link = GetItemInfo(itemID)

		return link
	end


	api.GetTradeSkillRecipeLink = function(index)
		local recipeID = skillList[index]

		if type(recipeID) == "string" then
			return
		end

		if recipeID < 0 then
			return "enchant:"..recipeID
		else
			return GetSpellLink(recipeID)
		end
	end


	api.GetTradeSkillLine = function()
		return (GetSpellInfo(51005)), 1, 1
	end


	api.GetTradeSkillInfo = function(index)
		local recipeID = skillList[index]

		if type(recipeID) == "string" then
			return recipeID, "header"
		end

		return millingNames[-recipeID], "optimal"
	end


	api.GetTradeSkillIcon = function(index)
		local recipeID = skillList[index]

		if type(recipeID) == "string" then
			return
		end

		local itemID = next(millingResults[-recipeID])

		return GetItemIcon(itemID)
	end


	api.IsTradeSkillLinked = function()
		return true
	end




	api.ConfigureMacroText = function(recipeID)
		return "/use "..GetItemInfo(next(commonRecipes[recipeID].reagents))

	end


	api.Scan = function()
		if not GnomeWorks.tradeID then
			return
		end

		local tradeID = GnomeWorks.tradeID
		local player = GnomeWorks.player

		local key = player..":"..tradeID

		local lastHeader = nil
		local gotNil = false

		local currentGroup = nil

		local mainGroup = GnomeWorks:RecipeGroupNew(player,tradeID,"By Bracket")

		local flatGroup = GnomeWorks:RecipeGroupNew(player,tradeID,"Flat")

		flatGroup.locked = true
		flatGroup.autoGroup = true

		GnomeWorks:RecipeGroupClearEntries(flatGroup)

		local groupList = {}

		local numHeaders = 0

		for i = 1, #skillList, 1 do
			local subSpell, extra

			if type(skillList[i]) == "string" then
				local groupName = skillList[i]

				numHeaders = numHeaders + 1

				currentGroup = GnomeWorks:RecipeGroupNew(player, tradeID, "By Bracket", groupName)
				currentGroup.autoGroup = true

				GnomeWorks:RecipeGroupAddSubGroup(mainGroup, currentGroup, i, true)
			else
				local recipeID = skillList[i]

				GnomeWorks:RecipeGroupAddRecipe(flatGroup, recipeID, i, true)

				if currentGroup then
					GnomeWorks:RecipeGroupAddRecipe(currentGroup, recipeID, i, true)
				else
					GnomeWorks:RecipeGroupAddRecipe(mainGroup, recipeID, i, true)
				end

--				difficulty[i] = "optimal"


--				skillIndexLookup[recipeID] = i
			end
		end

		GnomeWorks:InventoryScan()

		collectgarbage("collect")

		GnomeWorks:ScheduleTimer("UpdateMainWindow",.1)
		GnomeWorks:SendMessageDispatch("GnomeWorksScanComplete")
		return
	end

end





