# roblox-video-inclusion
roblox video inclusion , with roblox asset id

заходим на этот сайт https://create.roblox.com/store/videos

потом выбрали нужное превью ( например с водопадом )

заходим по нему, и в ссылке видно айди например store/asset/5670869502/ цифры это сам айди

в исходнике луа пишем этот айди по типу такого ["Video 1"] = "rbxassetid://5670869502", ( строка 29 )

заходим в плейс, врубаем луа и проверяем по кнопке 1 

меню удаляется после смерти , убрать или вернуть в строке 4 screenGui.ResetOnSpawn = true ( исчезает ) false = навсегда

короткое видео как ето работает -> https://www.youtube.com/watch?v=lV6fdFcmfcM
