use Mix.Config

config :phoenix, Todo.Router,
  port: System.get_env("PORT"),
  ssl: false,
  code_reload: false,
  cookies: true,
  session_key: "_todo_key",
  session_secret: "*^NIP!4^IBXLYT4K*D()J%I1SM!^OSL_T&L3MI$8!Q111W)3VC3V@WRTE#I99P#1FSP&QQ"

config :phoenix, :logger,
  level: :error

