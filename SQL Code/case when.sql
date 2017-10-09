select
sum(oi.units) units
,sum(case when((price_paid_by_customer_amt+consumed_credit_revenue_amt)*fx.usd_conv_rate) = 0 then oi.units else 0 end) free_units
,case when dm.marketplace_id in (91470, 5600) then 'us' else 'other' end region
,case when dp.product_royalty_earner like '%Blackstone%' then 'black' else 'other' end earner
,dd.yr_num
,dd.mth_num_in_yr

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

inner join dim_product dp
on oi.product_key = dp.product_key

where 1=1
and od.sale_type_desc not in ('EXCLUDE')
and os.order_status_key = 7
and dp.purchase_product_group ='CONTENT'
--and dp.product_availability ='ALL'
and dp.product_status = 'Ready for Export'
and dd.yr_num in (2012,2013,2014,2015,2016,2017)

group by
dd.yr_num
,dd.mth_num_in_yr
,case when dm.marketplace_id in (91470, 5600) then 'us' else 'other' end
,case when dp.product_royalty_earner like '%Blackstone%' then 'black' else 'other' end
