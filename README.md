*This project has been created as part of the 42 curriculum by lde-san-.*

---

# 🦝✨ So Long — Glutto the Fox ✨💜

> We all have our demons, not all fights have a clear evil and good side.

---

## 🎮 Description

**So Long** is a 2D game developed in **C** using the **MiniLibX (mlx)** graphics library, created as part of the 42 curriculum. At its core, the project focuses on map parsing, rendering, event handling, and building a simple game loop.

*But let’s not pretend this is just about moving a sprite around.*

---

### 🦊 Glutto the Fox — The Lore

Glutto is a fox with a *mad case of the blues*...  
As he dreams, his guilt makes him a prisoner of his gluttony. Once he gets the hunger, is almost as if he can't see an exit until he has eaten everything in the room.
He sees those that try to help him as ghostly orange figures that he tries to avoid. If they get too close, Glutto's fragile heart might stop from the stress! 

Will you indulge him on his sinful habit, to help him escape his prison and forgive himself? Or will the fear get the best of you, making this Glutto's final slumber?

🫓	The arepas are not just food — they are Glutto's Eden.  

---

### 🎯 Goal

Guide Glutto through his looping dreamscape:

- 🫓 Collect **all arepas (C)**
- 🚪 Unlock the **exit (E)** after everything is collected
- 👻 Avoid **ghostly enemies (X)**
- 💔 Survive long enough to escape

Will you help him confront his guilt?..  

---

## ⚙️ Instructions

There are 2 elements to this project that you can run with the provided makefile:

### 🛠️ Compilation

- **make** : Will compile the program as intended by the project's subject.
> Alternatively, you can set the background to a different .xmp from the textures file during compilation. You just need to define the path to the file in the make compilation.

```bash
make
```
```bash
make BKGRND=./textures/background_image.xmp
```

- **make evolution** : Will take you through a trip down memory lane. 
> This runs a presentation that opens windows and test files secuentially, to show the journey I went through while learning and experimenting with the mlx library. 

```bash
make evolution
```

### 🛠️ Running the Game

Running **make** will leave you with a **so_long** executable, that you can run passing the path to a map as a parameter.
```bash
./so_long ./maps/level001.ber
```
>This map needs to fulfill a series of conditions specified in the project's subject. Included in the repository. But for a short description, it is a text file with the .ber suffix, that will be interpreted by the program. The characters are interpreted as follows:

#### 🗺️ Map Format (.ber)
> - **[1]**	Wall 🧱
> - **[0]**	Empty space
> - **[P]**	Player (Glutto 🦊)
> - **[C]**	Collectible (Arepa 🫓)
> - **[E]**	Exit 🚪
> - **[X]**	Enemy 👻🟧

#### 🎮 Controls
> - **WASD / Arrow Keys**	→ Move Glutto
> - **ESC**	→ Exit game
> - **Window Close Button**	→ Exit game

### 🛠️ Running the Presentation

Running **make evolution** showcases a presentation that opens windows and test files secuentially, to show the journey I went through while learning and experimenting with the mlx library.

The presentation will start running from the makefile, opening the file I was working on at the time to test the functions. The file contains a comment that gives info on what aspect of the library I was working on, what tests I was doing, and even ways to interact with the tests. Yes, interact with the tests. 

Because along with this file, an mlx window will open that shows the result of the test, and in some cases, you can use **WASD** or the **arrow keys** and even the **mouse cursor** to interact with things on the window. **More info on each file.**

```bash
make evolution
```

As you finish looking at any of the tests, you can hit the **ESC** key to move on to the next stage of the testing evolution, or cancel with **CTRL+C** the Makefile at any time to exit the presentation altogether.

## 🧠 Technical Overview

- Language: C

- Graphics: MiniLibX

- Core concepts:
	- Event handling (keyboard/mouse)
	- Window management
	- Texture rendering
	- Game loop design
	- Memory management (because leaks, am I right?)

## 📚 Resources

- MiniLibX Guide:	👉 https://harm-smits.github.io/42docs/libs/minilibx
- Coffee:		👉 ☕
- Trial and Error:	👉 Certified 42 methodology.
> 🦝 Break it. Fix it. Make it better. 🦝   
> ✨ Repeat until enlightenment (or burnout). 💥

## 🤖 AI Usage

AI was used as a **supporting tool**, mainly for:

 - 📘 General documentation lookup *(e.g. signals, system behavior)*
 - 🔍 Code reviewing / catching subtle mistakes
 - 💣 Preventing unnecessary compile attempts *(a.k.a. “yes, you forgot a semicolon again”)*
 - 🧮 Math *(Yeah, just math)*

### 🚨 Other Makefile Utilities

```bash
make dependencies
```
> Minilibx might require some dependencies that you could not have installed. If that's the case, this rule should fix your compilation issues. **Requires sudo access**.

```bash
make open
```
> Opens all the source files that were created for this project.

```bash
make clean
```
> Removes the object files, created during compilation.

```bash
make fclean
```
> Runs **make clean** and rm the **so_long** executable.

```bash
make re
```
> Runs **make fclean** and re-compiles the **so_long** executable.

## 🧾 Final Notes 🦝💜

If you made it this far…

Merry Christmas.
Take a break. Drink water. Maybe eat an arepa.

Don’t let Glutto eat them all.

💥🧡✨

![Gameplay](./assets/Thanks.png)
