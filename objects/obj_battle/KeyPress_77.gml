//Temporary Menu to showcase menus
Menu(x+10,y+10,
[
	["Flight", -1, -1, true],
	["Magic", SubMenu,
		[[
			["Ice", -1, -1, true],
			["Back", MenuGoBack, -1, true]
		]],
		true
	],
	["Escape", -1, -1, true]
]);