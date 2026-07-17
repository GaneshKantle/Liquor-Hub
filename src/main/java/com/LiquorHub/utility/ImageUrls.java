package com.LiquorHub.utility;

/**
 * CDN image URLs for categories/products (no DB image column).
 */
public final class ImageUrls {

	private ImageUrls() {
	}

	public static String forCategory(String name) {
		String n = name == null ? "" : name.toLowerCase();
		if (n.contains("whisk") || n.contains("whiskey")) {
			return "https://images.unsplash.com/photo-1527281400683-1aae777175f8?auto=format&fit=crop&w=800&q=70";
		}
		if (n.contains("wine")) {
			return "https://images.unsplash.com/photo-1510812431401-41d2bd2722f3?auto=format&fit=crop&w=800&q=70";
		}
		if (n.contains("gin")) {
			return "https://images.unsplash.com/photo-1605270012917-bf157c5a9541?auto=format&fit=crop&w=800&q=70";
		}
		if (n.contains("vodka")) {
			return "https://images.unsplash.com/photo-1551538827-9c037cb4f32a?auto=format&fit=crop&w=800&q=70";
		}
		if (n.contains("rum")) {
			return "https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?auto=format&fit=crop&w=800&q=70";
		}
		if (n.contains("tequila") || n.contains("mezcal")) {
			return "https://images.unsplash.com/photo-1516535794938-6063878f08cc?auto=format&fit=crop&w=800&q=70";
		}
		if (n.contains("beer")) {
			return "https://images.unsplash.com/photo-1608270586620-248524c67de9?auto=format&fit=crop&w=800&q=70";
		}
		if (n.contains("brandy") || n.contains("cognac")) {
			return "https://images.unsplash.com/photo-1569529465841-dfecdab7503b?auto=format&fit=crop&w=800&q=70";
		}
		return "https://images.unsplash.com/photo-1470337458703-46ad1756a187?auto=format&fit=crop&w=800&q=70";
	}

	public static String forProduct(String name, String brand) {
		String blob = ((name == null ? "" : name) + " " + (brand == null ? "" : brand)).toLowerCase();
		if (blob.contains("whisk") || blob.contains("whiskey") || blob.contains("scotch") || blob.contains("bourbon")
				|| blob.contains("chivas") || blob.contains("johnnie") || blob.contains("glen")) {
			return "https://images.unsplash.com/photo-1527281400683-1aae777175f8?auto=format&fit=crop&w=640&q=70";
		}
		if (blob.contains("wine") || blob.contains("cabernet") || blob.contains("merlot") || blob.contains("champagne")
				|| blob.contains("prosecco")) {
			return "https://images.unsplash.com/photo-1510812431401-41d2bd2722f3?auto=format&fit=crop&w=640&q=70";
		}
		if (blob.contains("gin") || blob.contains("bombay") || blob.contains("tanqueray")) {
			return "https://images.unsplash.com/photo-1605270012917-bf157c5a9541?auto=format&fit=crop&w=640&q=70";
		}
		if (blob.contains("vodka") || blob.contains("absolut") || blob.contains("grey goose")) {
			return "https://images.unsplash.com/photo-1551538827-9c037cb4f32a?auto=format&fit=crop&w=640&q=70";
		}
		if (blob.contains("rum") || blob.contains("bacardi") || blob.contains("monk")) {
			return "https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?auto=format&fit=crop&w=640&q=70";
		}
		if (blob.contains("tequila") || blob.contains("patron") || blob.contains("jose")) {
			return "https://images.unsplash.com/photo-1516535794938-6063878f08cc?auto=format&fit=crop&w=640&q=70";
		}
		if (blob.contains("beer") || blob.contains("lager") || blob.contains("ale") || blob.contains("stout")) {
			return "https://images.unsplash.com/photo-1608270586620-248524c67de9?auto=format&fit=crop&w=640&q=70";
		}
		return "https://images.unsplash.com/photo-1470337458703-46ad1756a187?auto=format&fit=crop&w=640&q=70";
	}
}
