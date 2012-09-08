# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'rspec', :version => 2 do

  watch(%r{^spec/.+_spec\.rb$})

  watch(%r{^lib/(.+)\.rb$})     { "spec" }
  watch('spec/spec_helper.rb')  { "spec" }

end

guard :shell do

  watch(%r{^lib/(.+)\.rex$})   { `rake dev` }
  watch(%r{^lib/(.+)\.y$})     { `rake dev` }

end