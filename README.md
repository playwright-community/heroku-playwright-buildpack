# Heroku Playwright Buildpack

This buildpack installs all of the necessary dependencies to use Playwright with Chromium and Firefox on Heroku.

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/mxschmitt/heroku-playwright-example)

## Usage

To use this buildpack, you must add the buildpack **before** installing your Node.js dependencies.

```txt
heroku buildpacks:set https://github.com/mxschmitt/heroku-playwright-buildpack.git -a my-app
```

For a full example, see [here](https://github.com/mxschmitt/heroku-playwright-example).

It's common to use the `PLAYWRIGHT_BUILDPACK_BROWSERS` environment variable, which accepts a comma-separated list of the browser names (`chromium`, `firefox`, `webkit`). By default, it installs the dependencies for all of the browsers. To only install Chromium dependencies, for example, just set it to `chromium`. This approach will reduce the slug size.

You should also install the browser-specific NPM packages like `playwright-chromium` to reduce the slug size.

## Examples

### Chromium

To use Chromium, it's **necessary** to use `chromiumSandbox: false` in the launch options because Heroku does not support the Chromium sandbox.

```javascript
const { chromium } = require("playwright-chromium");

(async () => {
  const browser = await chromium.launch({ chromiumSandbox: false });
  const context = await browser.newContext();
  const page = await context.newPage();
  await page.goto("http://whatsmyuseragent.org/");
  await page.screenshot({ path: `chromium.png` });
  await browser.close();
})();
```

### Firefox

For Firefox, you can refer to the official examples; no need to adjust any configurations.

```javascript
const { firefox } = require("playwright-firefox");

(async () => {
  const browser = await chromium.launch();
  const context = await browser.newContext();
  const page = await context.newPage();
  await page.goto("http://whatsmyuseragent.org/");
  await page.screenshot({ path: `firefox.png` });
  await browser.close();
})();
```

## Best practices

It's common to only install the [browser-specific NPM packages](https://playwright.dev/#version=v1.1.1&path=docs%2Finstallation.md&q=download-single-browser-binary), which will reduce installation time and slug size on Heroku in the end. It should reduce the slug size.

If you encounter this error at runtime, it means that you are missing the chromium binary, which can be installed with `playwright install chromium`.

```
browserType.launch: Executable doesn't exist at /app/node_modules/playwright-core/.local-browsers/chromium-1012/chrome-linux/chrome
╔═════════════════════════════════════════════════════════════════════════╗
║ Looks like Playwright Test or Playwright was just installed or updated. ║
║ Please run the following command to download new browsers:              ║
║                                                                         ║
║     npx playwright install                                              ║
║                                                                         ║
║ <3 Playwright Team                                                      ║
╚═════════════════════════════════════════════════════════════════════════╝
```

You can incorporate it into Heroku's build step by including this script in the `package.json` file.

```
"scripts": {
  "heroku-cleanup": "yarn run playwright install [chromium | webkit | firefox]"
}
```
