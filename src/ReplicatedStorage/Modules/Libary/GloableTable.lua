local GloableTable = {}

GloableTable.BlackList = { -- UserId
    "6234623346234", -- check my nik
}

GloableTable.ColorLiderBoard = {
    [1] = { -- Emerald 
        Color1 = Color3.fromRGB(20, 168, 106),
        Color2 = Color3.fromRGB(24, 149, 59), 
    },
    [2] = { -- Diamond
        Color1 = Color3.fromRGB(27, 180, 203),
        Color2 = Color3.fromRGB(23, 156, 173),
    },
    [3] = { -- Gold
        Color1 = Color3.fromRGB(203, 203, 25),
        Color2 = Color3.fromRGB(163, 163, 20), 
    },
    [4] = { -- silver
        Color1 = Color3.fromRGB(172, 173, 154),
        Color2 = Color3.fromRGB(138, 139, 124), 
    },
    [5] = { -- usual
        Color1 = Color3.fromRGB(213, 160, 119),
        Color2 = Color3.fromRGB(181, 136, 101), 
    },

    ['Null1'] = { -- Standard 1
        Color1 = Color3.fromRGB(168, 127, 94),
        Color2 = Color3.fromRGB(149, 112, 84), 
    },
    ['Null2'] = { -- Standard 2
        Color1 = Color3.fromRGB(121, 96, 66),
        Color2 = Color3.fromRGB(157, 118, 87), 
    },
}

return GloableTable