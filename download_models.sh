#!/bin/bash
# ComfyUI 视频工作流模型下载脚本
# 使用方法: bash download_models.sh
# 如果下载失败，可以手动用浏览器打开对应链接下载

set -e
MODELS_DIR="$(cd "$(dirname "$0")" && pwd)/models"

echo "=========================================="
echo "  ComfyUI 视频工作流模型下载"
echo "=========================================="
echo ""
echo "目标目录: $MODELS_DIR"
echo ""

# 方法1: 使用 huggingface 镜像
download_hf() {
    local REPO="$1"
    local FILE="$2"
    local DEST="$3"
    local URL="https://hf-mirror.com/${REPO}/resolve/main/${FILE}"

    echo "下载: $FILE"
    echo "URL: $URL"

    if command -v aria2c &> /dev/null; then
        aria2c -x 4 -s 4 --continue=true -d "$DEST" "$URL"
    elif command -v wget &> /dev/null; then
        wget -c -P "$DEST" "$URL"
    else
        curl -C - -L -o "${DEST}/${FILE}" "$URL"
    fi
    echo "完成: ${DEST}/${FILE}"
    echo ""
}

# 方法2: 使用 ModelScope (备选)
download_ms() {
    echo "请手动下载以下文件："
    echo ""
    echo "1. SD 1.5 模型 (~4GB):"
    echo "   https://www.modelscope.cn/models/AI-ModelScope/stable-diffusion-v1-5/resolve/master/v1-5-pruned-emaonly.safetensors"
    echo "   保存到: ${MODELS_DIR}/checkpoints/"
    echo ""
    echo "2. AnimateDiff 运动模块 (~400MB):"
    echo "   https://www.modelscope.cn/models/AI-ModelScope/animatediff-motion-modules/resolve/master/mm_sd_v15_v2.ckpt"
    echo "   保存到: ${MODELS_DIR}/animatediff_models/"
    echo ""
}

# 创建目标目录
mkdir -p "${MODELS_DIR}/checkpoints"
mkdir -p "${MODELS_DIR}/animatediff_models"

# 下载 SD 1.5 checkpoint
echo "--- 下载 SD 1.5 基础模型 ---"
download_hf "runwayml/stable-diffusion-v1-5" \
    "v1-5-pruned-emaonly.safetensors" \
    "${MODELS_DIR}/checkpoints"

# 下载 AnimateDiff motion module
echo "--- 下载 AnimateDiff 运动模块 ---"
download_hf "guoyww/animatediff" \
    "mm_sd_v15_v2.ckpt" \
    "${MODELS_DIR}/animatediff_models"

echo "=========================================="
echo "  下载完成！"
echo ""
echo "  模型位置:"
echo "  - SD 1.5: ${MODELS_DIR}/checkpoints/v1-5-pruned-emaonly.safetensors"
echo "  - Motion:  ${MODELS_DIR}/animatediff_models/mm_sd_v15_v2.ckpt"
echo ""
echo "  启动 ComfyUI:"
echo "  source venv/bin/activate && python main.py --cpu"
echo "=========================================="
