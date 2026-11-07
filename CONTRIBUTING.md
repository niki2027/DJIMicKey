# Contributing

DJI Mic Key is a small Windows desktop utility built with C# and Windows Forms.

欢迎通过 Issues 或 Pull Requests 提交兼容反馈、修复和文档改进。请说明 Windows 版本、产品级 VID/PID、连接方式、复现步骤和预期结果，分别报告自动测试与真实设备验证。不要附带个人设备采集或私人日志。

This fork is based on [111jc/DJIMicKey](https://github.com/111jc/DJIMicKey). Contributions are distributed under the project's existing MIT license. Preserve [LICENSE](LICENSE), upstream copyright notices and [NOTICE.md](NOTICE.md); describe derived changes without claiming sole authorship of the upstream code.

## Development

1. Use Windows 10/11 x64 with .NET Framework 4.8 and MinGW-w64 `gcc` on PATH (x64 target).
2. Run `Build.cmd` to compile and run the core checks.
3. Run `Test.cmd` from an interactive Windows desktop for layout, lifecycle and native shortcut-recording checks.
4. Run `Test.cmd --device` to additionally test a connected DJI receiver.

No NuGet packages or downloaded runtime are required. GCC builds the user-mode Shell hook DLL; end users do not need GCC. Distribute the EXE and DLL together. Generated files belong in `dist/` or `.build/`, both ignored by Git. Personal diagnostic captures belong in ignored `log/`.

## Changes

- Keep the executable small and avoid additional runtime dependencies.
- Preserve the distinction between receiver detection and an actual working transmitter/audio link.
- Do not filter all Windows-injected keyboard events: the DJI consumer-control key is reported with injected flags.
- Keep keyboard-hook callbacks short. Post UI work to the UI thread.
- Preserve left/right modifier keys when recording shortcuts.
- Dispose native hooks, audio capture and tray resources on exit.
- Use one persistent Raw Input mapping owner; stopping diagnostics must not unregister mapping. Keep Shell callbacks short and release the filter on pause, disconnect, recording, and exit.
- Never replace input suppression with unconditional volume changes. Shell interception is global for unhandled Volume Up while armed; document that scope honestly.
- Add a focused regression check for a behavioral bug; avoid testing cosmetic changes by mirroring their implementation.
- Test scaling and large text for UI changes. Do not change the developer's real Windows display settings in tests.
- Startup-registration tests must use an isolated temporary registry key and preserve other values.

Do not commit personal logs, recordings, settings, API keys, device serial numbers, full device-instance paths or generated executables. Product-level VID/PID values may be included when needed to describe compatibility. Releases must contain only allowlisted program files, necessary instructions, license and minimal build metadata; test reports remain on the build runner. Use synthetic fixtures for regression checks and a generic build identity for release automation.
