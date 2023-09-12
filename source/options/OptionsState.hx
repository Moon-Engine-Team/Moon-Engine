package options;

import states.MainMenuState;
import backend.StageData;
import flixel.addons.transition.FlxTransitionableState;

class OptionsState extends MusicBeatState
{
	var options:Array<String> = ['Note Colors', 'Controls', 'Adjust Delay and Combo', 'Graphics', 'Visuals and UI', 'Gameplay'];
	var optionsESP:Array<String> = ['Notas Coloridas', 'Controles', 'Ajustar el retraso y mezclar', 'Gráficos', 'Imágenes y UI', 'Como se Juega'];
	var optionsPTBR:Array<String> = ['Notas Coloridas', 'Controles', 'Ajustar atraso e combinação', 'Gráficos', 'Visuais e IU', 'Jogabilidade'];
	var optionsD:Array<String> = ['Bunte Notizen', 'Kontrollen', 'Passen Sie Verzögerung und Mischung an', 'Grafik', 'Visuals und Benutzeroberfläche', 'Spielweise'];
	private var grpOptions:FlxTypedGroup<Alphabet>;
	private static var curSelected:Int = 0;
	public static var menuBG:FlxSprite;
	public static var onPlayState:Bool = false;
	var tipText:FlxText;

	function openSelectedSubstate(label:String) {
	if(ClientPrefs.data.language == 'English')
             {
		switch(label) {
			case 'Note Colors':
				openSubState(new options.NotesSubState());
			  #if android
				removeVirtualPad();
				#end
			case 'Controls':
				openSubState(new options.ControlsSubState());
			  #if android
				removeVirtualPad();
				#end
			case 'Graphics':
				openSubState(new options.GraphicsSettingsSubState());
			  #if android
				removeVirtualPad();
				#end
			case 'Visuals and UI':
				openSubState(new options.VisualsUISubState());
		    #if android
				removeVirtualPad();
				#end
			case 'Gameplay':
				openSubState(new options.GameplaySettingsSubState());
			case 'Adjust Delay and Combo':
				MusicBeatState.switchState(new options.NoteOffsetState());
			  #if android
				removeVirtualPad();
				#end
				 }
				}
			else if(ClientPrefs.data.language == 'Español') 
               {
               switch(label) {
			case 'Notas Coloridas':
				openSubState(new options.NotesSubState());
			  #if android
				removeVirtualPad();
				#end
			case 'Controles':
				openSubState(new options.ControlsSubState());
			  #if android
				removeVirtualPad();
				#end
			case 'Gráficos':
				openSubState(new options.GraphicsSettingsSubState());
			  #if android
				removeVirtualPad();
				#end
			case 'Imágenes y UI':
				openSubState(new options.VisualsUISubState());
		    #if android
				removeVirtualPad();
				#end
			case 'Como se Juega':
				openSubState(new options.GameplaySettingsSubState());
			case 'Ajustar el retraso y mezclar':
				MusicBeatState.switchState(new options.NoteOffsetState());
			  #if android
				removeVirtualPad();
				#end
				}
				}
			else if(ClientPrefs.data.language == 'Português (BR)')
               {
               switch(label) {
			case 'Notas Coloridas':
				openSubState(new options.NotesSubState());
			  #if android
				removeVirtualPad();
				#end
			case 'Controles':
				openSubState(new options.ControlsSubState());
			  #if android
				removeVirtualPad();
				#end
			case 'Gráficos':
				openSubState(new options.GraphicsSettingsSubState());
			  #if android
				removeVirtualPad();
				#end
			case 'Visuais e IU':
				openSubState(new options.VisualsUISubState());
		    #if android
				removeVirtualPad();
				#end
			case 'Jogabilidade':
				openSubState(new options.GameplaySettingsSubState());
			case 'Ajustar atraso e combinação':
				MusicBeatState.switchState(new options.NoteOffsetState());
			  #if android
				removeVirtualPad();
				#end
				}
				}
				else if(ClientPrefs.data.language == 'Deutsch')
               {
               switch(label) {
			case 'Bunte Notizen':
				openSubState(new options.NotesSubState());
			  #if android
				removeVirtualPad();
				#end
			case 'Kontrollen':
				openSubState(new options.ControlsSubState());
			  #if android
				removeVirtualPad();
				#end
			case 'Grafik':
				openSubState(new options.GraphicsSettingsSubState());
			  #if android
				removeVirtualPad();
				#end
			case 'Visuals und Benutzeroberfläche':
				openSubState(new options.VisualsUISubState());
		    #if android
				removeVirtualPad();
				#end
			case 'Spielweise':
				openSubState(new options.GameplaySettingsSubState());
			case 'Passen Sie Verzögerung und Mischung an':
				MusicBeatState.switchState(new options.NoteOffsetState());
			  #if android
				removeVirtualPad();
				#end
				}
		}
	}

	var selectorLeft:Alphabet;
	var selectorRight:Alphabet;

	override function create() {
		#if desktop
		DiscordClient.changePresence("Options Menu", null);
		#end

		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.antialiasing = ClientPrefs.data.antialiasing;
		bg.color = 0xFFea71fd;
		bg.updateHitbox();

		bg.screenCenter();
		add(bg);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		for (i in 0...options.length)
		{
			var optionText:Alphabet = new Alphabet(0, 0, options[i], true);
			optionText.screenCenter();
			optionText.y += (100 * (i - (options.length / 2))) + 50;
			grpOptions.add(optionText);
		}

		selectorLeft = new Alphabet(0, 0, '>', true);
		add(selectorLeft);
		selectorRight = new Alphabet(0, 0, '<', true);
		add(selectorRight);

		changeSelection();
		ClientPrefs.saveSettings();

		#if android
		addVirtualPad(UP_DOWN, A_B_X_Y);

		tipText = new FlxText(150, FlxG.height - 24, 0, 'Press X to Go In Android Controls Menu', 16);
			tipText.setFormat("VCR OSD Mono", 17, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			tipText.borderSize = 1.25;
			tipText.scrollFactor.set();
			tipText.antialiasing = ClientPrefs.data.antialiasing;
			add(tipText);
			tipText = new FlxText(150, FlxG.height - 44, 0, 'Press Y to Go In Hitbox Settings Menu', 16);
			tipText.setFormat("VCR OSD Mono", 17, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			tipText.borderSize = 1.25;
			tipText.scrollFactor.set();
			tipText.antialiasing = ClientPrefs.data.antialiasing;
			add(tipText);
	  	#end

		super.create();
	}

	override function closeSubState() {
		super.closeSubState();
		ClientPrefs.saveSettings();
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
		#if android
		if (MusicBeatState._virtualpad.buttonX.justPressed) {
			FlxTransitionableState.skipNextTransIn = true;
			FlxTransitionableState.skipNextTransOut = true;
			MusicBeatState.switchState(new android.AndroidControlsMenu());
		}
		if (MusicBeatState._virtualpad.buttonY.justPressed) {
			removeVirtualPad();
			openSubState(new android.HitboxSettingsSubState());
		}
		#end

		if (controls.UI_UP_P) {
			changeSelection(-1);
		}
		if (controls.UI_DOWN_P) {
			changeSelection(1);
		}

		if (controls.BACK) {
			FlxG.sound.play(Paths.sound('cancelMenu'));
			if(onPlayState)
			{
				StageData.loadDirectory(PlayState.SONG);
				LoadingState.loadAndSwitchState(new PlayState());
				FlxG.sound.music.volume = 0;
			}
			else MusicBeatState.switchState(new MainMenuState());
		}
		else if (controls.ACCEPT) openSelectedSubstate(options[curSelected]);
	}
	
	function changeSelection(change:Int = 0) {
		curSelected += change;
		if (curSelected < 0)
			curSelected = options.length - 1;
		if (curSelected >= options.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpOptions.members) {
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			if (item.targetY == 0) {
				item.alpha = 1;
				selectorLeft.x = item.x - 63;
				selectorLeft.y = item.y;
				selectorRight.x = item.x + item.width + 15;
				selectorRight.y = item.y;
			}
		}
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}

	override function destroy()
	{
		ClientPrefs.loadPrefs();
		super.destroy();
	}
}