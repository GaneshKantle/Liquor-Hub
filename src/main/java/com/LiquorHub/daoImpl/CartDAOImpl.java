package com.LiquorHub.daoImpl;

import java.sql.Connection;

import com.LiquorHub.dao.CartDAO;
import com.LiquorHub.utility.Connector;

public class CartDAOImpl implements CartDAO {
	
	Connection con = null;
	
	public CartDAOImpl() {
		this.con = Connector.requestConnection();
	}
	
	
}
