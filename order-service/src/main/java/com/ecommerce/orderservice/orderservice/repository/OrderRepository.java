package com.ecommerce.orderservice.orderservice.repository;

import com.ecommerce.orderservice.orderservice.model.Order;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderRepository extends JpaRepository<Order, String> {
}
