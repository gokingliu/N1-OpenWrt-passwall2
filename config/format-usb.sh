#!/bin/sh

DEVICE="/dev/sda"    # 磁盘设备路径
MOUNT_POINT="/opt"    # 挂载点路径

# 检查设备是否存在
if [ ! -b "$DEVICE" ]; then
  echo "设备 $DEVICE 不存在"
  exit 1
fi

# 检查磁盘挂载状态
if mountpoint -q "$MOUNT_POINT"; then
  echo "设备 $DEVICE 的剩余空间已经挂载到 $MOUNT_POINT"
  exit 0
fi

# 获取磁盘剩余空间大小
FREE_SPACE=$(df -BM --output=avail "$DEVICE" | tail -n 1 | awk '{print $1}' | sed 's/M//')

# 确保设备有剩余空间可用
if [ "$FREE_SPACE" -lt 1024 ]; then
  echo "设备 $DEVICE 的剩余空间不足 1GB，无法进行格式化和挂载"
  exit 1
fi

# 创建分区
echo -e "n\np\n\n\n\nt\n83\nw" | fdisk "$DEVICE"

# 获取新分区设备路径
PARTITION="${DEVICE}1"

# 格式化分区为ext4文件系统
mkfs.ext4 "$PARTITION"

# 挂载分区
mkdir -p "$MOUNT_POINT"
mount "$PARTITION" "$MOUNT_POINT"

# 将挂载信息写入/etc/fstab，确保下次启动时自动挂载
echo "$PARTITION $MOUNT_POINT ext4 defaults 0 0" >> /etc/fstab

echo "磁盘剩余空间已格式化并挂载到 $MOUNT_POINT"
