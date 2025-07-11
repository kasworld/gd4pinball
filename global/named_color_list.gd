extends Node

#class_name NamedColorList

func get_color(i :int)->Color:
	return color_list[i%color_list.size()][0]

func get_colorname(i :int)->String:
	return color_list[i%color_list.size()][1]

func get_colorname_by_color(c :Color)->String:
	for v in color_list:
		if v[0] == c:
			return v[1]
	return c.to_html()

func make_light_color_list(l :float= 0.5) -> Array:
	var rtn := []
	for i in color_list:
		if i[0].get_luminance() > l:
			rtn.append(i)
	return rtn

func make_dark_color_list(l :float= 0.5, clist = color_list) -> Array:
	var rtn := []
	for i in clist:
		if i[0].get_luminance() < l:
			rtn.append(i)
	return rtn
	
func make_red_color_list(clist = color_list) -> Array:
	var rtn := []
	for i in clist:
		if i[0].r > i[0].g and i[0].r > i[0].b:
			rtn.append(i)
	return rtn

func make_blue_color_list(clist = color_list) -> Array:
	var rtn := []
	for i in clist:
		if i[0].b > i[0].g and i[0].b > i[0].r:
			rtn.append(i)
	return rtn

func make_green_color_list(clist = color_list) -> Array:
	var rtn := []
	for i in clist:
		if i[0].g > i[0].r and i[0].g > i[0].b:
			rtn.append(i)
	return rtn

func make_yellow_color_list(clist = color_list) -> Array:
	var rtn := []
	for i in clist:
		if i[0].r > i[0].b and i[0].g > i[0].b:
			rtn.append(i)
	return rtn

func make_cyan_color_list(clist = color_list) -> Array:
	var rtn := []
	for i in clist:
		if i[0].b > i[0].r and i[0].g > i[0].r:
			rtn.append(i)
	return rtn

func make_magenta_color_list(clist = color_list) -> Array:
	var rtn := []
	for i in clist:
		if i[0].b > i[0].g and i[0].r > i[0].g:
			rtn.append(i)
	return rtn


const color_list = [
[Color.ALICE_BLUE, "ALICE_BLUE"],
[Color.ANTIQUE_WHITE, "ANTIQUE_WHITE"],
[Color.AQUA, "AQUA"],
[Color.AQUAMARINE, "AQUAMARINE"],
[Color.AZURE, "AZURE"],
[Color.BEIGE, "BEIGE"],
[Color.BISQUE, "BISQUE"],
[Color.BLACK, "BLACK"],
[Color.BLANCHED_ALMOND, "BLANCHED_ALMOND"],
[Color.BLUE, "BLUE"],
[Color.BLUE_VIOLET, "BLUE_VIOLET"],
[Color.BROWN, "BROWN"],
[Color.BURLYWOOD, "BURLYWOOD"],
[Color.CADET_BLUE, "CADET_BLUE"],
[Color.CHARTREUSE, "CHARTREUSE"],
[Color.CHOCOLATE, "CHOCOLATE"],
[Color.CORAL, "CORAL"],
[Color.CORNFLOWER_BLUE, "CORNFLOWER_BLUE"],
[Color.CORNSILK, "CORNSILK"],
[Color.CRIMSON, "CRIMSON"],
[Color.CYAN, "CYAN"],
[Color.DARK_BLUE, "DARK_BLUE"],
[Color.DARK_CYAN, "DARK_CYAN"],
[Color.DARK_GOLDENROD, "DARK_GOLDENROD"],
[Color.DARK_GRAY, "DARK_GRAY"],
[Color.DARK_GREEN, "DARK_GREEN"],
[Color.DARK_KHAKI, "DARK_KHAKI"],
[Color.DARK_MAGENTA, "DARK_MAGENTA"],
[Color.DARK_OLIVE_GREEN, "DARK_OLIVE_GREEN"],
[Color.DARK_ORANGE, "DARK_ORANGE"],
[Color.DARK_ORCHID, "DARK_ORCHID"],
[Color.DARK_RED, "DARK_RED"],
[Color.DARK_SALMON, "DARK_SALMON"],
[Color.DARK_SEA_GREEN, "DARK_SEA_GREEN"],
[Color.DARK_SLATE_BLUE, "DARK_SLATE_BLUE"],
[Color.DARK_SLATE_GRAY, "DARK_SLATE_GRAY"],
[Color.DARK_TURQUOISE, "DARK_TURQUOISE"],
[Color.DARK_VIOLET, "DARK_VIOLET"],
[Color.DEEP_PINK, "DEEP_PINK"],
[Color.DEEP_SKY_BLUE, "DEEP_SKY_BLUE"],
[Color.DIM_GRAY, "DIM_GRAY"],
[Color.DODGER_BLUE, "DODGER_BLUE"],
[Color.FIREBRICK, "FIREBRICK"],
[Color.FLORAL_WHITE, "FLORAL_WHITE"],
[Color.FOREST_GREEN, "FOREST_GREEN"],
[Color.FUCHSIA, "FUCHSIA"],
[Color.GAINSBORO, "GAINSBORO"],
[Color.GHOST_WHITE, "GHOST_WHITE"],
[Color.GOLD, "GOLD"],
[Color.GOLDENROD, "GOLDENROD"],
[Color.GRAY, "GRAY"],
[Color.GREEN, "GREEN"],
[Color.GREEN_YELLOW, "GREEN_YELLOW"],
[Color.HONEYDEW, "HONEYDEW"],
[Color.HOT_PINK, "HOT_PINK"],
[Color.INDIAN_RED, "INDIAN_RED"],
[Color.INDIGO, "INDIGO"],
[Color.IVORY, "IVORY"],
[Color.KHAKI, "KHAKI"],
[Color.LAVENDER, "LAVENDER"],
[Color.LAVENDER_BLUSH, "LAVENDER_BLUSH"],
[Color.LAWN_GREEN, "LAWN_GREEN"],
[Color.LEMON_CHIFFON, "LEMON_CHIFFON"],
[Color.LIGHT_BLUE, "LIGHT_BLUE"],
[Color.LIGHT_CORAL, "LIGHT_CORAL"],
[Color.LIGHT_CYAN, "LIGHT_CYAN"],
[Color.LIGHT_GOLDENROD, "LIGHT_GOLDENROD"],
[Color.LIGHT_GRAY, "LIGHT_GRAY"],
[Color.LIGHT_GREEN, "LIGHT_GREEN"],
[Color.LIGHT_PINK, "LIGHT_PINK"],
[Color.LIGHT_SALMON, "LIGHT_SALMON"],
[Color.LIGHT_SEA_GREEN, "LIGHT_SEA_GREEN"],
[Color.LIGHT_SKY_BLUE, "LIGHT_SKY_BLUE"],
[Color.LIGHT_SLATE_GRAY, "LIGHT_SLATE_GRAY"],
[Color.LIGHT_STEEL_BLUE, "LIGHT_STEEL_BLUE"],
[Color.LIGHT_YELLOW, "LIGHT_YELLOW"],
[Color.LIME, "LIME"],
[Color.LIME_GREEN, "LIME_GREEN"],
[Color.LINEN, "LINEN"],
[Color.MAGENTA, "MAGENTA"],
[Color.MAROON, "MAROON"],
[Color.MEDIUM_AQUAMARINE, "MEDIUM_AQUAMARINE"],
[Color.MEDIUM_BLUE, "MEDIUM_BLUE"],
[Color.MEDIUM_ORCHID, "MEDIUM_ORCHID"],
[Color.MEDIUM_PURPLE, "MEDIUM_PURPLE"],
[Color.MEDIUM_SEA_GREEN, "MEDIUM_SEA_GREEN"],
[Color.MEDIUM_SLATE_BLUE, "MEDIUM_SLATE_BLUE"],
[Color.MEDIUM_SPRING_GREEN, "MEDIUM_SPRING_GREEN"],
[Color.MEDIUM_TURQUOISE, "MEDIUM_TURQUOISE"],
[Color.MEDIUM_VIOLET_RED, "MEDIUM_VIOLET_RED"],
[Color.MIDNIGHT_BLUE, "MIDNIGHT_BLUE"],
[Color.MINT_CREAM, "MINT_CREAM"],
[Color.MISTY_ROSE, "MISTY_ROSE"],
[Color.MOCCASIN, "MOCCASIN"],
[Color.NAVAJO_WHITE, "NAVAJO_WHITE"],
[Color.NAVY_BLUE, "NAVY_BLUE"],
[Color.OLD_LACE, "OLD_LACE"],
[Color.OLIVE, "OLIVE"],
[Color.OLIVE_DRAB, "OLIVE_DRAB"],
[Color.ORANGE, "ORANGE"],
[Color.ORANGE_RED, "ORANGE_RED"],
[Color.ORCHID, "ORCHID"],
[Color.PALE_GOLDENROD, "PALE_GOLDENROD"],
[Color.PALE_GREEN, "PALE_GREEN"],
[Color.PALE_TURQUOISE, "PALE_TURQUOISE"],
[Color.PALE_VIOLET_RED, "PALE_VIOLET_RED"],
[Color.PAPAYA_WHIP, "PAPAYA_WHIP"],
[Color.PEACH_PUFF, "PEACH_PUFF"],
[Color.PERU, "PERU"],
[Color.PINK, "PINK"],
[Color.PLUM, "PLUM"],
[Color.POWDER_BLUE, "POWDER_BLUE"],
[Color.PURPLE, "PURPLE"],
[Color.REBECCA_PURPLE, "REBECCA_PURPLE"],
[Color.RED, "RED"],
[Color.ROSY_BROWN, "ROSY_BROWN"],
[Color.ROYAL_BLUE, "ROYAL_BLUE"],
[Color.SADDLE_BROWN, "SADDLE_BROWN"],
[Color.SALMON, "SALMON"],
[Color.SANDY_BROWN, "SANDY_BROWN"],
[Color.SEA_GREEN, "SEA_GREEN"],
[Color.SEASHELL, "SEASHELL"],
[Color.SIENNA, "SIENNA"],
[Color.SILVER, "SILVER"],
[Color.SKY_BLUE, "SKY_BLUE"],
[Color.SLATE_BLUE, "SLATE_BLUE"],
[Color.SLATE_GRAY, "SLATE_GRAY"],
[Color.SNOW, "SNOW"],
[Color.SPRING_GREEN, "SPRING_GREEN"],
[Color.STEEL_BLUE, "STEEL_BLUE"],
[Color.TAN, "TAN"],
[Color.TEAL, "TEAL"],
[Color.THISTLE, "THISTLE"],
[Color.TOMATO, "TOMATO"],
#[Color.TRANSPARENT, "TRANSPARENT"],
[Color.TURQUOISE, "TURQUOISE"],
[Color.VIOLET, "VIOLET"],
[Color.WEB_GRAY, "WEB_GRAY"],
[Color.WEB_GREEN, "WEB_GREEN"],
[Color.WEB_MAROON, "WEB_MAROON"],
[Color.WEB_PURPLE, "WEB_PURPLE"],
[Color.WHEAT, "WHEAT"],
[Color.WHITE, "WHITE"],
[Color.WHITE_SMOKE, "WHITE_SMOKE"],
[Color.YELLOW, "YELLOW"],
[Color.YELLOW_GREEN, "YELLOW_GREEN"],
]
