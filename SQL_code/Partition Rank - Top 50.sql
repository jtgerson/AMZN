with best_sellers as(

select
p.parent_product_id
,p.product_name
,p.product_author
,p.product_narrator
,p.product_royalty_earner
,greatest(p.product_first_online_date, p.product_strict_on_sale_date) as online_date
,case when parent_product_id like'%ADBL%' then 'ADBL' else 'ACX' end provider 
,rank () over (partition by provider order by sum(oi.units)desc) as rnk_units
,sum(oi.units) total_units
,sum(oi.royalty_amt*fx.usd_conv_rate) royalty
  
from fct_vw_unified_order_item oi

inner join dim_order_detail od
on od.order_detail_key = oi.order_detail_key

inner join dim_order_status os
on oi.order_status_key = os.order_status_key

inner join dim_marketplace mk
on mk.marketplace_id = oi.marketplace_id

inner join dim_date dd
on dd.date_key = oi.local_order_placed_date_key

inner join dim_merchant dm
on dm.merchant_key = oi.merchant_key

inner join dim_fx_rate fx
on (fx.fx_rate_key=oi.fx_rate_key and oi.currency_code=fx.src_curr) 

inner join dim_product p
on oi.product_key = p.product_key

where 1=1
and od.sale_type_desc not in ('EXCLUDE')
and os.order_status_key = 7
and p.purchase_product_group ='CONTENT'
and p.product_availability ='ALL'
and p.product_status = 'Ready for Export'
and (p.parent_product_id like'%ADBL%' or p.parent_product_id like'%ACX%')
and dd.date_value >= sysdate-365
and mk.marketplace_id in (91470, 5600)
and greatest(p.product_first_online_date, p.product_strict_on_sale_date) between '01-01-17' and '06-30-17'

Group by
p.parent_product_id
,p.product_name
,p.product_author
,p.product_narrator   
,p.product_royalty_earner
,p.product_running_time
,greatest(p.product_first_online_date, p.product_strict_on_sale_date)

Order by
total_units Desc)

select *
from best_sellers

where 1=1
and rnk_units < 51
