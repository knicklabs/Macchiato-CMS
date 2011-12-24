var FileHelper = {
	
	// ### Test
	// Tests if the browser fully supports the file API in HTML5. Returns true
	// if it does. 
	
	test: function() {
		if (window.File && window.FileReader && window.FileList && window.Blob) {
			// The browser fully supports the HTML5 file API.
			return true;
		} else {
			// Notify user that browser does not fully support the HTML5 file API.
			alert('File APIs are not fully supported in this browser.');
		}
		// The browser does not fully support the HTML5 file API.
		return false;
	},
	
	// ### Support Drag and Drop
	// Provides drag and drop support for uploading files.
	
	supportDragAndDrop: function() {
		// #### Handle File Select
		// Overrides the default browser handling of file selection. 
		
		function handleFileSelect(evt) {
			// Prevent default browser behaviour for file selection. 
		    evt.stopPropagation();
		    evt.preventDefault();
		    $('#drop-zone img').remove();

			// Get a list of files that were selected. 
		    var files = evt.dataTransfer.files;
		
			// We will only support uploading of one file. Set a global reference 
			// to the first file in the set so that other scripts can access the 
			// the file for processing. 
			window.fileToUpload = files[0];

		    // Output thumbnails of the selected file in the DOM. 
		    var output = [];
		    var i = 0;
		    for (var i = 0, f; f = files[i]; i++) {
			
				// Do not output non-image files. Skip this iteration of the loop
				// and continue on the next one.
				if (!f.type.match('image.*')) {
					continue;
				}
				
				// Since we will only allow one file to uploaded, we should only 
				// display one thumbnail. If there are multiple files, break out 
				// of this loop after the first thumbnail has been added.
				if (i > 0) {
					break;
				}
				
				// Create a new file reader object so that we may inspect the properties 
				// of the seleted file. 
				var reader = new FileReader();
				
				// Closure to captue the file information after the file has finished being
				// read into memory. 
				reader.onload = (function(theFile) {
					return function(e) {
						// Remove previous thumbnail that was output. 
						$('img.thumb').remove();
						// Remove placeholder message that notified user that he or she could drop a file. 
						$('#drop-zone span.message').remove();
						
						// Create a thumbnail from the file. 
						var span = document.createElement('span');
						span.innerHTML = ['<img class="thumb" src="', e.target.result, '" title="', theFile.name, '">'].join('');
						document.getElementById('drop-zone').insertBefore(span, null);
					};
				})(f);
				
				// Read in the image file as a data URL
				reader.readAsDataURL(f);
				
				i++;
			}

			// Append the thumbnail to the DOM.
		    document.getElementById('list').innerHTML = '<ul>' + output.join('') + '</ul>';
		  }
		
		// #### Handle Drag Over
		// Overrides the default browser handling of file dragging. 
		
		function handleDragOver(evt) {
			// Prevent default browser behaviour for file dragging.
			evt.stopPropagation();
			evt.preventDefault();
		}

		  // Setup actions to respond to drag and drop events.
		  var dropZone = document.getElementById('drop-zone');
		  dropZone.addEventListener('dragover', handleDragOver, false);
		  dropZone.addEventListener('drop', handleFileSelect, false);
		
	}
}