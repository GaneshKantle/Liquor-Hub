package com.LiquorHub.daoImpl;

import java.sql.Connection;

import com.LiquorHub.dao.CartItemDAO;
import com.LiquorHub.utility.Connector;

public class CartItemDAOImpl implements CartItemDAO {
	Connection con = null;
	
	public CartItemDAOImpl() {
		this.con = Connector.requestConnection();
	}
}
