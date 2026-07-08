package com.LiquorHub.daoImpl;

import java.sql.Connection;

import com.LiquorHub.dao.CategoryDAO;
import com.LiquorHub.utility.Connector;

public class CategoryDAOImpl implements CategoryDAO {
	Connection con = null;
	
	public CategoryDAOImpl() {
		this.con = Connector.requestConnection();
	}
}
