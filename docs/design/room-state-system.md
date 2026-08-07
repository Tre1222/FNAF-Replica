# Room & Animatronic State System

How FNAF Replica decides what background to show, where each animatronic is, and what state the player is in. This is the central design doc — read first before building anything.

---

## What we're building

A 2D top-down-ish horror game where:
- The player is in **one room at a time** (mostly the Office)
- Rooms have **multiple background variants** depending on game state (lights on/off, animatronic present, door closed)
- Animatronics **roam between rooms** on a tick schedule (every few seconds)
- The player can **open/close doors**, **check cameras**, and **do tasks**

Visual reference: classic FNAF — fixed camera angles, dark atmospheric rooms, occasional jumpscares.

---

## Core idea: variables drive visuals

Instead of hardcoding "if in Kitchen AND lights on, show kitchen_lights_on.png", we use **named state variables** that the Room script reads to decide which background to display.

### State variables (global, in `GameState` autoload)

```gdscript
extends Node

# Time
signal hour_changed(hour: int)
var current_hour: int = 0  # 0 = 12AM, 6 = 6AM (win)

# Player location
signal player_room_changed(room: Room)
var current_room: Room = null

# Per-room state (key = room id, value = dict of states)
var room_states: Dictionary = {
    "office": {"lights_on": true, "left_door_closed": false, "right_door_closed": false},
    "left_hallway": {"lights_on": true},
    "right_hallway": {"lights_on": true},
    "kitchen": {"lights_on": true},
    # ... etc
}

# Animatronic locations
signal animatronic_moved(animatronic_id: String, from_room: String, to_room: String)
var animatronic_locations: Dictionary = {
    "freddy": "show_stage",
    "bonnie": "show_stage",
    "chica": "show_stage",
    "foxy": "pirate_cove",
}

# Power
signal power_changed(amount: float)
var power: float = 100.0  # percentage
```

### Room scene structure

```
Room (Node2D)                        ← script: room.gd
├── Background (TextureRect)         ← script: background_swap.gd
│   └── (no children — single texture at a time)
├── Props (Node2D)                   ← animatronic sprites go here when they "enter" the room
│   └── (empty by default)
└── UI (CanvasLayer)                 ← room-specific UI (door buttons, etc.)
```

### `room.gd` — listens to state, updates visuals

```gdscript
extends Node2D
class_name Room

@export var room_id: StringName = &""  # matches key in GameState.room_states

@onready var background: TextureRect = $Background
@onready var props: Node2D = $Props

func _ready() -> void:
    GameState.room_states[room_id]  # ensure entry exists
    GameState.power_changed.connect(_on_power_changed)
    _refresh_background()

func _refresh_background() -> void:
    var states: Dictionary = GameState.room_states[room_id]
    var key: String = _compute_background_key(states)
    var path: String = "res://assets/rooms/%s/%s.png" % [room_id, key]
    if ResourceLoader.exists(path):
        background.texture = load(path)

func _compute_background_key(states: Dictionary) -> String:
    # Override per room. Default: lights on/off
    if states.get("lights_on", true):
        return "lights_on"
    return "lights_off"

func _on_power_changed(_amount: float) -> void:
    # When power hits 0, all lights off = all rooms dark
    _refresh_background()
```

---

## Animatronic AI — the scheduler

Every N seconds (configurable per animatronic), each animatronic picks a new room to move to based on its AI personality.

### Base class (C# — good for resume visibility)

```csharp
using Godot;

public partial class Animatronic : Node
{
    [Export] public string Id { get; set; } = "";
    [Export] public int MoveIntervalSeconds { get; set; } = 5;
    [Export] public int Aggression { get; set; } = 1; // 1-20, higher = moves toward player faster

    private double _accumulator = 0;

    public override void _Process(double delta)
    {
        _accumulator += delta;
        if (_accumulator >= MoveIntervalSeconds)
        {
            _accumulator = 0;
            Tick();
        }
    }

    public virtual void Tick()
    {
        var currentRoom = GameState.AnimatronicLocations[Id];
        var newRoom = ChooseNextRoom(currentRoom);
        GameState.MoveAnimatronic(Id, currentRoom, newRoom);
    }

    protected virtual string ChooseNextRoom(string currentRoom) => currentRoom;
}
```

### Per-animatronic behavior

- **Freddy** (aggression 1): Only moves when player isn't watching. Path: show_stage → dining → kitchen → east_hall → office. Never moves off the path unless player is distracted.
- **Bonnie** (aggression 3-8): Moves left side. Path: show_stage → dining → left_hall → office. Aggression increases each hour.
- **Chica** (aggression 3-8): Moves right side. Path: show_stage → dining → right_hall → kitchen → east_hall → office.
- **Foxy** (special): Stays in pirate_cove until player stops checking cameras. Charges down left_hall when triggered.

Each gets its own `Tick()` override in `source/animatronics/Freddy.cs`, etc.

---

## Doors + power

The Office has two doors (left, right). Each has 3 states:
- **Open** (default, no power cost)
- **Closed** (uses power constantly)
- **Light on** (uses power + reveals hallway)

Power ticks down over time + every active door/light. At 0%, all doors fail open and lights go out.

```gdscript
# in power_manager.gd (autoload)
const POWER_DRAIN_PER_SECOND: float = 0.1
const DOOR_DRAIN_PER_SECOND: float = 0.5
const LIGHT_DRAIN_PER_SECOND: float = 0.3

func _process(delta: float) -> void:
    var drain: float = POWER_DRAIN_PER_SECOND * delta
    if GameState.room_states["office"].get("left_door_closed", false):
        drain += DOOR_DRAIN_PER_SECOND * delta
    if GameState.room_states["office"].get("right_door_closed", false):
        drain += DOOR_DRAIN_PER_SECOND * delta
    # ... lights too
    GameState.power = max(0.0, GameState.power - drain)
```

---

## Tasks

Player can leave the office to do tasks (lights out for X seconds, audio cue to lure animatronics). Implement as `Task` resources — each has a duration and an effect:

```gdscript
class_name Task
extends Resource

@export var name: String
@export var duration_seconds: float
@export var effect: String  # e.g. "lure_bonnie_to_party_room_2"
```

---

## Things to remember

- **State lives in GameState (autoload), not in scenes.** Scenes read state and render. This way multiple UIs (office view + camera view) stay in sync automatically.
- **Use signals** (`room_states_changed`, `animatronic_moved`, `power_changed`) — let scenes subscribe instead of polling.
- **Per-room background variants** are just files in `assets/rooms/<room_id>/`. Naming convention: `<state_key>.png` (e.g. `lights_on.png`, `lights_off.png`, `bonnie_present.png`).
- **Tick interval matters.** 5 seconds is classic FNAF feel. Animatronics that move every 2 seconds feel chaotic; every 10 seconds feels boring.
- **Test with placeholder art** — colored squares for backgrounds, simple shapes for animatronics. Real art comes last.
- **Don't preload all backgrounds** — `ResourceLoader.exists()` + `load()` is fine for 11 rooms × 2-3 variants each.

---

## Status

- [ ] `GameState` autoload (GDScript) created
- [ ] `Room` base class created
- [ ] First room scene (Office) with `_refresh_background()` working
- [ ] `Animatronic` base class (C#) created
- [ ] Per-animatronic subclasses (Freddy, Bonnie, Chica, Foxy)
- [ ] Animatronic movement on tick works (logs to console)
- [ ] Power system wired
- [ ] Door open/close buttons
- [ ] Task system (player leaves office to do task)
- [ ] Win condition (survive to 6AM)
- [ ] Jumpscare system (animatronic reaches office)
