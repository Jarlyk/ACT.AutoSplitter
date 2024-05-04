state("AnotherCrabsTreasure") {}

startup {    
    refreshRate = 20;

    vars.debugPrint = true;

    dynamic unity = Assembly.Load(File.ReadAllBytes(@"Components\asl-help")).CreateInstance("Unity");
	vars.Helper.GameName = "AnotherCrabsTreasure";
	vars.Helper.AlertGameTime();    
	vars.started = false;
	vars.readyToSplit = false;
	vars.startTime = DateTime.UtcNow;
	vars.isLoading = false;
	vars._gm = null;
	vars._cf = null;
	vars._pd = null;
	vars._ud = null;
	vars._ld = null;
	vars._gui = null;
	vars._player = null;
	vars._shell = null;
	
	
	vars.pendingSplitCount = 0;
    vars.debugPrinted = !vars.debugPrint;
	
	//Indices for each split
    vars.indexOfName = 0;
    vars.indexOfDefaultOn = 1;
    vars.indexOfCaption = 2;
    vars.indexOfFlag = 3;
    vars.indexOfIsSplit = 4;
	vars.indexOfState = 5;

    var addSplits = (Action<object[,], string>)((splits, category) => {
		for (int i = 0; i <= splits.GetUpperBound(0); i++) {
			settings.Add((string)splits[i, vars.indexOfName], (bool)splits[i, vars.indexOfDefaultOn], (string)splits[i, vars.indexOfCaption], category);
		}
	});
	
	//Shallows
    vars.categoryShallows = "shallows";
	settings.Add(vars.categoryShallows, true, "Shallows");
	settings.SetToolTip(vars.categoryShallows, "splits when flag is set");	
    vars.shallows = new object[,] {
        {"shallows_entered", false, "Entered", 400, false, false},
        {"shallows_nephro", false, "Nephro Defeated", 600, false, false},	
        {"shallows_dutchess", false, "Magista Defeated", 1400, false, false},
		{"shallows_royal", false, "Royal Shellsplitter Defeated", 1500, false, false},
		{"shallows_ppp", true, "Polluted Platoon Pathfinder Defeated", 1600, false, false}
    };
    addSplits(vars.shallows, vars.categoryShallows);

	//Grove
    vars.categoryGrove = "grove";
	settings.Add(vars.categoryGrove, true, "Expired Grove");
	settings.SetToolTip(vars.categoryGrove, "splits when flag is set");	
    vars.grove = new object[,] {
        {"grove_entered", true, "Entered", 10, false, false},
        {"grove_heikea", true, "Heikea Defeated", 150, false, false},
        {"grove_topoda", false, "Topoda Defeated", 300, false, false},
        {"grove_lichenthrope", false, "Diseased Lichenthrope Defeated", 700, false, false},
        {"grove_carbonara", false, "Curdled Carbonara Conoisseur Defeated", 700, false, false}
    };
    addSplits(vars.grove, vars.categoryGrove);
	
	//Ocean
    vars.categoryOcean = "ocean";
	settings.Add(vars.categoryOcean, true, "Sands Between");
	settings.SetToolTip(vars.categoryOcean, "splits when flag is set");	
    vars.ocean = new object[,] {
        {"ocean_entered", false, "Entered", 10, false, false},
        {"ocean_pagurus", false, "Pagurus Defeated", 400, false, false}
    };
    addSplits(vars.ocean, vars.categoryOcean);
	
	//New Carcinia
    vars.categoryNewCar = "newcar";
	settings.Add(vars.categoryNewCar, true, "New Carcinia");
	settings.SetToolTip(vars.categoryNewCar, "splits when flag is set");	
    vars.newcar = new object[,] {
        {"newcar_entered", false, "Entered", 10, false, false},
        {"newcar_garbage", true, "Trash Day Cutscene", 200, false, false},
        {"newcar_vale_map", true, "Mailbox Map Piece", 400, false, false},
        {"newcar_completed_map", false, "Completed  Map", 600, false, false}
    };
    addSplits(vars.newcar, vars.categoryNewCar);
	
	//Scuttleport
    vars.categoryScuttleport = "scuttleport";
	settings.Add(vars.categoryScuttleport, true, "Scuttleport");
	settings.SetToolTip(vars.categoryScuttleport, "splits when flag is set");	
    vars.scuttleport = new object[,] {
        {"scuttleport_entered", false, "Entered Facilities", 250, false, false},
        {"scuttleport_voltai", true, "Voltai Defeated", 850, false, false},
        {"scuttleport_boat", true, "Boat Powered", 1000, false, false},
        {"scuttleport_consort", false, "The Consortium Defeated", 1200, false, false},
        {"scuttleport_roland", true, "Roland Defeated", 1300, false, false},
        {"scuttleport_roller", false, "Scuttling Sludge Steamroller Defeated", 1400, false, false},
        {"scuttleport_ceviche", false, "Ceviche Sisters Defeated", 1500, false, false}
    };
    addSplits(vars.scuttleport, vars.categoryScuttleport);
	
	//The Unfathom
    vars.categoryUnfathom = "unfathom";
	settings.Add(vars.categoryUnfathom, true, "The Unfathom");
	settings.SetToolTip(vars.categoryUnfathom, "splits when flag is set");	
    vars.unfathom = new object[,] {
        {"unfathom_nemma", true, "Depression Sequence", 25, false, false},
        {"unfathom_petroch", false, "Petroch Defeated", 69, false, false},
        {"unfathom_inkerton", true, "Inkerton Defeated", 3000, false, false}
    };	
    addSplits(vars.unfathom, vars.categoryUnfathom);
	
	//Bleached City
    vars.categoryBleached = "bleached";
	settings.Add(vars.categoryBleached, true, "Bleached City");
	settings.SetToolTip(vars.categoryBleached, "splits when flag is set");	
    vars.bleached = new object[,] {
        {"bleached_king", true, "Camstcha Defeated", 550, false, false},
        {"bleached_praya", true, "Praya Dubia Defeated", 800, false, false}
    };
    addSplits(vars.bleached, vars.categoryBleached);
	
	//Trash Island
    vars.categoryTrash = "trash";
	settings.Add(vars.categoryTrash, true, "Trash Island");
	settings.SetToolTip(vars.categoryTrash, "splits when flag is set");	
    vars.trash = new object[,] {
        {"trash_firth", true, "Firth Defeated", 100, false, false}
    };
    addSplits(vars.trash, vars.categoryTrash);
	
	//World Skills
    vars.categorySkills = "skills";
	settings.Add(vars.categorySkills, true, "World Skills");
	settings.SetToolTip(vars.categorySkills, "splits when unlocked");	
    vars.skills = new object[,] {
        {"skills_string", true, "Fishing line", 200, false, false}
    };
    addSplits(vars.skills, vars.categorySkills);
	
	//Tree Skills
    vars.categoryTSkills = "tskills";
	settings.Add(vars.categoryTSkills, true, "Tree Skills");
	settings.SetToolTip(vars.categoryTSkills, "splits when unlocked");	
    vars.tskills = new object[,] {
        {"tskills_umami", false, "Basic Umami training", 100, false, false},
		{"tskills_parry", true, "Parry", 1600, false, false},
		{"tskills_aggro", false, "Aggravation", 1400, false, false},
		{"tskills_selfrepair", false, "Self-Repair", 1500, false, false}
    };
    addSplits(vars.tskills, vars.categoryTSkills);
	
	//Endings (special splits
	vars.categoryEndings = "endings";
	settings.Add(vars.categoryEndings, true, "Endings");
	settings.SetToolTip(vars.categoryEndings, "splits upon triggering ending cutscene");
	vars.endings = new object[,] {
		{"ending_normal", true, "Home", 0, false, false}
	};
	addSplits(vars.endings, vars.categoryEndings);	
}

init {
    vars.Helper.TryLoad = (Func<dynamic, bool>)(helper =>
    {
        vars._gm = helper["Assembly-CSharp", "GameManager"];
		vars._cf = helper["Assembly-CSharp", "CrabFile"];
		vars._pd = helper["Assembly-CSharp", "ProgressData"];
		vars._ud = helper["Assembly-CSharp", "UnlockableData"];
		vars._ld = helper["Assembly-CSharp", "LevelDirector"];
		vars._gui = helper["Assembly-CSharp", "GUIManager"];
		vars._loadingScreen = helper["Assembly-CSharp", "LoadingScreen"];
		vars._player = helper["Assembly-CSharp", "Player"];
		vars._shell = helper["Assembly-CSharp", "Shell"];
        return true;
    });

	vars.readProgressBools = (Action<IntPtr, object[,]>)((fldPtr, splits) => {
		var listPtr = vars.Helper.Read<IntPtr>(fldPtr);
		var count = vars.Helper.Read<int>(listPtr + 24);
		var itemsPtr = vars.Helper.Read<IntPtr>(listPtr + 16);
		for (int i = 0; i < count; i++) {		
			var itemPtr = vars.Helper.Read<IntPtr>(itemsPtr + 0x20 + (i * 8));
			if (itemPtr != IntPtr.Zero) {
				var state = vars.Helper.Read<bool>(itemPtr + 0x18);
				var id = vars.Helper.Read<int>(itemPtr + 0x20);
				for (int k=0; k<=splits.GetUpperBound(0); k++) {
					if ((int)splits[k, vars.indexOfFlag] == id) {
						splits[k, vars.indexOfState] = state;
					}
				}
				//print(id.ToString() + " : " + state.ToString());
			}
		}
	});
	
	vars.checkSplits = (Action<object[,]>)((splits) => {
		for (int i = 0; i <= splits.GetUpperBound(0); i++) {
			var didSplit = (bool)splits[i, vars.indexOfIsSplit];
			if (!settings[(string)splits[i, vars.indexOfName]] || didSplit) {
				continue;
			}
			if ((bool)splits[i, vars.indexOfState]) {
				vars.pendingSplitCount++;
				splits[i, vars.indexOfIsSplit] = true;
				print("Split on " + splits[i, vars.indexOfName] + " for key " + splits[i, vars.indexOfFlag]);
			}
		}
	});
	
	vars.resetSplits = (Action<object[,]>)((splits) => {
		for (int i = 0; i <= splits.GetUpperBound(0); i++) {
			splits[i, vars.indexOfIsSplit] = false;
			splits[i, vars.indexOfState] = false;
		}
	});
	    
	vars.hasUpdated = false;
}

update {
	var gm = vars._gm;
	var cf = vars._cf;
	var pd = vars._pd;
	var ud = vars._ud;
	var ld = vars._ld;
	var gui = vars._gui;
	if (gm.Static != IntPtr.Zero) {	
		var gmPtr = vars.Helper.Read<IntPtr>(gm.Static + gm["_instance"]);
		if (gmPtr != IntPtr.Zero) {
			var cfPtr = vars.Helper.Read<IntPtr>(gmPtr + gm["activeCrabfile"]);
			if (cfPtr != IntPtr.Zero) {
				var pdPtr = vars.Helper.Read<IntPtr>(cfPtr + cf["progressData"]);
				if (pdPtr != IntPtr.Zero) {
					vars.readProgressBools(pdPtr + pd["shallowsBools"], vars.shallows);
					vars.readProgressBools(pdPtr + pd["expiredGroveBools"], vars.grove);
					vars.readProgressBools(pdPtr + pd["newCarciniaBools"], vars.newcar);
					vars.readProgressBools(pdPtr + pd["openOceanBools"], vars.ocean);
					vars.readProgressBools(pdPtr + pd["scuttleportBools"], vars.scuttleport);
					vars.readProgressBools(pdPtr + pd["theUnfathomBools"], vars.unfathom);
					vars.readProgressBools(pdPtr + pd["theBleachedCityBools"], vars.bleached);
					vars.readProgressBools(pdPtr + pd["trashIslandBools"], vars.trash);
					
					vars.debugPrinted = true;
					vars.readyToSplit = true;
				}
				
				var udPtr = vars.Helper.Read<IntPtr>(cfPtr + cf["unlocks"]);
				if (udPtr != IntPtr.Zero) {
					vars.readProgressBools(udPtr + ud["worldSkills"], vars.skills);
					vars.readProgressBools(udPtr + ud["skills"], vars.tskills);
				}
			}
					
			current.started = vars.Helper.Read<bool>(gmPtr + gm["startLevelLoad"]);			
			//current.started = vars.Helper.Read<bool>(gmPtr + gm["sessionStarted"]);
		}		
	}
	
	//if (ld.Static != IntPtr.Zero) {
	//	var ldPtr = vars.Helper.Read<IntPtr>(ld.Static + ld["_instance"]);
	//	vars.isLoading = vars.Helper.Read<bool>(ldPtr + ld["isLoading"]);
	//}
	
	var ls = vars._loadingScreen;
	if (gui.Static != IntPtr.Zero && ls.Static != IntPtr.Zero) {	
		var lsPtr = vars.Helper.Read<IntPtr>(gui.Static + gui["currentLoadingScreen"]);
		var isLoading = vars.Helper.Read<bool>(lsPtr + ls["_loading"]);
		var loadingString = vars.Helper.ReadString(lsPtr + ls["loadingString"]);
		        vars.isLoading = isLoading && !string.IsNullOrEmpty(loadingString);
	}
	
	//Special case for ending split
	current.shellPrefabName = "";
	if (vars.readyToSplit) {			
		//Only need to check shell if Firth is defeated
		if ((bool)vars.trash[0, vars.indexOfState]) {
			var player = vars._player;
			var shell = vars._shell;
			if (player.Static != IntPtr.Zero) {
				var playerPtr = vars.Helper.Read<IntPtr>(player.Static + 0);
				if (playerPtr != IntPtr.Zero) {
					var shellPtr = vars.Helper.Read<IntPtr>(playerPtr + player["equippedShell"]);
					if (shellPtr != IntPtr.Zero) {
						current.shellPrefabName = vars.Helper.ReadString(shellPtr + shell["prefabName"]);						
					}
				}
			}
		}
	}
	
	vars.hasUpdated = true;
}

start {
	if (!vars.readyToSplit) return false;
	return current.started;
}

onStart {
	vars.started = true;
	vars.startTime = DateTime.UtcNow;
}

split {
	if (!vars.hasUpdated) return false;
	if (!vars.started) return false;
	if (!vars.readyToSplit) return false;

	//Progression flag splits
	vars.checkSplits(vars.shallows);
	vars.checkSplits(vars.grove);
	vars.checkSplits(vars.ocean);
	vars.checkSplits(vars.newcar);
	vars.checkSplits(vars.scuttleport);
	vars.checkSplits(vars.unfathom);
	vars.checkSplits(vars.bleached);
	vars.checkSplits(vars.trash);
	vars.checkSplits(vars.skills);
	vars.checkSplits(vars.tskills);
	
	if (current.shellPrefabName != old.shellPrefabName) {
		print("New shell: " + current.shellPrefabName);
	}
	
	//Ending split is special
	//We only check if Firth is defeated
	if ((bool)vars.trash[0, vars.indexOfState] && current.shellPrefabName == "Shell_HomeShell") {
		if (settings[(string)vars.endings[0, vars.indexOfName]] && !(bool)vars.endings[0, vars.indexOfIsSplit]) {
			vars.pendingSplitCount++;
			vars.endings[0, vars.indexOfIsSplit] = true;
		}	
	}
	
	//In case multiple splits occur on the same frame, dole out the split triggers per poll cycle until they are complete
	var split = vars.pendingSplitCount > 0;
	if (split) {
		vars.pendingSplitCount--;
	}
    return split;
}

onReset {
	vars.hasUpdated = false;
	vars.started = false;
	vars.readyToSplit = false;
    vars.debugPrinted = !vars.debugPrint;
	vars.pendingSplitCount = 0;
	
    vars.resetSplits(vars.shallows);
	vars.resetSplits(vars.grove);
	vars.resetSplits(vars.ocean);
	vars.resetSplits(vars.newcar);
	vars.resetSplits(vars.scuttleport);
	vars.resetSplits(vars.unfathom);
	vars.resetSplits(vars.bleached);
	vars.resetSplits(vars.trash);
	vars.resetSplits(vars.skills);
	vars.resetSplits(vars.tskills);
	vars.resetSplits(vars.endings);
}

isLoading {
	if (!vars.readyToSplit) return true;
	
	return vars.isLoading;
}
