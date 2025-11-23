#!/bin/bash

# Clippy 警告检查脚本
# 使用 -W 标志但有警告时返回非零退出码

echo "Running Clippy with warning detection..."

# 运行 clippy 并捕获输出
output=$(cargo clippy --manifest-path ./Cargo.toml --all-features --workspace -- -W warnings -W clippy::unwrap_used -W clippy::expect_used 2>&1)
exit_code=$?

# 显示输出
echo "$output"

# 检查是否有编译错误 (exit_code != 0)
if [ $exit_code -ne 0 ]; then
    echo "❌ Clippy 编译失败，退出码: $exit_code"
    exit $exit_code
fi

# 检查是否有警告
if echo "$output" | grep -q "warning:"; then
    echo "⚠️  发现警告，返回退出码 1"
    exit 1
else
    echo "✅ 无警告，返回退出码 0"
    exit 0
fi