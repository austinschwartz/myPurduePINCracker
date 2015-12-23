require "selenium-webdriver"

account = "userperson"
password = "pass"

driver = Selenium::WebDriver.for :firefox
driver.manage.timeouts.implicit_wait = 10
driver.navigate.to "https://timetable.mypurdue.purdue.edu/Timetabling/gwt.jsp?page=sectioning"

element = driver.find_element(:id, "username")
element.send_keys account + "\t" + password
element.submit

pins = (0..9).to_a.repeated_permutation(6).to_a

pins.each do |pin|
  pin_box = driver.find_element(:class, "gwt-SuggestBox")
  pin_box.send_keys pin.map(&:to_s).reduce(&:+)
  pin_box.send_keys:return
  sleep 1
end

driver.quit
