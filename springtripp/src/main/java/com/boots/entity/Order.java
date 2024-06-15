package com.boots.entity;


import java.util.Date;


import lombok.*;
import javax.persistence.*;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Getter
@Setter
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
    private Date date;
    private String departure;
    private String destination;
    private String status;

    private String from;
    private String to;
    @Enumerated(EnumType.STRING)
    private car_type car_type; // Use an enum for car type

    @Enumerated(EnumType.STRING)
    private paymentMethod paymentMethod; // Use an enum for payment method

    public enum car_type {
        ECONOMY, COMFORT, LUXURY
    }

    public enum paymentMethod {
        CASH, CARD
    }
}

