select
p.parent_product_id
,p.product_royalty_earner
,p.product_running_time
,p.product_first_online_date
,p.product_strict_on_sale_date
,ntile(5) over (order by sum(oi.units)Desc) as rnk_units
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
and (p.product_royalty_earner like'%Brilliance%')

Group by
p.parent_product_id
,p.product_royalty_earner
,p.product_running_time
,p.product_first_online_date
,p.product_strict_on_sale_date

Order by
rnk_units ASC
