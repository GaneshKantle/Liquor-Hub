package com.LiquorHub.daoImpl;

import java.sql.Connection;

import com.LiquorHub.dao.OrderItemDAO;
import com.LiquorHub.utility.Connector;

public class OrderItemDAOImpl implements OrderItemDAO {
	Connection con = null;
	
	public OrderItemDAOImpl() {
		this.con = Connector.requestConnection();
	}
}
