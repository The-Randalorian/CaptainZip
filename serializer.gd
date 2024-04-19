extends Resource

class_name Serializer

@export var completedLevels :int;   # = GameManager.numLevelsCompleted;

func load_data(file_name):
	if ResourceLoader.exists(file_name):
		var cNum = ResourceLoader.load(file_name);
		if cNum is Serializer: # Check that the data is valid
			return cNum;
