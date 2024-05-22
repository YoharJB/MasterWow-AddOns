local aname = ...
-- Global Vars

VERSION = "BC2.0.7";
AddonNamePlain = "%s" .. aname .. "%s %sMasterWow%s";
AddonName = string.format(AddonNamePlain, "|cffff00ff", "|r", "|cffff0000", "|r");

-- Binding Vars
BINDING_HEADER_ED = string.format(AddonNamePlain, "", "", "", "");
BINDING_NAME_OPTIONS = "Easy Destroy Options Frame";
BINDING_NAME_TOGGLE = "Enable or Disable " .. aname;
BINDING_NAME_NOTIFY = "Enable or Disable Notifications";
BINDING_NAME_CURSOR = "Destroy what you just picked up";
BINDING_NAME_EDCONVERT = "Manually convert the old safe list";
BINDING_NAME_EDSAFELIST = "Show the safe list in the chat window";

QUALITY_FLOOR = 2;

-- For items of quality >= QUALITY_FLOOR (Green, Blue, Purple) we want to confirm that they
-- want to delete the item.	They can repeat the procedure to delete it.
LAST_ITEM_BAG = nil;
LAST_ITEM_SLOT = nil;
LAST_ITEM_LINK = nil;
LAST_CONFIRM = 0;

EasyDestroy_Options = {
    Notify = false,
    On = true,
    Converted = false,
    KeyBoardShortcuts = true
};

EasyDestroy_Safe = {
    ["Hearthstone"] = true
};
local aName, aVer = AddonName, VERSION;

-- Function used for debugging, the debugger can adjust the quality level to make sure
-- the script checks the rarity before destroying it. You must pick up an item first.
-- The up arrow increases by 1
-- The down arrow decreases by 1
-- The asterisk makes it equal to the curser item's quality
function EasyDestroy_ChangeQualityFloor(key)
    if key == 'UP' then
        QUALITY_FLOOR = QUALITY_FLOOR + 1;
    elseif key == 'DOWN' then
        QUALITY_FLOOR = QUALITY_FLOOR - 1;
    elseif key == 'NUMPADMULTIPLY' then
        local _, _, itemLink = GetCursorInfo();
        local _, _, quality = GetItemInfo(itemLink);
        QUALITY_FLOOR = quality;
    end
    -- The highest is 7 and the lowest is 0.
    if QUALITY_FLOOR > 7 then
        QUALITY_FLOOR = 7;
    end
    if QUALITY_FLOOR < 0 then
        QUALITY_FLOOR = 0;
    end
    Print("|cffffffff[" .. AddonName .. "] QUALITY_FLOOR changed to " .. QUALITY_FLOOR .. ".|r");
end

-- OnLoad functions, set up Print, logon spam (:p), hooking and register events
function EasyDestroy_OnLoad(self)
    -- Make sure we have non-nil options
    if EasyDestroy_Options.Notify == nil then
        EasyDestroy_Options.Notify = false;
    end

    if EasyDestroy_Options.On == nil then
        EasyDestroy_Options.On = true;
    end

    if EasyDestroy_Options.Converted == nil then
        EasyDestroy_Options.Converted = false;
    end

    if EasyDestroy_Options.KeyBoardShortcuts == nil then
        EasyDestroy_Options.KeyBoardShortcuts = true;
    end
    --

    UIErrorsFrame:AddMessage(aName .. " version " .. aVer .. " loaded.");
    if (not Print) then
        Print = function(x, ...)
            local r, g, b = ...;
            if (not r) then
                r = 1.0;
            end
            if (not g) then
                g = 1.0;
            end
            if (not b) then
                b = 1.0;
            end
            DEFAULT_CHAT_FRAME:AddMessage(x, r, g, b);
        end
    end

    Print("|cffffffff[" .. AddonName .. "] v" .. VERSION .. " loaded.|r");

    UIPanelWindows[aname .. "Options"] = {
        area = "center",
        pushable = 0
    };

    -- Events
    self:RegisterEvent("VARIABLES_LOADED");

    -- Slash Command Handler (added by Whizzbang)
    SlashCmdList["EASYD"] = EasyDestroy_Cmd;
    SLASH_LOST_CHAT1 = "/easydestory";
    SLASH_EASYD1 = "/ed";
end

-- OnEvent functions, mainly to add myAddOns support
function EasyDestroy_OnEvent(event)
    if (event == "VARIABLES_LOADED") then
        -- myAddOns support
        EasyDestroyOptions.name = EasyDestroyOptions:GetName()
        InterfaceOptions_AddCategory(EasyDestroyOptions)
        EasyDestroyOptions:SetScript("OnHide", function(self)
            self:SetParent(UIParent)
        end)
        if (myAddOnsFrame) then
            myAddOnsList.EasyDestroy = {
                name = aname .. "Safe",
                releaseDate = "October 20, 2005",
                author = "tsigo, Wilz, Whizzbang",
                description = "Quickly and easily destroy items.",
                version = VERSION,
                category = MYADDONS_CATEGORY_INVENTORY,
                optionsframe = aname .. "Options"
            };
        end
        if (not EasyDestroy_Options["Converted"]) then
            -- Normalize an old Database.
            local temp = {};
            for k, v in pairs(EasyDestroy_Safe) do
                local _, _, itemName = strfind(k, "h%[(.*)%]%|h");
                if (EasyDestroy_Debug) then
                    Print("|cffffffff[" .. AddonName .. "]" .. " Checking " .. k .. ".|r");
                end
                if (itemName ~= nil) then
                    EasyDestroy_Safe[k] = nil;
                    temp[itemName] = true;
                else
                    temp[k] = true;
                end
            end
            if (temp) then
                EasyDestroy_Safe = temp;
            end
            EasyDestroy_Options["Converted"] = true;
        end
    end
end

function EasyDestroy_GetCmd(msg)
    if msg then
        local a, b, c = strfind(msg, "(%S+)"); -- contiguous string of non-space characters
        if a then
            return c, strsub(msg, b + 2);
        else
            return "";
        end
    end
end

-- Slash Command Handler (added by Whizzbang)
function EasyDestroy_Cmd(msg)
    if (msg) then
        local cmd, sub = EasyDestroy_GetCmd(msg);

        if (cmd ~= nil) then
            cmd = cmd:lower();
        end

        if (cmd == "notify") then
            if (EasyDestroy_Options.Notify) then
                EasyDestroy_Options.Notify = false;
                Print("|cffffffff[" .. AddonName .. "]" .. " Destroy notifcation |cffff0000disabled|r.|r");
            else
                EasyDestroy_Options.Notify = true;
                Print("|cffffffff[" .. AddonName .. "]" .. " Destroy notifcation |cff00ff00enabled|r.|r");
            end
        elseif (cmd == 'debug') then
            EasyDestroy_Debug = (not EasyDestroy_Debug);
            local temporarily, mode;
            if (EasyDestroy_Debug) then
                temporarily, mode = " (temporarily)", "On\nDebug mode will turn off on reload or relog.";
            else
                temporarily, mode = "", "Off";
            end
            Print("|cffffffff[" .. AddonName .. "] Debug mode" .. temporarily .. ": " .. mode .. "|r");
        elseif (cmd == "showoptions") then
            EasyDestroyOptions:Show();
        elseif (cmd == "toggle") then
            if (EasyDestroy_Options.On) then
                EasyDestroy_Options.On = false;
                Print("|cffffffff[" .. AddonName .. "] |cffff0000disabled|r.|r");
            else
                EasyDestroy_Options.On = true;
                Print("|cffffffff[" .. AddonName .. "] |cff00ff00enabled|r.|r");
            end
        elseif (cmd == "showsafe") then
            EasyDestroy_SafeList_Show();
        elseif (cmd == 'keyboard') then
            EasyDestroy_Options.KeyBoardShortcuts = (not EasyDestroy_Options.KeyBoardShortcuts);
            Print("|cffffffff[" .. AddonName .. "] |cff00ff00Keyboard Shortcuts: " ..
                      tostring(EasyDestroy_Options.KeyBoardShortcuts) .. "|r.|r");
        elseif cmd == "options" then
            EasyDestroyOptions_Toggle()
        elseif (sub) then
            EasyDestroy_AddRemove(sub, cmd);
        else
            Print("|cffffffff[" .. AddonName .. "]" .. " Usage:|r");
            Print("|cffffffff" .. SLASH_EASYD1 .. ": Shortcut slash.|r");
            Print("|cffffffff" .. SLASH_LOST_CHAT1 ..
                      " notify: |cff00ff00Enabled|r or |cffff0000Disabled|r notifications.|r");
            Print("|cffffffff" .. SLASH_LOST_CHAT1 .. " showoptions: Open the options menu.|r");
            Print("|cffffffff" .. SLASH_LOST_CHAT1 .. " toggle: |cff00ff00Enabled|r or |cffff0000Disabled|r " ..
                      AddonName .. ".|r");
            Print("|cffffffff" .. SLASH_LOST_CHAT1 .. " showsafe: Print safe list.|r");
            Print("|cffffffff" .. SLASH_LOST_CHAT1 ..
                      " add [item link]: Add an item to the safe list (use Shift-Click or type the item's name).|r");
            Print("|cffffffff" .. SLASH_LOST_CHAT1 ..
                      " remove [item link]: Remove an item from the safe list (use Shift-Click or type the item's name).|r");
            Print("|cffffffff" .. SLASH_LOST_CHAT1 .. " keyboard: Toggle Keyboard Shortcuts on/off.|r");
            Print("|cffffffff" .. SLASH_LOST_CHAT1 .. " options: Show the options frame.|r");
            Print("|cffffffffKeyboard Shortcuts (pick up an item and the do the shortcut)|r");
            Print("|cffffffff[DELETE] Delete the item in hand.|r");
            Print("|cffffffff[CTRL-S] Add the item to the safe list.|r");
            Print("|cffffffff[CTRL-R] Remove the item from the safe list.|r");
        end
    end
end

function EasyDestroy_SafeList_Show()
    local output = "";
    local count = 0;
    for k, v in pairs(EasyDestroy_Safe) do
        if (output == "") then
            output = k;
        else
            output = output .. "\n" .. k;
        end
        count = count + 1;
    end
    Print("|cffffffff[" .. AddonName .. "] Safe List (" .. count .. "):|r");
    if (count == 0) then
        Print('There are no items in safe list.');
    else
        Print(output);
    end
end

function EasyDestroy_AddRemove(sub, cmd)
    if (sub == nil) then
        return false;
    end

    local itemName, tempsub = GetItemInfo(sub);
    if (not itemName) then
        Print("|cffffffff[" .. AddonName .. "] Could not find " .. sub .. "|r");
    else
        if (cmd == 'add') then
            if (EasyDestroy_Safe[itemName]) then
                Print("|cffffffff[" .. AddonName .. "] " .. tempsub .. " is already on your safe list.|r");
            else
                EasyDestroy_Safe[itemName] = true;
                Print("|cffffffff[" .. AddonName .. "] " .. tempsub .. " added to safe list.|r");
            end
        elseif (cmd == 'remove') then
            if (EasyDestroy_Safe[itemName]) then
                EasyDestroy_Safe[itemName] = nil;

                Print("|cffffffff[" .. AddonName .. "] " .. tempsub .. " removed safe list.|r");
            else
                Print("|cffffffff[" .. AddonName .. "] " .. tempsub .. " is not in safe list.|r");
            end
        end
    end
end

local Old_ContainerFrameItemButton_OnModifiedClick = ContainerFrameItemButton_OnModifiedClick;
function ContainerFrameItemButton_OnModifiedClick(self, button)
    if (button == "RightButton" and EasyDestroy_Options.On and IsAltKeyDown() and IsShiftKeyDown() and
        not IsControlKeyDown()) then
        EasyDestroy_DestroyItem(self:GetParent():GetID(), self:GetID());
    else
        Old_ContainerFrameItemButton_OnModifiedClick(self, button);
    end
end

function EasyDestroy_Do_Item_Check(itemLink, qualityText, ...)
    local bag, slot = ...;
    if (not bag) then
        bag = -1;
    end
    if (not slot) then
        slot = -1;
    end

    -- If the item's quality is >= 2 (Green or better), then we want to make sure they *really* want to delete this.
    -- This is accomplished through making them do the procedure a second time within 5 seconds.

    Print("|cffffffff[" .. AddonName .. "] " .. itemLink .. " is " .. qualityText ..
              "!	Repeat the procedure to destroy it.|r");

    LAST_ITEM_LINK = itemLink;
    LAST_ITEM_BAG = bag;
    LAST_ITEM_SLOT = slot;
    LAST_CONFIRM = GetTime();
end

-- Delete item in hand
function EasyDestroy_DeleteCursorItem()
    if (EasyDestroy_Debug) then
        if (CursorHasItem()) then
            local type, _, itemLink = GetCursorInfo();
            local itemName, _, quality = GetItemInfo(itemLink);
            Print("|cffffffff[" .. AddonName .. "] EasyDestroy_DeleteCursorItem called with: type=\"" .. type ..
                      "\" itemLink=" .. itemLink .. " quality=\"" .. quality .. "\".|r");
        else
            Print("|cffffffff[" .. AddonName .. "] EasyDestroy_DeleteCursorItem called with no item.|r");
        end
    end
    if (CursorHasItem()) then
        local type, _, itemLink = GetCursorInfo();
        local itemName, _, quality, _, _, itemType = GetItemInfo(itemLink);
        local qualityText = EasyDestroy_GetQualityText(quality);
        if (type ~= "item") then
            return false;
        else
            if (EasyDestroy_Safe[itemName]) then
                Print("|cffffffff[" .. AddonName .. "] " .. itemLink ..
                          " is on your safe list! If you really want to destroy it, use Blizzard's default method or remove it from your safe list first.|r");
            else
                if ((itemType == "Quest" or quality >= QUALITY_FLOOR) and
                    ((itemLink ~= LAST_ITEM_LINK) or (-1 ~= LAST_ITEM_BAG) or (-1 ~= LAST_ITEM_SLOT) or
                        (GetTime() - LAST_CONFIRM > 5))) then
                    if itemType == "Quest" then
                        qualityText = "Quest Item";
                    end
                    EasyDestroy_Do_Item_Check(itemLink, qualityText);
                else
                    -- Prevents me from deleting something important during testing.
                    if (not EasyDestroy_Debug) then
                        DeleteCursorItem();
                    else
                        Print("[" .. AddonName .. "] DEBUG : ITEM WOULD'VE BEEN DELETED!!!");
                    end

                    -- It's really gone now.	Really.	No getting it back.
                    LAST_ITEM_LINK = nil;
                    LAST_ITEM_BAG = nil;
                    LAST_ITEM_SLOT = nil;
                    LAST_CONFIRM = 0;

                    if (EasyDestroy_Options.Notify) then
                        Print("|cffffffff[" .. AddonName .. "] |cff0000ffDestroyed|r - " .. itemLink .. ".|r");
                    end
                end
            end
        end
    end
end

-- Generic function to allow either hooked function to destroy an item at <bag>,<slot>. 
function EasyDestroy_DestroyItem(bag, slot)
    if (EasyDestroy_Options.On and IsAltKeyDown() and IsShiftKeyDown()) then
        local _, itemCount, _, _ = GetContainerItemInfo(bag, slot);
        local itemLink = GetContainerItemLink(bag, slot);

        -- Normalize the itemName.
        local itemName, _, quality = GetItemInfo(itemLink);
        local qualityText = EasyDestroy_GetQualityText(quality);

        if (EasyDestroy_Safe[itemName]) then
            Print("|cffffffff[" .. AddonName .. "] " .. itemLink ..
                      " is on your safe list! If you really want to destroy it, use the default method or remove it from your safe list first.|r");
        else
            if (quality >= 2 and
                ((itemLink ~= LAST_ITEM_LINK) or (bag ~= LAST_ITEM_BAG) or (slot ~= LAST_ITEM_SLOT) or
                    (GetTime() - LAST_CONFIRM > 5))) then
                EasyDestroy_Do_Item_Check(itemLink, qualityText, bag, slot);
            else
                -- Either they've confirmed the deletion by clicking twice and we're seeing the same item,
                -- or the item's White or less and we don't care if it gets destroyed.
                if (bag ~= -1 and slot ~= -1) then
                    PickupContainerItem(bag, slot);
                end

                if (CursorHasItem()) then
                    -- Prevents me from deleting something important during testing.
                    if (not EasyDestroy_Debug) then
                        DeleteCursorItem();
                    else
                        Print("DEBUG : ITEM WOULD'VE BEEN DELETED!!!");
                    end

                    -- It's really gone now.	Really.	No getting it back.
                    LAST_ITEM_LINK = nil;
                    LAST_ITEM_BAG = nil;
                    LAST_ITEM_SLOT = nil;
                    LAST_CONFIRM = 0;

                    if (EasyDestroy_Options.Notify) then
                        Print("|cffffffff[" .. AddonName .. "] |cff0000ffDestroyed|r - " ..
                                  ((itemCount > 1) and itemCount .. "x " or "") .. itemLink .. ".|r");
                    end
                end
            end
        end
    end
end

function EasyDestroyOptions_Toggle()
    if (EasyDestroyOptions:IsVisible()) then
        EasyDestroyOptions:Hide();
    else
        EasyDestroyOptions:Show();
    end
end

function EasyDestroyOptions_Show()
    local str = getglobal("EasyDestroyOptionsFrame_CheckButton1Text");
    str:SetText("Enable EasyDestroy");
    local button = getglobal("EasyDestroyOptionsFrame_CheckButton1");
    if (EasyDestroy_Options.On) then
        checked = 1;
    else
        checked = 0;
    end
    button:SetChecked(checked);

    str = getglobal("EasyDestroyOptionsFrame_CheckButton2Text");
    str:SetText("Announce Destroy");
    button = getglobal("EasyDestroyOptionsFrame_CheckButton2");
    if (EasyDestroy_Options.Notify) then
        checked = 1;
    else
        checked = 0;
    end
    button:SetChecked(checked);

    str = getglobal("EasyDestroyOptionsFrame_CheckButton3Text");
    str:SetText("Keyboard Shortcuts");
    button = getglobal("EasyDestroyOptionsFrame_CheckButton3");
    if (EasyDestroy_Options.KeyBoardShortcuts) then
        checked = 1;
    else
        checked = 0;
    end
    button:SetChecked(checked);
end

function EasyDestroyOptions_Hide(self)
    if self:GetParent():GetParent() == UIParent then
        self:GetParent():Hide();
    end
end

function EasyDestroyOptions_Defaults()
    EasyDestroy_Options.On = true;
    EasyDestroy_Options.Notify = true;
end

local function clicky(self)
    if (self:GetChecked()) then
        PlaySound("igMainMenuOptionCheckBoxOff");
    else
        PlaySound("igMainMenuOptionCheckBoxOn");
    end
end

function EasyDestroyOptionsFrame_CheckButton1_OnClick(self)
    clicky(self)
    if (EasyDestroy_Options.On == true) then
        EasyDestroy_Options.On = false;
    else
        EasyDestroy_Options.On = true;
    end
end

function EasyDestroyOptionsFrame_CheckButton2_OnClick(self)
    clicky(self)
    if (EasyDestroy_Options.Notify == true) then
        EasyDestroy_Options.Notify = false;
    else
        EasyDestroy_Options.Notify = true;
    end
end

function EasyDestroyOptionsFrame_CheckButton3_OnClick(self)
    clicky(self)
    if (EasyDestroy_Options.KeyBoardShortcuts == true) then
        EasyDestroy_Options.KeyBoardShortcuts = false;
    else
        EasyDestroy_Options.KeyBoardShortcuts = true;
    end
end

function EasyDestroy_OptionsCheckButtonOnClick(self)
    _G[self:GetName() .. "_OnClick"](self)
end

-- Function to change quality integers into text for display in warning
function EasyDestroy_GetQualityText(quality)
    if (quality == 0) then
        return "Junk";
    elseif (quality == 1) then
        return "Common";
    elseif (quality == 2) then
        return "Uncommon";
    elseif (quality == 3) then
        return "Rare";
    elseif (quality == 4) then
        return "Epic";
    elseif (quality == 5) then
        return "Legendary";
    elseif (quality == 6) then
        return "Artifact";
    else
        return "Unknown";
    end
end
