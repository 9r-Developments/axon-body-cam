# Discord: https://discord.gg/9rdev

## 📝 Introduction

9K AXON body cam is a highly customizable body camera system designed for FiveM. This resource simulates the real-life AXON BODY cameras, adding realism to law enforcement roleplay. It supports both AXON BODY 3 and AXON BODY 4 models, perfect for police roleplay scenarios.

### ✨ Key Features

- Support for both AXON BODY 3 and AXON BODY 4 camera models
- Highly customizable UI interface, including ratio, position, and text formatting
- Generates unique camera device IDs
- Random device numbering system for added realism
- On/off sound effects and periodic audible notifications
- Multi-language support (currently English and Simplified Chinese)
- Animation effects when switching cameras
- No framework dependencies, can be used as a standalone resource
- Customizable command system

## 🛠️ Installation Instructions

1. Download this resource
2. Extract and rename the folder to `9k_axonbodycam`
3. Copy the folder to the `resources` directory of your FiveM server
4. Add the following line to your `server.cfg` file:
```
ensure 9k_axonbodycam
```
5. Restart your FiveM server

## 📁 Project Structure

```
9k_axonbodycam/
├── client/               # Client-related scripts
│   └── main.lua          # Main client file
├── config/               # Configuration files
│   └── config.lua        # Main configuration file
├── html/                 # UI-related files
│   ├── index.html        # UI main page
│   ├── script.js         # UI-related scripts
│   ├── style.css         # UI stylesheet
│   ├── BodyCamStart.wav  # Camera activation sound effect
│   ├── BodyCamStop.wav   # Camera deactivation sound effect
│   └── KlartextMonoBold.ttf # Font file
├── locales/              # Multi-language files
│   ├── en.lua            # English translation
│   └── zh.lua            # Simplified Chinese translation
├── server/               # Server-related scripts
│   └── main.lua          # Main server file
├── shared/               # Shared scripts
│   └── main.lua          # Shared functions and variables
└── fxmanifest.lua        # FiveM resource manifest file
```

## ⚙️ Configuration Options

There are various customizable options in the `config/config.lua` file:

### Basic Settings
- Language selection (English/Simplified Chinese)
- Standalone mode (no framework dependencies)
- Timezone settings
- Periodic notification interval

### Interface Settings
- UI ratio and position
- AXON logo display options
- Text spacing and shadows
- Background transparency

### Command Settings
- Customizable activation/deactivation commands

### Animation Settings
- Animation effects when switching cameras
- Disable animations in vehicles option

### Sound Settings
- Enable/disable sound effects
- Volume control
- Periodic notification options

## 🎮 Usage

### Basic Commands

- `/axon3` - Activate AXON BODY 3 camera
- `/axon4` - Activate AXON BODY 4 camera
- `/axonoff` - Turn off the currently active camera
- `/axonhelp` - Display help information

All commands can be customized in the configuration file.

## 🌐 Multi-language Support

Currently supported languages:
- English (en)
- Simplified Chinese (zh)

You can change the default language in the configuration file or add your own translations.

## 📄 License

This project is licensed under the [MIT](LICENSE) license - see the LICENSE file for details.
