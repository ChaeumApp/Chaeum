package com.tls.recipe.service;

import com.tls.recipe.entity.single.Recipe;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.analysis.TokenStream;
import org.apache.lucene.analysis.tokenattributes.CharTermAttribute;

import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

public class RecipeSimilarityCalculator {

    private StandardAnalyzer analyzer = new StandardAnalyzer();

    public List<Recipe> getTop3SimilarRecipes(Recipe targetRecipe, List<Recipe> allRecipes) throws IOException {
        Map<Recipe, Double> similarityScores = computeCosineSimilarity(targetRecipe, allRecipes);

        return similarityScores.entrySet().stream()
            .sorted(Map.Entry.<Recipe, Double>comparingByValue().reversed())
            .limit(3)
            .map(Map.Entry::getKey)
            .collect(Collectors.toList());
    }

    private Map<Recipe, Double> computeCosineSimilarity(Recipe targetRecipe, List<Recipe> allRecipes) throws IOException {
        Map<Recipe, Double> similarityScores = new HashMap<>();

        Map<String, Double> targetVector = getTfIdfVector(targetRecipe.getRecipeName());

        for (Recipe otherRecipe : allRecipes) {
            if (otherRecipe.getRecipeId() != targetRecipe.getRecipeId()) {
                Map<String, Double> otherVector = getTfIdfVector(otherRecipe.getRecipeName());
                double similarity = cosineSimilarity(targetVector, otherVector);
                similarityScores.put(otherRecipe, similarity);
            }
        }

        return similarityScores;
    }

    private Map<String, Double> getTfIdfVector(String text) throws IOException {
        Map<String, Double> vector = new HashMap<>();
        TokenStream tokenStream = analyzer.tokenStream(null, text);
        CharTermAttribute charTermAttribute = tokenStream.addAttribute(CharTermAttribute.class);
        tokenStream.reset();

        while (tokenStream.incrementToken()) {
            String term = charTermAttribute.toString();
            vector.put(term, vector.getOrDefault(term, 0.0) + 1);
        }
        tokenStream.end();
        tokenStream.close();

        return vector;
    }

    private double cosineSimilarity(Map<String, Double> vectorA, Map<String, Double> vectorB) {
        double dotProduct = 0.0;
        double normA = 0.0;
        double normB = 0.0;

        for (String key : vectorA.keySet()) {
            dotProduct += vectorA.get(key) * vectorB.getOrDefault(key, 0.0);
            normA += Math.pow(vectorA.get(key), 2);
        }

        for (double value : vectorB.values()) {
            normB += Math.pow(value, 2);
        }

        return dotProduct / (Math.sqrt(normA) * Math.sqrt(normB));
    }
}
