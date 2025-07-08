extends Node

const WorldSize := Vector3(40,20,30)

const BottomSize := Vector2(WorldSize.x, WorldSize.z)
const BottomCenter := Vector3(WorldSize.x/2, 0, WorldSize.z/2)
const TopCenter := Vector3(WorldSize.x/2, WorldSize.y, WorldSize.z/2)

const WestSize := Vector2(WorldSize.y, WorldSize.z)	
const WestCenter := Vector3(0, WorldSize.y/2, WorldSize.z/2)
const EastCenter := Vector3(WorldSize.x, WorldSize.y/2, WorldSize.z/2)

const NorthSize := Vector2(WorldSize.x, WorldSize.y)
const NorthCenter := Vector3(WorldSize.x/2, WorldSize.y/2, 0)
const SouthCenter := Vector3(WorldSize.x/2, WorldSize.y/2, WorldSize.z)

const BallRadius := 0.3
