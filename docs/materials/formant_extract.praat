form Get F1, F2, F3
	sentence Directory ./
	comment window length (half of your window)
	positive window 0.025
	comment The name of result file 
	text textfile result.tsv
	comment Number of formants
	positive nformant 5
	comment Maximum range
	positive maxfreq 5500
endform

# Write-out the header

fileappend "'textfile$'" intervalname'tab$'F1'tab$'F2'tab$'F3'tab$''newline$'

#Read all files in a folder
Create Strings as file list... wavlist 'directory$'/*.wav
Create Strings as file list... gridlist 'directory$'/*.TextGrid
n = Get number of strings

for i to n

#We first extract a formant tier
	select Strings wavlist
	filename$ = Get string... i
	Read from file... 'directory$'/'filename$'
	soundname$ = selected$ ("Sound")
	To Formant (burg): 0, 'nformant', 'maxfreq', 0.025, 50
	
# We now read grid files and extract all intervals in them
	select Strings gridlist
	gridname$ = Get string... i
	Read from file... 'directory$'/'gridname$'
	int=Get number of intervals... 1

# We then calculate F1, F2 and F3

		for k from 1 to 'int'
			select TextGrid 'soundname$'
			label$ = Get label of interval... 1 'k'
			if label$ <> ""

				# calculates the mid point
 				vowel_onset = Get starting point... 1 'k'
  				vowel_offset = Get end point... 1 'k'
     			midpoint = (vowel_onset + vowel_offset)/2
				winbeg = midpoint - window
				winend = midpoint + window

				# get the formant values at the midpoint
				selectObject: "Formant 'soundname$'"
				f_one = Get mean: 1, winbeg, winend, "Hertz"
				f_two = Get mean: 2, winbeg, winend,  "Hertz"
				f_three = Get mean: 3, winbeg, winend,  "Hertz"
				fileappend "'textfile$'" 'label$''tab$''f_one''tab$''f_two''tab$''f_three''tab$''newline$'
			endif
		endfor
endfor

#clean up

#select all
#Remove