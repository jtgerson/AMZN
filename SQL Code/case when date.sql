select
dp.product_royalty_earner product_royalty_earner
,dp.product_first_online_date online_date
,case when dm.price_type = 'Hushpuppy' then 'WS4V' else 'NON-WS4V' end ws4v
,case when (od.sale_type_desc = 'ALC' and mk.partner_id = 2) then 'ITUNES' else od.sale_type_desc end sale_type
,sum(oi.units) units
,sum(case when mk.partner_id = 2 then (oi.revenue_partner_amt*fx.usd_conv_rate) when (od.sale_type_desc != 'AL' and mk.partner_id = 1) then ((price_paid_by_customer_amt+consumed_credit_revenue_amt)*fx.usd_conv_rate)  else (oi.net_sales_amt*fx.usd_conv_rate) end) cogs_rev
,sum(oi.royalty_amt*fx.usd_conv_rate) royalty
,sum((price_paid_by_customer_amt+consumed_credit_revenue_amt)*fx.usd_conv_rate) consumed_rev
,case when dd.date_value between '27-FEB-2017' and '12-MAR-2017' then 'pre_2week1'
when dd.date_value between '13-MAR-2017' and '26-MAR-2017' then 'pre_2week2'
when dd.date_value between '27-MAR-2017' and '02-APR-2017' then 'pre_2week3'
when dd.date_value between '15-MAY-2017' and '28-MAY-2017' then 'post_2week1'
when dd.date_value between '29-MAY-2017' and '11-JUN-2017' then 'post_2week2'
when dd.date_value between '12-JUN-2017' and '25-JUN-2017' then 'post_2week3'
else 'blackout' end date_range
,dp.product_price

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
and dd.date_value >='01-FEB-2017'
and (dp.product_royalty_earner like '%Hachette Audio%'or dp.product_royalty_earner like '%Hachette - Hyperion%')
and mk.marketplace_id in (91470, 5600)

group by
dp.product_royalty_earner
,dp.product_first_online_date
,case when dm.price_type = 'Hushpuppy' then 'WS4V' else 'NON-WS4V' end 
,case when (od.sale_type_desc = 'ALC' and mk.partner_id = 2) then 'ITUNES' else od.sale_type_desc end
,case when dd.date_value between '27-FEB-2017' and '12-MAR-2017' then 'pre_2week1'
when dd.date_value between '13-MAR-2017' and '26-MAR-2017' then 'pre_2week2'
when dd.date_value between '27-MAR-2017' and '02-APR-2017' then 'pre_2week3'
when dd.date_value between '15-MAY-2017' and '28-MAY-2017' then 'post_2week1'
when dd.date_value between '29-MAY-2017' and '11-JUN-2017' then 'post_2week2'
when dd.date_value between '12-JUN-2017' and '25-JUN-2017' then 'post_2week3'
else 'blackout' end
,dp.product_price
