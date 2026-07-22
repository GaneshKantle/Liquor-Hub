package com.LiquorHub.utility;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.LiquorHub.dao.ProductDAO;
import com.LiquorHub.dto.ProductDTO;

/**
 * Seeds extra catalogue rows once (by product name) so the shelf feels full.
 */
public final class CatalogSeeder {

	private CatalogSeeder() {
	}

	public static void ensureExtraProducts(ProductDAO productDAO) {
		if (productDAO == null) {
			return;
		}
		List<ProductDTO> existing;
		try {
			existing = productDAO.getAllProducts();
		} catch (Exception e) {
			return;
		}
		Set<String> names = new HashSet<>();
		if (existing != null) {
			for (ProductDTO p : existing) {
				if (p.getProductName() != null) {
					names.add(p.getProductName().toLowerCase());
				}
			}
		}

		String[][] rows = {
				// Whisky (1)
				{ "1", "Amrut Fusion", "Amrut", "5200", "18" },
				{ "1", "Paul John Brilliance", "Paul John", "4800", "20" },
				{ "1", "Rampur Double Cask", "Rampur", "7500", "12" },
				{ "1", "Indigo Blue Rare", "Indigo", "2100", "40" },
				{ "1", "Antiquity Blue", "Antiquity", "1600", "55" },
				{ "1", "Officer's Choice Blue", "Officer's Choice", "750", "90" },
				{ "1", "McDowell's No.1 Reserve", "McDowell's", "820", "100" },
				{ "1", "Dewar's White Label", "Dewar's", "2700", "28" },
				{ "1", "Famous Grouse", "Famous Grouse", "2400", "30" },
				{ "1", "Glenmorangie The Original", "Glenmorangie", "6900", "14" },
				// Vodka (2)
				{ "2", "Ketel One", "Ketel One", "4100", "22" },
				{ "2", "Tito's Handmade", "Tito's", "3900", "20" },
				{ "2", "Stolichnaya Premium", "Stoli", "2100", "35" },
				{ "2", "Magic Moments Remix Cranberry", "Magic Moments", "780", "70" },
				{ "2", "Russian Standard", "Russian Standard", "2800", "25" },
				{ "2", "Skyy Vodka", "Skyy", "2500", "28" },
				// Rum (3)
				{ "3", "Havana Club 3 Year", "Havana Club", "2900", "22" },
				{ "3", "Diplomatico Reserva", "Diplomatico", "6200", "10" },
				{ "3", "Mount Gay Eclipse", "Mount Gay", "3400", "18" },
				{ "3", "Sailor Jerry Spiced", "Sailor Jerry", "3100", "20" },
				{ "3", "Contessa Rum", "Contessa", "700", "80" },
				{ "3", "Hercules XXX Rum", "Hercules", "620", "90" },
				// Gin (4)
				{ "4", "Botanist Islay Dry", "The Botanist", "5800", "12" },
				{ "4", "Monkey 47", "Monkey 47", "7200", "8" },
				{ "4", "Saffron Gin", "Saffron", "3200", "20" },
				{ "4", "Jaisalmer Indian Craft Gin", "Jaisalmer", "2800", "25" },
				{ "4", "Nao Gin", "Nao", "2600", "22" },
				{ "4", "Roku Japanese Gin", "Roku", "4500", "15" },
				// Beer (5)
				{ "5", "Guinness Draught Can", "Guinness", "280", "160" },
				{ "5", "Bira 91 Boom", "Bira 91", "190", "200" },
				{ "5", "Simba Strong", "Simba", "170", "180" },
				{ "5", "Bro Code White", "Bro Code", "200", "150" },
				{ "5", "Foster's Lager", "Foster's", "200", "170" },
				{ "5", "Peroni Nastro Azzurro", "Peroni", "300", "110" },
				{ "5", "Asahi Super Dry", "Asahi", "310", "100" },
				{ "5", "Beck's Ice", "Beck's", "220", "140" },
				// Wine (6)
				{ "6", "Sula Riesling", "Sula", "1200", "40" },
				{ "6", "Fratelli Cabernet Franc", "Fratelli", "1600", "30" },
				{ "6", "Grover Zampa Chene", "Grover Zampa", "2400", "18" },
				{ "6", "Four Seasons Barrique", "Four Seasons", "1500", "25" },
				{ "6", "Big Banyan Shiraz", "Big Banyan", "1400", "28" },
				{ "6", "Yellow Tail Merlot", "Yellow Tail", "1600", "30" },
				{ "6", "Barefoot Moscato", "Barefoot", "1500", "32" },
				{ "6", "Moet & Chandon Imperial", "Moet & Chandon", "8500", "8" },
				// Brandy (7)
				{ "7", "Honey Bee Gold", "Honey Bee", "950", "60" },
				{ "7", "Morpheus Blue", "Morpheus", "1350", "40" },
				{ "7", "Mansion House VSOP", "Mansion House", "1100", "50" },
				{ "7", "Dreher Napoleon", "Dreher", "1600", "28" },
				{ "7", "Remy Martin VSOP", "Remy Martin", "9800", "8" },
				{ "7", "Martell VS", "Martell", "7200", "10" },
				// Tequila (8)
				{ "8", "Sauza Silver", "Sauza", "3600", "22" },
				{ "8", "Sauza Gold", "Sauza", "3800", "18" },
				{ "8", "Espolon Blanco", "Espolon", "4200", "16" },
				{ "8", "Casamigos Blanco", "Casamigos", "9500", "7" },
				{ "8", "Herradura Reposado", "Herradura", "8800", "8" },
				{ "8", "1800 Silver", "1800", "5200", "14" }
		};

		for (String[] row : rows) {
			String name = row[1];
			if (names.contains(name.toLowerCase())) {
				continue;
			}
			ProductDTO p = new ProductDTO();
			p.setCategoryId(Integer.parseInt(row[0]));
			p.setProductName(name);
			p.setBrand(row[2]);
			p.setPrice(Double.parseDouble(row[3]));
			p.setStock(Integer.parseInt(row[4]));
			try {
				if (productDAO.addProduct(p)) {
					names.add(name.toLowerCase());
				}
			} catch (Exception ignored) {
				// keep home load resilient
			}
		}
	}
}
