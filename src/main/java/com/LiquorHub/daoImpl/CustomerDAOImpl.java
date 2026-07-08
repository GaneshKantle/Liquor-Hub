package com.LiquorHub.daoImpl;

import java.sql.Connection;

import com.LiquorHub.dao.CustomerDAO;
import com.LiquorHub.utility.Connector;

public class CustomerDAOImpl implements CustomerDAO {
	Connection con = null;
	
	public CustomerDAOImpl() {
		this.con = Connector.requestConnection();
	}
}
