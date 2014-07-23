#Workaround with Octopress moved to subdirectory

Normally, there is an [official document](http://octopress.org/docs/deploying/subdir/) about how to deploy octopress to a subdirectory. However due to some bug the font path is not being generated automatically. Fixing the code may be one solution, and we can also get a workaround by editing _source/stylesheets/screen.css_ and make a substitution of the font path.
