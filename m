Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:60201 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725936AbfEIF1i (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 9 May 2019 01:27:38 -0400
From: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: [PATCH] generic/530: fix shutdown failure of generic/530 in overlay
Date: Thu,  9 May 2019 13:26:56 +0800
Message-Id: <1557379616-13850-1-git-send-email-jefflexu@linux.alibaba.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: darrick.wong@oracle.com, Jeffle Xu <jefflexu@linux.alibaba.com>
List-ID: <fstests@vger.kernel.org>

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
 tests/generic/530 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

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
-- 
1.8.3.1
