# pc_bios
```
qemu-system-x86_64 -kernel out/bin/vmlinuz -drive file=out/bin/rootfs.img,if=virtio,format=raw -append "root=/dev/vda init=/sbin/init vga=0x37E devtmpfs.mount=0"
```
