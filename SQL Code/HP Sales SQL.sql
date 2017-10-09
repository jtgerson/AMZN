select
p.product_royalty_earner
,p.parent_product_id
,p.product_name
,dd.yr_mth_name
,mk.marketplace_id
,mk.marketplace_name
,case when dm.price_type = 'Hushpuppy' then 'WS4V' else 'NON-WS4V' end ws4v
,case when (od.sale_type_desc = 'ALC' and mk.partner_id = 2) then 'ITUNES' else od.sale_type_desc end sale_type
,sum(case when mk.partner_id = 2 then (oi.revenue_partner_amt*fx.usd_conv_rate) when (od.sale_type_desc != 'AL' and mk.partner_id = 1) then ((price_paid_by_customer_amt+consumed_credit_revenue_amt)*fx.usd_conv_rate)  else (oi.net_sales_amt*fx.usd_conv_rate) end) cogs_rev
,sum(oi.units) units
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
--and p.product_availability ='ALL'
and p.product_status = 'Ready for Export'
and p.product_royalty_earner like'%Pottermore%'
--and dd.date_value <= '30-September-2017'
--and od.sale_type_desc = 'ALC'
--and mk.partner_id =1 (this is just audible ex iTunes)

group by
p.product_royalty_earner
,p.parent_product_id
,p.product_name
,dd.yr_mth_name
,mk.marketplace_id
,mk.marketplace_name
,case when dm.price_type = 'Hushpuppy' then 'WS4V' else 'NON-WS4V' end
,case when (od.sale_type_desc = 'ALC' and mk.partner_id = 2) then 'ITUNES' else od.sale_type_desc end
