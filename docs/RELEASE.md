# DJIMicKey v1.1.0

DJIMicKey（DJI Mic Key）是 Windows 上的大疆麦克风按键映射工具：将发射器的配对／连接键转换成自定义按键或快捷键，可用于目标应用支持的语音等快捷操作。

## 本版更新

- 增加 USB `2CA3:4015` 相机版接收器识别，保留 `2CA3:4011` 支持。
- 统一接收器探测与按键来源筛选，界面显示实际设备 ID。
- 保留自定义快捷键、麦克风电平、暂停映射及托盘运行。
- 发布完整 Windows x64 便携包，保留上游 MIT 许可与来源声明，不附带个人资料或诊断日志。

已验证组合为大疆 Mini RS 麦克风、相机版接收器，发射器无线连接接收器，接收器通过 USB-C to USB-C（C2C）连接 Windows 台式电脑。该组合已获得使用者实际运行正常的反馈；其他型号、连接方式和电脑环境仍需分别验证。

## 下载与使用

下载 `DJIMicKey-v1.1.0-win-x64-portable.zip`，可用同页的 `.sha256` 文件校验。GitHub 自动提供的 Source code ZIP 是源码，需要自行编译。

1. 使用 Windows 10/11 x64 和 .NET Framework 4.8，完全退出旧版，包括托盘实例。
2. 完整解压便携包，保持 `DJIMicKey.exe` 与 `DJIMicKey.Shell.dll` 同目录，运行 EXE。
3. 连接接收器，检查设备 ID；录制所需按键或组合后，点击“应用并保存”。
4. 先用实体键盘确认目标应用支持该快捷键，再按发射器配对／连接键测试。

ChatGPT 语音等目标功能取决于应用自身的快捷键支持，工具不预设通用 ChatGPT 语音组合。`Win+H` 是 Windows 听写，不等于 ChatGPT 语音会话。

音量增加抑制可能影响同一桌面的其他音量加来源；暂停或完全退出后应恢复。完整操作与限制见 `WINDOWS.md` 和 `SHELL_VOLUME_FILTER.md`。诊断仅用于本机排错，不要公开个人诊断、设置或录音。

本项目基于 [111jc/DJIMicKey](https://github.com/111jc/DJIMicKey) 改进，使用 MIT 许可证；原始许可及版权声明见 `LICENSE`，派生说明见 `NOTICE.md`。这是社区工具，与 DJI 官方无隶属关系。
