directories = {"estimators"=>"_est","simulators"=>"_sim"}
suffixes = ["ode","analytical"]
prefix_rm = "TEMPLATE"
cgi_dir = "octave_cgi_scripts"
extension = ".cgi"

directories.each do |d,k|
  suffixes.each do |s|
    files = Dir.glob( "#{d}_#{s}#{File::Separator}*.m").reject{ |f| f.include?(prefix_rm)}
    files.each do |f|
      new_cgi_name = File.basename(f).sub(k+".m","")
      new_cgi_path = "..#{File::Separator + cgi_dir + File::Separator + d + File::Separator}"
      file_path = new_cgi_path + new_cgi_name + extension
      #
      if File.exists? file_path
        puts "doing nothing (file already exists): " + file_path
      else
        puts "creating new file: " + file_path
        fid = File.open(file_path,"w")
        fid.write "#! /usr/bin/octave -q\n"
        fid.write "warning(\"off\",\"all\");\n"
        fid.write "#{File.basename(f).sub(".m","")};\n"
        fid.chmod 0775
        fid.close
      end
    end
  end
end
