select
count(distinct
dc.customer_key)
,sum(oi.units)

from fct_order_item_purchase oi

inner join dim_product dp
on oi.product_key = dp.product_key

inner join dim_marketplace dm
on oi.marketplace_key = dm.marketplace_key

inner join dim_order_detail od
on od.order_detail_key = oi.order_detail_key

inner join dim_order_status os
on os.order_status_key = oi.order_status_key

inner join dim_date dd
on dd.date_key = oi.local_order_placed_date_key

inner join dim_customer dc
on oi.customer_key = dc.customer_key

where 1=1
and dc.active_flag = 'Y'
and dd.date_value >= sysdate-367
and od.sale_type_desc not in ('EXCLUDE', 'N/A', 'UNKNOWN')
and os.order_status_key = 7
and dc.current_customer_id != -2
and dm.partner_id = 1
and dp.purchase_product_group = 'CONTENT'
and length(dp.product_id) in (14, 16)
and dp.product_status = 'Ready for Export'
and dc.reg_marketplace_id = 91470
and dp.parent_product_id = 'BK_POTR_000001'
