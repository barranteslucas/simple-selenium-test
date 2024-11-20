import time
import os
from dotenv import load_dotenv
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.keys import Keys
import chromedriver_autoinstaller

def load_user_data():
    load_dotenv()
    user_data = {
        "debug": os.getenv("DEBUG"),
        "url": os.getenv("URL"),
        "query": os.getenv("QUERY"),
    }
    return user_data


def main():
    try:
        user_data = load_user_data()

        chromedriver_autoinstaller.install()
        chrome_options = Options()

        if user_data["debug"] == "True":
            print("Running in DEBUG mode")
            chrome_options.headless = False
            chrome_options.use_subprocess = False
            driver = webdriver.Chrome(options=chrome_options)
        else:
            print("Running in PROD mode")
            chrome_options.add_argument('--headless')
            chrome_options.add_argument('--no-sandbox')
            chrome_options.add_argument('--disable-gpu')
            chrome_options.add_argument('--disable-software-rasterizer')
        
        driver = webdriver.Chrome(options=chrome_options)        
        driver.get(user_data["url"])

        time.sleep(3)
        
        search_box = driver.find_element(By.NAME, "q")
        query = "apx.school"
        search_box.send_keys(query)
        search_box.send_keys(Keys.RETURN)
        
        time.sleep(3)
        
        first_result = driver.find_element(By.CSS_SELECTOR, "h3")
        first_result.click()
        
        time.sleep(5)

        if user_data["debug"] == "True":
            input("Press Enter to close the browser...") 

    except Exception as e:
        print(f"Error: {e}")

    finally:
        if user_data["debug"] == "True":
            pass
        else:
            driver.quit()

if __name__ == "__main__":
    main()