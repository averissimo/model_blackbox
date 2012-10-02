directories = {"estimators"=>"_est","simulators"=>"_sim"}
suffixes = ["ode","analytical"]
prefix_rm = "TEMPLATE"
cgi_dir = "cgi/octave"
extension = ".cgi"
shebang_name = "octave-no-x11"
shebang_path = "../bin"

# generate custom octave bin

Dir::mkdir(shebang_path) unless FileTest::directory?(shebang_path) # creates dir if does not exists

bin_dir = File.expand_path(shebang_path)
octave_bin = bin_dir + File::Separator + shebang_name
unless File.exists?(octave_bin)
  puts "creating bin for octave: " + octave_bin
  f = File.new(octave_bin,"w")
  f.write("#! /bin/sh\n")
  f.write("exec octave --silent --no-window-system $@\n")
  f.chmod 0775
  f.close
  f = nil
end

# generate scripts
directories.each do |d,k|
  suffixes.each do |s|
    files = Dir.glob( "#{d}_#{s}#{File::Separator}*.m").reject{ |f| f.include?(prefix_rm)}
    files.each do |f|
      new_cgi_name = File.basename(f).sub(k+".m","")
      new_cgi_path = "..#{File::Separator + cgi_dir + File::Separator + d + File::Separator}"
      file_path = new_cgi_path + new_cgi_name + extension
      Dir::mkdir(new_cgi_path) unless FileTest::directory?(new_cgi_path)
      #
      if File.exists?(file_path)
        puts "doing nothing (file already exists): " + file_path
      else
        puts "creating new file: " + file_path
        fid = File.open(file_path,"w")
        fid.write "#! #{octave_bin}\n"
        fid.write "warning(\"off\",\"all\");\n"
        fid.write "#{File.basename(f).sub(".m","")};\n"
        fid.chmod 0775
        fid.close
      end
    end
  end
end
