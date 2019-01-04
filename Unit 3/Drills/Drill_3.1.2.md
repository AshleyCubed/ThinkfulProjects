# Unit 3 Lesson 1 Project 2
## DRILL: <br>
> Let's say we work at a credit card company and we're trying to figure out if people are going to pay their bills on time. We have everyone's purchases, split into four main categories: groceries, dining out, utilities, and entertainment. <br> 
What are some ways you might use KNN to create this model? <br>
What aspects of KNN would be useful? <br>

- If there is purchase information like dates and amounts, we can see if a person paid utilities and groceries around the same time simply by plotting the data. Using KNN you can see if the due date and amount due for the credit card has a higher probability of being treated as a utility bill rather than groceries, since utilities have specific due dates. <br> 
- By looking at the amount of each purchase, you can first create new categories, like priority - noting what purcheses are made most consistenly, and then see the probability of a creidt purchase being likely to land in the new priority category.<br>

- I think the most useful aspects of KNN are the amount of neighbors we'd want to include, especially if they're weighted. Also being able to see the probability of the credit bill data point being more similar to a category will help tailor the prediction.
