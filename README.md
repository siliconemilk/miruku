To Build: 

	Requirements - 
	
		* node.js (npm)
		* coffeescript (npm install -g coffee-script)

	In root directory, run `cake` to view a list of current build options.
	Run `cake [build option]` to allow the Cakefile to work its magic.

	Currently, the only option is 'build-monolith' which will join all .coffee files together into a single compiled javascript file called 'app.js' found in libs/

 To Use: 

 	Include lib/app.js as a javascript source file in your main html file.
