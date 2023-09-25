package com.tls.recipe.entity.composite;

import com.tls.recipe.entity.single.Recipe;
import com.tls.user.entity.User;
import java.time.LocalDateTime;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;

@Entity
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "recipe_select_log_tb")
public class UserRecipeLog {

    @Id
    @Column(name = "recipe_select_pk")
    private long recipeSelectPk;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User userId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "recipe_id")
    private Recipe recipeId;

    @CreationTimestamp
    @Column(name = "recipe_select_time")
    private LocalDateTime recipeSelectTime;
}
