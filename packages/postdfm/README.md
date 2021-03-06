# postdfm

> Process over Delphi Forms (.dfm) files via an AST.
>
> Inspired by the excellent PostCSS tool, motivated by my rage at the Delphi IDE.

[![npm](https://img.shields.io/npm/v/postdfm.svg?label=npm)](https://www.npmjs.com/package/postdfm)
[![CircleCI branch](https://img.shields.io/circleci/project/github/spiltcoffee/postdfm/master.svg)](https://circleci.com)
[![Codecov branch](https://img.shields.io/codecov/c/gh/spiltcoffee/postdfm/master.svg)](https://codecov.io)
[![Known Vulnerabilities](https://snyk.io/test/github/spiltcoffee/postdfm/badge.svg?targetFile=packages/postdfm/package.json)](https://snyk.io/test/github/spiltcoffee/postdfm?targetFile=packages/postdfm/package.json)

## Table of Contents

- [Installation](#installation)
- [Example Usage](#example-usage)
- [Reference](#reference)
- [Contributing](#contributing)
- [License](#license)

## Installation

The `postdfm` project is an interface wrapping all the separate modules together.

```shell
# npm
$ npm install postdfm

# yarn
$ yarn add postdfm
```

## Example Usage

```js
const fs = require("fs");
const postdfm = require("postdfm");

const cisDfm = fs.readFileSync(
  "cis.dfm",
  //.dfm files tend to be ascii instead of utf8
  "ascii"
);

const runner = postdfm({
  transformers: [
    function(ast) {
      //transform and return the ast
      return transformedAst;
    }
  ]
});

const transDfm = runner.processSync(dfm, {
  //filename used for reporting errors
  from: "cis.dfm"
});

fs.writeFileSync("trans.dfm", transDfm);
```

## Reference

### `Runner` instance

Create a runner by calling the `postdfm` function.

```js
const postdfm = require("postdfm");
const runner = postdfm();
```

#### `postdfm(options?: RunnerOptions)`

Create a `Runner` instance using `RunnerOptions`

#### `runner.process(dfm: string, processingOptions: ProcessingOptions): Promise<string>`

Process a file through the runner asynchronously.

#### `runner.processSync(dfm: string, processingOptions: ProcessingOptions): string`

Process a file through the runner synchronously.

### `RunnerOptions`

Options to pass to an instance of `Runner`.

#### `options.transformers: Transformer[]`

Array of transformations to perform on AST.

#### `options.parser: Parser = "@postdfm/dfm2ast"`

Parser to use, defaults to `@postdfm/dfm2ast`.

#### `options.stringifier: Stringifier = "@postdfm/ast2dfm"`

Stringifier to use, defaults to `@postdfm/ast2dfm`.

### `Transformer`

A function that takes an AST, transforms it, and returns it.

```js
(ast: AST.Root): AST.Root
```

### `Parser`

A function that takes a string, parses it, and returns an AST.

```js
(dfm: string): AST.Root
```

### `Stringifier`

A function that takes an AST, stringifies it, and returns a string.

```js
(ast: AST.Root): string
```

### `ProcessingOptions`

#### `processingOptions.from`

The file which is being processed. Used when throwing syntax errors.

## Generated Documentation

You can find the generated `typedoc` documentation [here](https://spiltcoffee.com/docs/postdfm/).

## Contributing

Bug reports and feature requests are greatly appreciated, as are pull requests.

Please see the [Contributing Guide](https://github.com/spiltcoffee/postdfm/blob/master/.github/CONTRIBUTING.md) for instructions on how to contribute to this project.

## License

Licensed under the MIT License.
