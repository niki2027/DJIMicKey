# 第三方运行库许可

DJIMicKey 应用代码沿用上游 MIT 许可证，见 `LICENSE` 和 `NOTICE.md`。

配套的 `DJIMicKey.Shell.dll` 由 MinGW-w64 GCC 构建，可能包含 MinGW-w64 的启动／运行支持代码及静态链接的 GCC 运行支持代码。它们保留各自许可，不改变本项目应用代码的 MIT 许可。

随源码提供的许可原文位于 `licenses/`；便携 ZIP 将同名文件放在根目录：

- `MINGW-W64-COPYING.txt`：MinGW-w64 官方许可说明及 Zope Public License 2.1。
- `GCC-RUNTIME-EXCEPTION-3.1.txt`：GCC Runtime Library Exception 3.1。
- `GPL-3.0.txt`：GNU General Public License version 3 原文，与 GCC 运行库例外一同阅读。

官方来源：[MinGW-w64](https://github.com/mingw-w64/mingw-w64)、[MinGW-w64 COPYING](https://github.com/mingw-w64/mingw-w64/blob/master/COPYING)、[GCC 源码](https://gcc.gnu.org/git.html)、[GCC 运行库例外说明](https://www.gnu.org/licenses/gcc-exception-3.1.html)。本项目未修改这些运行库的源码；发布工作流通过公开的 MSYS2 MinGW-w64 工具链构建程序。

Windows 系统 DLL 和 .NET Framework 由用户的系统提供，不随本项目打包；编译器本身也不在便携包内。
