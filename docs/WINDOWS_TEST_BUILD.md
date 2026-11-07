# Windows x64 构建测试包

本构建包含 `2CA3:4015` 相机版接收器兼容，以及原有 `2CA3:4011` 和自定义快捷键支持。已收到大疆 Mini RS 麦克风、相机版接收器、C2C 连接 Windows 台式电脑的正常使用反馈；这与自动构建测试结果分别记录，详见 [VALIDATION.md](VALIDATION.md)。

## 下载与运行

正式版本从仓库 [Releases](https://github.com/niki2027/DJIMicKey/releases/latest) 下载。开发分支测试包位于 **Actions → Windows camera receiver test package → 成功运行记录 → Artifacts**，名称包含 `camera-4015` 与提交标识。GitHub 可能要求登录后下载 Actions 产物。

解压时如遇外层 ZIP 内还有 ZIP，继续解压，直到 `DJIMicKey.exe`、`DJIMicKey.Shell.dll`、说明和许可证位于同一目录。完全退出旧实例后再运行，避免混用不同版本文件。首次测试暂不开启开机启动。

用 USB 数据线连接相机版接收器，检查实际设备 ID。先用实体键盘验证目标应用的语音快捷键，再在程序中录入同一组合并测试配对／连接键。请同时检查暂停、退出、长按、连按和重连；音量增加抑制可能影响其他音量加来源。

`BUILD-INFO.txt` 记录该包的源码提交、Windows 运行链接与二进制校验值。工作流成功表示原有 `Test.cmd`、`Release.cmd` 及便携包完整性检查通过，不表示所有硬件或目标应用均已验证。

## 工作流与隐私

工作流支持开发分支推送和手动触发。首次使用 Fork 的 Actions，如 GitHub 提示启用工作流，先启用，再向匹配的分支推送新提交触发构建；没有运行记录时不能使用“重新运行”入口。

构建使用 Windows、.NET Framework 编译器和 MinGW-w64 x64 GCC。任何构建、测试或打包检查失败都应使工作流失败，失败运行不上传可运行程序包。

成功运行只上传完整程序 ZIP，不上传个人资料、设备诊断、设置或测试日志。GitHub 自身仍会生成标准构建控制台记录。本机诊断如用于排错，只留在本机。
