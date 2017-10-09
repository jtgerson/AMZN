with whatever as
(
select
distinct
dc.customer_key

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

left join fct_membership_accum fma
on oi.customer_key= fma.customer_key
  
where 1=1
and dc.active_flag = 'Y'
and dd.date_value >= sysdate-365
and od.sale_type_desc not in ('EXCLUDE', 'N/A', 'UNKNOWN')
and os.order_status_key = 7
and dc.current_customer_id != -2
and dm.partner_id = 1
and dp.purchase_product_group = 'CONTENT'
and length(dp.product_id) in (14, 16)
and dp.product_status = 'Ready for Export'
)

select
distinct
fls.customer_key
,sum(fls.event_duration) seconds

from audible_dw.fct_listening_stats fls

join whatever ca
on ca.customer_key = fls.customer_key

join audible_dw.dim_listening_device dld   
on fls.listening_device_key = dld.listening_device_key

join audible_dw.dim_marketplace dm 
on fls.marketplace_key = dm.marketplace_key

join dim_date dd                   
on fls.local_start_date_key = dd.date_key

join dim_product dp
on fls.product_key = dp.product_key

where 1=1
and fls.local_start_date_key between 20160801 and 20160831 --time
and event_duration < 86400
and event_duration > 60
and fls.listening_event_ct = 1
and dp.purchase_product_group = 'CONTENT'
and dp.product_status = 'Ready for Export'
and length(dp.product_id) in (14, 16)

group by
fls.customer_key
