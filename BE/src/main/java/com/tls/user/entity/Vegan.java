package com.tls.user.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.DynamicInsert;

@Entity
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "vegan_tb")
@DynamicInsert
public class Vegan {
    @Id
    @Column(name = "vegan_id")
    private int veganId;

    @Column(name = "vegan_name")
    private String veganName;
}
