package com.liqourhub.dao;

import com.liqourhub.dto.Payment;

public interface PaymentDAO {

	boolean makePayment(Payment payment);

	Payment getPaymentByOrderId(int orderId);

	boolean updatePaymentStatus(int paymentId, String paymentStatus);

}