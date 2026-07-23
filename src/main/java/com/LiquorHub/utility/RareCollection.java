package com.LiquorHub.utility;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import com.LiquorHub.dto.RareBottle;

/**
 * Curated ultra-rare bottle dossiers for the Rare Collection showcase.
 * Not backed by the Product table — provenance-first floor lots.
 */
public final class RareCollection {

	private static final String Q = "?auto=format&fit=crop&w=900&q=80";

	private RareCollection() {
	}

	public static List<RareBottle> all() {
		List<RareBottle> lots = new ArrayList<>();

		lots.add(lot(
				"rh-macallan-30",
				"The Macallan 30 Year Old Sherry Oak",
				"The Macallan",
				"Single Malt Scotch",
				"Speyside, Scotland",
				"30 years",
				"Bottled from sherry-seasoned European oak",
				"43% ABV",
				"Dried fruit, dark chocolate, polished oak, orange peel, and a long spicy finish.",
				"A flagship Speyside rarity — decades in sherry casks produce a dense, collector-grade pour. Few cases reach private boards outside auction houses.",
				485000,
				"Allocation lot · very limited",
				"https://images.unsplash.com/photo-1527281400683-1aae777175f8"
		));

		lots.add(lot(
				"rh-yamazaki-18",
				"Yamazaki 18 Year Old",
				"Suntory",
				"Japanese Single Malt",
				"Osaka Prefecture, Japan",
				"18 years",
				"Multi-cask blend, bottled in Japan",
				"43% ABV",
				"Raisin, toffee, Mizunara spice, incense wood, and soft orchard fruit.",
				"Japan’s most sought Speyside-style malt. Global allocation keeps secondary prices high; this desk lot is held for serious collectors only.",
				215000,
				"Asia allocation · scarce",
				"https://images.unsplash.com/photo-1569529465841-dfecdab7503b"
		));

		lots.add(lot(
				"rh-pappy-23",
				"Pappy Van Winkle 23 Year Old",
				"Old Rip Van Winkle",
				"Kentucky Straight Bourbon",
				"Frankfort, Kentucky, USA",
				"23 years",
				"Buffalo Trace Antique Collection lineage",
				"47.8% ABV",
				"Caramel, dark cherry, tobacco leaf, toasted oak, and baking spice.",
				"The American whisky that broke lottery culture. Ultra-low annual releases make every bottle a floor event.",
				650000,
				"Lottery release · 1 bottle on desk",
				"https://images.unsplash.com/photo-1470337458703-46ad1756a187"
		));

		lots.add(lot(
				"rh-krug-grande",
				"Krug Grande Cuvée 171ème Édition",
				"Krug",
				"Champagne",
				"Reims, Champagne, France",
				"Multi-vintage reserve",
				"171st edition assemblage",
				"12% ABV",
				"Brioche, citrus oil, hazelnut, white flowers, and precise salinity.",
				"Krug’s multi-vintage house style — reserve wines spanning decades. Prestige cuvée for celebrations that deserve a dossier, not a shelf tag.",
				89000,
				"Maison allocation",
				"https://images.unsplash.com/photo-1510812431401-41d2bd2722f3"
		));

		lots.add(lot(
				"rh-dom-p2",
				"Dom Pérignon P2 Plénitude 2002",
				"Dom Pérignon",
				"Champagne",
				"Épernay, Champagne, France",
				"Second plénitude",
				"Vintage 2002 · disgorged for P2",
				"12.5% ABV",
				"Smoky mineral, candied citrus, grilled almond, and deep autolytic richness.",
				"P2 is Dom’s second life — held on lees far longer than the standard vintage. A cellar trophy for collectors who wait.",
				175000,
				"Vintage P2 · limited",
				"https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd"
		));

		lots.add(lot(
				"rh-hibiki-21",
				"Hibiki 21 Year Old",
				"Suntory",
				"Japanese Blended Whisky",
				"Japan (Yamazaki · Hakushu · Chita)",
				"21 years",
				"Discontinued classic blend",
				"43% ABV",
				"Plum, sandalwood, honey, rose petal, and silky oak.",
				"Discontinued and hunted. Hibiki 21 sits at the top of Japanese blend collecting — this lot is presentation-ready.",
				320000,
				"Discontinued · last cases",
				"https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b"
		));

		lots.add(lot(
				"rh-zacapa-xo",
				"Ron Zacapa XO Solera Gran Reserva Especial",
				"Ron Zacapa",
				"Guatemalan Rum",
				"Quetzaltenango, Guatemala",
				"Solera up to 25 years",
				"Sistema solera · American & French oak + PX finish",
				"40% ABV",
				"Dried fig, cocoa, roasted coffee, maple, and warm spice.",
				"High-altitude ageing and a PX finish make Zacapa XO a rum collector staple — rare on Indian desks at this presentation level.",
				42000,
				"Premium solera lot",
				"https://images.unsplash.com/photo-1556679343-c7306c1976bc"
		));

		lots.add(lot(
				"rh-hennessy-paradis",
				"Hennessy Paradis Rare Cognac",
				"Hennessy",
				"Cognac",
				"Cognac, France",
				"Eau-de-vie up to ~130 years in blend",
				"House Paradis reserves",
				"40% ABV",
				"Candied orange, jasmine, toasted almond, soft leather, and endless length.",
				"Paradis draws on eaux-de-vie older than most cellars. A luxury cognac lot for the clearing house’s top shelf.",
				280000,
				"Maison rare reserve",
				"https://images.unsplash.com/photo-1595981267035-7b04ca84a82d"
		));

		lots.add(lot(
				"rh-clon-extra-anejo",
				"Clase Azul Extra Añejo",
				"Clase Azul",
				"Tequila Extra Añejo",
				"Jalisco, Mexico",
				"Minimum 3+ years in oak",
				"Hand-painted ceramic decanter",
				"40% ABV",
				"Cooked agave, vanilla, dark chocolate, cinnamon, and toasted oak.",
				"Collector tequila in the iconic ceramic. Extra añejo stock plus artisan vessel — gift-floor and vault-worthy.",
				95000,
				"Decanter edition · limited",
				"https://images.unsplash.com/photo-1516535794938-6063878f08cc"
		));

		lots.add(lot(
				"rh-octomore-14",
				"Octomore 14.1 Progressive Peat",
				"Bruichladdich",
				"Islay Single Malt",
				"Islay, Scotland",
				"5 years (super-heavily peated)",
				"PPM famously extreme · bourbon casks",
				"59.6% ABV",
				"Medicinal smoke, lemon zest, vanilla cream, and coastal brine.",
				"Young age, absurd peat — Octomore is the cult Islay experiment. This edition is for smoke hunters who collect by PPM.",
				38000,
				"Cult release",
				"https://images.unsplash.com/photo-1536935338788-846bb9981813"
		));

		return Collections.unmodifiableList(lots);
	}

	public static RareBottle byId(String id) {
		if (id == null || id.isBlank()) {
			return null;
		}
		for (RareBottle b : all()) {
			if (id.equalsIgnoreCase(b.getId())) {
				return b;
			}
		}
		return null;
	}

	private static RareBottle lot(
			String id,
			String name,
			String brand,
			String spiritType,
			String origin,
			String age,
			String vintage,
			String abv,
			String tasting,
			String story,
			double priceInr,
			String limited,
			String imageBase) {
		RareBottle b = new RareBottle();
		b.setId(id);
		b.setName(name);
		b.setBrand(brand);
		b.setSpiritType(spiritType);
		b.setOrigin(origin);
		b.setAge(age);
		b.setVintage(vintage);
		b.setAbv(abv);
		b.setTastingNotes(tasting);
		b.setStory(story);
		b.setPriceInr(priceInr);
		b.setLimited(limited);
		b.setImageUrl(imageBase + Q);
		return b;
	}
}
