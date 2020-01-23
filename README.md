# Customer-Quality-Prediction
To determine which set of customers the marketing firm should contact to maximize profit.

## Problem Set
The insurance company has provided a historical data set (training.csv). The company has also provided with a list of potential
customers to whom to market (testingCandidate.csv). From this list of potential customers, one needs to determine whether the customers should be targeted for marketing.

## Given Information
The cost of marketing to a particular customer is $30. This cost is paid regardless of whether the customer responds to our marketing or
not.
Only if a customer responds to our marketing, do we earn a profit.
Profit does NOT include the marketing cost.
Total Profit = Average profit per responding Customer * Number of customers responding – Number of customers to whom you marketed* $30.

## Few Observations
1. The percentage of negative and positive response  to the marketing campaign were  88.83% and  11.17% respectively. 
This imbalance is needed to handled for more accurate prediction.
2. Highly correlated variables with the threshold of 80% needs to be removed
3. The mean age of customers who are responding and not responding lies in the age group 39-41 years.
4. On an average, the number of times the customers were contacted was 2-3 times. 
5. It seems that campaign is not a very important variable for predicting the response. 
6. The pdays (days since the customer was last contacted) is understandably lower for the customers who responded to the marketing campaign. 
7. The lower the pdays, the better the memory of the last contact and hence the better chances of response to the marketing campaign.
8. Technicians, admins and blue collars respond the most to the marketing campaigns while housemaid, unemployed and students respond the least to these marketing campaigns
9. Illiterate person doesn’t respond to the marketing campaigns at all
10. A person who is single responds the most to the marketing campaigns as compared to a divorced or married person
11. The response of the customers doesn’t vary according to which day they have been contacted. 
However, it does vary with respect to the months they have been contacted. 
12. The Age of the customer is highly skewed to the right. This suggests that this column contains outliers. 
13. With respect to the months, the customers are least likely to respond in the month of May, followed by July and August. 

## Models Implemented
1. Three models – Logistic Regression, Decision Tree and Random Forest were implemented to evaluate the best classifier. 
2. When comparing the results of the model, Logistic Regression was able to classify the correct positive response rate better than the 
other models(Recall score = 65% ) and there fore this model was chosen to predict the response rate. 

## What the Prediction says
1. A customer with higher CPI are 22.26 times more likely to respond to the marketing campaigns. 
2. A customer contacted in the month of March are 10.28 times more likely to respond to the marketing campaign, followed by September, August, October and April.
3. A customer contacted via Cell phones are 2.5 times more likely to respond to the marketing campaign
4. Customers who have high EVR are 0.14 times less likely to respond to marketing campaign
5. Customers who have been contacted previous to the campaign are 0.71 times less likely to respond to the marketing campaign

## Recommendations
1. March, September, August, October and April are the best months for getting good responds from the customers.
2. Customers should be contacted via Cellular phones for getting best results
3. Targeting customers with higher CPIs will give better response to the marketing campaigns 
4. Customers who have been contacted previously before the campaign should not be contacted as it can reduce the response rate. 


 
