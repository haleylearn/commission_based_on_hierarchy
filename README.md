# Case Study: How To Calculate Commission Based On Hierarchy

* In this SQL Challenge the dataset contains four tables: user_transactions, user_mapping, leadership_bonus, level_bonus
 ![image](https://github.com/haleylearn/commission_based_on_hierarchy/blob/main/diagram.png)

# Overview:
This case study uses SQL Server. To successfully answer all the questions one should have exposure to the following areas of SQL:
* Basic aggregations
* Sub Queries
* Joins
* CTEs
* Recursive

![image](https://github.com/haleylearn/commission_based_on_hierarchy/blob/main/hierarchy.jpg)
![image](https://github.com/haleylearn/commission_based_on_hierarchy/blob/main/explain_calculate_RI_RB.png)

(Assume that each node only brings in invested_amount only 100 USD)

# Calculate RI:
Node X has :
* Level 1 > 10 + 10 ( A + B )
* Level 2 > 3 + 3 + 3 +3 + 3 ( c + d + e + f )
* Level 3 > 8 times 2 ( g + h + i + j + k + l + m + n)
* Level 4 > 16 × 2 ( O to A5)

RI of X = 10+10+3+3+3+3+2+2+2+2+2+2+2+2+2+2+2+2+2+2+2+2+2+2+2+2+2+2+2+2 = 80


Node A has : 
* Level 1 > 10 +10 (C+D)
* Level 2 > 3+3+3+3 (g + h + i + j)
* Level 3 > 2+2+2+2+2+2+2+2 ( q + p + q + r + s + t + u + v + w)
  
RI of A = 10+10+3+3+3+3+2+2+2+2+2+2+2+2 = 48

Same to calculate another B, C, D, ....

# Calculate RB:
RB of X = 4.8 + 4.8 + 1.6 + 1.6 +1.6 +1.6 + 1 +1 + 1 + 1 +1 +1 +1 + 1 

(4.8 means 48 is the RI of child user A)

* 1st 4.8 = A RI 48 * ld_level_percentage( this percentage from leadership bonus table) as A belongs to level 1 for X so the value is 4.8)
* 2nd 4.8 = B RI 48 * ld_level_percentage
* 3rd 1.6 = C RI * ld_level_percentage
* 4th ( 1  ) = G RI * ld_level_percentage 

# Questions
1) Calculate RI(Referal_Income: To find the referral income of given user all child records invested amount)
2) Calculate RB(Referal_Bonus: To find the referral bonus of the given user_id)
   
