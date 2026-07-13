package com.LiquorHub.utility;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class Connector {
	private static Connection con = null;

	public static Connection getConnection() {
		return requestConnection();
	}

	public static Connection requestConnection() {
		if (con != null) {
			return con;
		}

		try {
			Properties properties = loadProperties();

			String driver = properties.getProperty("db.driver");
			String url = properties.getProperty("db.url");
			String username = properties.getProperty("db.username");
			String password = properties.getProperty("db.password");

			Class.forName(driver);
			con = DriverManager.getConnection(url, username, password);

		} catch (ClassNotFoundException | SQLException | IOException e) {
			System.err.println("Database connection failed: " + e.getMessage());
			e.printStackTrace();
		}
		return con;
	}

	private static Properties loadProperties() throws IOException {
		Properties properties = new Properties();

		// 1) Classpath (Eclipse: src/main/resources on build path)
		InputStream input = Connector.class.getClassLoader().getResourceAsStream("db.properties");
		if (input != null) {
			try (InputStream in = input) {
				properties.load(in);
			}
			return properties;
		}

		// 2) File fallbacks when running from project root in Eclipse
		String[] candidates = {
				"src/main/resources/db.properties",
				"src/db.properties",
				"db.properties"
		};

		for (String candidate : candidates) {
			Path path = Paths.get(candidate);
			if (Files.exists(path)) {
				try (InputStream in = new FileInputStream(path.toFile())) {
					properties.load(in);
				}
				return properties;
			}
		}

		throw new IOException(
				"db.properties not found. Copy src/db.properties.example to "
						+ "src/main/resources/db.properties and set your MySQL username/password. "
						+ "In Eclipse: right-click project → Refresh, and ensure src/main/resources is a source folder.");
	}
}
