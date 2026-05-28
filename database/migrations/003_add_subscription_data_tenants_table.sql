ALTER TABLE tenants
  ADD COLUMN subscription_plan ENUM('free', 'basic', 'pro', 'enterprise', 'custom')
    NOT NULL DEFAULT 'basic'
    AFTER status,

  ADD COLUMN subscription_status ENUM('trialing', 'active', 'past_due', 'paused', 'canceled', 'expired')
    NOT NULL DEFAULT 'active'
    AFTER subscription_plan,

  ADD COLUMN subscription_started_at DATETIME NULL
    AFTER subscription_status,

  ADD COLUMN subscription_ends_at DATETIME NULL
    AFTER subscription_started_at,

  ADD COLUMN trial_ends_at DATETIME NULL
    AFTER subscription_ends_at,

  ADD COLUMN subscription_config JSON NULL
    AFTER trial_ends_at,

  ADD COLUMN feature_config JSON NULL
    AFTER subscription_config;

CREATE INDEX idx_tenants_subscription_status
ON tenants (
  subscription_plan,
  subscription_status,
  subscription_ends_at
);