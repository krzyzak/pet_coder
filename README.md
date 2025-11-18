# 🐾 PetCoder - Learn Ruby Programming by Helping Pets!

<img width="1523" height="1327" alt="PetCoder Game Screenshot" src="https://github.com/user-attachments/assets/69cc86d0-4bbb-4aca-91f0-92deba6efad5" />

## 🎮 What is PetCoder?

PetCoder is an interactive game that teaches kids (and beginners!) how to program in Ruby by helping adorable pets reach their goals! Write Ruby code to move your pet around a grid, collect treats, avoid obstacles, and reach the target to advance through increasingly challenging levels.

## ✨ Features

- **🐱 Choose Your Pet**: Pick from various cute pets to guide through the game
- **🍖 Collect Treats**: Earn bonus points by collecting treats along the way
- **🎯 Reach Targets**: Navigate your pet to the target location to complete each level
- **❤️ Three Lives System**: Be careful! You have 3 lives per game
- **🏆 Progressive Difficulty**: Multiple levels with walls, holes, and gates to challenge you
- **📝 Real Ruby Code**: Learn actual Ruby programming syntax in a fun, visual way
- **🔒 Safe Sandbox**: All code runs in a secure Docker container for safety

## 🎯 How to Play

1. **Select a Player**: Choose or create your player profile
2. **Write Ruby Code**: In the code editor on the right, write Ruby commands to move your pet
3. **Run Your Code**: Click the "Run" button to execute your commands
4. **Watch Your Pet Move**: See your code come to life as your pet follows your instructions!
5. **Complete the Level**: Guide your pet to the target to advance

## 💻 Ruby Commands You Can Use

Your pet understands these Ruby commands:

```ruby
up      # Move your pet up one space
down    # Move your pet down one space
left    # Move your pet left one space
right   # Move your pet right one space
open    # Open nearby gates
```

### Example Code

Here are some examples to get you started:

**Simple movement:**
```ruby
right
right
up
```

**Using loops (Ruby's `.times` method):**
```ruby
5.times { right }
3.times { up }
```

**Mix and match:**
```ruby
2.times { up }
open
3.times { right }
down
```

**More complex logic:**
```ruby
# Move in a square pattern
4.times do
  3.times { right }
  3.times { down }
  3.times { left }
  3.times { up }
end
```

## 🎨 Game Elements

| Element | Description |
|---------|-------------|
| 🐾 **Pet** | Your character that you control with code |
| 🎯 **Target** | The goal location your pet needs to reach |
| 🍖 **Treat** | Collect these for bonus points! |
| 🧱 **Wall** | Blocks your pet's path - can't move through |
| 🕳️ **Hole** | Dangerous! Falling in costs a life |
| 🚪 **Gate** | Use the `open` command when nearby to open gates |

## 🏗️ Technical Stack

- **Ruby on Rails** (main branch) - Web framework
- **Turbo & Stimulus** - Modern, reactive UI without heavy JavaScript
- **Tailwind CSS** - Beautiful, responsive styling
- **SQLite** - Lightweight database
- **Docker** - Secure code execution sandbox
- **Kamal** - Zero-downtime deployment to any server
- **RSpec** - Testing framework

## 🚀 Getting Started

### Prerequisites

- Ruby 3.4+
- Rails (main branch)
- Docker (for running user code safely)
- SQLite 3

### Installation

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd pet_coder
   ```

2. **Install dependencies:**
   ```bash
   bundle install
   ```

3. **Setup the database:**
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. **Start the server:**
   ```bash
   bin/dev
   ```

5. **Open your browser:**
   Navigate to `http://localhost:3000`


## 🧪 Running Tests

```bash
# Run all tests
bundle exec rspec

# Run specific test file
bundle exec rspec spec/lib/executor_spec.rb
```

## 🎓 What Kids Will Learn

Playing PetCoder teaches fundamental programming concepts:

1. **Sequencing**: Commands execute in order, from top to bottom
2. **Loops**: Use `.times` and `do..end` blocks to repeat actions
3. **Problem Solving**: Break down complex movements into simple steps
4. **Debugging**: When code doesn't work, figure out why and fix it
5. **Spatial Reasoning**: Visualize movements on a 2D grid
6. **Ruby Syntax**: Learn real Ruby programming syntax

## 🔒 Security Features

PetCoder takes security seriously when executing user code:

- **Docker Isolation**: Code runs in isolated containers
- **No Network Access**: `--network=none` prevents internet access
- **Memory Limits**: Maximum 32MB RAM per execution
- **CPU Limits**: 0.5 CPU cores maximum
- **Read-Only Filesystem**: No file system modifications allowed
- **Timeout Protection**: 1-second execution limit
- **Capability Dropping**: All Linux capabilities removed
- **Dangerous Method Removal**: Unsafe Ruby methods are disabled

## 📊 Game Mechanics

- **Lives**: Start with 3 ❤️ lives per game
- **Points**: Earn 100 points for completing each level
- **Bonus Points**: Collect treats for extra points
- **Grid Size**: 10x10 grid for pet movement
- **Multiple Levels**: Progress through increasingly difficult challenges

## 🤝 Contributing

This is an educational project! Contributions are welcome:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request


## 🙏 Acknowledgments

- Built with ❤️ for kids learning to code
- Inspired by games like Scratch
- Uses beautiful pet and nature graphics to make learning fun!

---

**Have fun coding and helping your pet reach its goals! 🐾✨**
