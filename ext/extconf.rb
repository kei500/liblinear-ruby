require 'mkmf'
CONFIG["LDSHARED"] = case RUBY_PLATFORM
                     when /darwin/
                       "g++ -dynamic -bundle -undefined suppress -flat_namespace"
                     else
                       "g++ -shared"
                     end
$CFLAGS = "#{ENV['CFLAGS']} -Wall -O3 "
if CONFIG["MAJOR"].to_i >= 1 && CONFIG["MINOR"].to_i >= 8
  $CFLAGS << " -DHAVE_DEFINE_ALLOC_FUNCTION"
end
create_makefile('liblinearswig')
