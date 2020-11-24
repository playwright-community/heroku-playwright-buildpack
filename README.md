# Heroku Playwright Buildpack

This buildpack installs all the needed dependencies to use Playwright with Chromium and Firefox on Heroku.

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/mxschmitt/heroku-playwright-example)

## Usage

For using this buildpack, you have to add the buildpack **before** installing your Node.js dependencies.

```txt
heroku buildpacks:set https://github.com/mxschmitt/heroku-playwright-buildpack.git -a my-app
```

For a full example, see [here](https://github.com/mxschmitt/heroku-playwright-example) a usage with the Express library.

It's common to use the `PLAYWRIGHT_BUILDPACK_BROWSERS` environment variable which accepts a comma-separated list of the browser names (`chromium`, `firefox`, `webkit`). By default, it's installing the dependencies for all the browsers. To only install Chromium dependencies for example, just set it to `chromium`. This will reduce the slug size in the end too.

You should also install the browser specific NPM packages like `playwright-chromium.` to reduce the slug size.

## Examples

### Chromium

For using Chromium, it's **necessary** to use `chromiumSandbox: false` in the launch options, since on Heroku is no support for the Chromium sandbox.

```javascript
const { chromium } = require("playwright-chromium");

(async () => {
  const browser = await chromium.launch({ chromiumSandbox: false });
  const context = await browser.newContext();
  const page = await context.newPage();
  await page.goto('http://whatsmyuseragent.org/');
  await page.screenshot({ path: `chromium.png` });
  await browser.close();
})();
```

### Firefox

For Firefox, you can refer to the official examples, no need to adjust any configurations.

```javascript
const { firefox } = require("playwright-firefox");

(async () => {
  const browser = await chromium.launch();
  const context = await browser.newContext();
  const page = await context.newPage();
  await page.goto('http://whatsmyuseragent.org/');
  await page.screenshot({ path: `firefox.png` });
  await browser.close();
})();
```

## Best practises

It's common to only install the [browser-specific NPM packages](https://playwright.dev/#version=v1.1.1&path=docs%2Finstallation.md&q=download-single-browser-binary), which will reduce installation time and slug size on Heroku in the end, that should fix also the error that the slug size is too large.
