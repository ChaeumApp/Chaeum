package com.tls.recipe.service;

import com.tls.recipe.entity.single.Recipe;
import com.tls.recipe.entity.single.RecipeDesc;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.analysis.TokenStream;
import org.apache.lucene.analysis.tokenattributes.CharTermAttribute;

import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

public class RecipeSimilarityCalculator {

    private StandardAnalyzer analyzer = new StandardAnalyzer();

    public List<RecipeDesc> getTop3SimilarRecipes(RecipeDesc targetRecipeDesc, List<RecipeDesc> allRecipeDescs) throws IOException {
        Map<RecipeDesc, Double> similarityScores = computeCosineSimilarity(targetRecipeDesc, allRecipeDescs);

        return similarityScores.entrySet().stream()
            .sorted(Map.Entry.<RecipeDesc, Double>comparingByValue().reversed())
            .limit(3)
            .map(Map.Entry::getKey)
            .collect(Collectors.toList());
    }

    private Map<RecipeDesc, Double> computeCosineSimilarity(RecipeDesc targetRecipeDesc, List<RecipeDesc> allRecipeDescs) throws IOException {
        Map<RecipeDesc, Double> similarityScores = new HashMap<>();

        Map<String, Double> targetVector = getTfIdfVector(targetRecipeDesc.getRecipeDescription());

        for (RecipeDesc otherRecipeDesc : allRecipeDescs) {
            if (otherRecipeDesc.getRecipeId() != targetRecipeDesc.getRecipeId()) {
                Map<String, Double> otherVector = getTfIdfVector(otherRecipeDesc.getRecipeDescription());
                double similarity = cosineSimilarity(targetVector, otherVector);
                similarityScores.put(otherRecipeDesc, similarity);
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
