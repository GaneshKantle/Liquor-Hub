package com.LiquorHub.utility;

/**
 * Real liquor photography via Unsplash CDN.
 * Prefer categoryId (1–8) so Indian brands still get the right spirit look.
 */
public final class ImageUrls {

	private static final String Q = "?auto=format&fit=crop&w=%d&q=80";

	/* Verified Unsplash CDN photo pools per spirit */
	private static final String[] WHISKY = {
			"https://images.unsplash.com/photo-1527281400683-1aae777175f8",
			"https://images.unsplash.com/photo-1569529465841-dfecdab7503b",
			"https://images.unsplash.com/photo-1470337458703-46ad1756a187",
			"https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b",
			"https://images.unsplash.com/photo-1536935338788-846bb9981813"
	};

	private static final String[] VODKA = {
			"https://images.unsplash.com/photo-1551538827-9c037cb4f32a",
			"https://images.unsplash.com/photo-1618885472179-5e474019f2a9",
			"https://images.unsplash.com/photo-1551024709-8f23befc6f87",
			"https://images.unsplash.com/photo-1544145945-f90425340c7e"
	};

	private static final String[] RUM = {
			"https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b",
			"https://images.unsplash.com/photo-1536935338788-846bb9981813",
			"https://images.unsplash.com/photo-1556679343-c7306c1976bc",
			"https://images.unsplash.com/photo-1595981267035-7b04ca84a82d"
	};

	private static final String[] GIN = {
			"https://images.unsplash.com/photo-1605270012917-bf157c5a9541",
			"https://images.unsplash.com/photo-1558642452-9d2a7deb7f62",
			"https://images.unsplash.com/photo-1571613316887-6f8d5cbf7ef7",
			"https://images.unsplash.com/photo-1551024709-8f23befc6f87"
	};

	private static final String[] BEER = {
			"https://images.unsplash.com/photo-1608270586620-248524c67de9",
			"https://images.unsplash.com/photo-1436076863939-06870fe779c2",
			"https://images.unsplash.com/photo-1607623814075-e51df1bdc82f",
			"https://images.unsplash.com/photo-1536935338788-846bb9981813"
	};

	private static final String[] WINE = {
			"https://images.unsplash.com/photo-1510812431401-41d2bd2722f3",
			"https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd",
			"https://images.unsplash.com/photo-1556679343-c7306c1976bc",
			"https://images.unsplash.com/photo-1470337458703-46ad1756a187"
	};

	private static final String[] BRANDY = {
			"https://images.unsplash.com/photo-1569529465841-dfecdab7503b",
			"https://images.unsplash.com/photo-1527281400683-1aae777175f8",
			"https://images.unsplash.com/photo-1470337458703-46ad1756a187",
			"https://images.unsplash.com/photo-1595981267035-7b04ca84a82d"
	};

	private static final String[] TEQUILA = {
			"https://images.unsplash.com/photo-1516535794938-6063878f08cc",
			"https://images.unsplash.com/photo-1551024709-8f23befc6f87",
			"https://images.unsplash.com/photo-1544145945-f90425340c7e",
			"https://images.unsplash.com/photo-1571613316887-6f8d5cbf7ef7"
	};

	private ImageUrls() {
	}

	public static String forCategory(String name) {
		return pick(poolForName(name), name == null ? "cat" : name, 900);
	}

	public static String forProduct(String name, String brand) {
		return forProduct(name, brand, 0);
	}

	/** Preferred: pass DB category_id (1 Whisky … 8 Tequila). */
	public static String forProduct(String name, String brand, int categoryId) {
		String key = ((name == null ? "" : name) + "|" + (brand == null ? "" : brand) + "|" + categoryId);
		String[] pool = poolForCategoryId(categoryId);
		if (pool == null) {
			pool = poolForName((name == null ? "" : name) + " " + (brand == null ? "" : brand));
		}
		return pick(pool, key, 720);
	}

	private static String[] poolForCategoryId(int categoryId) {
		switch (categoryId) {
		case 1:
			return WHISKY;
		case 2:
			return VODKA;
		case 3:
			return RUM;
		case 4:
			return GIN;
		case 5:
			return BEER;
		case 6:
			return WINE;
		case 7:
			return BRANDY;
		case 8:
			return TEQUILA;
		default:
			return null;
		}
	}

	private static String[] poolForName(String raw) {
		String n = raw == null ? "" : raw.toLowerCase();

		if (containsAny(n, "whisk", "whiskey", "scotch", "bourbon", "chivas", "johnnie", "glen",
				"jameson", "jack daniel", "ballantine", "teachers", "royal stag", "blenders",
				"imperial blue", "oaksmith", "rockford", "black dog", "vat 69", "monkey shoulder",
				"pipers", "signature rare", "black & white", "black and white")) {
			return WHISKY;
		}
		if (containsAny(n, "vodka", "absolut", "smirnoff", "grey goose", "belvedere", "ciroc",
				"magic moments", "romanov", "white mischief")) {
			return VODKA;
		}
		if (containsAny(n, "rum", "bacardi", "monk", "captain morgan", "malibu", "celebration")) {
			return RUM;
		}
		if (containsAny(n, "gin", "bombay", "tanqueray", "gordon", "beefeater", "hendrick",
				"hapusa", "greater than", "stranger")) {
			return GIN;
		}
		if (containsAny(n, "beer", "lager", "ale", "stout", "kingfisher", "budweiser", "heineken",
				"corona", "bira", "tuborg", "carlsberg", "hoegaarden", "stella")) {
			return BEER;
		}
		if (containsAny(n, "wine", "cabernet", "merlot", "chardonnay", "shiraz", "chenin", "brut",
				"sula", "fratelli", "grover", "jacob", "hardys", "casillero", "champagne", "prosecco")) {
			return WINE;
		}
		if (containsAny(n, "brandy", "cognac", "hennessy", "morpheus", "honey bee", "mansion house",
				"st-rémy", "st remy", "courrier", "napoleon")) {
			return BRANDY;
		}
		if (containsAny(n, "tequila", "mezcal", "patron", "jose", "cuervo", "olmeca", "don julio")) {
			return TEQUILA;
		}
		return WHISKY;
	}

	private static boolean containsAny(String hay, String... needles) {
		for (String n : needles) {
			if (hay.contains(n)) {
				return true;
			}
		}
		return false;
	}

	private static String pick(String[] pool, String key, int width) {
		if (pool == null || pool.length == 0) {
			pool = WHISKY;
		}
		int idx = Math.floorMod(key.hashCode(), pool.length);
		return pool[idx] + String.format(Q, width);
	}
}
