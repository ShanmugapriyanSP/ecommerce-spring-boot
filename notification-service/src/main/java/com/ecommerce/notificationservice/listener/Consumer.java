package com.ecommerce.notificationservice.listener;


import com.ecommerce.notificationservice.event.OrderPlacedEvent;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class Consumer {

    private final JavaMailSender mailSender;

    @KafkaListener(topics = "orderTopic")
    public void handleNotification(OrderPlacedEvent orderPlacedEvent) {
        log.info("Order placed!!! OrderNumber: {}", orderPlacedEvent.getOrderNumber());
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo("shanmugapriyan9696@gmail.com");
        message.setSubject("ECOMMERCE: Order Placed Successfully");
        message.setText("Order placed successfully!! Order Number: " + orderPlacedEvent.getOrderNumber());
        mailSender.send(message);
    }
}
