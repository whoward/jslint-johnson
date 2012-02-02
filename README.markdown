[![Build Status](https://secure.travis-ci.org/whoward/jslint-johnson.png)](http://travis-ci.org/whoward/jslint-johnson)

# NOTE

This project is no longer maintained, I would suggest using my alternative project jslint-v8 which runs much 
faster and does not have the same issues caused by the Johnson library (doesn't compile on Ruby 1.9.x).

http://www.rubygems.org/gems/jslint-v8

If you would like to take ownership of this project you are welcome to, contact me here on Github to do so.

## Description

JSLintJohnson is simply a ruby wrapper that helps you run JSLint as an automated
code quality standards tool inside your projects.  It's geared towards being run
in a continuous integration process (CI), such as Jenkins.

While it is focused on Ruby projects it can just as easily be used for any other 
language out there so long as you have Ruby installed on your system.

# How to use

1. Make sure you have Ruby and Rubygems installed on your computer (most operating systems except for Windows have this already)

2. In your console run: ```gem install jslint-johnson```

3. Run the following command ```jslint-johnson path/to/file.js```

For full details on using the command line interface simply type ```jslint-johnson```

