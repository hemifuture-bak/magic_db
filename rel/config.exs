# Import all plugins from `rel/plugins`
# They can then be used by adding `plugin MyPlugin` to
# either an environment, or release definition, where
# `MyPlugin` is the name of the plugin module.
~w(rel plugins *.exs)
|> Path.join()
|> Path.wildcard()
|> Enum.map(&Code.eval_file(&1))

use Distillery.Releases.Config,
    # This sets the default release built by `mix distillery.release`
    default_release: :default,
    # This sets the default environment used by `mix distillery.release`
    default_environment: Mix.env()

# For a full list of config options for both releases
# and environments, visit https://hexdocs.pm/distillery/config/distillery.html


# You may define one or more environments in this file,
# an environment's settings will override those of a release
# when building in that environment, this combination of release
# and environment configuration is called a profile

environment :dev do
  # If you are running Phoenix, you should make sure that
  # server: true is set and the code reloader is disabled,
  # even in dev mode.
  # It is recommended that you build with MIX_ENV=prod and pass
  # the --env flag to Distillery explicitly if you want to use
  # dev mode.
  set dev_mode: true
  set include_erts: false
  set cookie: :"NUWfurggm8n3Je$uHgv9>zw5q!3}85LX`x>1JUiTDOk$w(!WUMdw`507;h@[k6@X"
  set vm_args: "rel/vm.args.eex"
end

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :"Qo%k|*fa/Y|5p]LB9)!vJb./jRRh(k/hZWMcbHC7tuw5aqZ$F]{eVB.{5/JT)1aE"
  set vm_args: "rel/vm.args.eex"
  set config_providers: [
    {Distillery.Releases.Config.Providers.Elixir, ["${RELEASE_ROOT_DIR}/etc/config.exs"]}
  ]
end

# You may define one or more releases in this file.
# If you have not set a default release, or selected one
# when running `mix distillery.release`, the first release in the file
# will be used by default

release :data_contact do
  set version: current_version(:data_contact)
  set overlays: [
    {:copy, "apps/data_contact/rel/config/config.exs", "etc/config.exs"}
  ]
end

release :data_service do
  set version: current_version(:data_service)
  set overlays: [
    {:copy, "apps/data_service/config/release.exs", "etc/config.exs"}
  ]
end

release :data_store do
  set version: current_version(:data_store)
  set overlays: [
    {:copy, "apps/data_store/rel/config/config.exs", "etc/config.exs"}
  ]
end
