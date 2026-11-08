# DJIMicKey · DJI Microphone Button Mapper for Windows

[中文](README.md) | English

DJIMicKey (DJI Mic Key) maps a DJI wireless microphone transmitter’s pairing/link button to a configurable key or keyboard shortcut. It can control voice features and other actions supported by the target application.

This version adds support for the camera USB receiver `2CA3:4015`, with configurable key mappings.

[Download the Windows x64 portable package v1.1.0](https://github.com/niki2027/DJIMicKey/releases/download/v1.1.0/DJIMicKey-v1.1.0-win-x64-portable.zip) · [All releases](https://github.com/niki2027/DJIMicKey/releases)

Requirements: Windows 10/11 x64 and .NET Framework 4.8.

## Verified hardware and connection

DJI Mini RS transmitter → wireless connection → camera receiver → USB-C to USB-C (C2C) data cable → Windows desktop PC.

The receiver identifies as `2CA3:4015`. A user has confirmed this setup works on their PC. Upstream support for `2CA3:4011` is retained. Other models, direct Bluetooth connections and 3.5 mm audio connections were not verified in this setup.

## Quick start

1. Download the complete portable ZIP, exit any older instance and extract it into a separate folder.
2. Keep `DJIMicKey.exe` and `DJIMicKey.Shell.dll` together. Run the EXE and connect the receiver.
3. Verify the target application’s shortcut with a physical keyboard. Click the shortcut-recording button, enter your key or combination, then apply and save it.
4. Briefly press the transmitter’s pairing/link button to send the saved shortcut. Mapping can be paused, and the app can run in the system tray.

No fixed key combination is required. Applications such as ChatGPT must support the desired keyboard shortcut themselves; this tool sends keystrokes. Windows `Win+H` dictation is not a ChatGPT voice session.

## Features and limitations

- Records and saves single keys or combinations, including left/right modifier keys.
- Shows the detected receiver ID and microphone level, with tray operation and optional startup.
- Normal Raw Input mode filters by receiver source. If initialization fails, the existing keyboard fallback may also map Volume Up from other devices. Pause mapping if this occurs.
- Volume Up suppression may affect other sources on the same desktop. Pausing or fully exiting restores their handling.
- Audio is not saved or uploaded. Diagnostics are opt-in and intended for local troubleshooting. Do not submit personal information, settings or diagnostic logs to the public repository.

See the [Windows guide](docs/WINDOWS.md) and [validation scope](docs/VALIDATION.md) for details. These additional guides are currently in Chinese.

## Clone and contribute

```sh
git clone https://github.com/niki2027/DJIMicKey.git
```

The project uses C#, WinForms, .NET Framework and a companion C DLL. Issues and pull requests for compatibility, features and documentation are welcome. See [CONTRIBUTING.md](CONTRIBUTING.md) for build and contribution instructions.

For compatibility feedback, open an [issue](https://github.com/niki2027/DJIMicKey/issues) with the receiver model, product-level USB ID and Windows version. Do not include serial numbers or private logs. If the project is useful to you, you are welcome to Star it.

## Origin and license

This project is derived from [111jc/DJIMicKey](https://github.com/111jc/DJIMicKey), adding camera-receiver compatibility and Windows build/distribution configuration.

Codex assisted with the camera-receiver adaptation (USB ID `2CA3:4015`), which the maintainer tested on a Windows PC.

The application retains the upstream [MIT license](LICENSE) and copyright notices. See [NOTICE.md](NOTICE.md) for attribution and [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) for runtime licenses.

This is a community project and is not officially affiliated with DJI, OpenAI or the target applications.
