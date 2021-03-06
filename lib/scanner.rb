#!/usr/bin/env ruby
#  scanner
#
#  Created by Paolo Bosetti on 2011-01-13.
#  Copyright (c) 2011 University of Trento. All rights reserved.
#

# Class for dealing with Deform input/output files.
# @author Paolo Bosetti
class Scanner
  attr_reader :line_count, :error_count
  
  # The +Scanner+ gets initialized with the following defaults:
  #     :tag_open  => '<$',
  #     :tag_close => '$>',
  #     :in_ext    => 'tpl',
  #     :out_ext   => 'txt',
  #     :input_file => "input"
  # If no +args+ is specified, these are the defaults. Otherwise, the keys that 
  # are passed are merged with those defaults.
  # @param [Hash] args a +Hash+ of initialization values
  def initialize(args = {})
    @cfg = {
      :tag_open  => '<$',
      :tag_close => '$>',
      :in_ext    => 'tpl',
      :out_ext   => 'txt',
      :input_file => "input"
    }
    @cfg.merge! args
  end
  
  # Writes a new input file, on the basis of the template file and of the passed
  # +Hash+ of values.
  #
  # Names of input and output files are determined on the basis of values specified
  # in the +@cfg+ variable.
  # @param [Hash, <Symbol,Numeric>] vars the hash of values; keys must be present
  #   in the template file.
  def write_input(vars)
    raise ArgumentError, "Expecting an Hash" unless vars.kind_of? Hash
    @error_count = @line_count = 0
    @cfg[:tag_open].gsub!(/([\$\^\+])/) {|p| "\\#{$1}"}
    @cfg[:tag_close].gsub!(/([\$\^\+])/) {|p| "\\#{$1}"}
    re = Regexp.new( @cfg[:tag_open] + '\s*([a-zA-Z0-9]*)\s*' + @cfg[:tag_close])
    File.open("#{@cfg[:input_file]}.#{@cfg[:out_ext]}", "w") do |file| 
      File.foreach("#{@cfg[:input_file]}.#{@cfg[:in_ext]}") do |line|
        file.puts line.gsub(re) {|p| 
          if vars[$1.to_sym] then
            vars[$1.to_sym]
          else
            @error_count += 1
            "***ERROR: #{p}***"
          end
        }
        @line_count += 1
      end
    end
  end
  
  def read_output
    f = force()
    load_nodes()
    ct = chip_thickness()
    cc = chip_curvature()
    [f, ct, cc].inject {|memo, v| memo + v**2.0 }
  end
  
  def force
    
  end
  
  def load_nodes
    
  end
  
  def chip_thickness
    
  end
  
  def chip_curvature
    
  end
end