#Import libraries
library(ggplot2)
library(ggcorrplot)
library(tidyverse)

#Import the data
wholesale_data <- read.csv("Wholesale customers data.csv")

# Check for NA values in entire dataset
any(is.na(wholesale_data))

#Summary statistic
summary(wholesale_data)

#Convert Channel and region columns into nominal data
wholesale_data$Channel <- as.factor(wholesale_data$Channel)
wholesale_data$Region <- as.factor(wholesale_data$Channel)

#Visualize the distribution of spending in each product category
par(mfrow = c(3, 2))
hist(wholesale_data$Fresh, main = "Fresh Products", xlab = "Spending (m.u.)", col = "blue")
hist(wholesale_data$Milk, main = "Milk Products", xlab = "Spending (m.u.)", col = "green")
hist(wholesale_data$Grocery, main = "Grocery Products", xlab = "Spending (m.u.)", col = "red")
hist(wholesale_data$Frozen, main = "Frozen Products", xlab = "Spending (m.u.)", col = "purple")
hist(wholesale_data$Detergents_Paper, main = "Detergents and Paper Products", xlab = "Spending (m.u.)", col = "orange")
hist(wholesale_data$Delicassen, main = "Delicatessen Products", xlab = "Spending (m.u.)", col = "yellow")
#most spending on fresh products is concentrated at lower amounts, with fewer instances of higher spending.

#Correlation analysis between different product categories
correlation_matrix <- cor(wholesale_data[, c("Fresh", "Milk", "Grocery", "Frozen", "Detergents_Paper", "Delicassen")])
correlation_matrix
ggcorrplot(correlation_matrix, type = "lower", outline.color = "white", lab = TRUE)
#Milk and Grocery have strong positive correlations with Detergents_Paper, indicating that higher spending in Milk and Grocery is associated with higher spending in Detergents_Paper.

#Cluster analysis
clustered_data <- wholesale_data[, -c(1, 2)]
k <- 3 #  Number of clusters
km_clusters <- kmeans(clustered_data , centers = k)
km_clusters 

# View results
cluster_assignments <- km_clusters$cluster
cluster_assignments
cluster_counts <- table(cluster_assignments)
cluster_counts

#Calculate mean spending values for each cluster
aggregate(clustered_data, by=list(cluster=km_clusters$cluster), mean)

#Calculate principal components
pca_result <- prcomp(clustered_data, scale. = TRUE) 

#Extract principal component scores
pca_scores <- as.data.frame(pca_result$x[, 1:2])  

#Add cluster assignments as a factor variable
pca_scores$Cluster <- as.factor(cluster_assignments) 

#Visualization
ggplot(pca_scores, aes(x = PC1, y = PC2, color = Cluster)) +
  geom_point() +
  labs(x = "Principal Component 1", y = "Principal Component 2", color = "Cluster")

#Cluster 2's compactness implies a higher degree of homogeneity among its members in terms of spending patterns.
#Clusters 1 and 3 being spread out suggest greater heterogeneity, with potentially different subgroups or segments within each cluster exhibiting varied spending behaviors.
