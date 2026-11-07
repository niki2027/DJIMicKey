# Artifact delivery and privacy

- Deliver executable test packages through verified HTTPS artifact downloads or a supported attachment export. Cloud filesystem paths are not download links.
- The current public repository is an authorized destination for test branches and Actions packages. Do not publish a formal Release or change the default branch without an explicit request.
- Exclude personal information, device captures, settings, recordings and logs from commits and downloadable packages. Use a generic build identity for new public commits.
- Upload only the complete portable ZIP. Keep intermediate test reports on the build runner; do not upload them as artifacts.
- Allow only the matching EXE/DLL, necessary Chinese instructions, LICENSE and minimal build metadata in the portable ZIP. Preserve upstream license and copyright notices.
- Verify that a build run and its artifact actually exist before providing a download link. Identify the artifact and note any GitHub sign-in requirement.
- Distinguish cross-compilation, Windows build/tests and real receiver/ChatGPT verification. Preparing a workflow or publishing a package does not prove hardware compatibility.
