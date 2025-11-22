# R3D6
![Screenshot from 2024-01-06 14-48-17](https://github.com/frankvd/r3d6/assets/1485248/6723982b-f0e4-4aee-afe3-554cffcbcdc3)
*Screenshot of the REPL frontend hosted at https://r3d6-web.x.codetje.app/repl*

This repository is split up into 3 projects:

- `parser/` contains a ruby gem that can parse and evaluate dice roll expressions such as `4d6d1 + 3`
- `api/` is a simple web server that uses the `r3d6-parser` gem to evaluate dice roll expressions:
  - https://r3d6-api.x.codetje.app/4d6+d1+3
- `web/` includes two fronteds that use the `api`. A REPL like interface and a UI built with [Lit](https://lit.dev/):
  - https://r3d6-web.x.codetje.app/repl
  - https://r3d6-web.x.codetje.app
