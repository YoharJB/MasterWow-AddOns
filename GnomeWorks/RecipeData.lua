





do

-- courtesy of nandini

	local cooldownGroups = {
	Alchemy = {
	  ["Transmute"] = {
	   duration = 72000 , -- 20 hours, in seconds
	   spells = {
		11479 , -- Transmute: Iron to Gold
		11480 , -- Transmute: Mithril to Truesilver
		60350 , -- Transmute: Titanium

		17559 , -- Transmute: Air to Fire
		17560 , -- Transmute: Fire to Earth
		17561 , -- Transmute: Earth to Water
		17562 , -- Transmute: Water to Air
		17563 , -- Transmute: Undeath to Water
		17565 , -- Transmute: Life to Earth
		17566 , -- Transmute: Earth to Life

		28585 , -- Transmute: Primal Earth to Life
		28566 , -- Transmute: Primal Air to Fire
		28567 , -- Transmute: Primal Earth to Water
		28568 , -- Transmute: Primal Fire to Earth
		28569 , -- Transmute: Primal Water to Air
		28580 , -- Transmute: Primal Shadow to Water
		28581 , -- Transmute: Primal Water to Shadow
		28582 , -- Transmute: Primal Mana to Fire
		28583 , -- Transmute: Primal Fire to Mana
		28584 , -- Transmute: Primal Life to Earth
		53771 , -- Transmute: Eternal Life to Shadow
		53773 , -- Transmute: Eternal Life to Fire
		53774 , -- Transmute: Eternal Fire to Water
		53775 , -- Transmute: Eternal Fire to Life
		53776 , -- Transmute: Eternal Air to Water
		53777 , -- Transmute: Eternal Air to Earth
		53779 , -- Transmute: Eternal Shadow to Earth
		53780 , -- Transmute: Eternal Shadow to Life
		53781 , -- Transmute: Eternal Earth to Air
		53782 , -- Transmute: Eternal Earth to Shadow
		53783 , -- Transmute: Eternal Water to Air
		53784 , -- Transmute: Eternal Water to Fire

		66658 , -- Transmute: Ametrine
		66659 , -- Transmute: Cardinal Ruby
		66660 , -- Transmute: King's Amber
		66662 , -- Transmute: Dreadstone
		66663 , -- Transmute: Majestic Zircon
		66664 , -- Transmute: Eye of Zul
	   } ,
	  } ,
	 } ,
	 Mining = {
	  ["Titansteel"] = {
	   duration = 72000 , -- 20 hours, in seconds
	   spells = {
		52208 , -- Smelt Titansteel
	   } ,
	  } ,
	 } ,
	 Inscription = {
	  ["Minor research"]  = {
	   duration = 72000 , -- 20 hours, in seconds
	   spells = {
		61288 , -- Minor Inscription Research
	   } ,
	  } ,
	  ["Northrend research"] = {
	   duration = 72000 , -- 20 hours, in seconds
	   spells = {
		61177 , -- Northrend Inscription Research
	   } ,
	  } ,
	 } ,
	 Enchanting = {
	  ["Void Sphere"] = {
	   duration = 172800 , -- 48 hours, in seconds
	   spells = {
		28028 , -- Void Sphere
	   } ,
	  } ,
	 } ,
	}

	local spellCooldown = {}

	for tradeSkill, cooldownGroup in pairs(cooldownGroups) do
		for groupName, data in pairs(cooldownGroup) do
			for i=1,#data.spells do
				spellCooldown[ data.spells[i] ] = cooldownGroup
			end
		end
	end

	function GnomeWorks:GetSpellCooldownGroup(recipeID)
		return spellCooldown[recipeID]
	end



-- pseudo trade info
	local tradeName = {
		[100000] = "Common",
		[100001] = "Vendor",
	}

	local tradeLink = {
		[100000] = "[Common]",
		[100001] = "[Vendor]",
	}

	local tradeIcon = {
		[100000] = "Interface\\Icons\\Ability_Creature_Cursed_01",
		[100001] = "Interface\\Icons\\INV_Misc_Bag_10",
	}



--[[
-- specialization info
	local specializations = {
		[26798] = {				-- mooncloth tailor
			[26751] = {
				[21845] = 2
			},
			[56001] = {
				[41594] = 2
			}
		},
		[26801] = {				-- shadowweave
			[36686] = {
				[24272] = 2
			},
			[56002] = {
				[41593] = 2
			},
		[26797] = {				-- spellfire
			[31373] = {
				[24271] = 2
			},
			[56003] = {
				[41595] = 2
			}
		}
	}
]]



	local specializations = {
-- mooncloth
		[26751] = {
			specID = 26798,
			results = {
				[21845] = 2
			},
		},
		[56001] = {
			specID = 26798,
			results = {
				[41594] = 2
			},
		},
-- shadowweave
		[36686] = {
			specID = 26801,
			results = {
				[24272] = 2
			},
		},
		[56002] = {
			specID = 26801,
			results = {
				[41593] = 2
			},
		},
-- spellfire
		[31373] = {
			specID = 26797,
			results = {
				[24271] = 2
			},
		},
		[56003] = {
			specID = 26797,
			results = {
				[41595] = 2
			}
		}
	}


	function GnomeWorks:GetRecipeName(recipeID)
		if recipeID then
			local pseudoTrade = self.data.pseudoTradeRecipes[recipeID]
			if pseudoTrade then
				return pseudoTrade.GetRecipeName(recipeID)
			end

			return GnomeWorksDB.names[recipeID] or (GetSpellInfo(recipeID))
		end
	end

	function GnomeWorks:GetTradeName(tradeID)
		if not tradeID then return "unknown" end
		return tradeName[tradeID] or (GetSpellInfo(tradeID))
	end

	--[[
	function GnomeWorks:GetTradeInfo(recipeID)
		local pseudoTrade = self.data.pseudoTradeRecipes[recipeID]
print("getTradeInfo", recipeID)
		if pseudoTrade then
			local tradeID = pseudoTrade.tradeID

			if tradeName[tradeID] then
				return tradeName[tradeID], tradeLink[tradeID], tradeIcon[tradeID]
			else
				return GetSpellInfo(tradeID)
			end
		else
			local tradeID = GnomeWorksDB.tradeIDs[recipeID]

			if tradeName[tradeID] then
				return tradeName[tradeID], tradeLink[tradeID], tradeIcon[tradeID]
			else
				return GetSpellInfo(tradeID)
			end
		end
	end
]]
	function GnomeWorks:GetTradeInfo(tradeID)
		if tradeName[tradeID] then
			return tradeName[tradeID], tradeLink[tradeID], tradeIcon[tradeID]
		else
			return GetSpellInfo(tradeID)
		end
	end


	function GnomeWorks:GetRecipeTradeID(recipeID)
		local pseudoTrade = self.data.pseudoTradeRecipes[recipeID]
		if pseudoTrade then
			return pseudoTrade.tradeID
		end

		return GnomeWorksDB.tradeIDs[recipeID]
	end

	function GnomeWorks:GetRecipeData(recipeID, player)
		local pseudoTrade = self.data.pseudoTradeRecipes[recipeID]
		if pseudoTrade then
			return pseudoTrade.GetRecipeData(recipeID)
		end

		player = player or self.player or (UnitName("player"))

		local spec = specializations[recipeID]
		if spec then
			local playerSpec = self.data.playerData[player].specializations

			if playerSpec and playerSpec[spec.specID] then
				return spec.results, GnomeWorksDB.reagents[recipeID], GnomeWorksDB.tradeIDs[recipeID]
			end
		end

		return GnomeWorksDB.results[recipeID], GnomeWorksDB.reagents[recipeID], GnomeWorksDB.tradeIDs[recipeID]
	end
end




