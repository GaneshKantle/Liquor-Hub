package com.LiquorHub.dao;

import com.LiquorHub.dto.PaymentDTO;

public interface PaymentDAO {

	boolean makePayment(PaymentDTO payment);

	PaymentDTO getPaymentByOrderId(int orderId);

	boolean updatePaymentStatus(int paymentId, String paymentStatus);

}