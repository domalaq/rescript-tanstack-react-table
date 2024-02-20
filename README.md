# rescript-tanstack-react-table

ReScript bindings for [@tanstack/react-table](https://tanstack.com/table/latest) (targeted version : `~8.12.0`)

## Setup

1. Install the module

```bash
bun install @dck/rescript-tanstack-react-table
# or
yarn install @dck/rescript-tanstack-react-table
# or
npm install @dck/rescript-tanstack-react-table
```

2. Add it to your `rescript.json` config

```json
{
  "bsc-dependencies": ["@dck/rescript-tanstack-react-table"]
}
```

## Usage

The functions can be accessed through `ReactTable` module.

### [Basic](https://github.com/DCKT/rescript-tanstack-react-table/blob/main/examples/src/Basic.res)

### [Pagination](https://github.com/DCKT/rescript-tanstack-react-table/blob/main/examples/src/Pagination.res)

### [Row Selection](https://github.com/DCKT/rescript-tanstack-react-table/blob/main/examples/src/RowSelection.res)

## Development

Install deps

```bash
bun install
```

Compiles files

```bash
bun run dev
```

Run examples

```bash
bun run examples
```
