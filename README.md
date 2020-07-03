# Heroku Playwright Buildpack

This buildpack installs all the needed dependencies to use Playwright with Chromium and Firefox on Heroku.

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/mxschmitt/heroku-playwright-example)

## Usage

For using this buildpack, you have to add the buildpack **before** installing your Node.js dependencies.

```txt
heroku buildpacks:set https://github.com/mxschmitt/heroku-playwright-example -a my-app
```

For a full example, see [here](https://github.com/mxschmitt/heroku-playwright-example) a usage with the Express library.

## Best practises

It's common to only install the [browser-specific NPM packages](https://playwright.dev/#version=v1.1.1&path=docs%2Finstallation.md&q=download-single-browser-binary), which will reduce installation time and slug size on Heroku in the end, that should fix also the error that the slug size is too large.
