#!/bin/bash

# --- GPU Power (NVIDIA) ---
GPU_W=$(nvidia-smi --query-gpu=power.draw --format=csv,noheader,nounits | awk '{printf "%.0f", $1}')

# --- CPU Power (Intel using turbostat) ---
# Using the correct path for turbostat on your system.
CPU_W=$(sudo /usr/bin/turbostat --show PkgWatt --interval=0.1 --num_iterations=1 2>/dev/null | tail -1 | awk '{printf "%.0f", $1}')

# --- Calculate Total and Display ---
# Check if CPU_W has a value to avoid math errors if the command fails.
#if [[ -n "$CPU_W" ]]; then
#    TOTAL_W=$((GPU_W + CPU_W))
#    echo "CPU: ${CPU_W}W | GPU: ${GPU_W}W | Total: ${TOTAL_W}W"
#else
#    # Fallback output if CPU command fails for any reason
#    echo "CPU: N/A | GPU: ${GPU_W}W"
#fi
echo -e "c${CPU_W}\n\ng${GPU_W}"
