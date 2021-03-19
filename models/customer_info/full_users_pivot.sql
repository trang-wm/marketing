{{ config (
    materialized="table"
)}}
with full_users_pivot as (
(select user_tracking_id, 
  user_email,
  user_id, 
  user_registered, 
  first_name,  last_name, 
  billing_phone, billing_city, billing_state, 
  billing_country, 
  billing_postcode, 
  shipping_city, shipping_state, shipping_country, shipping_postcode, 
  wc_last_active, 
  django_user, 
  trial_date_start  , 
  _schedule_trial_end, _schedule_cancelled, _schedule_next_payment, 
  billing_cycles,
  post_status, 
  full_order_id, 
  first_product_id as first_order_id, latest_product_id as latest_order_id, 
  mktg_affiliate, 
  first_aff_id, latest_aff_id,
  total_amount, 
  order_shipping, order_tax, 
  products_purchased, 
  members_revenue as member_revenue, 
  ecommerce_revenue, 
  number_orders,
  digital_programs,
  type_customer as type_customers, 
  'no' as alpha_testers
from  {{ ref('users_pivot_woo') }} )
UNION ALL 
(select cast(user_tracking_id as string) as user_tracking_id, 
  user_email, 
  user_id, 
  cast(NULLIF(user_registered,'') as timestamp) as user_registered,
  first_name, last_name, 
  billing_phone, billing_city, billing_state, 
  billing_country, 
  billing_postcode, 
  shipping_city, shipping_state, shipping_country, shipping_postcode, 
  wc_last_active, 
  django_user, 
  trial_date_start, 
  _schedule_trial_end, _schedule_cancelled, _schedule_next_payment, 
  billing_cycles,
  post_status, 
  full_order_id, 
  first_order_id, latest_order_id, 
  mktg_affiliate, 
  cast(first_aff_id as string) as first_aff_id, 
  cast(latest_aff_id as string) as latest_aff_id,
  total_amount, 
  order_shipping, order_tax, 
  products_purchased, 
  member_revenue, 
  ecommerce_revenue,
  number_orders, 
  null as digital_programs, 
  type_customers, 
  'no' as alpha_testers
from  {{ ref('users_pivot_kon') }} ) )

select distinct * from full_users_pivot