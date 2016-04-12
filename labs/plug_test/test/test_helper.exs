ExUnit.start

Mix.Task.run "ecto.create", ~w(-r PlugTest.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r PlugTest.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(PlugTest.Repo)

