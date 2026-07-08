package com.LiquorHub.daoImpl;

import java.sql.Connection;

import com.LiquorHub.dao.ProductDAO;
import com.LiquorHub.utility.Connector;

public class ProductDAOImpl implements ProductDAO {
	Connection con = null;
	
	public ProductDAOImpl() {
		this.con = Connector.requestConnection();
	}
}
