select
p.parent_product_id
,p.product_name
,p.product_author
,p.product_narrator
,p.product_royalty_earner
,greatest(p.product_first_online_date, p.product_strict_on_sale_date) as online_date
,sum(case when dd.date_value >= sysdate-365 then oi.units else 0 end) T12_units
,sum(oi.units) ltd_units

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
and (lower (p.product_royalty_earner) like '%recorded books%'
or lower (p.product_royalty_earner) like '%tantor%'
or lower (p.product_royalty_earner) like '%highbridge%'
or lower (p.product_royalty_earner) like '%echristian%'
or lower (p.product_royalty_earner) like '%gildan%')
and primary_language_name = 'Spanish'

group by
p.parent_product_id
,p.product_name
,p.product_author
,p.product_narrator
,p.product_royalty_earner
,greatest(p.product_first_online_date, p.product_strict_on_sale_date)

order by
ltd_units desc
