Received: from mail.cn.fujitsu.com ([183.91.158.132]:2787 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725767AbfGBKkz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 2 Jul 2019 06:40:55 -0400
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 1DCEC4CDE647
        for <fstests@vger.kernel.org>; Tue,  2 Jul 2019 18:40:53 +0800 (CST)
From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: [PATCH] generic/042: add sleep before shutdown
Date: Thu, 27 Jun 2019 07:51:45 +0800
Message-ID: <1561593105-24164-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: fstests@vger.kernel.org
Cc: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

On some server machines, the memory was so big that we
don't have enough time to submit file.  After umoumt,
hexdump will report no such file or directory on ext4.
memory=EF=BC=9A128G
swap:8G
fail as below:
-------------------------------------------
  falloc -k
  wrote 65536/65536 bytes at offset 0
 -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 +64 KiB, 16 ops; 0.0002 sec (282.805 MiB/sec and 72398.1900 ops/sec)
 +hexdump: /mnt/xfstests/scratch/042.mnt/file: No such file or directory
 +hexdump: all input file arguments failed
-------------------------------------------

I think we should reserve a short time, so umount will not lose file.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 tests/generic/042 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/generic/042 b/tests/generic/042
index 6c62eb63..e1453114 100755
--- a/tests/generic/042
+++ b/tests/generic/042
@@ -56,6 +56,10 @@ _crashtest()
 	# write, run the test command and shutdown the fs
 	$XFS_IO_PROG -f -c "pwrite -S 1 0 64k" -c "$cmd 60k 4k" $file | \
 		_filter_xfs_io
+
+	# keep file not lose when umount even on server machine
+	sleep 10
+
 	./src/godown -f $mnt
=20
 	$UMOUNT_PROG $mnt
--=20
2.18.1
