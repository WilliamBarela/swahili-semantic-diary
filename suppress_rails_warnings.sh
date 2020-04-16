# It's annoying to do migrations and general rake operations with so many warnings about futre versions of Ruby.
# When this file is run, Rails warnings for the current terminal session will be suppressed.
# This of course could live in the ~/.bashrc; however, it is probably not a good idea for future migrations since these warnings may be useful then.
# To allow this environement varialbe to be set in the current session, you need to run the following:
# . ./suppress_rails_warnings.sh
# The additional dot in front of the command will indicate that the script should be run in the context of the current terminal session.
export RUBYOPT='-W:no-deprecated -W:no-experimental'

# squelching of bundler platform warnings has to be done on each machine where the repo is hosted.
# This is because this sets a variable in /.bundle/config and /.bundle is ignored in the gitignore.

# squelch bundler platform warnings
# bundle config --local disable_platform_warnings true

# unsquelch bundler platform warnings
# bundle config --local disable_platform_warnings false
