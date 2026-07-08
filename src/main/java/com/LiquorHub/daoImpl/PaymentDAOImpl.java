package com.LiquorHub.daoImpl;

import java.sql.Connection;

import com.LiquorHub.dao.PaymentDAO;
import com.LiquorHub.utility.Connector;

public class PaymentDAOImpl implements PaymentDAO {
	Connection con = null;
	
	public PaymentDAOImpl() {
		this.con = Connector.requestConnection();
	}
}
