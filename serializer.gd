extends Resource

class_name Serializer

@export var completedLevels :int;   # = GameManager.numLevelsCompleted;

func load_data(file_name):
	if ResourceLoader.exists(file_name):
		var cNum = ResourceLoader.load(file_name);
		if cNum is Serializer: # Check that the data is valid
			return cNum;
	else:
		print_debug("Save file doesn't exist, creating one now.");
		GameManager.numLevelsCompleted = 0;
		setupSave(0);
		return null;
		
func setupSave(lNum):
	#prevents levelsCompleted from incrementing when it shouldn't
	GameManager.numLevelsCompleted = min(lNum, GameManager.numLevelsCompleted + 1);
	#print(GameManager.numLevelsCompleted);
	
	var serializeInstance = Serializer.new();
	serializeInstance.completedLevels = GameManager.numLevelsCompleted;
	
	var cNum = ResourceSaver.save(serializeInstance, "user://CoolData.res");
	assert(cNum == OK)
