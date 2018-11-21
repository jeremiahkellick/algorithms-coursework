require_relative "insertion_sort"

def shell_sort(arr, &prc)
  prc ||= Proc.new { |a, b| a <=> b }
  interval = 1;
  interval = interval * 3 + 1 while interval < arr.length / 3
  while interval >= 1
    insertion_sort(arr, interval, &prc)
    interval /= 3
  end
  arr
end
