v1.8.5

Atlas, a World of Warcraft instance map browser
Copyright 2005, 2006 Dan Gilbert
Email me at loglow@gmail.com


***ATTENTION: Prior to Tuesday, December 5, 2006 you must enable "Load out of date AddOns" in order to use Atlas.***


關於 Atlas
==========

Atlas 是一款《魔獸世界》用戶界面插件，可使玩家在遊戲內瀏覽一些額外的地圖。輸入“/atlas”或者單擊小地圖旁邊的圖標以打開 Atlas 窗口。透過選項面板，玩家可以關閉小地圖旁邊的圖標，開關自動選擇地圖功能，開關替換世界地圖功能，開關右鍵打開世界地圖功能，改變小地圖圖標的位置，或者設定 Atlas 窗口的透明度。如果自動選擇副本地圖功能開啟，如果你在副本內打開 Atlas，其會自動為你選擇地圖。如果右鍵打開地圖功能開啟，你可以在 Atlas 面板上點擊右鍵打開世界地圖。只需簡單的點擊和拖動就可以移動 Atlas 窗口。利用右上角的鎖圖標可以鎖定 Atlas 窗口的位置。Atlas 提供了所有遊戲中副本的地圖。


如何安裝
========

將此壓縮包解壓縮到︰
...\World of Warcraft\Interface\AddOns\

您的 ZIP 解壓縮軟體必須要能夠保留原始的目錄結構。

如果你有使用上的問題，請造訪以下網址：
http://www.atlasmod.com/phpBB2/viewtopic.php?t=3


支援的插件集
============

- myAddOns
- CTMod
- Cosmos


Atlas 英文官方網站
==================

http://www.atlasmod.com/


已知錯誤
========
自動選擇副本地圖功能無法對如下副本起作用：黑石塔上層、黑石塔下層、厄運之槌

語言
====

- 英語
- 簡體中文 (zhCN)
- 正體中文 (zhTW)
- 法文 (frFR)
- 德文 (deDE)
- 韓文 (koKR)
- 西班牙文 (esES)
- 荷蘭語 (將 Locale\Atlas-NL.lua 文件中的 ATLAS_NL 屬性改為 true)
- 加泰羅尼亞語 (將 Locale\Atlas-CA.lua 文件中的 ATLAS_CA 屬性改為 true)


聯繫
====

如果您有什麼問題、評論或者回饋訊息，請聯繫原作者
- 姓名︰Dan Gilbert
- 電子郵件︰loglow@gmail.com (請用英文)
- AIM︰dan5981

如有中文翻譯的建議，可嘗試在以下網址反應：
http://atlasmod.com/phpBB2/viewforum.php?f=6


Licence
=======

Atlas is released under the GNU General Public License (GPL)
For the full licence text please see gpl-v2.txt

Unofficial translations of the GPL can be found here:
http://www.gnu.org/licenses/translations.html


更新歷史
=======

v1.8.5
- wide release in anticipation of WoW v2 patch
- fixed options frame dragging compatibility
- fixed Spanish (esES) localization file
- Atlas is now released under the GPL

v1.8.5b3
- no more AtlasLoader; no more load-on-demand (goodbye)
- scrapped v1.8.5b2 and reverted to v1.8.5b base
- the "Reset Position" button works again
- all other b2 features should be a-okay
- settings are now saved per-character
- removed some unnecessary myAddOns code (as of b2)
- new default minimap button position (as of b2)
- lots of new metadata in the TOC (as of b2)

v1.8.5b2
- completely localized (arith, Sirlefou, Dynaletik, bornay)
- added AtlasLoader which loads Atlas on first use (whoa!)
- changed minimap button to use crisper built-in art (snazzy!)
- auto-select should be hackishly working again (whoops!)
- frame position is stored differently due to load on demand
- renamed all the localization files (Atlas-xxXX.lua)
- created some folders for organization

v1.8.5b
- 更新 TOC 版本編號到 20000 以支援「燃燒的遠征」 (WoW 2.0)
- 更新一系列的地域火堡壘與盤牙洞穴地圖 (Nifl)
- 副本地圖現在被重新分類到多個分類
- Atlas視窗現在新增可以調整大小尺度
- 新增新的選項以設定 Atlas 小地圖旁按鍵的半徑範圍
- 新增選項以設定限制 Atlas 視窗超出遊戲畫面
- 選項設定視窗現在可被移動
- 以滑動條設定的選項現在會顯示其最大與最小值
- 增進程式在資料片的相容性 (Daviesh)
- 小地圖按鍵現在有新的顏色，以與暴雪的世界地圖按鍵做區別

v1.8.4
- 由於資料片 beta 的 NDA 已經被提升，地域火堡壘的地圖現已被加回來了，詳見：
- http://forums.worldofwarcraft.com/thread.html?topicId=32338600
- 更改西班牙文翻譯為自動選擇
- 注意: ***Atlas 需要完整的西班牙文翻譯!***
- 更新德文翻譯 (Dynaletik)
- 更新韓文翻譯 (k2hyun)

v1.8.3
- 基於暴雪的要求，暫時移除地域火堡壘的相關地圖，詳見以下網址：
- http://forums.worldofwarcraft.com/thread.html?topicId=32338600
- 更新法文翻譯 (Pherus)
- 更新德文翻譯 (Dynaletik)
- 更新簡體中文翻譯 (DiabloHu)
- 更新正體中文翻譯 (arith)
- 更新地域火堡壘地圖的背景 (Nifl)
- 更正 AQ20 的傷害類型，修正為自然傷害 (Pherus)
- 增加 Ony 為奧妮克希亞的巢穴的縮寫 (Pherus)
- 增加奧妮克希亞的巢穴的傷害類型 (Pherus)

v1.8.2
- 新地圖: 地域火堡壘-鮮血熔爐 (Patrick M.)
- 新地圖: 地域火堡壘-碎裂大廳 (Patrick M.)
- 更新簡體中文翻譯與 readme (DiabloHu)
- 更新正體中文翻譯 (arith)
- 更新韓文翻譯 (k2hyun)
- 改進替換世界地圖的功能 (Daphne P.)
- 修正一部份罕見的世界地圖大小的錯誤
- 增加傷害類型到以下的副本 ZG, MC, BWL, AQ20, AQ40, Nax (Pauper)
- 增加僅限德魯伊的飛行路徑

v1.8.1
- 更新 TOC 版本編號至 11200 以支援 1.12 更新
- 修正一系列因 1.12 更新所帶來的世界地圖相關的錯誤
- 修正法文版的翻譯錯誤 (KKram)

v1.8
- 新增新的地圖類別: 團隊會戰
- 新的地圖: 艾索雷葛斯, 翡翠四巨龍, 卡札克
- 新增 "死亡騎士達克雷爾" 到通靈學院的地圖 (Aludian)
- 新增 "赫爾努拉斯" 到厄運之槌(西)的地圖 (Aludian)
- 新增 "大元素師克裡希克" 到黑翼之巢的地圖 (Hegarol)
- 變更在黑石深淵中 "洛考爾" 的位置 (Medion)
- 由於各國本土化訊息的因素, 將 "n/a" 改成 "---"
- 修正黑石深淵的相關資訊, 使所有的資訊都可以正常顯示

v1.7.5
- 更新簡體中文 (zhCN) 本地化文件和讀我檔案 (DiabloHu)
- 更新繁體中文 (zhTW) 本地化文件 (arith, Suzuna)
- 更新法文 (frFR) 本地化文件 (Pherus)
- 更新德文(deDE)本地化文件 (Nihlo, Dynaletik)
- 更新韓文(koKR)本地化文件 (k2hyun)
- 新增本地化翻譯到索引(TOC)檔案
- 移除獨立的西班牙與索引(TOC)檔案

v1.7.4
- 更新 TOC 到11100以適應1.11版本的更新
- 添加新的飛行點和飛行路線
- 更新加泰羅尼亞語地化文件 (Lehn)
- 更新繁體中文(zhCN)本地化文件 (Suzuna)
- 更新簡體中文(zhCN)本地化文件 (DiabloHu)
- 添加簡體中文(zhCN)自述文件 (DiabloHu)
- 修正飛行路線圖的一些錯誤 (arith)
- 修正黑石塔(上層)地圖中的一些錯誤 (Aludian)
- 在祖爾法拉克地圖中加入暗影祭司塞瑟斯 (Aludian)
- 在黑石塔(上層)地圖中加入索拉卡‧火冠 (Hegarol)
- 加入T0.5套裝任務相關首領 (Niflheim)
- 加入 EarthFeatureFrame 作為可選的開發組件 (Ryan S.)

v1.7.3
- 更新簡體中文(zhCN)本地化文件 (Diablohu)
- 更新繁體中文(zhCN)本地化文件 (arith)
- 更新法文(frFR)本地化文件 (Pherus)
- 更新德文(deDE)本地化文件 (Nihlo)
- 更新韓文(koKR)本地化文件 (k2hyun)
- 更新西班牙本地化文件 (festor)
- 添加西班牙文自述文件 (festor)
- 添加西班牙文 TOC 文件 (festor)
- 修正東部地下城分佈圖 (Morfin)
- 修正西部地下城分佈圖 (Morfin)
- 修正西厄運之槌地圖中卡雷迪斯鎮長的位置 (Dynaletik)
- 添加一些新的簡稱 (thegabbert)
- (英文)修正 Kel'Thuzad's 名字的拼寫 (Aludian)

v1.7.2
- 新類別︰地下城分佈圖
- 新地圖︰地下城分佈圖 (東部和西部)
- 更新簡體中文(zhCN)本地化文件 (Diablohu)
- 更新繁體中文(zhCN)本地化文件 (arith)
- 更新德文(deDE)本地化文件 (Nihlo)
- 更新法文(frFR)本地化文件 (Pherus)
- 加寬了重置位置按鈕
- 在安其拉廢墟地圖中講拉賈克斯將軍名字的位置調整到頂端 (Nihlo)
- 修正右鍵打開世界地圖功能的錯誤
- (英文)安其拉廢墟地圖的自動選擇功能現下可用

v1.7.1
- 修正在非英語客戶端中的一處小兒科錯誤

v1.7
- 新地圖︰納克薩瑪斯 (eDark, Cryect)
- 更新許多地圖的品性 (Niflheim)
- 加入加泰羅尼亞語本地化文件，使用方法見上 (Lehn)
- 加入荷蘭語本地化文件，使用方法見上 (JungZandvliet)
- 更新德文(deDE)本地化文件 (Nihlo, anon)
- 更新繁體中文(zhCN)本地化文件 (arith)
- 更新韓文(koKR)本地化文件 (Next96)
- 將 Atlas_GetFixedZoneText 訊息本地化 (DocVanGogh)
- 新的設置︰顯示簡稱
- 更改 Atlas 載入模式 (Grayhoof)
- 更改 Atlas 設置保存模式 (Grayhoof)
- ESC 鍵又可以關閉 Atlas 窗口了
- TitanAtlas、MapAtlas 和 AtlasLoot 將會在不久(重新)出現
- (英文)修正 Battleguard Sartura 名字的拼寫問題 (Iskim, Michael R.)

v1.6.2
- 更新 TOC 到11000以適應1.10版本的更新
- 因為時間原因，移除對 Titan Panel 支持 (TitanAtlas)
- 希望解決了煩人的載入錯誤
- 更新簡體中文(zhCN)本地化文件 (DiabloHu)
- 更新繁體中文(zhCN)本地化文件 (warrenchen, arith)
- 更新法文(frFR)本地化文件 (Pherus)
- 更新德文(deDE)本地化文件 (Nihlo)
- 修正奧特蘭克山谷地圖中的一些 NPC 名稱顏色 (RommelESP)
- 修正奧特蘭克山谷地圖中“空軍部隊長穆維裡克”的位置 (RommelESP)
- 自動選擇副本地圖功能先應該可以正確作用于安其拉 (Gnor)
- 更新人數上限數字以反映1.10版本的更新 (Faithbleed)
- 添加航線: 鐵爐堡 - 聖光之愿禮拜堂
- 添加航線: 石爪峰 - 阿斯特蘭納
- 添加航線: 塔倫迪斯營地 - 永望鎮
- 添加航線: 塞拉莫島 - 塔倫迪斯營地
- 添加航線: 瑟伯切爾 - 塔倫米爾
- (英文)修正安其拉廢墟地圖中 Captain Dreenn 的拼寫問題 (Manias, baloor)
- (英文)修正 Drenn、Qeez、Xurrem 和 Tuubid 的名字 (anon)
- (英文)更正 Stormspike 為 Stormpike (Dazzle)
- (法文)修正 Kraal de Tranchebauge 的文字 (Sparrows)

v1.6.1
- 修正黑翼之巢地圖的一個錯誤 (placebo)
- 修正安其拉神殿地圖中的一處拼寫錯誤 (Foogray)
- 修正安其拉神殿地圖中一些位置錯誤 (anon, Manias)
- 修正安其拉廢墟地圖中的少數位置 (anon, Pater)
- 在安其拉廢墟地圖中添加一部分怪物資料 (anon, Jan S.)
- 在奧特蘭克山谷地圖中加入資料 (RommelESP)
- 在飛行路徑地圖中添加一條摩爾根的崗哨至暴風城的航線 (Harm H.)
- 標記祖爾格拉布地圖中的加茲蘭卡為“可跳過” (placebo)
- 將 Atlas_MapTypes 函數移至本地化文件 (Pherus)
- 更改“飛行點地圖”為“飛行路徑地圖”
- 更新法文(frFR)本地化文件 (Pherus)

v1.6
- 小幅擴大 Atlas 窗口大小
- 添加地圖分類系統
- 添加重置按鈕以便重置窗口位置
- 新地圖︰奧特蘭克山谷 (北) (Niflheim)
- 新地圖︰奧特蘭克山谷 (南) (Niflheim)
- 新地圖︰聯盟飛行路徑圖 (東)
- 新地圖︰聯盟飛行路徑圖 (西)
- 新地圖︰部落飛行路徑圖 (東)
- 新地圖︰部落飛行路徑圖 (西)
- 在安其拉廢墟中加入資料 (Jan S., Pater, Zanchez)
- 修正安其拉廢墟地圖方向 (感謝所有人)
- 將祖爾格拉布地圖中的某些首領標記為可跳過 (Aludian)
- 在祖爾法拉克地圖中加入灰塵怨靈(稀有) (KarWing)
- 移除黑翼之巢地圖中一個不存在的通道 (Ferahgus)
- 更新法文(frFR)本地化文件 (Pherus)
- 更新德文(deDE)本地化文件 (GermanWraith)
- 更新簡體中文(zhCN)本地化文件 (DiabloHu, Slaytanic)
- 更改 Atlas 初始化模式 (Shamino)
- 為 Atlas.lua 添加完全註釋 (以後還會有更多內容)
- 自動選擇副本地圖、替換世界地圖功能現下僅作用于副本內
- 為 TitanAtlas 菜單添加右鍵設置功能

v1.5
- 更正黑翼之巢地圖中的耐法利安為奈法利安
- 更正通靈學院地圖中的煉金試驗室為煉金實驗室
- 更正祖爾格拉布地圖中的高階祭司塞卡為高階祭司塞凱爾
- 新地圖︰戰歌峽谷 (Niflheim)
- 新地圖︰阿拉希盆地 (Niflheim)
- 新地圖︰安其拉廢墟 (Niflheim)
- 添加韓文(koKR)本地化文件 (hicle, Mars)
- 添加西班牙文本地化文件，具體使用方法請查閱自述文件 (festor)
- 更新法文(frFR)本地化文件 (Pherus)
- 更新德文(deDE)本地化文件 (Chinkuwaila, ninjamask)
- 在安其拉神殿中加入資料 (Ragowit, Zanchez)
- 在祖爾法拉克地圖中加入杉達爾‧沙掠者(稀有) (DiabloHu)
- 更改黑石塔(上層)地圖中傑德的位置 (Aludian)
- 為以下副本更新地圖圖片︰黑石深淵、熔火之心、監獄、剃刀沼澤、剃刀高地、黑石塔(上層) (wowguru.com)
- 替換世界地圖功能現下默認是關閉的
- 修正一個使世界地圖無法關閉的錯誤
- 更改判斷玩家是否身處于副本的模式
- 為了壓縮插件體積，所有地圖都由16位替換原來的32位
- 更改祖爾格拉布地圖中混濁的水的標示，由(B)更改為(1')
- 在所有地圖左下角添加 Atlas 水印
- 添加點擊右鍵打開世界地圖功能 (tyroney)
- 在壓縮包中添加 Interface/Addons 目錄定向

v1.4.1
- 更新德文(deDE)本地化文件 (EarMaster)
- 修正一個存在于非英語版本的崩潰錯誤

v1.4
- 新功能︰替換世界地圖
- 新地圖︰安其拉神殿 (wowguru.com)
- 更改小地圖圖標提示以使其更加人性化 (Yatlas)
- 現下可以用鼠標來改變小地圖圖標位置 (Yatlas)

v1.3.3
- “墜落的瓦拉斯塔茲”更正為“墮落的瓦拉斯塔茲”
- 更新德文(deDE)本地化文件 (Maischter)

v1.3.2
- 更新 TOC 到10900以適應1.9版本的更新
- 在黑石塔(下層)地圖中加入尖石統帥(稀有) (Bhaerau)
- 更正一些史丹索姆地圖中的敵人刷新位置 (Ville K.)
- 更正黑暗深淵地圖中的洛古斯‧傑特 (Ville K., Greymalkin)
- 更新法文(frFR)本地化文件 (Pherus)
- 更新德文(deDE)本地化文件 (anavolver, Jan S.)
- 希望修正了一些自動選擇副本地圖功能的問題 (jmu)
- 修正一個無害化函數問題 (Pherus)
- 最小透明度由0提升到0.25

v1.3.1
- 更新法文(frFR)本地化文件 (Pherus)
- 在哀嚎洞穴地圖中加入變異精靈龍(稀有) (Searing)
- 在黑石塔(下層)地圖中加入尖石屠夫(稀有) (Gauss)

v1.3
- 更新 TOC 代碼到 1800
- 加入繁體中文(zhTW)本地化文件 (ama)
- 根據集合石更新了所有副本的等級範圍 (David C.)
- 修正了一個微小的事件錯誤 (PiraMod)
- 在厄運之槌(西)和厄運之槌(北)地圖中加入圖書館 (Pherus)
- 更新法文(frFR)本地化文件 (Pherus)
- 在祖爾格拉布地圖中加入多個釣魚點，即混濁的水 (Jan)
- 加入自動排序列表功能 (Alexander M.)
- 更新簡體中文(zhCN)本地化文件 (DiabloHu)
- 在祖爾格拉布地圖中加入首領級敵人屬性 (Matthew M.)
- 加入對 ModWatcher 的支持
- 修正一個自動排序列表功能的錯誤
- 整理等級範圍和人數上限數值

v1.2
- 完全漢化了祖爾格拉布地圖
- 透過 TitanAtlas 插件加入了對 Titan Panel 的支持 (Adsertor)
- 核心代碼改進 (Adsertor)
- 更新 MyAddons 插件對于 Atlas 和 TitanAltas 的支持
- Atlas 現下會記住你上次瀏覽的地圖

v1.1.3
- 加入簡體中文本地化文件 (DiabloHu)

v1.1.2
- 加入法語本地化文件 (Sparrows)

v1.1.1
- 更新血色修道院地圖中的稀有敵人 (Geisterkarle)
- 移除史丹索姆地圖中的不可寬恕者的稀有標籤 (tanniss)
- 自動選擇副本地圖功能現下默認開啟
- 修正大量自動選擇副本地圖功能的錯誤

v1.1
- 更新 TOC 到1700以適應1.7版本的更新
- 新的地圖︰黑翼之巢(wwwguru.com)和祖爾格拉布(Jan)
- 重新加入了自動選擇副本地圖功能，這個功能現下作為一個選項出現
- 創建了 Readme.txt 文件，該文件包括最近的發行情況
- 在厄運之槌(西)地圖中加入蘇斯(稀有) (Quiche)
- 在史丹索姆地圖中加入不可寬恕者(稀有) (Aludian)
- 在剃刀沼澤地圖中加入喚地者哈穆加(稀有) (Luke)
- 在黑石塔(下層)地圖中加入第五塊和第六塊摩沙魯石板 (Billy)
- 在黑石深淵地圖中加入審訊官格斯塔恩 (Yukkon)
- 在通靈學院地圖中加入基爾圖諾斯的衛士 (Ernesto)
- 在史丹索姆地圖中加入各個郵箱的名字 (Thomas)
- 在黑石塔(下層)地圖中加入班諾克‧巨斧(稀有) (Galon)
- 在影牙城堡地圖中加入死亡之誓(稀有) (Harri)
- 在通靈學院地圖中加入煉金試驗室 (Gere)
- 在黑石深淵地圖中加入部隊長哥沙克 (Jonas)

v1.0.1
- 更新 TOC 到1600以適應1.6版本的更新
- 加入法語支持 (感謝 Sasmira)
- 將剃刀高地的拉戈斯諾特標記為稀有 (感謝 Joshua B.)
- 修正黑石深淵中溫德索爾元帥的位置 (感謝 Stefan、Fegnus)