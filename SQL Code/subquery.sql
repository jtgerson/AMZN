with cats as ( --truncated categories
select 
distinct 
xrf.product_key,
dpc.product_ctgry_name,
dpc.product_subcat_name

from xrf_product_category xrf 

inner join dim_product_category dpc 
on dpc.product_ctgry_key = xrf.product_ctgry_key

where 1=1
and xrf.active_flag = 'Y' 
and xrf.primary_ctgry_flag = 'Y'
and dpc.active_flag = 'Y') 

select
cats.product_ctgry_name
,cats.product_subcat_name
,sum(oi.units) units

from fct_vw_unified_order_item oi

left join cats
on cats.product_key = oi.product_key

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

where 1=1
and od.sale_type_desc not in ('EXCLUDE')
and os.order_status_key = 7
and mk.marketplace_id in (91470)
and dd.yr_num in (2017)

group by
cats.product_ctgry_name
,cats.product_subcat_name
