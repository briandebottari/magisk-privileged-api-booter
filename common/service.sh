#!/system/bin/sh
MODDIR=${0%/*}
#encryption detection
# [ $(getprop ro.crypto.state) = "encrypted" ] || echo "unencrypted"
#boot detection
until [ $(getprop init.svc.bootanim) = "stopped" ]
do
sleep 2
done
#app_process
if [ -f /system/bin/app_process64 ]
then
ln -sf /system/bin/app_process64 /data/local/tmp/app_process
else
ln -sf /system/bin/app_process32 /data/local/tmp/app_process
fi
PATH=/data/local/tmp:$PATH
[[ -z $SHELL ]] && SHELL=/system/bin/sh
{ #brevent server
cat /data/data/me.piebridge.brevent/brevent.sh |$SHELL
} &
{ #shizuku server
cat /sdcard/Android/data/moe.shizuku.privileged.api/files/start.sh |$SHELL
} &
{ #storage redirect
cat /data/data/moe.shizuku.redirectstorage/files/start.sh |$SHELL
} &
