package com.tls.allergy.single;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import javax.persistence.Table;
import org.hibernate.annotations.DynamicInsert;

@Entity
@Getter
@NoArgsConstructor
@Builder
@AllArgsConstructor
@Table(name = "allergy_tb")
@DynamicInsert
public class Allergy {

    @Id
    @Column(name = "algy_id")
    private int algyId;

    @Column(name = "algy_name")
    private int algyName;
}
