require "./spurdify/*"
require "option_parser"

SPURDIFICATION = {
  "kek"     => "geg",
  "epic"    => "ebin",
  "america" => "clapistan",
  "right"   => "rite",
  "your"    => "ur",
  "god"     => "dog",
  "."       => -> { return " :" + ("D" * rand(5)) },
  ","       => -> { return " x" + ("D" * rand(5)) },
  "wh"      => "w",
  "th"      => "d",
  "af"      => "ab",
  "ap"      => "ab",
  "ca"      => "ga",
  "ck"      => "gg",
  "co"      => "go",
  "ev"      => "eb",
  "ex"      => "egz",
  "et"      => "ed",
  "iv"      => "ib",
  "it"      => "id",
  "ke"      => "ge",
  "nt"      => "nd",
  "op"      => "ob",
  "ot"      => "od",
  "po"      => "bo",
  "pe"      => "be",
  "pi"      => "bi",
  "up"      => "ub",
  "va"      => "ba",
  "ck"      => "gg",
  "cr"      => "gr",
  "kn"      => "gn",
  "lt"      => "ld",
  "mm"      => "m",
  "nt"      => "dn",
  "pr"      => "br",
  "ts"      => "dz",
  "tr"      => "dr",
  "bs"      => "bz",
  "ds"      => "dz",
  "es"      => "es",
  "fs"      => "fz",
  "gs"      => "gz",
  "is"      => "iz",
  "as"      => "az",
  "ls"      => "lz",
  "ms"      => "mz",
  "ns"      => "nz",
  "rs"      => "rz",
  "ss"      => "sz",
  "ts"      => "tz",
  "us"      => "uz",
  "ws"      => "wz",
  "ys"      => "yz",
  "alk"     => "olk",
  "ing"     => "ign",
  "ic"      => "ig",
  "ng"      => "nk"
}

def spurdify(text : String) : String
  SPURDIFICATION.each do |k, v|
    text = if v.is_a?(Proc)
      text.gsub(k, &v)
    else
      text.gsub(k, v)
    end
  end
  return text
end

file, args = String.new, String.new

OptionParser.parse! do |parser|
  parser.banner = <<-BANNER
  Fuggs up text :DDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
            ▄▄▄▄▀▀▀▀▀▀▀▀▄▄▄▄▄▄▄
           █▒▒░▄▄▀▀▀▀▄░▒░▄▄▄▄▄░▀▀▄
          █▒░▄▀░▒▒▒▒▒░▀▄▀░▒▒▒▒▒▒▒█
         █▒▒▒▒▒▒▒▒▒██▀▒▒▒▒▒▒██▀▄▒█
        ▄▀▒▒▒▒▒▒▒▒▒▀▀▀▒▒▒▒▒▒▀▀▀▒▒▒█
        █▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██▒░░░░░░░▒█
        █░▒▒▀▄▄▒░░░░░░▒▄▀▄▄░░░░░░▒█
         █░▒▒▒▒▀▄▄▄▄▄███████▄▄▄▄▄▀
          █░▒▒▒▒▒▒▀▄▀▀████▀▀▄▀▒▒█
           ▀▀▀▄▄▄▄▄▄█▄▄▄▄▄▄█▄▄▄▀"



  BANNER

  parser.on("-f FILE", "--file=FILE", "A text file to fugg up") { |f| file = f }
  parser.on("-h", "--help", "Show this help") { puts parser }
  parser.on("-v", "--version", "Show version") { puts Spurdify::VERSION }

  parser.unknown_args { |ua|  args = ua }
end

if !file.empty?
  text_io = File.open(file)
elsif args.size > 0
  args = args.as(Array).join(" ") if args.is_a? Array
  text_io = IO::Memory.new(args.as(String))
else
  puts "Type stuff to be spurdified."
  text_io = STDIN
end

text_io.each_line do |txt|
  puts spurdify(txt)
end
