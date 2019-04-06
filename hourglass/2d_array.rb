#!/usr/bin/env ruby

require 'json'
require 'stringio'

# Complete the hourglassSum function below.
def hourglassSum(arr)
  main_arr = arr
  largest_sum = 0

  arr.each do |a|
    a.each do |i|
      i = 2
      max_hourglass_diagonal_dimension = main_arr.dig(i + 2, i + 2)
      # puts max_hourglass_diagonal_dimension
      unless max_hourglass_diagonal_dimension.nil?
        top_left_hourglass_node = main_arr[i][i]
        top_middle_hourglass_node = main_arr[i][i+1]
        top_right_hourglass_node = main_arr[i][i+2]
        middle_hourglass_node = main_arr[i+1][i+1]
        bottom_middle_hourglass_node = main_arr[i+2][i+1]
        bottom_left_hourglass_node = main_arr[i+2][i]
        bottom_right_hourglass_node = main_arr[i+2][i+2]

        sum_of_hourglass_node = top_left_hourglass_node + top_middle_hourglass_node +
          top_right_hourglass_node + middle_hourglass_node + bottom_middle_hourglass_node +
          bottom_left_hourglass_node + bottom_right_hourglass_node

        largest_sum = largest_sum < sum_of_hourglass_node ? sum_of_hourglass_node : largest_sum
      end
    end
  end

  largest_sum
end

  fptr = File.open(ENV['OUTPUT_PATH'], 'w')

  arr = Array.new(6)

  6.times do |i|
    arr[i] = gets.rstrip.split(' ').map(&:to_i)
  end

  result = hourglassSum arr

  fptr.write result
  fptr.write "\n"

  fptr.close()
