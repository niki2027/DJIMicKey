# DJIMicKey · 大疆麦克风按键映射工具

中文 | [English](README.en.md)

DJIMicKey（DJI Mic Key）是一个 Windows 工具，可将大疆无线麦克风发射器的配对／连接键，映射为自定义单键或组合快捷键，用于目标应用支持的语音启停等操作。

本版本增加相机版 USB 接收器 `2CA3:4015` 支持，按键映射可自定义。

[下载 Windows x64 便携包 v1.1.0](https://github.com/niki2027/DJIMicKey/releases/download/v1.1.0/DJIMicKey-v1.1.0-win-x64-portable.zip) · [查看全部版本](https://github.com/niki2027/DJIMicKey/releases)

运行环境：Windows 10/11 x64、.NET Framework 4.8。

## 已验证的设备与连接

大疆 Mini RS 发射器 → 无线连接相机版接收器 → USB-C to USB-C（C2C）数据线 → Windows 台式电脑。

接收器标识为 `2CA3:4015`，这套组合已由使用者确认正常工作。保留上游 `2CA3:4011` 支持；其他型号、蓝牙直连及 3.5 mm 音频连接未纳入本次验证。

## 使用方法

1. 下载完整便携 ZIP，完全退出旧版后解压到独立文件夹。
2. 保持 `DJIMicKey.exe` 与 `DJIMicKey.Shell.dll` 同目录，运行 EXE 并连接接收器。
3. 先用实体键盘验证目标应用的快捷键，再点击“开始录制”，录入所需按键或组合，点击“应用并保存”。
4. 短按发射器配对／连接键，触发保存的快捷键。可随时暂停映射、最小化到托盘或退出。

映射不要求固定组合。ChatGPT 等目标应用需要自行支持相应快捷键；本工具只负责发送按键。Windows `Win+H` 听写不等于 ChatGPT 语音会话。

## 功能与使用边界

- 支持单键、组合键录制和保存，可区分左右修饰键。
- 显示实际接收器 ID 和麦克风电平，支持托盘运行及可选开机启动。
- 正常 Raw Input 模式按接收器来源筛选。若初始化失败，现有键盘回退可能使其他设备的音量加键触发映射；遇到此情况应暂停映射。
- 音量增加抑制可能影响桌面上其他来源的音量加键，暂停或完全退出后恢复。
- 不保存或上传音频。诊断由使用者主动开启，仅用于本机排错；不要向公开仓库提交个人资料、设置或诊断日志。

完整操作见 [Windows 使用说明](docs/WINDOWS.md)，测试与硬件范围见 [验证说明](docs/VALIDATION.md)。

## 克隆与贡献

```sh
git clone https://github.com/niki2027/DJIMicKey.git
```

项目使用 C#、WinForms、.NET Framework 和配套 C 语言 DLL。欢迎通过 Issues 和 Pull Requests 改进兼容性、功能与文档。构建方法和提交要求见 [贡献指南](CONTRIBUTING.md)。

兼容反馈请在 [Issues](https://github.com/niki2027/DJIMicKey/issues) 中说明接收器型号、产品级 USB ID 和 Windows 版本，不附带序列号或私人日志。项目对你有帮助时，欢迎 Star 收藏。

## 来源与许可证

本项目基于 [111jc/DJIMicKey](https://github.com/111jc/DJIMicKey) 改进，主要增加相机版接收器兼容及 Windows 构建分发配置。

相机版接收器（USB ID `2CA3:4015`）的适配由 Codex 协助开发，并由维护者在 Windows 电脑上实测。

沿用 [MIT 许可证](LICENSE)，保留上游版权声明。派生说明见 [NOTICE.md](NOTICE.md)，运行库许可见 [第三方说明](THIRD_PARTY_NOTICES.md)。

这是社区工具，与 DJI、OpenAI 或其他目标应用无官方隶属关系。
