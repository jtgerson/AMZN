select
p.parent_product_id
,p.product_title
,p.product_author
,p.product_narrator
,p.product_royalty_earner
,p.product_media_type
,p.product_running_time
,p.product_faithfulness
,greatest(p.product_first_online_date, p.product_strict_on_sale_date) as online_date

from dim_product p

where 1=1
and p.purchase_product_group ='CONTENT'
and p.product_availability ='ALL'
and p.product_status = 'Ready for Export'
and p.product_marketplace_id = 91470
and length(p.product_id) in (14,16)

group by
p.parent_product_id
,p.product_title
,p.product_author
,p.product_narrator
,p.product_royalty_earner
,p.product_media_type
,p.product_running_time
,p.product_faithfulness
,greatest(p.product_first_online_date, p.product_strict_on_sale_date)

------------------------------------------------------------------------------------------
select
count (distinct(p.parent_product_id))

from dim_product p

where 1=1
and p.purchase_product_group ='CONTENT'
and p.product_availability ='ALL'
and p.product_status = 'Ready for Export'
and p.product_marketplace_id = 91470
and length(p.product_id) in (14,16)
and p.product_running_time <=240

----------------------------------------------------------------------------------------
All titles with sales

with pr as (
select
pr.parent_product_id
,pr.product_title
,pr.product_author
,pr.product_narrator
,pr.product_royalty_earner
,pr.product_key
,pr.product_running_time
,pr.product_media_type
,pr.product_faithfulness  

from dim_product pr

where 1=1
and pr.product_marketplace_id = 91470
and length(pr.product_id) in (14,16)
and pr.product_status = 'Ready for Export'
and pr.product_availability = 'ALL'
and pr.purchase_product_group = 'CONTENT'
and pr.product_running_time <=240  
)

select
pr.parent_product_id
,pr.product_title
,pr.product_author
,pr.product_narrator
,pr.product_royalty_earner
,pr.product_running_time
,pr.product_media_type
,pr.product_faithfulness
,sum(oi.total_units)

from pr

left join (
select
dp.parent_product_id
,dd.yr_num
,sum(oi.total_units) total_units
  
from agg_daily_product_metrics oi

inner join dim_marketplace mk
on mk.marketplace_key = oi.marketplace_key

inner join dim_date dd
on dd.date_key = oi.local_date_key

inner join dim_product dp
on dp.product_key = oi.product_key

where 1=1  
and dp.purchase_product_group = 'CONTENT'
and mk.marketplace_id = 91470

group by 
dp.parent_product_id 
,dd.yr_num
) oi
on oi.parent_product_id = pr.parent_product_id

group by 
pr.parent_product_id
,pr.product_title
,pr.product_author
,pr.product_narrator
,pr.product_royalty_earner
,pr.product_running_time
,pr.product_media_type
,pr.product_faithfulness
