# FNAF Replica

A Five Nights at Freddy's-style horror game built in Godot 4.x — survival horror where you monitor cameras, manage doors, and complete tasks while animatronic characters roam the building at night.

> **Status:** Pre-production — setting up project foundation

---

## Concept

You play the night security guard at a pizza restaurant overrun with animatronic characters. Each night, you have a limited amount of power to keep the doors closed and the lights on. The animatronics move around the building according to their own AI patterns, and you watch them on the camera system. The goal is simple: survive until 6 AM.

This is a learning project — built to understand state-driven game systems (animatronic AI, room states, power management), 2D rendering, and the horror atmosphere that makes FNAF work.

## Tech Stack

- **Engine:** [Godot 4.x](https://godotengine.org/)
- **Language:** GDScript + C# (using both — GDScript for fast iteration on room/UI logic, C# for reusable systems like the animatronic AI scheduler; good for resume visibility too)
- **Version control:** Git + GitHub
- **Target platforms:** macOS first

---

## Getting Started

### Prerequisites

1. Install [Godot 4.x](https://godotengine.org/download) (Standard edition for GDScript)
2. For C# scripts: install [Godot 4.x with .NET support](https://godotengine.org/download) (the LARGER download labeled ".NET" or "Mono")
3. Install the [.NET SDK 6.0 or newer](https://dotnet.microsoft.com/download) (verify with `dotnet --version`)
4. Install [Git](https://git-scm.com/) (you probably already have this)
5. (Optional) Install [Visual Studio Code](https://code.visualstudio.com/) for editing

### Opening the project

1. Open Godot 4.x (use the .NET variant if you want C# support)
2. Click **Import** → navigate to this folder → select `project.godot`
3. Click **Open**

> **Note:** `project.godot` doesn't exist yet — it gets created when you first open the project in Godot.

### Running the game

Press **F5** in the Godot editor, or click the **Play** button in the top-right.

---

## Project Structure

```
FNAF Replica/
├── assets/
│   ├── rooms/                       # One subfolder per room (backgrounds, props)
│   │   ├── kitchen/
│   │   ├── office/
│   │   ├── left-hallway/
│   │   ├── left-door/
│   │   ├── right-hallway/
│   │   ├── right-door/
│   │   ├── main-room/
│   │   ├── backroom/
│   │   ├── party-room-1/
│   │   ├── party-room-2/
│   │   └── party-room-3/
│   ├── animatronics/                # Animatronic sprites (Freddy, Bonnie, Chica, Foxy)
│   ├── ui/                          # Camera UI, buttons, door controls
│   ├── audio/                       # Music + SFX
│   └── imports/                     # Raw asset files before Godot processes them
├── source/
│   ├── rooms/                       # Room scenes + scripts (background swap logic)
│   ├── animatronics/                # Animatronic AI scripts (C#)
│   ├── ui/                          # UI scenes (camera, doors, power meter)
│   └── autoload/                    # Singletons (GameState, PowerManager)
├── docs/
│   ├── design/                      # System design docs (room state system, AI)
│   ├── animatronics/                # Per-animatronic behavior notes
│   ├── rooms/                       # Per-room notes + asset lists
│   └── journal/                     # Dev log — what I worked on
├── .github/                         # GitHub-specific files
├── .gitignore
├── CHANGELOG.md
├── LICENSE                          # MIT
└── README.md                        # You are here
```

> **Note:** Files in `docs/` are just markdown notes. Open them in any text editor (VS Code, TextEdit). Godot doesn't load them — they're reference material.

---

## Roadmap

- [ ] Set up project in Godot 4.x (create `project.godot`)
- [ ] Enable C# support (Project → Tools → C# → Create C# solution)
- [ ] Build `GameState` autoload (current room, time of night, power)
- [ ] Build `RoomManager` (variable-driven background swap)
- [ ] Build first room scene (Office) with placeholder art
- [ ] Wire up door open/close controls
- [ ] Add first animatronic (Freddy — slowest, follows path)
- [ ] Add camera system (cycle through rooms)
- [ ] Add power consumption mechanic
- [ ] Survive-to-6AM win condition

---

## Author

**Walter Aguilar** — passion project.

Built with Godot 4.x.
