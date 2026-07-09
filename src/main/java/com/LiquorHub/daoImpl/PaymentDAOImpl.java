package com.LiquorHub.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.LiquorHub.dao.PaymentDAO;
import com.LiquorHub.dto.PaymentDTO;
import com.LiquorHub.utility.Connector;



public class PaymentDAOImpl implements PaymentDAO {

    private Connection con;

    public PaymentDAOImpl() {
        con = Connector.requestConnection();
    }

    @Override
    public boolean makePayment(PaymentDTO payment) {

        String sql = "INSERT INTO Payment(order_id, payment_method, payment_status) VALUES(?,?,?)";

        try {

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, payment.getOrderId());
            ps.setString(2, payment.getPaymentMethod());
            ps.setString(3, payment.getPaymentStatus());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public PaymentDTO getPaymentByOrderId(int orderId) {

        String sql = "SELECT * FROM Payment WHERE order_id=?";

        try {

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, orderId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                PaymentDTO payment = new PaymentDTO();

                payment.setPaymentId(rs.getInt("payment_id"));
                payment.setOrderId(rs.getInt("order_id"));
                payment.setPaymentMethod(rs.getString("payment_method"));
                payment.setPaymentStatus(rs.getString("payment_status"));

                return payment;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public boolean updatePaymentStatus(int paymentId, String paymentStatus) {

        String sql = "UPDATE Payment SET payment_status=? WHERE payment_id=?";

        try {

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, paymentStatus);
            ps.setInt(2, paymentId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

}