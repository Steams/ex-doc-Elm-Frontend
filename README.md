# ExDoc Elm Frontend (work in progress)

ExDoc is a tool to generate documentation for your Elixir projects. In case you are looking for documentation for Elixir itself, [check out Elixir's website][elixir-lang].

This fork contains a rewrite of ExDoc to port all javascript and markdown concerns to a new Elm application.

The Elm application must be compiled and the resulting js file (elm_main.js) placed in the html formatters distribution assets folder (this file is already in place when you pull the repo, this step needs to be performed only if you edit the elm application code). After this is done, clean and re-compile the project with mix and use it as normal (as specified in the Using ExDoc Via Command Line section below)

```bash
cd ex_doc/elm_frontend
elm-make src/Main.elm --output=../priv/ex_doc/formatter/html/assets/dist/elm_main.js
 
```

## Status as of this commit
Currently the Elm application renders a sidebar
component in place of the sidebar_template in formatter/html/templates.

The Elm sidebar at current retains all the stylings and class names of
the previous template but the functionality implement consists only of
opening and closing the sidebar, and selecting the category. Rendering
the nodes is not yet implemented as of this commit. Animations are also
not implemented.

The Elm project should be compiled and placed in
priv/ex_doc/formatter/html/assets/dist. This will be integrated into the build system in a future commit.


## Using ExDoc via command line

You can ExDoc via the command line as follows:

1. First clone and compile it:

    ```console
    $ git clone https://github.com/elixir-lang/ex_doc.git
    $ cd ex_doc
    $ mix do deps.get, compile
    ```

2. Then you are ready to use it in your projects. First, move into your project directory and make sure it is already compiled:

    ```console
    $ cd PATH_TO_YOUR_PROJECT
    $ mix compile
    ```

3. Next invoke the ex_doc executable from your project:

    ```console
    $ PATH_TO_YOUR_EXDOC/bin/ex_doc "PROJECT_NAME" "PROJECT_VERSION" path/to/project/ebin -m "PROJECT_MODULE" -u "https://github.com/GITHUB_USER/GITHUB_REPO" -l path/to/logo.png
    ```

4. By default, ex_doc produces HTML files, but, you can also create a EPUB document passing the option `--formatter epub`:

    ```console
    $ PATH_TO_YOUR_EXDOC/bin/ex_doc "PROJECT_NAME" "PROJECT_VERSION" path/to/project/ebin -m "PROJECT_MODULE" -u "https://github.com/GITHUB_USER/GITHUB_REPO" -l path/to/logo.png -f epub
    ```

For example, here are some acceptable values:

    PROJECT_NAME    => Ecto
    PROJECT_VERSION => 0.1.0
    PROJECT_MODULE  => Ecto (the main module provided by the library)
    GITHUB_USER     => elixir-lang
    GITHUB_REPO     => ecto

## Auto-linking

ExDoc will automatically generate links across modules and functions if you enclose them in backticks:

  * By referring to a module, function, type or callback from your project, such as `` `MyModule` ``, ExDoc will automatically link to those
  * By referring to a module, function, type or callback from Elixir, such as `` `String` ``, ExDoc will automatically link to Elixir's stable documentation
  * By referring to a module or function from erlang, such as (`` `:erlang` ``), ExDoc will automatically link to the Erlang documentation
  * By referring to a module, function, type or callback from any of your dependencies, such as `` `MyDep` ``, ExDoc will automatically link to that dependency documentation on [hexdocs.pm](http://hexdocs.pm/) (the link can be configured by setting `docs: [deps: [my_dep: "https://path/to/docs/"]]` in your `mix.exs`)

ExDoc supports linking to modules (`` `MyModule` ``), functions (`` `MyModule.function/1` ``), types (`` `t:MyModule.type/2` ``) and callbacks (`` `c:MyModule.callback/3` ``). If you want to link a function, type or callback in the current module, you may skip the module name, such as `` `function/1` ``.

## Changing the Markdown tool

In the examples above, we have used [Earmark][] to convert Markdown to HTML. If you prefer, you can also use hoedown (in C) or cmark (in C).

### Hoedown

Hoedown is a standard compliant Markdown parser written in C.  To use hoedown, add the elixir NIF wrapper [markdown][devinus/markdown] as a dependency to your project:

```elixir
{:markdown, github: "devinus/markdown"}
```

Update your project configuration to use hoedown:

```elixir
config :ex_doc, :markdown_processor, ExDoc.Markdown.Hoedown
```

### Cmark

[Cmark][cmark] is a CommonMark parser written in C. To use cmark add the elixir NIF wrapper [cmark.ex][cmark.ex] as a dependency to your project:

```elixir
{:cmark, "~> 0.6", only: :dev}
```

Update your project configuration to use Cmark:

```elixir
config :ex_doc, :markdown_processor, ExDoc.Markdown.Cmark
```

# License

ExDoc source code is released under Apache 2 License. The generated contents, however, are under different licenses based on projects used to help render HTML, including CSS, JS, and other assets.

Check the [LICENSE](LICENSE) file for more information.


[coverage-status]: https://coveralls.io/github/elixir-lang/ex_doc?branch=master
[build-status]: http://travis-ci.org/elixir-lang/ex_doc
[earmark]: http://github.com/pragdave/earmark
[elixir-lang]: http://elixir-lang.org/
[cmark]: https://github.com/jgm/cmark
[cmark.ex]: https://github.com/asaaki/cmark.ex
[devinus/markdown]: http://github.com/devinus/markdown
