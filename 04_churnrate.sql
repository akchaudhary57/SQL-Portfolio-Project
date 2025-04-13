-- Churn rate -- 
-- Customer retention -- who are not purchasing recently -- churn rate
-- Active Customer -- Customer who made a purchase with in last 6 month
-- Churned Customer -- Customer who hasn't made a purchase in over 6 months.

-- lastorderdate k ho? -- client wise
with getlastpurchase as (
select 
row_number() over (partition by customerkey order by cast(orderdate as date) desc) as rn,
*
from client_revenue
)
select  
*,
case when orderdate < dateadd(month,-6,'2017-06-30') then 'Churn' else 'Active' end as customer_status
into churndate
from getlastpurchase 
where rn = 1