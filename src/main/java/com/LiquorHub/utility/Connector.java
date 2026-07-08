package com.LiquorHub.utility;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class Connector {
	private static Connection con = null;
	
	public static Connection requestConnection() {
		try {
            // Load db.properties from the classpath
            InputStream input = Connector.class.getClassLoader()
                    .getResourceAsStream("db.properties");

            Properties properties = new Properties(); 
            properties.load(input);

            String driver = properties.getProperty("db.driver");
            String url = properties.getProperty("db.url");
            String username = properties.getProperty("db.username");
            String password = properties.getProperty("db.password");

            Class.forName(driver);

            con = DriverManager.getConnection(url, username, password);

        } catch (ClassNotFoundException | SQLException | IOException e) {
            e.printStackTrace();
        }
		return con;
    }
		
}
