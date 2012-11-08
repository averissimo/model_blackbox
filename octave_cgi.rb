# Model Blackbox
# Copyright (C) 2012-2012  André Veríssimo
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; version 2
# of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

directories = {"estimators"=>"_est","simulators"=>"_sim"}
suffixes = ["algebraic","differential"]
prefix_rm = "TEMPLATE"
base_models = "models"
cgi_dir = "cgi/octave"
extension = ".cgi"
shebang_name = "octave-no-x11"
shebang_path = "bin"

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
suffixes.each do |s|
  directories.each do |d,k|
    files = Dir.glob( "#{base_models}#{File::Separator}#{s}#{File::Separator}*#{File::Separator}*#{k}.m").reject{ |f| f.include?(prefix_rm)}
    files.each do |f|
      new_cgi_name = File.basename(f).sub(k+".m","")
      new_cgi_path = "#{cgi_dir + File::Separator + d + File::Separator}"
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
        fid.write "addpath(genpath(\"#{File.expand_path("toolbox")}\"));\n"
        fid.write "#{File.basename(f).sub(".m","")};\n"
        fid.chmod 0775
        fid.close
      end
    end
  end
end
