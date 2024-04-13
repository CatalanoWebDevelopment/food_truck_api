defmodule Mix.Tasks.Gen.Doc do
  use Mix.Task

  @shortdoc "Generates docs and pushes them to the /docs directory"

  def run(_args) do
    Mix.Task.run("deps.get")
    Mix.Task.run("docs", ["--output", "docs"])

    {status, _output, _} =
      System.cmd("git", ["add", "docs"], into: IO.stream(:stdio, :line))

    if status == 0 do
      System.cmd("git", ["commit", "-m", "Update documentation"], into: IO.stream(:stdio, :line))
      System.cmd("git", ["push", "origin", "HEAD"], into: IO.stream(:stdio, :line))
    else
      Mix.shell().error("Failed to add docs to git.")
    end
  end
end
