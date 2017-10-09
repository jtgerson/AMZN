select
p.product_royalty_earner
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
and (p.product_royalty_earner like'Hachette Audio'
or p.product_royalty_earner like 'Hachette - Hyperion'
or p.product_royalty_earner like 'Harper Audio'
or p.product_royalty_earner like 'Harper Audio (Learning Services)'
or p.product_royalty_earner like 'HarperCollins Canada'
or p.product_royalty_earner like 'Zondervan'
or p.product_royalty_earner like 'Zondervan - Thomas Nelson'
or p.product_royalty_earner like 'Macmillan Audio'     
or p.product_royalty_earner like 'Random House Audio'
or p.product_royalty_earner like 'Penguin Audio'
or p.product_royalty_earner like 'The Princeton Review'
or p.product_royalty_earner like 'Books on Tape'
or p.product_royalty_earner like 'Listening Library'     
or p.product_royalty_earner like 'Living Language'
or p.product_royalty_earner like 'Multnomah'
or p.product_royalty_earner like 'Simon & Schuster - DLP'
or p.product_royalty_earner like 'Simon & Schuster - Dylan'
or p.product_royalty_earner like 'Simon & Schuster - Pimsleur')
and dd.date_value between '24-June-2016' and'24-June-2017'
and od.sale_type_desc = 'ALC'
and p.product_running_time >=300
--and mk.partner_id =1 (this is just audible ex iTunes)

group by
p.product_royalty_earner
