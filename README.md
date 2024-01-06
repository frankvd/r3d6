# R3D6

This repository is split up into 3 projects:

- `parser/` contains a ruby gem that can parse and evaluate dice roll expressions such as `4d6d1 + 3`
- `api/` is a simple web server that uses the `r3d6-parser` gem to evaluate dice roll expressions:
  - https://r3d6-api.treegnome.tech/4d6+d1+3
- `web/` includes two fronteds that use the `api`. A REPL like interface and a UI built with [Lit](https://lit.dev/):
  - https://r3d6-web.treegnome.tech/repl
  - https://r3d6-web.treegnome.tech
