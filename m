Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:37211 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726806AbfEJDSE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 9 May 2019 23:18:04 -0400
From: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: [PATCH v2] generic/530: fix shutdown failure of generic/530 in overlay
Date: Fri, 10 May 2019 11:17:41 +0800
Message-Id: <1557458261-1878-1-git-send-email-jefflexu@linux.alibaba.com>
In-Reply-To: <1557379616-13850-1-git-send-email-jefflexu@linux.alibaba.com>
References: <1557379616-13850-1-git-send-email-jefflexu@linux.alibaba.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: darrick.wong@oracle.com, cgxu519@icloud.com, amir73il@gmail.com, caspar@linux.alibaba.com, Jeffle Xu <jefflexu@linux.alibaba.com>
List-ID: <fstests@vger.kernel.org>

Testcases are recommended to use  _require_scratch_shutdown()
and _scratch_shutdown() pair helper function to test and execute
shutdown.

generic/530 formmerly used _require_scratch_shutdown() to test
whether the filesystem supports shutdown or not, while executed
the shutdown action in a raw binary (src/t_open_tmpfiles) rather
than the recommended _scratch_shutdown() helper. This will cause
a "shutdown: Inappropriate ioctl for device" error message when
testing overlay filesystem.

This patch simply move the shutdown action from the raw binary
into the packaged _scratch_shutdown() helper. That is, we remove
the "shutdown" interface of t_open_tmpfiles.c and call
_scratch_shutdown() in genric/530 and xfs/501.

I did some tests on this patch. ext4 and overlay pass generic/530
and generic/531. However there is some problem with xfs, even in
the original version (that is, without this patch applied).

When I run "./check xfs/501" or "./check xfs/502" with xfs, I get
the follwing error message

```
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 iZuf6h1kfgutxc3el68z2lZ 4.19.36+
MKFS_OPTIONS  -- -f -bsize=4096 /dev/vdc
MOUNT_OPTIONS -- /dev/vdc /mnt/scratch

xfs/501 [not run] XFS error injection iunlink_fallback unknown on this
kernel.
```

And when I run "./check generic/530" or "./check generic/531" with
xfs, I get the following error message

```
 ./check generic/530
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 iZuf6h1kfgutxc3el68z2lZ 4.19.36+
MKFS_OPTIONS  -- -f -bsize=4096 /dev/vdc
MOUNT_OPTIONS -- /dev/vdc /mnt/scratch

generic/530 1s ...
Message from syslogd@iZuf6h1kfgutxc3el68z2lZ at May 10 10:01:33 ...
 kernel:XFS: Assertion failed: VFS_I(ip)->i_nlink == 0, file:
fs/xfs/xfs_log_recover.c, line: 5074
```

and the kernel just hangs

```
[   28.064762] XFS (vdc): Unmounting Filesystem
[   28.114884] XFS (vdc): Mounting V5 Filesystem
[   28.153505] XFS (vdc): Starting recovery (logdev: internal)
[   28.191680] XFS: Assertion failed: VFS_I(ip)->i_nlink == 0, file:
fs/xfs/xfs_log_recover.c, line: 5074
[   28.193064] ------------[ cut here ]------------
[   28.193655] kernel BUG at fs/xfs/xfs_message.c:102!
[   28.194302] invalid opcode: 0000 [#1] SMP NOPTI
[   28.195226] CPU: 13 PID: 2292 Comm: mount Not tainted 4.19.36+ #82
[   28.196392] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/24
[   28.198323] RIP: 0010:assfail+0x28/0x30
[   28.198801] Code: c3 90 0f 1f 44 00 00 48 89 f1 41 89 d0 48 c7 c6 88
e9 0a b5 48 89 fa 31 ff e8 84 fa ff ff 80 3d 55 e7 eea
[   28.201330] RSP: 0018:ffffa23a8378fc90 EFLAGS: 00010202
[   28.202009] RAX: 00000000ffffffea RBX: ffff903e2688bc00 RCX:
0000000000000000
[   28.202943] RDX: 00000000ffffffc0 RSI: 000000000000000a RDI:
ffffffffb5067827
[   28.203884] RBP: 0000000000000000 R08: 0000000000000000 R09:
0000000000000000
[   28.204815] R10: 0000000000000000 R11: f000000000000000 R12:
0000000000000000
[   28.205713] R13: 0000000000000000 R14: ffff903e2747a200 R15:
0000000000000000
[   28.206643] FS:  00007f828026d880(0000) GS:ffff903e3bb40000(0000)
knlGS:0000000000000000
[   28.207704] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   28.208443] CR2: 00007f827f55f8f3 CR3: 0000000139f22006 CR4:
00000000003606a0
[   28.209370] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[   28.210301] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[   28.211231] Call Trace:
[   28.211524]  xlog_recover_process_one_iunlink+0x122/0x150
[   28.212224]  ? up+0x12/0x60
[   28.212549]  xlog_recover_process_iunlinks.isra.28+0x70/0xa0
[   28.213272]  xlog_recover_finish+0x33/0xa0
[   28.213778]  xfs_log_mount_finish+0x6f/0x110
[   28.214315]  xfs_mountfs+0x611/0x890
[   28.214739]  xfs_fs_fill_super+0x463/0x620
[   28.215245]  ? xfs_test_remount_options+0x60/0x60
[   28.215833]  mount_bdev+0x170/0x1a0
[   28.216266]  mount_fs+0x36/0x140
```

Is there some indication?

-------------------------
Following is the old commit message:

We got "shutdown: Inappropriate ioctl for device" when running
"./check -overlay generic/530". The error message is due to the
XFS_IOC_GOINGDOWN ioctl used in generic/530.

Though _require_scratch_shutdown() is called to test whether the
tested filesystem supports XFS_IOC_GOINGDOWN ioctl or not, a piece
of C code snippet in src/t_open_tmpfiles.c is used to shutdown the
filesysetm, rather than calling the corresponding helper function
_scratch_shutdown().

Let me explain it clearly:

1. suppose the config is

```
export TEST_DEV=/dev/vdb
export TEST_DIR=/mnt/test
export SCRATCH_DEV=/dev/vdc
export SCRATCH_MNT=/mnt/scratch
```

2. When running "./check -overlay generic/530", the scratch device,
/dev/vdc is mounted on /mnt/scratch, and the overlay filesystem is
mounted on /mnt/scratch/mnt using the follwing command

```
mount -t overlay -o lowerdir=/mnt/scratch/ovl-lower \
-o upperdir=/mnt/scratch/ovl-upper/ -o workdir=/mnt/scratch/ovl-work/ \
overlay /mnt/scratch/ovl-mnt
```

3. In this case, _require_scratch_shutdown() will inspect whether the
underlying upper system, that is **/mnt/scratch/**, supports shutdown
feature or not. In my test, the underlying system of overlay (that is
/dev/vdc) is ext4, and thus it passes the _require_scratch_shutdown
test.

4. However, the C code executing the shutdown action in t_open_tmpfiles.c
actually execute XFS_IOC_GOINGDOWN ioctl on the mount point of overlay
filesystem, that is **/mnt/scratch/ovl-mnt**. Since overlay doesn't support
XFS_IOC_GOINGDOWN ioctl, it fails naturally.

5. So we should use _scratch_shutdown() to shutdown if we have used
_require_scratch_shutdown

As for the solution to fix the failure, I temporarily move the shutdown
action from t_open_tmpfiles into generic/530 as the workaround. How would
you think @Darrick? Maybe there is a better solution but I'm not sure.

thx

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 src/t_open_tmpfiles.c | 19 -------------------
 tests/generic/530     |  4 +++-
 tests/xfs/501         |  4 +++-
 3 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/src/t_open_tmpfiles.c b/src/t_open_tmpfiles.c
index da9390f..0393c6b 100644
--- a/src/t_open_tmpfiles.c
+++ b/src/t_open_tmpfiles.c
@@ -24,7 +24,6 @@ static int min_fd = -1;
 static int max_fd = -1;
 static unsigned int nr_opened = 0;
 static float start_time;
-static int shutdown_fs = 0;
 
 void clock_time(float *time)
 {
@@ -69,22 +68,6 @@ void die(void)
 				end_time - start_time);
 		fflush(stdout);
 
-		if (shutdown_fs) {
-			/*
-			 * Flush the log so that we have to process the
-			 * unlinked inodes the next time we mount.
-			 */
-			int flag = XFS_FSOP_GOING_FLAGS_LOGFLUSH;
-			int ret;
-
-			ret = ioctl(min_fd, XFS_IOC_GOINGDOWN, &flag);
-			if (ret) {
-				perror("shutdown");
-				exit(2);
-			}
-			exit(0);
-		}
-
 		clock_time(&start_time);
 		for (fd = min_fd; fd <= max_fd; fd++)
 			close(fd);
@@ -160,8 +143,6 @@ int main(int argc, char *argv[])
 		if (ret)
 			perror(argv[1]);
 	}
-	if (argc > 2 && !strcmp(argv[2], "shutdown"))
-		shutdown_fs = 1;
 
 	clock_time(&start_time);
 	while (1)
diff --git a/tests/generic/530 b/tests/generic/530
index b0d188b..56c6d32 100755
--- a/tests/generic/530
+++ b/tests/generic/530
@@ -49,7 +49,9 @@ ulimit -n $max_files
 
 # Open a lot of unlinked files
 echo create >> $seqres.full
-$here/src/t_open_tmpfiles $SCRATCH_MNT shutdown >> $seqres.full
+$here/src/t_open_tmpfiles $SCRATCH_MNT >> $seqres.full
+_scratch_shutdown -f
+
 
 # Unmount to prove that we can clean it all
 echo umount >> $seqres.full
diff --git a/tests/xfs/501 b/tests/xfs/501
index 974f341..4be9997 100755
--- a/tests/xfs/501
+++ b/tests/xfs/501
@@ -54,7 +54,9 @@ ulimit -n $max_files
 
 # Open a lot of unlinked files
 echo create >> $seqres.full
-$here/src/t_open_tmpfiles $SCRATCH_MNT shutdown >> $seqres.full
+$here/src/t_open_tmpfiles $SCRATCH_MNT >> $seqres.full
+_scratch_shutdown -f
+
 
 # Unmount to prove that we can clean it all
 echo umount >> $seqres.full
-- 
1.8.3.1
