# Writing Documentation
Documentation is written as markdown files and rendered using [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/getting-started/).  
To create versioned documentation, use [Mike](https://squidfunk.github.io/mkdocs-material/setup/setting-up-versioning/).  
Documentation lives in the `docs/` folder in the root of the repository.

## Setting up MkDocs
1. First, initialise the docs folder and configuration `mkdocs.yml` file.

        mkdocs new .

1. Then, set the default docs to latest (enables redirect from root)

        mike set-default --push latest

1. Lastly, deploy the current docs to GitHub with the correct version and alias `latest`

        mike deploy --push --update-alises 0.0 latest

1. Optionally, copy the configuration file, styles and images from this repository (details of differences to come).

## Viewing rendered docs
Hot reloading means that changes to markdown files are quickly rendered on a locally served web page.
```bash
mkdocs serve
```

## Maintaining latest docs
The markdown files in the `docs` folder at a given commit should reflect the behaviour of the tool at that commit.

## Publishing
MkDocs generates static websites so the documentation can be made available for public consumption using any web server. For convenience, MkDocs and Mike come with commands which integrate with GitHub.

