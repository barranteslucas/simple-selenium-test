require('dotenv').config();

const debug = process.env.DEBUG === 'True';
const url = process.env.URL;
const query = process.env.QUERY;

console.log(`Debug mode: ${debug ? 'Enabled' : 'Disabled'}`);
console.log(`Searching on: ${url}`);
console.log(`Search query: ${query}`);

const { Builder, By, Key, Capabilities } = require('selenium-webdriver');
const chromedriver = require('chromedriver');
const chrome = require('selenium-webdriver/chrome');

process.env['PATH'] += `:${chromedriver.path}`;

(async function googleSearch() {
    let options = new chrome.Options();
    if (!debug) {
        options.addArguments('headless');
        options.addArguments('disable-gpu');
        options.addArguments('no-sandbox');
    }

    let driver = await new Builder()
        .forBrowser('chrome')
        .setChromeOptions(options)
        .build();

    try {
        await driver.get(url);
        
        await driver.sleep(5000);

        let searchBox = await driver.findElement(By.name('q'));
        await searchBox.sendKeys(query, Key.RETURN);

        await driver.sleep(5000);

        let firstResult = await driver.findElement(By.css('h3'));
        await firstResult.click();

        if (debug) {
            console.log('Browser will stay open for debugging.');
            await driver.sleep(10000);
        }

    } finally {
        if (!debug) {
            await driver.quit();
        }
    }
})();
