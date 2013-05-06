To Build: 

	Requirements - 

		* node.js (npm)
		* coffeescript (npm install -g coffee-script)

	In root directory, run `cake` to view a list of current build options.
	Run `cake [build option]` to allow the Cakefile to work its magic.

	Currently, the only option is 'build-monolith' which will join all .coffee files together into a single compiled javascript file called 'app.js' found in libs/

 To Use: 

 	- Include lib/app.js as a javascript source file in your main html file.
 	- New dialogs (menus) are defined in a .html file per new type of menu in ./contents/ with the file named after the type of dialog such as ./contents/mainMenu.html
 	- Give an element a class of 'editable' such as <div class="editable"></div> to make it valid for editing when editing is enabled.
 	
 	Optional - 
		* Connect (npm install connect). Allows launching of ./localhost.js to test Miruku on a local web server.
			Otherwise, be sure to set the domain, port, and root variables in main.coffee to point to the server Miruku is hosted on such as: 
				document = "www.google.com"
				port = 8080
				root = "/miruku/"
			if you were hosting at http://www.google.com:8080/miruku/


