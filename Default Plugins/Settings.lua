--[[
			  ____                      _       _           _       
			 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
			 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
			  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
			 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
			        |___/                                                                                         
                           

			@Description: Synchronized Admin Commands | Settings Module
			@Author: Dominik [VolcanoINC], Hannah [DataSynchronized]
			@Date of Creation: 13th, September, 2016 | Powered by British Tea


					Synchronized Administrative Commands Loader Below
	=========================================================================================
	Authors 				Hannah Jane [DataSynchronized], Dominik [VolcanoINC]
	Description				This module contains settings for SyncAdmin.
	Support					https://github.com/DataSynchronized/SyncAdmin/issues
	
	Terms of Service		https://github.com/DataSynchronized/SyncAdmin/wiki/Terms-of-Service
	Privacy Policy			https://github.com/DataSynchronized/SyncAdmin/wiki/Privacy-Policy
	-----------------------------------------------------------------------------------------
	
	Note
	----
	You CANNOT use this in Studio mode. This is due to Roblox limitations as well as security on our side
	to protect from users gathering the internal workings of SyncAdmin. We hope you understand our concern
	for keeping our product secure :)
	
	Setup Information
	-----------------
	Setting up SyncAdmin can be confusing for first users, so we're here to explain how to do this.
	
	Step 1. Ensure that HttpService is enabled - HttpService is required to contact the SyncAdmin website to store your settings and 
	        other features. In order to enable HttpService, go to your Studio Explorer window and click 'HttpService' and then within
	        your Studio Properties windows, check 'HttpEnabled'.
	
	Step 2. All your settings are edited in-game, so you do not need to use Studio to change your settings. So, to access
	        your settings you must first join your game and run !!settings.
	
			Pro Tip: If you're NOT the game owner, you will first need to add yourself to the BaseAdmins in the Settings ModuleScript
			         located in this loader.
	
	Step 3. Once you've opened the !!settings panel, you can now change your game settings such as command prefix, group permissions
	        moderators, administrators and super administrators.
	
	Got questions? Contact us on our Discord at https://discord.gg/3nzcRkD
	Thank you for using SyncAdmin!
	
	
	*** Pro Tip: Default command prefix is !! ***
--]]
return {
	-- [SettingsToken] This setting allows you to sync all your settings between several games. 
	-- In order to use this feature, you will need to submit a request to our support team.
	SettingsToken 	= ""; -- Example: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
	-- *** Notice: This token should be kept PRIVATE!! Do NOT share this token to other users or they can change your settings!! ***
	
	-- [BetaUser] This setting toggles SyncAdmin BETA build. 
	-- NOTE: If you're using BETA, updates on this build may be unstable
	BetaUser		= false;
	
	-- [UseVersion] This setting allows you to select what version of SyncAdmin you want to load. 
	-- Refer to the website for a list of available versions: https://syncadminrblx.com/?page=previous-versions/
	UseVersion 		= "Latest";
	
	-- [BaseAdmins] This settings allows you to set super administrators which cannot be removed from the in-game settings.
	-- This is often used for game developers who are not directly the place owner but still need permissions. 
	BaseAdmins		= {
	-- Example: { Username = "Username"; UserId = 0000000; },
		{ Username = "Player1"; UserId = -1; },
		{ Username = "SyncAdmin"; UserId = 153072319; }, -- Change these users to the users you want to set.
	}
}