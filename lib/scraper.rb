require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper
  
#grabs entire HTML document from the web page  
  def get_page
    doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
  end

#uses a CSS selector to grab all HTML elements that contain a course  
  def get_courses
    self.get_page.css(".post")
  end
  
#instantiates Course objects and gives each course object the correct title, schedule, and description attribute that was scraped  
  def make_courses
    self.get_courses.each do |post|
      course = Course.new
      course.title = post.css("h2").text
      course.schedule = post.css(".date").text
      course.description = post.css("p").text   
    end
  end
  
#calls on make_courses and iterates over the courses that get created to puts out a list of course offerings  
  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
  
end

Scraper.new.get_page


