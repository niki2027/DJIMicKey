# DJIMicKey · 大疆麦克风按键映射工具

**DJIMicKey（DJI Mic Key）**是一个轻量 Windows 工具：把大疆无线麦克风发射器的配对／连接键，映射为你自己设置的按键或快捷键。可用于目标应用支持的语音启停等操作，例如 ChatGPT 语音功能。

Windows shortcut mapper for DJI microphones and USB camera receivers, with configurable key bindings.

## 已验证的连接方式

**大疆 Mini RS 麦克风 → 无线连接相机版接收器 → USB-C to USB-C（C2C）数据线 → Windows 台式电脑。**

本次实测接收器标识为 **`2CA3:4015`**，已由使用者确认在其电脑上正常工作。本版本同时保留上游 `2CA3:4011` 接收器支持；其他硬件、蓝牙直连和 3.5 mm 音频连接未纳入本次验证。

## 下载与使用

运行环境：**Windows 10/11 x64、.NET Framework 4.8**。

1. 从 [Releases 下载最新版完整便携 ZIP](https://github.com/niki2027/DJIMicKey/releases/latest)，完全退出旧版后解压到独立文件夹。
2. 保持 `DJIMicKey.exe` 和 `DJIMicKey.Shell.dll` 在同一目录，运行 EXE，连接接收器并检查设备状态。
3. 先用实体键盘确认目标应用的快捷键有效，再点击“开始录制”，录入你需要的按键或组合键，点击“应用并保存”。
4. 短按麦克风发射器的配对／连接键，触发已保存的快捷键。可暂停映射、最小化到托盘或退出程序。

**映射可以自定义**，无需固定使用某一组按键。ChatGPT 不同客户端或版本的快捷键能力可能不同；本工具发送快捷键，不代替目标应用提供语音功能，也不把 Windows `Win+H` 听写当作 ChatGPT 语音会话。

## 功能与范围

- 支持单键或组合键录制、保存，以及左右修饰键区分。
- 显示接收器实际 USB ID 和麦克风输入电平，支持托盘运行与可选开机启动。
- 不保存或上传音频；本机可选诊断用于排查按键事件，发行包不包含个人日志、设置或设备采集数据。
- 正常 Raw Input 模式按接收器来源筛选；若该监听初始化失败，现有键盘回退路径可能使其他来源的音量加键触发映射。遇到此情况应暂停映射并检查本机状态。
- 音量增加抑制可能同时影响桌面上其他来源的音量加键；暂停或完全退出后恢复。系统音量变化与快捷键是否生效需分别判断。

本机实测通过与 Windows 自动测试通过分别记录，详见 [验证范围](docs/VALIDATION.md)。完整操作见 [Windows 使用说明](docs/WINDOWS.md)。

## 克隆与参与开发

```sh
git clone https://github.com/niki2027/DJIMicKey.git
```

项目使用 C#、WinForms、.NET Framework 和一个自带的 C 语言 Shell DLL。开发者可在 Windows x64 上安装 MinGW-w64 x64 GCC，运行 `Build.cmd`、`Test.cmd` 和 `Release.cmd`；最终用户无需编译器。欢迎通过 Issues 和 Pull Requests 提交兼容反馈与改进，具体要求见 [CONTRIBUTING.md](CONTRIBUTING.md)。

## 来源与许可证

本项目基于 [111jc/DJIMicKey](https://github.com/111jc/DJIMicKey) 改进，主要增加相机版接收器兼容及 Windows 构建分发配置，保留原有自定义快捷键功能。沿用 [MIT 许可证](LICENSE)，保留上游版权声明；派生关系见 [NOTICE.md](NOTICE.md)，运行库许可见 [第三方说明](THIRD_PARTY_NOTICES.md)。

这是社区工具，与 DJI、OpenAI 或其他目标应用无官方隶属关系。
