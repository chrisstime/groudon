#!/usr/bin/env ruby

def self.split_date(date:)
  date.split(//, 0)
end

def self.get_days_for(month:, leap_year:)
  days_of_month = {
    '1': 31,
    '2': leap_year ? 29 : 28,
    '3': 31,
    '4': 30,
    '5': 31,
    '6': 30,
    '7': 31,
    '8': 31,
    '9': 30,
    '10': 31,
    '11': 30,
    '12': 31
  }
  days_of_month[:"#{month}"]
end

def self.leap_year(year:)
  year.to_i%400 == 0
end

def self.how_many_years_apart(from_year, to_year)
  to_year.to_i - from_year.to_i
end

def self.calculate_for_same_year(from_month, from_day, from_year, from_date_leap_year, to_month, to_day)
  total_number_of_days = 0
  (from_month.to_i..to_month.to_i).each do |month|
    days_for_month =
      if month == from_month.to_i
        days_remaining_on(day: from_day, month: month, leap_year: from_date_leap_year)
      elsif month == to_month.to_i
        to_day.to_i
      else
        get_days_for(month: month.to_s, leap_year: from_year).to_i
      end
    total_number_of_days += days_for_month
  end
end

def self.calculate_for_different_years(from_month, from_date_leap_year, from_year, from_day,
  to_month, to_year, to_day, to_date_leap_year)
  total_number_of_days = get_number_of_days_between(from_year.to_i + 1, to_year.to_i - 1)
  (from_month.to_i..12).each do |month|
    days_for_month =
      if month == from_month.to_i
        days_remaining_on(day: from_day, month: month, leap_year: from_date_leap_year)
      else
        get_days_for(month: month.to_s, leap_year: from_year).to_i
      end
    total_number_of_days += days_for_month
  end
  (1..to_month.to_i).each do |month|
    days_for_month = month == to_month.to_i ? to_day.to_i : get_days_for(month: month.to_s, leap_year: to_date_leap_year).to_i
    total_number_of_days += days_for_month
  end
  total_number_of_days
end

def self.days_remaining_on(day:, month:, leap_year:)
  self.get_days_for(month: month.to_s, leap_year: leap_year).to_i - day.to_i
end

def self.get_number_of_days_between(from_year, to_year)
  total_days = 0
  (from_year.to_i..to_year.to_i).each do |year|
    total_days += leap_year(year: year) ? 366 : 365
  end
  total_days
end

puts "Enter from date: "
from_date = gets.strip
puts "Enter to date: "
to_date = gets.strip
split_from_date = self.split_date date: from_date
from_year, from_month, from_day = split_from_date[0..3], split_from_date[4..5], split_from_date[6..7]
formatted_from_year, formatted_from_month, formatted_from_day = from_year.join, from_month.join, from_day.join
from_date_leap_year = self.leap_year year: formatted_from_year

split_to_date = self.split_date date: to_date
to_year, to_month, to_day = split_to_date[0..3], split_to_date[4..5], split_to_date[6..7]
formatted_to_year, formatted_to_month, formatted_to_day = to_year.join, to_month.join, to_day.join
to_date_leap_year = self.leap_year year: formatted_to_year

days_between =
  if self.how_many_years_apart(formatted_from_year, formatted_to_year) == 0
    self.calculate_for_same_year(formatted_from_month, from_day, formatted_from_year, from_date_leap_year,
                                 formatted_to_month, formatted_to_day)
  else
    self.calculate_for_different_years(formatted_from_month, from_date_leap_year, formatted_from_year, formatted_from_day,
                                       formatted_to_month, formatted_to_year, formatted_to_day, to_date_leap_year)
  end
puts "The days between the provided dates is #{days_between}"
