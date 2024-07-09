require 'rexml/document'

def exec(input_file, output_file, xpath)
  input= REXML::Document.new(File.open(input_file))
  output= REXML::Document.new('<root/>')

  begin
    input.elements[xpath]
  rescue
    puts "Invalid xpath"
    return -1
  end

  count = input.elements.each(xpath) {|element|
    output.root.add_element(element)
  }.size

  fd = REXML::Formatters::Default.new
  fd.write(output, File.open(output_file, "w"))

  return count
end

print "xpath > "
xpath = STDIN.gets.chomp

dir = ARGV[2]
[ARGV[0], ARGV[1]].each do |file|
  count = exec(file, "#{dir}/#{file}", xpath)
  exit -1 if count < 0
  puts "No elements found.(#{file})" if count == 0
end
