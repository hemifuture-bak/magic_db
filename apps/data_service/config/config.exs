import Config

config :data_service,
  base_time: %DateTime{year: 2019, month: 9, day: 14, hour: 0, minute: 0, second: 0, microsecond: {0, 0}, time_zone: "Asia/Beijing", std_offset: 0, utc_offset: 0, zone_abbr: "CST"}

import_config "#{Mix.env}.exs"
