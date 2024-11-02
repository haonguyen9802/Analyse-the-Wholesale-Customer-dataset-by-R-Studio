library(ggplot2)
library(ggcorrplot)
library(tidyverse)

wholesale_data <- read.csv("Wholesale customers data.csv")

# Check for NA values in entire dataset
any(is.na(wholesale_data))

###EXPLORATORY DATA ANALYSIS

#1.Summary statistic
summary(wholesale_data)

#Convert Channel and region columns into nominal data
wholesale_data$Channel <- as.factor(wholesale_data$Channel)
wholesale_data$Region <- as.factor(wholesale_data$Channel)


#2.Visualize the distribution of spending in each product category

#Fresh product
ggplot(wholesale_data, aes(x = Fresh)) +
  geom_histogram(bins = 30, fill = "blue", color = "black", alpha = 0.7) +
  labs(title = "Distribution of Spending on Fresh Products",
       x = "Spending (m.u.)", y = "Frequency") +
  theme_minimal()

#ggplot(wholesale_data, aes(x = Fresh)) +
  #geom_density(fill = "blue", alpha = 0.7) +
  #labs(title = "Density Plot of Spending on Fresh Products",
       #x = "Spending (m.u.)", y = "Density") +
  #theme_minimal()

par(mfrow = c(3, 2))
hist(wholesale_data$Fresh, main = "Fresh Products", xlab = "Spending (m.u.)", col = "blue")
hist(wholesale_data$Milk, main = "Milk Products", xlab = "Spending (m.u.)", col = "green")
hist(wholesale_data$Grocery, main = "Grocery Products", xlab = "Spending (m.u.)", col = "red")
hist(wholesale_data$Frozen, main = "Frozen Products", xlab = "Spending (m.u.)", col = "purple")
hist(wholesale_data$Detergents_Paper, main = "Detergents and Paper Products", xlab = "Spending (m.u.)", col = "orange")
hist(wholesale_data$Delicassen, main = "Delicatessen Products", xlab = "Spending (m.u.)", col = "yellow")
#most spending on fresh products is concentrated at lower amounts, with fewer instances of higher spending.

#3.Correlation analysis between different product categories
correlation_matrix <- cor(wholesale_data[, c("Fresh", "Milk", "Grocery", "Frozen", "Detergents_Paper", "Delicassen")])
correlation_matrix
ggcorrplot(correlation_matrix, type = "lower", outline.color = "white", lab = TRUE)
#Milk and Grocery have strong positive correlations with Detergents_Paper, indicating that higher spending in Milk and Grocery is associated with higher spending in Detergents_Paper.

#4.Cluster analysis
clustered_data <- wholesale_data[, -c(1, 2)]

#library(factoextra)
#fviz_nbclust(clustered_data, kmeans, method = "wss") #find the optimal cluster


k <- 3 #  Number of clusters
km_clusters <- kmeans(clustered_data , centers = k)
km_clusters 

# View results
cluster_assignments <- km_clusters$cluster
cluster_assignments

cluster_counts <- table(cluster_assignments)
cluster_counts

# Calculate mean spending values for each cluster
aggregate(clustered_data, by=list(cluster=km_clusters$cluster), mean)


pca_result <- prcomp(clustered_data, scale. = TRUE) #calculate principal components
#pca_result stores the result of the PCA analysis, which includes several components:
##$center: The means of the variables (columns) used in the PCA.
##$scale: The standard deviations of the variables used in the PCA.
##$rotation: The matrix of variable loadings (eigenvectors) onto the principal components.
##$x: The matrix of principal component scores (transformed data).

pca_scores <- as.data.frame(pca_result$x[, 1:2])  #extract principal component scores

pca_scores$Cluster <- as.factor(cluster_assignments) #add cluster assignments as a factor variable


ggplot(pca_scores, aes(x = PC1, y = PC2, color = Cluster)) +
  geom_point() +
  labs(x = "Principal Component 1", y = "Principal Component 2", color = "Cluster")


#Cluster 2's compactness implies a higher degree of homogeneity among its members in terms of spending patterns.
#Clusters 1 and 3 being spread out suggest greater heterogeneity, with potentially different subgroups or segments within each cluster exhibiting varied spending behaviors.
