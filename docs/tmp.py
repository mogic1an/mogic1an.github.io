from selenium import webdriver
from selenium.webdriver.common.by import By

# Start a browser session
driver = webdriver.Chrome()  # You need to have chromedriver installed

# Navigate to WhiskyBase
driver.get("https://www.whiskybase.com/whiskies/whisky/247045/caol-ila-2006-gm")

# Example: find an element by its CSS selector and click it
element = driver.find_element(By.XPATH, '//div[@id="carousel-whisky"]//img')
print(element.get_attribute('src'))
#element.click()

# Perform other actions as needed...

# Close the browser session
driver.quit()
