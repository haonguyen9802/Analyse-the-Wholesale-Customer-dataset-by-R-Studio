# Wholesale Customers Segmentation Analysis
This project analyzes the Wholesale Customers dataset to uncover the distribution and relationships among key variables, including Channel, Region, and spending categories like Fresh, Milk, Grocery, Frozen, Detergents_Paper, and Delicassen. By applying exploratory data analysis, correlation analysis, and clustering techniques, this project aims to identify distinct customer segments based on purchasing behavior, providing valuable insights into customer profiles and spending patterns.

## Steps and Techniques
### Data Preparation
Loaded the dataset and conducted a preliminary check for missing values. Converted categorical variables (Channel and Region) to factors for analysis.
### Exploratory Data Analysis (EDA):
* Generated summary statistics to gain a comprehensive view of the dataset.
* Visualized the distribution of spending in each product category using histograms.
### Correlation Analysis:
* Calculated a correlation matrix to explore relationships between product categories.
* Visualized correlations using ggcorrplot, highlighting notable associations among product categories.
### Clustering Analysis:
* Applied k-means clustering (with 3 clusters) to segment customers based on their spending profiles.
* Analyzed each cluster by calculating mean spending values, uncovering distinct segments that differ in their purchasing behavior.
### Principal Component Analysis (PCA):
* Performed PCA on the spending data (excluding Channel and Region) to reduce dimensionality for effective visualization.
* Visualized the clusters along the first two principal components.
  
## Key Insights
* Customer Segments: The k-means clustering and PCA revealed clear customer segments, providing insight into the composition and spending behaviors of different customer types.
* Spending Correlations: Notable positive correlations between certain categories (e.g., Milk, Grocery, and Detergents_Paper) suggest complementary spending trends among customers.
