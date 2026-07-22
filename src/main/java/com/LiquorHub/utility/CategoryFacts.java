package com.LiquorHub.utility;

/**
 * Short facts for category flip cards (origin, fame, style).
 */
public final class CategoryFacts {

	private CategoryFacts() {
	}

	public static String origin(String name) {
		String n = name == null ? "" : name.toLowerCase();
		if (n.contains("whisk") || n.contains("whiskey")) {
			return "Scotland, Ireland, USA & India";
		}
		if (n.contains("vodka")) {
			return "Eastern Europe & Russia";
		}
		if (n.contains("rum")) {
			return "Caribbean & tropical cane belts";
		}
		if (n.contains("gin")) {
			return "England (London Dry) & India craft";
		}
		if (n.contains("beer")) {
			return "Worldwide - lager & ale cultures";
		}
		if (n.contains("wine")) {
			return "Europe, New World & Indian vineyards";
		}
		if (n.contains("brandy") || n.contains("cognac")) {
			return "France (Cognac/Armagnac) & India";
		}
		if (n.contains("tequila") || n.contains("mezcal")) {
			return "Mexico - blue agave heartlands";
		}
		return "Global craft & classic regions";
	}

	public static String fame(String name) {
		String n = name == null ? "" : name.toLowerCase();
		if (n.contains("whisk") || n.contains("whiskey")) {
			return "The celebration spirit - aged in oak, sipped neat or with a drop of water.";
		}
		if (n.contains("vodka")) {
			return "Clean canvas for cocktails - from house parties to martini bars.";
		}
		if (n.contains("rum")) {
			return "Old Monk nostalgia to Caribbean spice - molasses warmth in every pour.";
		}
		if (n.contains("gin")) {
			return "Juniper-forward and botanical - the backbone of G&T culture.";
		}
		if (n.contains("beer")) {
			return "The everyday social pour - from Kingfisher tables to craft pints.";
		}
		if (n.contains("wine")) {
			return "Dinner tables and celebrations - grape stories from vineyard to glass.";
		}
		if (n.contains("brandy") || n.contains("cognac")) {
			return "Warm after-dinner classic - distilled wine aged into velvet heat.";
		}
		if (n.contains("tequila") || n.contains("mezcal")) {
			return "Agave icons - from party shots to slow reposado sipping.";
		}
		return "A defined shelf with clear style and stories.";
	}

	public static String note(String name) {
		String n = name == null ? "" : name.toLowerCase();
		if (n.contains("whisk") || n.contains("whiskey")) {
			return "Look for age statements, grain vs malt, and region.";
		}
		if (n.contains("vodka")) {
			return "Neutral profile - quality shows in smoothness and finish.";
		}
		if (n.contains("rum")) {
			return "White for mixers, dark & spiced for depth.";
		}
		if (n.contains("gin")) {
			return "London Dry vs contemporary botanicals - pick your aromatic lane.";
		}
		if (n.contains("beer")) {
			return "Lager for crisp refreshment, wheat & craft for character.";
		}
		if (n.contains("wine")) {
			return "Red with body, white with lift, sparkling for toast moments.";
		}
		if (n.contains("brandy") || n.contains("cognac")) {
			return "VS for mix, VSOP/XO for slower evenings.";
		}
		if (n.contains("tequila") || n.contains("mezcal")) {
			return "Blanco bright, reposado soft oak, anejo rich and deep.";
		}
		return "Browse the live catalogue for this shelf.";
	}
}
