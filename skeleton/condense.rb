

def condense(string)
  output = ""
  string.chars.each do |char|
    output << char unless char == " " || char == "\n"
  end
  output
end

p condense("  Movie
    .having('MAX(score) <= 8')
    .group(:yr)
    .distinct
    .pluck(:yr)
")
