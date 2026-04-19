### Godot Wild Jam #92: BREWING
My idea: Space Druid License Renewal

Pitch: Combine exotic ingredients in absurd ways to renew your Space Druid Licence.

### Credits:
- Font: https://rurr.itch.io/tremolo-mono
- Other font: https://www.1001fonts.com/bitmgothic-font.html
- Background music loop: https://opengameart.org/content/heavenly-loop
- Rocket sound: https://freesound.org/people/Mozfoo/sounds/458377/
- Zap sound: https://freesound.org/people/nicorico_120/sounds/819339/, https://freesound.org/people/sgossner/sounds/375169/
- Laser SFX: https://freesound.org/people/danlucaz/sounds/517763/
- Lock SFX: https://freesound.org/people/Breviceps/sounds/458400/
- Fanfare: https://freesound.org/people/Kagateni/sounds/404358/
- Success: https://freesound.org/people/GabrielAraujo/sounds/242501/
- Failure: https://freesound.org/people/FunWithSound/sounds/456963/
- Other SFX from: https://sfxr.me, https://freesound.org/people/JonnyRuss01/sounds/478196/, https://freesound.org/people/bernhoftbret/sounds/655157/, https://freesound.org/people/jimbo555/sounds/630498/, more CC0 from freesound.org
- HTML5 File Dialog plugin: https://gitlab.com/mocchapi/godot-4-html5-file-dialogs
- Basic game setup template by me: https://github.com/flygohr/godot-template
- Some colors from: https://lospec.com/palette-list/radioactive13
- Some pixel art based on:
	- Space BG: https://opengameart.org/content/space-background-01
	- Some base sprites for the fruit from: https://bigwander.itch.io/the-banquet by https://bigwander.itch.io 

### Devlog:
- 2026-04-11
	- Heavy brainstorming, difficult to get a good, small idea
	- Setting up this project, cloning my template
- 2026-04-12
	- Idea finalized
	- Started implementing minigames, grabbing and chopping
	- Added global persistence of fruit nodes and scene transition
- 2026-04-13
	- I have all the minigames done, prototypes
	- Starting to get the flow of the game going adding screens and mockup assets
- 2026-04-14
	- Not much time today, just worked out a flow and some texts in Obsidian
- 2026-04-15
	- Still not much time, minimal progress
- 2026-04-16
	- Finishing grabbing minigame
	- Lots of systems and flow, from title to end of grabbing
- 2026-04-17
	- Some fixes on the grabbing minigame, and polish
	- No longer reparenting fruit but loading it at minigame start
	- Working on the chopping minigame
- 2026-04-18
	- Idk if I'll make it in time
	- Reduced scope of chopping minigame, can expand if enough time
-2026-04-19
	- Finalizing the game, will need to cut replayability for the jam, will add more in the "clean up week" eventually
	- Adding grade screen
	- Adding "post game dev message"
	- Adding restart prompt and newgame = false to get rid of msgs
	- Adding sound
	- Idk why the zap animation doesn't work
	- Project corrupted, lost 6hrs of work, rushing for the end again

### To-do:
- [x] Make settings menu an autoload with a signal, too messy to keep track of scene
- [x] Find a way to pause the current node upon firing the settings menu
- [ ] Art:
	- [x] Title art: gothic font for "Space Druid", regular font for "Licence Renewal"
	- [x] Repeating space background
	- [ ] Colored handles for sliders to match theme
	- [x] Chopped fruit states
- [x] Ditch the spacebar, make everything on click so it can work on mobile
- [x] Set up grade screen
- [x] Set up report card
- [ ] Zapping animation for fruit in grabbing minigame, idk why it doesn't show up
- [ ] Different stages for the fruit in the chopping minigame:
	- [ ] The original idea was to chop the fruit in different stages, each expanding the collision shape so it would have been easier to get multiple fruit in a laser shot, but also more granular to get a 100% completion
- [ ] Non-critical:
	- [ ] Transitions are a bit janky, i need to transition to a scene and do the recap at the beginning of the new one to minimize transitions
	- [ ] Bottom bar sprites loading delay
	- [x] Some button remains highlighted the first time I call the options menu in, idk why. Probably hovering something, and not recalculating outline size
