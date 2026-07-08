package com.LiquorHub.daoImpl;

import java.sql.Connection;

import com.LiquorHub.dao.OrderDAO;
import com.LiquorHub.utility.Connector;

public class OrderDAOImpl implements OrderDAO {
	Connection con = null;
	
	public OrderDAOImpl() {
		this.con = Connector.requestConnection();
	}
}
