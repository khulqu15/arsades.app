UPDATE tenants
SET
  subscription_plan = 'basic',
  subscription_status = 'active',
  subscription_started_at = NOW(),
  subscription_ends_at = '2027-05-14 23:59:59',
  feature_config = JSON_OBJECT(
    'news', true,
    'onlineLetter', false,
    'finance', false,
    'letterC', false
  )
WHERE slug = 'martopuro';