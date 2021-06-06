# Pewlett-Hackard-Analysis

### Resources
- PostgreSQL 12.7, pgAdmin 4
- CSV files used for SQL database: [Resources](https://github.com/adampaseltiner/Pewlett-Hackard-Analysis/tree/main/Data)

## Overview

The purpose of this project was to use SQL to perform analysis on the employees of Pewlett-Hackard to determine which employees are eligible for retirement and how those numbers might affect the company's decisions regarding employment and mentorship in the future.

## Results

### Employees Eligible For Retirement
![Retiring_Titles](https://user-images.githubusercontent.com/82347825/120905822-c4549f80-c622-11eb-8b0a-d724dc6767fe.png)

- We were able to determine that out of the 300,024 employees at Pewlett-Hackard that the above 90,397 employees (or 30.12%) are eligibile for retirement. 

- Analyzing these retirement eligible employees by job title shows that a majority of them are Engineers or Staff, which comprises 28.04% of the total number of employees.

- There are only 2 managers who are eligible to retire, which would make training younger employees for management positions an easier process.

### Employees Eligible For Mentorship Program
![Eligible_mentor_by_title](https://user-images.githubusercontent.com/82347825/120931574-2ca58e80-c6c0-11eb-899b-2d0fc8bde006.png)

- Out of all the employees eligible for retirement, only 1,549 are also eligible for the mentorship program.



## Summary

After completing our analysis it is now clear that Pewlett-Hackard have an alarmingly high number of employees (90,397) that could choose to retire at any moment. This "silver tsunami" could potentially leave an incredibly large gap in the Pewlett-Hackard workforce, especially when considering this number of retirement eligible employees compiles 30% of all employees.

When looking at the mentorship program, it does not appear as if Pewlett-Hackard is very well prepared since only 1,549 of retirement-ready employees would be qualified to train the next generation of Pewlett-Hackard employees.

### Two Additional Queries:

The following queries would also provide more insight into the upcoming "silver tsunami":

- Looking at the departments where the most employees are eligible to retire, we see that the Development, Production and Sales teams yield the highest totals.

![Retiring_by_dept_code](https://user-images.githubusercontent.com/82347825/120931017-bc960900-c6bd-11eb-8585-f5c61adf5de7.png)

![Retiring_by_dept](https://user-images.githubusercontent.com/82347825/120927254-3b834580-c6ae-11eb-8e20-5bbc6bd847eb.png)

- We can also run a query to show the total amount in salary that is currently being earned by eligible retirees. The company can assume that younger, newer, and less experienced employees stand to earn a significantly lower amount than their retirees and the company can stand to make money over the long run as long as they keep the hiring costs of new employees lower than the total of the salaries coming off the books.

![Retiring_by_salary_code](https://user-images.githubusercontent.com/82347825/120931049-e6e7c680-c6bd-11eb-9065-806d89cb66c8.png)

![Retiring_by_salary](https://user-images.githubusercontent.com/82347825/120927705-cadd2880-c6af-11eb-886b-18c18a48b3b5.png)
