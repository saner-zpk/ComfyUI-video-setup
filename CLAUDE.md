# Project: ComfyUI Video Workflow Setup

基于 ComfyUI v0.7.0 的 AI 视频生成工作流环境，含 AnimateDiff + VideoHelperSuite 插件。

## Tech Stack
- Python 3.12 (venv), PyTorch 2.2.2 (CPU mode)
- ComfyUI (commit 4f3f9e72, before comfy-kitchen requirement)
- Plugins: ComfyUI-Manager, AnimateDiff-Evolved, VideoHelperSuite

## Commands
```bash
source venv/bin/activate
python main.py --cpu        # Intel Mac (无 GPU)
python main.py              # NVIDIA GPU
```

## Key Paths
- `models/checkpoints/` — 基础模型（需手动下载 SD 1.5）
- `models/animatediff_models/` — 运动模块（需手动下载）
- `custom_nodes/` — 插件目录
- `user/default/workflows/` — 工作流模板

## Notes
- Intel Mac + CPU 模式性能极低，仅用于学习工作流搭建
- 模型文件过大（4GB+），未被 git 跟踪
- 分支 `comfyui-video-setup` 包含所有自定义配置
