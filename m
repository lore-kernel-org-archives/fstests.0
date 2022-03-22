Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4769C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Mar 2022 18:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240414AbiCVSbW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240431AbiCVSbU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Mar 2022 14:31:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC61E90FDE
        for <fstests@vger.kernel.org>; Tue, 22 Mar 2022 11:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647973789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bNJ05AMcgOeWsmMw0JHS08Q4cNVQh/JH+evXmCJR5Ao=;
        b=WuDDlvV0K8R5Qnuiexg+b5H7LrZyTXbJzDuwqXQfEn7Z+CPCdZvjBACfkgvfcW0COr3H+N
        hWsDVKiPpwTE0QgPQJ7cPahl7YVfOvDBcZHojeye3OPF5CnOOclIzJumO7EOFZkutIYwZc
        KMhf8MAsSMy1XkdxM9wstlzZhh0XX8M=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-JlNGqODhPTaa4wvr3Uxlgw-1; Tue, 22 Mar 2022 14:29:43 -0400
X-MC-Unique: JlNGqODhPTaa4wvr3Uxlgw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B17483C174C1;
        Tue, 22 Mar 2022 18:29:42 +0000 (UTC)
Received: from zlang-laptop.redhat.com (ovpn-13-229.pek2.redhat.com [10.72.13.229])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1FCFE2166B2D;
        Tue, 22 Mar 2022 18:29:38 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Cc:     david@fromorbit.com, djwong@kernel.org
Subject: [PATCH v2 1/2] xfstests: replace hexdump with od command
Date:   Wed, 23 Mar 2022 02:29:25 +0800
Message-Id: <20220322182926.1829846-2-zlang@redhat.com>
In-Reply-To: <20220322182926.1829846-1-zlang@redhat.com>
References: <20220322182926.1829846-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The "od" is one of the most fundamental commands in GNU/Linux and
most Unix-like systems. So we nearly always can count on it, don't
need to check if it's installed.

The "hexdump" isn't such fundamental as "od", some systems don't
install it by default. And as "od" nearly can replace all functions
of "hexdump", so let's use an unified command "od" to do the hexdump
job in fstests cases.

Signed-off-by: Zorro Lang <zlang@redhat.com>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
---
 common/rc             |  12 +
 tests/ceph/002        |   2 +-
 tests/ceph/002.out    |   8 +-
 tests/f2fs/001        |   4 +-
 tests/f2fs/001.out    |  16 +-
 tests/generic/029     |  12 +-
 tests/generic/029.out |  68 +--
 tests/generic/030     |  12 +-
 tests/generic/030.out |  48 +-
 tests/generic/031     |   4 +-
 tests/generic/031.out |  16 +-
 tests/generic/032     |   2 +-
 tests/generic/032.out |   4 +-
 tests/generic/033     |   2 +-
 tests/generic/033.out |   4 +-
 tests/generic/042     |   4 +-
 tests/generic/086     |   2 +-
 tests/generic/086.out |  14 +-
 tests/generic/404     |   2 +-
 tests/generic/404.out | 996 +++++++++++++++++++++---------------------
 tests/generic/536     |   4 +-
 tests/generic/567     |   4 +-
 tests/generic/567.out |  16 +-
 tests/generic/612     |   4 +-
 tests/generic/612.out |   8 +-
 tests/generic/639     |   2 +-
 tests/generic/639.out |   4 +-
 27 files changed, 643 insertions(+), 631 deletions(-)

diff --git a/common/rc b/common/rc
index d326572f..3158fea2 100644
--- a/common/rc
+++ b/common/rc
@@ -4856,6 +4856,18 @@ _require_kernel_config()
 	_has_kernel_config $1 || _notrun "Installed kernel not built with $1"
 }
 
+_hexdump()
+{
+	# Hex format address and data output
+	od -Ax -t x1z $*
+}
+
+# Disable hexdump, turn to use "od" command in _hexdump
+hexdump()
+{
+	_fail "Use _hexdump(), please!"
+}
+
 init_rc
 
 ################################################################################
diff --git a/tests/ceph/002 b/tests/ceph/002
index ac3d65b5..02f66842 100755
--- a/tests/ceph/002
+++ b/tests/ceph/002
@@ -59,7 +59,7 @@ $XFS_IO_PROG -c "truncate 0" $dest >> $seqres.full 2>&1
 # copy the whole file over
 $XFS_IO_PROG -c "copy_range -s 0 -d 0 -l $(($objsz * 3)) $file" "$dest"
 
-hexdump $dest
+_hexdump $dest
 
 #success, all done
 status=0
diff --git a/tests/ceph/002.out b/tests/ceph/002.out
index 6f067250..f7f1c0ba 100644
--- a/tests/ceph/002.out
+++ b/tests/ceph/002.out
@@ -1,8 +1,8 @@
 QA output created by 002
-0000000 6161 6161 6161 6161 6161 6161 6161 6161
+000000 61 61 61 61 61 61 61 61 61 61 61 61 61 61 61 61  >aaaaaaaaaaaaaaaa<
 *
-0400000 6262 6262 6262 6262 6262 6262 6262 6262
+400000 62 62 62 62 62 62 62 62 62 62 62 62 62 62 62 62  >bbbbbbbbbbbbbbbb<
 *
-0800000 6363 6363 6363 6363 6363 6363 6363 6363
+800000 63 63 63 63 63 63 63 63 63 63 63 63 63 63 63 63  >cccccccccccccccc<
 *
-0c00000
+c000000
diff --git a/tests/f2fs/001 b/tests/f2fs/001
index e2429e46..1141a63e 100755
--- a/tests/f2fs/001
+++ b/tests/f2fs/001
@@ -45,9 +45,9 @@ $XFS_IO_PROG -c "truncate 96" -c "pwrite -S 0x58 8192 4096" $testfile 2>&1 \
 	| _filter_xfs_io_error
 
 echo "==== check data contents ===="
-hexdump -C $testfile
+_hexdump $testfile
 _scratch_cycle_mount
-hexdump -C $testfile
+_hexdump $testfile
 
 rm $testfile
 rm $dummyfile
diff --git a/tests/f2fs/001.out b/tests/f2fs/001.out
index 997aa5b2..8a11d3f4 100644
--- a/tests/f2fs/001.out
+++ b/tests/f2fs/001.out
@@ -7,15 +7,15 @@ fallocate: No space left on device
 ==== change i_size & write data ====
 pwrite: No space left on device
 ==== check data contents ====
-00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
+000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
 *
-00000020  58 58 58 58 58 58 58 58  00 00 00 00 00 00 00 00  |XXXXXXXX........|
-00000030  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+000020 58 58 58 58 58 58 58 58 00 00 00 00 00 00 00 00  >XXXXXXXX........<
+000030 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
 *
-00000060
-00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
+000060
+000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
 *
-00000020  58 58 58 58 58 58 58 58  00 00 00 00 00 00 00 00  |XXXXXXXX........|
-00000030  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+000020 58 58 58 58 58 58 58 58 00 00 00 00 00 00 00 00  >XXXXXXXX........<
+000030 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
 *
-00000060
+000060
diff --git a/tests/generic/029 b/tests/generic/029
index 751e4f65..8b75c02a 100755
--- a/tests/generic/029
+++ b/tests/generic/029
@@ -39,10 +39,10 @@ $XFS_IO_PROG -t -f \
 $testfile | _filter_xfs_io
 
 echo "==== Pre-Remount ==="
-hexdump -C $testfile
+_hexdump $testfile
 _scratch_cycle_mount
 echo "==== Post-Remount =="
-hexdump -C $testfile
+_hexdump $testfile
 
 rm -f $testfile
 sync
@@ -64,10 +64,10 @@ $XFS_IO_PROG -t -f \
 $testfile | _filter_xfs_io
  
 echo "==== Pre-Remount ==="
-hexdump -C $testfile
+_hexdump $testfile
 _scratch_cycle_mount
 echo "==== Post-Remount =="
-hexdump -C $testfile
+_hexdump $testfile
 
 # third case is the same as second case, just with non-1k aligned offsets and
 # sizes.
@@ -84,10 +84,10 @@ $XFS_IO_PROG -t -f \
 $testfile | _filter_xfs_io
  
 echo "==== Pre-Remount ==="
-hexdump -C $testfile
+_hexdump $testfile
 _scratch_cycle_mount
 echo "==== Post-Remount =="
-hexdump -C $testfile
+_hexdump $testfile
 
 status=0
 exit
diff --git a/tests/generic/029.out b/tests/generic/029.out
index 457982c6..cf6019aa 100644
--- a/tests/generic/029.out
+++ b/tests/generic/029.out
@@ -2,64 +2,64 @@ QA output created by 029
 wrote 5120/5120 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 ==== Pre-Remount ===
-00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
+000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
 *
-00000800  59 59 59 59 59 59 59 59  59 59 59 59 59 59 59 59  |YYYYYYYYYYYYYYYY|
+000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  >YYYYYYYYYYYYYYYY<
 *
-00001400
+001400
 ==== Post-Remount ==
-00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
+000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
 *
-00000800  59 59 59 59 59 59 59 59  59 59 59 59 59 59 59 59  |YYYYYYYYYYYYYYYY|
+000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  >YYYYYYYYYYYYYYYY<
 *
-00001400
+001400
 wrote 5120/5120 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 ==== Pre-Remount ===
-00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
+000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
 *
-00000400  57 57 57 57 57 57 57 57  57 57 57 57 57 57 57 57  |WWWWWWWWWWWWWWWW|
+000400 57 57 57 57 57 57 57 57 57 57 57 57 57 57 57 57  >WWWWWWWWWWWWWWWW<
 *
-00000800  59 59 59 59 59 59 59 59  59 59 59 59 59 59 59 59  |YYYYYYYYYYYYYYYY|
+000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  >YYYYYYYYYYYYYYYY<
 *
-00001400
+001400
 ==== Post-Remount ==
-00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
+000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
 *
-00000400  57 57 57 57 57 57 57 57  57 57 57 57 57 57 57 57  |WWWWWWWWWWWWWWWW|
+000400 57 57 57 57 57 57 57 57 57 57 57 57 57 57 57 57  >WWWWWWWWWWWWWWWW<
 *
-00000800  59 59 59 59 59 59 59 59  59 59 59 59 59 59 59 59  |YYYYYYYYYYYYYYYY|
+000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  >YYYYYYYYYYYYYYYY<
 *
-00001400
+001400
 wrote 5121/5121 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 ==== Pre-Remount ===
-00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
+000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
 *
-00000200  58 57 57 57 57 57 57 57  57 57 57 57 57 57 57 57  |XWWWWWWWWWWWWWWW|
-00000210  57 57 57 57 57 57 57 57  57 57 57 57 57 57 57 57  |WWWWWWWWWWWWWWWW|
+000200 58 57 57 57 57 57 57 57 57 57 57 57 57 57 57 57  >XWWWWWWWWWWWWWWW<
+000210 57 57 57 57 57 57 57 57 57 57 57 57 57 57 57 57  >WWWWWWWWWWWWWWWW<
 *
-00000600  57 57 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |WWXXXXXXXXXXXXXX|
-00000610  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
+000600 57 57 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >WWXXXXXXXXXXXXXX<
+000610 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
 *
-000007f0  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 59  |XXXXXXXXXXXXXXXY|
-00000800  59 59 59 59 59 59 59 59  59 59 59 59 59 59 59 59  |YYYYYYYYYYYYYYYY|
+0007f0 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 59  >XXXXXXXXXXXXXXXY<
+000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  >YYYYYYYYYYYYYYYY<
 *
-000013f0  59 59 59 59 59 59 59 59  59 59 59 59 59 59 00 00  |YYYYYYYYYYYYYY..|
-00001400  00                                                |.|
-00001401
+0013f0 59 59 59 59 59 59 59 59 59 59 59 59 59 59 00 00  >YYYYYYYYYYYYYY..<
+001400 00                                               >.<
+001401
 ==== Post-Remount ==
-00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
+000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
 *
-00000200  58 57 57 57 57 57 57 57  57 57 57 57 57 57 57 57  |XWWWWWWWWWWWWWWW|
-00000210  57 57 57 57 57 57 57 57  57 57 57 57 57 57 57 57  |WWWWWWWWWWWWWWWW|
+000200 58 57 57 57 57 57 57 57 57 57 57 57 57 57 57 57  >XWWWWWWWWWWWWWWW<
+000210 57 57 57 57 57 57 57 57 57 57 57 57 57 57 57 57  >WWWWWWWWWWWWWWWW<
 *
-00000600  57 57 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |WWXXXXXXXXXXXXXX|
-00000610  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
+000600 57 57 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >WWXXXXXXXXXXXXXX<
+000610 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
 *
-000007f0  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 59  |XXXXXXXXXXXXXXXY|
-00000800  59 59 59 59 59 59 59 59  59 59 59 59 59 59 59 59  |YYYYYYYYYYYYYYYY|
+0007f0 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 59  >XXXXXXXXXXXXXXXY<
+000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  >YYYYYYYYYYYYYYYY<
 *
-000013f0  59 59 59 59 59 59 59 59  59 59 59 59 59 59 00 00  |YYYYYYYYYYYYYY..|
-00001400  00                                                |.|
-00001401
+0013f0 59 59 59 59 59 59 59 59 59 59 59 59 59 59 00 00  >YYYYYYYYYYYYYY..<
+001400 00                                               >.<
+001401
diff --git a/tests/generic/030 b/tests/generic/030
index 7c263702..c467bb74 100755
--- a/tests/generic/030
+++ b/tests/generic/030
@@ -44,10 +44,10 @@ $XFS_IO_PROG -t -f \
 $testfile | _filter_xfs_io
 
 echo "==== Pre-Remount ==="
-hexdump -C $testfile
+_hexdump $testfile
 _scratch_cycle_mount
 echo "==== Post-Remount =="
-hexdump -C $testfile
+_hexdump $testfile
 
 rm -f $testfile
 sync
@@ -73,10 +73,10 @@ $XFS_IO_PROG -t -f \
 $testfile | _filter_xfs_io
 
 echo "==== Pre-Remount ==="
-hexdump -C $testfile
+_hexdump $testfile
 _scratch_cycle_mount
 echo "==== Post-Remount =="
-hexdump -C $testfile
+_hexdump $testfile
 
 # third case is the same as the first, but this time on unaligned byte
 # boundaries rather than block boundaries. This mimics the exact mmap write
@@ -109,10 +109,10 @@ $XFS_IO_PROG -t -f \
 $testfile | _filter_xfs_io
 
 echo "==== Pre-Remount ==="
-hexdump -C $testfile
+_hexdump $testfile
 _scratch_cycle_mount
 echo "==== Post-Remount =="
-hexdump -C $testfile
+_hexdump $testfile
 
 status=0
 exit
diff --git a/tests/generic/030.out b/tests/generic/030.out
index 20f6561e..f43a67b7 100644
--- a/tests/generic/030.out
+++ b/tests/generic/030.out
@@ -2,52 +2,52 @@ QA output created by 030
 wrote 5137408/5137408 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 ==== Pre-Remount ===
-00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
+000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
 *
-004e6400  59 59 59 59 59 59 59 59  59 59 59 59 59 59 59 59  |YYYYYYYYYYYYYYYY|
+4e6400 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  >YYYYYYYYYYYYYYYY<
 *
-004e7000
+4e7000
 ==== Post-Remount ==
-00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
+000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
 *
-004e6400  59 59 59 59 59 59 59 59  59 59 59 59 59 59 59 59  |YYYYYYYYYYYYYYYY|
+4e6400 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  >YYYYYYYYYYYYYYYY<
 *
-004e7000
+4e7000
 wrote 5137408/5137408 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 ==== Pre-Remount ===
-00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
+000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
 *
-004e6000  5a 5a 5a 5a 5a 5a 5a 5a  5a 5a 5a 5a 5a 5a 5a 5a  |ZZZZZZZZZZZZZZZZ|
+4e6000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
 *
-004e6400  59 59 59 59 59 59 59 59  59 59 59 59 59 59 59 59  |YYYYYYYYYYYYYYYY|
+4e6400 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  >YYYYYYYYYYYYYYYY<
 *
-004e7000
+4e7000
 ==== Post-Remount ==
-00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
+000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
 *
-004e6000  5a 5a 5a 5a 5a 5a 5a 5a  5a 5a 5a 5a 5a 5a 5a 5a  |ZZZZZZZZZZZZZZZZ|
+4e6000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
 *
-004e6400  59 59 59 59 59 59 59 59  59 59 59 59 59 59 59 59  |YYYYYYYYYYYYYYYY|
+4e6400 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  >YYYYYYYYYYYYYYYY<
 *
-004e7000
+4e7000
 wrote 5136912/5136912 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 ==== Pre-Remount ===
-00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
+000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
 *
-004e6210  59 59 59 59 59 59 59 59  59 59 59 59 59 59 59 59  |YYYYYYYYYYYYYYYY|
+4e6210 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  >YYYYYYYYYYYYYYYY<
 *
-004e6d00  59 59 59 59 59 59 59 59  00 00 00 00 00 00 00 00  |YYYYYYYY........|
-004e6d10  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+4e6d00 59 59 59 59 59 59 59 59 00 00 00 00 00 00 00 00  >YYYYYYYY........<
+4e6d10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
 *
-004e7000
+4e7000
 ==== Post-Remount ==
-00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
+000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
 *
-004e6210  59 59 59 59 59 59 59 59  59 59 59 59 59 59 59 59  |YYYYYYYYYYYYYYYY|
+4e6210 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  >YYYYYYYYYYYYYYYY<
 *
-004e6d00  59 59 59 59 59 59 59 59  00 00 00 00 00 00 00 00  |YYYYYYYY........|
-004e6d10  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+4e6d00 59 59 59 59 59 59 59 59 00 00 00 00 00 00 00 00  >YYYYYYYY........<
+4e6d10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
 *
-004e7000
+4e7000
diff --git a/tests/generic/031 b/tests/generic/031
index 313ce9ff..cbb2fc34 100755
--- a/tests/generic/031
+++ b/tests/generic/031
@@ -34,10 +34,10 @@ $XFS_IO_PROG -f \
 $testfile | _filter_xfs_io
 
 echo "==== Pre-Remount ==="
-hexdump -C $testfile
+_hexdump $testfile
 _scratch_cycle_mount
 echo "==== Post-Remount =="
-hexdump -C $testfile
+_hexdump $testfile
 
 status=0
 exit
diff --git a/tests/generic/031.out b/tests/generic/031.out
index 194bfa45..3669222e 100644
--- a/tests/generic/031.out
+++ b/tests/generic/031.out
@@ -4,16 +4,16 @@ XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 63394/63394 bytes at offset 133228
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 ==== Pre-Remount ===
-00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
 *
-0001f860  00 00 00 00 00 00 00 00  00 00 00 00 cd cd cd cd  |................|
-0001f870  cd cd cd cd cd cd cd cd  cd cd cd cd cd cd cd cd  |................|
+01f860 00 00 00 00 00 00 00 00 00 00 00 00 cd cd cd cd  >................<
+01f870 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >................<
 *
-0002fdc0
+02fdc0
 ==== Post-Remount ==
-00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
 *
-0001f860  00 00 00 00 00 00 00 00  00 00 00 00 cd cd cd cd  |................|
-0001f870  cd cd cd cd cd cd cd cd  cd cd cd cd cd cd cd cd  |................|
+01f860 00 00 00 00 00 00 00 00 00 00 00 00 cd cd cd cd  >................<
+01f870 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >................<
 *
-0002fdc0
+02fdc0
diff --git a/tests/generic/032 b/tests/generic/032
index b3d13896..3302c1ee 100755
--- a/tests/generic/032
+++ b/tests/generic/032
@@ -85,7 +85,7 @@ wait
 
 # clear page cache and dump the file
 _scratch_cycle_mount
-hexdump $SCRATCH_MNT/file
+_hexdump $SCRATCH_MNT/file
 
 status=0
 exit
diff --git a/tests/generic/032.out b/tests/generic/032.out
index ca5376dc..0d8097f2 100644
--- a/tests/generic/032.out
+++ b/tests/generic/032.out
@@ -1,5 +1,5 @@
 QA output created by 032
 100 iterations
-0000000 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
+000000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >................<
 *
-0100000
+100000
diff --git a/tests/generic/033 b/tests/generic/033
index 9dd854f2..d3b926e6 100755
--- a/tests/generic/033
+++ b/tests/generic/033
@@ -48,7 +48,7 @@ for i in $(seq 4096 8192 $endoff); do
 done
 
 _scratch_cycle_mount
-hexdump $file
+_hexdump $file
 
 status=0
 exit
diff --git a/tests/generic/033.out b/tests/generic/033.out
index 419d8313..7539b9a3 100644
--- a/tests/generic/033.out
+++ b/tests/generic/033.out
@@ -1,4 +1,4 @@
 QA output created by 033
-0000000 0000 0000 0000 0000 0000 0000 0000 0000
+000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
 *
-0010000
+010000
diff --git a/tests/generic/042 b/tests/generic/042
index 9419606f..dbc65e33 100755
--- a/tests/generic/042
+++ b/tests/generic/042
@@ -57,9 +57,9 @@ _crashtest()
 
 	# We should /never/ see 0xCD in the file, because we wrote that pattern
 	# to the filesystem image to expose stale data.
-	if hexdump -v -e '/1 "%02X "' $file | grep -q "CD"; then
+	if od -An -tx1 $file | grep -q "CD"; then
 		echo "Saw stale data!!!"
-		hexdump $file
+		_hexdump $file
 	fi
 
 	$UMOUNT_PROG $mnt
diff --git a/tests/generic/086 b/tests/generic/086
index c5023081..509c4f38 100755
--- a/tests/generic/086
+++ b/tests/generic/086
@@ -49,7 +49,7 @@ echo 3 > /proc/sys/vm/drop_caches
 $XFS_IO_PROG -c "pwrite -S 0xdd 67584 2048" $test_file >> $seqres.full 2>&1
 
 # On a faulty ext4 oxbb data will be missing, overwritten by zeroes.
-hexdump -C $test_file
+_hexdump $test_file
 
 # success, all done
 status=0
diff --git a/tests/generic/086.out b/tests/generic/086.out
index 3c0cc838..7fd24802 100644
--- a/tests/generic/086.out
+++ b/tests/generic/086.out
@@ -1,14 +1,14 @@
 QA output created by 086
-00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
 *
-00001000  aa aa aa aa aa aa aa aa  aa aa aa aa aa aa aa aa  |................|
+001000 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  >................<
 *
-00001800  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+001800 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
 *
-00010000  bb bb bb bb bb bb bb bb  bb bb bb bb bb bb bb bb  |................|
+010000 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  >................<
 *
-00010800  dd dd dd dd dd dd dd dd  dd dd dd dd dd dd dd dd  |................|
+010800 dd dd dd dd dd dd dd dd dd dd dd dd dd dd dd dd  >................<
 *
-00011000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+011000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
 *
-00020000
+020000
diff --git a/tests/generic/404 b/tests/generic/404
index f1e8b0a8..4c9b11ea 100755
--- a/tests/generic/404
+++ b/tests/generic/404
@@ -110,7 +110,7 @@ for (( block=3; block<=500; block++ )); do
 	# or blocks are in correct order, this commit:
 	#   2b3864b32403 ("ext4: do not polute the extents cache while shifting extents")
 	#
-	md5=`hexdump -e '16/1 "%_p" "\n"' $testfile | md5sum`
+	md5=`md5sum $testfile | awk '{print $1}'`
 	printf "#%d %s\n" "$block" "$md5"
 done
 
diff --git a/tests/generic/404.out b/tests/generic/404.out
index 9623cc2a..ac6b48b8 100644
--- a/tests/generic/404.out
+++ b/tests/generic/404.out
@@ -1,499 +1,499 @@
 QA output created by 404
-#3 b40b8afd2e381a40407a4cabf1694a68  -
-#4 73b7914c2b7494839adc98299eedee66  -
-#5 aeed156f3d1eb23790ee41c9efec8c58  -
-#6 328bcafd2b742ff32f14c72993f776a0  -
-#7 acedb6b1f9f8620e06fd804f94f8929b  -
-#8 7a5e536d3c7d9f8abb8480cde1bf3da6  -
-#9 08c8614efab4466d2d41936468e7930b  -
-#10 7944a562399caafbe5fec5dc1c3cec16  -
-#11 5a6b1097866da5909b18783de1fb363f  -
-#12 945fc318274341faacc633afebf90559  -
-#13 6fc1e29b3361714e3b6729c40f1b0265  -
-#14 e14b10f44b4fae74fe8bdeecb7bc49b9  -
-#15 38535f425c55812bb7c3f6822302b97f  -
-#16 2d816cd1abc9ce29fdad7397c477b6b3  -
-#17 9bd7b504828f8882a37868de154a2c5a  -
-#18 bf28358929df6e214c415d56830fcdee  -
-#19 74857bb59be8988abf5c8eed71e54a59  -
-#20 790191e48c6c9cbf2b6f52d183b99305  -
-#21 417e093f9e0622821bad44318f0027c2  -
-#22 7f60e471fec52f2920802e9376840d98  -
-#23 0eda2e86db14f51c9f2a138cd9d6ffc3  -
-#24 b3934891150aac3bc0ea782f3577287b  -
-#25 5c46d687ce8520d20cdc78d396deff42  -
-#26 ebc6a56b8cee2cd545580ca6224e0716  -
-#27 8c7cb0e566b2472f12d3e6006fbe3589  -
-#28 ca51dfb8838b6906245a72f4af4481af  -
-#29 e21b76a4aba64ce4d3a05b0c7e20cfaf  -
-#30 67df17f3941daa7cf84626d680ebf9e3  -
-#31 e01b21f53c1a51260279c7d136dc2ba0  -
-#32 608b7ade4dd2207c754b2f31e77d21f2  -
-#33 4b2873e8c73f0f34ac7c6810b736a560  -
-#34 c196a25a29a8c3e16903beb715197443  -
-#35 a4381e008a448e1df91b647dacedb760  -
-#36 fd9df4a150b200efb43d4ecbe369c81f  -
-#37 fa12b7ebe41a558a98344223549ad832  -
-#38 f25381d9544af7556aaef5a6939b0e9b  -
-#39 bd9a0aaadf2e665936de5abdaebec1dc  -
-#40 937f4f14ee19476c490eea41524613c3  -
-#41 56f00d984d62389164ad050f81ca99cf  -
-#42 457b51302abbd07fba488d694f5f621c  -
-#43 1cd779b71c6ef7c8f85e46b03d5f0c09  -
-#44 1896fb8de6b597f07c67071e9783f368  -
-#45 9f22c5baedcf8ea5126cdbe4c5ca50b3  -
-#46 a1c38fe295962a4c5fc26271de1398bb  -
-#47 4507c68c64e37da21f9c854b37afe6e2  -
-#48 e1f093ef71643b511f80f1319c425352  -
-#49 07af6d259eb9bc74949e84dc3bdda931  -
-#50 107323eefaa9877e795512c39363e1bd  -
-#51 7956fdf7f4d7c0006b073106bf606135  -
-#52 9f499511cdb6f374e23ac59a0d86fb73  -
-#53 ae0827fbb91852b298143f4dc2afb738  -
-#54 2c304496e463661e77f7e518c18f9f6a  -
-#55 8433acf59a855d8abcdb8cfc231848e7  -
-#56 fb887d3ec40f0d36200cbb68b38ec172  -
-#57 2bb4b1399180ef334f0deb5455efa143  -
-#58 b0fcf32d093446b530e56f9ab9175188  -
-#59 1791c635d98cf201e88637d9590afaab  -
-#60 5045e4a12110a244771e0eef19d485b4  -
-#61 7f2f07f320cbf27c313a3e399e3220b6  -
-#62 f04c71019aab0725cd24c628db3fb243  -
-#63 8e5da85506522c8bf68e00e938a97cca  -
-#64 8ea751e260ae814b3dbbdfbb23759d6f  -
-#65 95cb265cecd7d8cb0882e03b71e43090  -
-#66 fc73630ba5f02f61e8694a75aaf0a3fa  -
-#67 0bd1ad799476da671d962a7cb553eb40  -
-#68 34e0e12a4513cdc5021ca0e4aff5a5c3  -
-#69 50441db34ed7ce5a459568ea59deebe0  -
-#70 56d94cd5b4996f36e0c9d5d33cf4d6a6  -
-#71 5f131ca68f9b395f46ce863343a47bab  -
-#72 978124e241eb21c0522048d67e305fc0  -
-#73 eafeeae7e87b3a6b55166d6e940ea6cf  -
-#74 b76be9c21ddb1132d68944b8ce484dea  -
-#75 82f5567db16436abf4bafdf110344d22  -
-#76 3880649cc308783a1d3c1af633cb8224  -
-#77 2ff1653e55103392e968b9d29695dfc6  -
-#78 49686541df8cdc247f129a21d2c94d64  -
-#79 3888d0fbc75627da8e8f816b5a43ff28  -
-#80 0d6d3764bfc4d8b9f25cbb493f8e293e  -
-#81 bba4efd1080eb1673ad7d6300125651f  -
-#82 d207cf09ceca49d8b3aea1cea1f5d858  -
-#83 c72d01b6f752435b6a140aea2db87a57  -
-#84 0cc13f138e9acab46344cce885ecb64f  -
-#85 b5f87021ae52c559d972510f3ad01ea7  -
-#86 eb1db384a63703228c767ba64e301503  -
-#87 8b3aa651733437f7620e0f059ef88b29  -
-#88 81890285c2aaa8df0b3e0b12021fe082  -
-#89 4c67fe934bf0c9821b296af23442fece  -
-#90 d712bad143f1604a73ad62e494469933  -
-#91 41be37d05657cb7aba849dea17280fa5  -
-#92 e0e47160e24e54e88b9a006509511e91  -
-#93 de8dffdd56191fb3dec3c6049785d82b  -
-#94 7f8d4f5c904a9a8ca7eeaf8e0f745b59  -
-#95 77bc1a22c14c0cb2e2959caf1f42b3d5  -
-#96 150f20129f4126626379b767674b620b  -
-#97 a10252c7334f6fbbd8a8c64aeb7ab261  -
-#98 c750f6deac85a20e2305992b03e7f039  -
-#99 d59d4d911b21bb0b320177e6279a0c60  -
-#100 2eb0f6ffe7407d613f7a6b4215ae1b05  -
-#101 95660cf0ff8a4a89985c7bd062d3e857  -
-#102 8cc5ee51f6302142e9ab9979881af47f  -
-#103 ec5e8c00fc5834749dd55fd372554963  -
-#104 417dffa66f4b66ed0559919ddec3c537  -
-#105 8eeaa5683c69bbd6bd1b87e1d62f10a3  -
-#106 aab5a42dd50e6ada15f3d9ca78b7bf2f  -
-#107 28ffc6030708b9f895ce0b2fdfd7eade  -
-#108 8584586ccb72a1c581eb340e33f91630  -
-#109 bae02cac06efc3dc9fa0e9341d3bc2b9  -
-#110 2abf81d21d07a2c9f7ce3203817e0821  -
-#111 75d169c3d22318911d3b10590640233e  -
-#112 4f9de53badce99bf4e64ea152f0642ba  -
-#113 cf33da4a0a0bd8cb7ff6ef5a7817e9e8  -
-#114 7c4400ce48f622dcd0663f246fe2443b  -
-#115 5ecaa98cd594684505aae990ce2dc7a9  -
-#116 79a7745b719f2e887ee85f14a8c6ed1d  -
-#117 274b8d2db324bcdedd3c94d7c1f0b42b  -
-#118 55ceb5cfff8946db02ab47f8a21be982  -
-#119 e8d8d6feb5624ccc4337ba8ddcf34bf3  -
-#120 d5462434b784355138e9f917d83a6608  -
-#121 88589455bd78f1ae12d05b61c4849040  -
-#122 4c276539520fdd53c379d65e94f8b25e  -
-#123 49066f50e1b4cf0d293be5c58f557c6f  -
-#124 9eca579682a49703aa284b0421bc4fd6  -
-#125 9a52fa10c84ffa3b4f6d258237446dd8  -
-#126 8cbb46eaec06f08b9231ccc6bd1f48d7  -
-#127 165f8860ee3423dc5c692d750a18e259  -
-#128 2e2aabfea83bb62ffff7f58c013e608b  -
-#129 670b6750ca38c0def0777bbc33c5ddc7  -
-#130 9304352bd76e246897f232abe7d5331d  -
-#131 682c9097a850ecfb1281c61fd1b612d3  -
-#132 f5311569ce10c53631b6e2226a59e6e6  -
-#133 26ef51c7b75058fbae2a78a983f0e129  -
-#134 6db852b34bbce84b2bc866f48ae6d705  -
-#135 fc67ab89fd75b9d4a725e46eff02c161  -
-#136 c7a348d263321f5dd7fe9f18d6c054ed  -
-#137 93cf6b30a452d5e098821dd6bee3aee1  -
-#138 0c5ea56539f0eaaf043dbfc5c0f735f5  -
-#139 74d1a1234c98478496e7cedbcf9c3ed6  -
-#140 062b0186add0f2ae7c68c925a717f3fe  -
-#141 d93cf97feffbc7b6952ddab435ae8eb0  -
-#142 269e428624b3b3405ac4d50137561eb5  -
-#143 571472deb35a2e4d3358d648d99c1cda  -
-#144 9eb9884528f24339166277d118c0ed43  -
-#145 ea3f42b018d8ffaa95318343d53a1204  -
-#146 b3d6024bc0cf968e3143b0e4abc59557  -
-#147 f9ecadbd08160bc97933877e1e175567  -
-#148 2a8d67c8c35849a7bfa9a4fd88885afe  -
-#149 a0f16c9e9f6c62db6690bfa77d7da2c4  -
-#150 a0213f5f9dc3044d9a855859991ff2d3  -
-#151 fad141327d32f7fc1bdb823f5fcb11b5  -
-#152 a249b474993cd9b8a7ca43fe6f8c3909  -
-#153 07a3e38649aeea8ccf3c26147a6edad7  -
-#154 78bcd86784ae3f322f20543c2dcbbcb0  -
-#155 643bcc8fedd7e56cc209913e7727ee5f  -
-#156 29d538b0e5f6180b85127e71ad625a50  -
-#157 709cd5defb579f6b7429ebc966d06dd3  -
-#158 e558d9bca2d65531e156b097b6bbcfa9  -
-#159 0b114275c62aa9bdca81898aa46128aa  -
-#160 19c3415197d59bf985b0b705ebff03ba  -
-#161 4bd1d2c8a208f0df74e48effdf383b57  -
-#162 8ac831d9a90516c78373cd69d523545a  -
-#163 63574bcbd930ccb8033e6eabd08abaec  -
-#164 6f2a794fb7d63e91c83a94a5fde76a27  -
-#165 2cf8f0e97dbecd7b20e5e255fbfe921e  -
-#166 d5f7788cff11b5fce74528d4f6c42205  -
-#167 9392e18d085a3edf2c48d1889bdb62bf  -
-#168 8765b9e1a738975a0f49a605bbf4a4c9  -
-#169 599ef1b02493b1668341289b40ebca87  -
-#170 6df3afdb48695d0441b4a83d19b91320  -
-#171 7b1b5423bf184fc9e751c52b4392a6f9  -
-#172 2db6c5ad880b03a9d48a777f83315250  -
-#173 cdcdd3dbec770fc33d2ca0af89b40336  -
-#174 fb0d63f813c090c7fd5c897a590216ba  -
-#175 4b867c926ca9178a2ea418cb2abff5c7  -
-#176 a168bd429232699c58f886948d38012d  -
-#177 57360791489997d22ae285dc0c734bfe  -
-#178 fb75b2971d7c5aa1630b61373bdc9ce3  -
-#179 174e97c10de310e0b6a7733dd13480e3  -
-#180 841c9ee63b866fe0ab73ebc5fc0e0318  -
-#181 aec2b0da898ec9c3108fce13b448d828  -
-#182 42e14af1ba39ca161f8ad61b57db7e91  -
-#183 0b6d6715f57be737596c02320c61df85  -
-#184 aaef73fbe1ec228c75396c54cdf6b005  -
-#185 49649b9256d1d6c097f5adf6f1721286  -
-#186 75ce0c4745bacb828ee07704f665f3ab  -
-#187 0ffd29cd820ed4f1cb8f020890610ab1  -
-#188 9bfa4bd854d171d12dc3a6fcfba80aa6  -
-#189 01b599c107359a92f8e41cc33bb09f88  -
-#190 ba72f30ae4036e85d77ca4cf56d2e6c9  -
-#191 0ca3f4eef11cae4c5a9061243526f605  -
-#192 0d187a77cfb2af2def1faf6f00a01ad3  -
-#193 2207ce7f1ab6fca10305fa8be35679e8  -
-#194 db97ec7d95017468d973786cc75d48a7  -
-#195 d548b42f57e449d9d9e8beb42aaba3a6  -
-#196 9aab0fdc7b1f74051c25f33affa735c6  -
-#197 204ff19d96ac22766a8710a16e126392  -
-#198 43f694e24bbed84f4025c1f3cbe46c2b  -
-#199 2d21ae8eeef5883836db9afdc1e1124b  -
-#200 ef5ab861607b2db923ebc470e13ab843  -
-#201 90c0f5b7285a2cdcd6ae36dcca9634c9  -
-#202 0e94348e69d81bd61009fe5ff0846e0c  -
-#203 3199f0acc4a521b0e0bb15d1c0a2b8d6  -
-#204 36fa3117cf33e37336e4239922a0f6f4  -
-#205 b579a6f066ba6ecf00494090fb87026d  -
-#206 4a7e7b6dbd0cfdc126368b75d15383d8  -
-#207 a414d929552bb1ae5c5f17b302af4f6d  -
-#208 abdc21e0d1567ab526cb0fb0860851e0  -
-#209 b71a7db0e6769eaa5114cfe7601d4f27  -
-#210 263e25196b54b4077a88c61866f971f9  -
-#211 145ff5b101d20a104e740cebfa7219e3  -
-#212 42cb83bde244d79c150a030e4728f453  -
-#213 3fbb599607bc2032901f01bc790ac844  -
-#214 087c4ca4a96547afbdb47d76155a7239  -
-#215 47fb4aa176eeca4817aa68fbe5fdee4e  -
-#216 d637473441299b984b1ffee196927438  -
-#217 52d8787181afb8b287e1b4c4abf7e554  -
-#218 79c0c32f6bdb8802e3a958fb3c8b153a  -
-#219 a014301a718c4984423999ffc0a735ec  -
-#220 598b1808e988a6aa1991ba26f2c30f59  -
-#221 54b2b8c61197d29221954325def6c97e  -
-#222 7089f1e3d8ed9184baa0a231a86e9a5b  -
-#223 a8241b12a305a8a938058199db71de53  -
-#224 226f59920eb93bb3713e3338bd73560a  -
-#225 4af7ecf04a5d7d897c9a8d35dd49a68b  -
-#226 aabeaa38c0381ed3d2c034bbb0903ec4  -
-#227 19c9914a119ceedf412cc911ab1b54eb  -
-#228 e9b248f979f619a726d6b0ce388d91fd  -
-#229 3186d011b531b31e7d7bc61b9831fba4  -
-#230 6bf3e986f75779afb39da4d90ce4b15a  -
-#231 3f97b6196d485408890598857c05345f  -
-#232 a4e3082bf2fbc205f135e1ea70ca06a9  -
-#233 c8ed98defcdcffbb3f269bf928755612  -
-#234 c1c8c23242e8395f2c1c807f7b595dad  -
-#235 1e16f42c7ccbadb450c8648f805b0c6e  -
-#236 672b26c47ca67e35e1a27d101132a999  -
-#237 8e6fb6effb47d45f13263b2e9428635d  -
-#238 7a7f9eeaa5ce02bd9123a06f402dbbfb  -
-#239 6719f21d95a3393846b60d7341406211  -
-#240 e3343bc99c1ab58c1693790bafece5cb  -
-#241 9ee46386e5740e62ca14e06fb4ba06cc  -
-#242 457a61a9c60a098cd363c2c36aea687b  -
-#243 3a7a38f2036f56bb7656689d80096c78  -
-#244 bc2a687f301a7f612f2564fc62f4a9bc  -
-#245 b96e74a15c77180ce4eb5767d469ef9f  -
-#246 b654019f53bfbecfd30071df7e98f762  -
-#247 6b322786e0eafdf8efdd1e37d23346bc  -
-#248 c9667c893693d1b44f6e68b9f8f7e053  -
-#249 61e6f7ec69907ed7f984aee77c7063f4  -
-#250 d8978485bbfe51fc97f7d10892469b28  -
-#251 30a4b1388cebf5b2c2c7e0b64a81e6e7  -
-#252 75c92b242d4377c0d5fe1a241a1a3165  -
-#253 5db00144cbfc4360b9a76a7aa2ccae15  -
-#254 dace901f5dd25147fa2b7215a4a9a52a  -
-#255 364f2f4d5e875fbd6243bd3bfaf4cb89  -
-#256 308fe905fafe4fba1f1ce76884e39100  -
-#257 a1f24ff36680c9de49d6b4cc0dbd6b04  -
-#258 df181c968c12367f2df746692d9b7f44  -
-#259 d7abe869ae6438032d13530a0bae1e9c  -
-#260 ec20ba097ccbc21d52d11f7a089ae8b4  -
-#261 64291f17aef5e434cf557282e735979a  -
-#262 f249828ce3cf4622be70d087be6028fc  -
-#263 2e97911fe1330029d60ceed85ce22511  -
-#264 958cc748e5ad53496aa1ff21290f6d9c  -
-#265 5488570e55da294434d3c0651ea7133a  -
-#266 c5f2fbc3ce9e5a669941909227e89bd0  -
-#267 e8f22ae891bda4a96a78635e20fadf73  -
-#268 226f44274ad84f01a6d31d4ce3d8640b  -
-#269 ee4af61bad36ff025f40acf3a38e8c6b  -
-#270 1e4ab468d3e23d5701a85566d884c0b0  -
-#271 c07e26ff1edb13fda16efb75370a644d  -
-#272 99e949dc6c4203d5b4d7831eb33eff00  -
-#273 b31d1a6151a60c89aa9a093c89612418  -
-#274 ede0e156c47878e05cfe23d073eeef87  -
-#275 138e03c89429a51cd64c33958ee86d99  -
-#276 32cc0f6fb4d9c2257d2aec2f256601e7  -
-#277 d6d56f8d1dbffdd8bb8a58515bce6187  -
-#278 f672a758d7f58a2c515665c3b9c1bae4  -
-#279 bdc47ebcebc838da40cbb15d2001d1a3  -
-#280 0e7136d1b9fcfe1dc45d8126591ecda9  -
-#281 31379f03e4101be16de250817db492a9  -
-#282 a6c1b3aa879aac4059f6009e357fa758  -
-#283 74947f74a9259ea1058403e6bc4f563d  -
-#284 bdc3610f31610cd1db0f412e59b7205b  -
-#285 6e08b6d016796379fa159345158c367d  -
-#286 0758a4be77d3d0bce5512fcdd55dfc06  -
-#287 c2171a97dc0c8faad88db6088516e1c0  -
-#288 4e4d19385870ebc49a518991f29440eb  -
-#289 3fc0aa17aaa2103ebd8bae6298954c19  -
-#290 69f6519074a44fe3481b94e3b1e28eea  -
-#291 70b3653f02c0e62c136913b65794e180  -
-#292 0a25479362d90785fd6543410844283c  -
-#293 07f1fc9a65145bf87862ac1801449124  -
-#294 a2cc3c289918e0231b2332f8b53f86e7  -
-#295 d889871723762c2e3b788a67ee62b621  -
-#296 7cee6cc6b8037af11cb63649da80584f  -
-#297 992946551a4b4184b25b72bf33cffa51  -
-#298 698f01d8ede0155e73e9f88dd4efa75f  -
-#299 c1d2721d74bb2535c9db1b1db24ea67a  -
-#300 0c960f29755e33b198de195f72565fd3  -
-#301 d3f72ee88ee6201563f68f293f7a5186  -
-#302 18fd8a648fbb1a34f9cbd1df839091e3  -
-#303 5bd2420bfd007ce67b077b8b9f041b31  -
-#304 f8697e371fb466745c5ed21a4354a028  -
-#305 b3b364e546b838107906e44a54ae36cb  -
-#306 5a0ea4207c76c572811f7fa2ef2706b4  -
-#307 95e417a71368752a9ddc559ab7be1b57  -
-#308 b0a5fc3f1134765ab5f0e794107cd8ef  -
-#309 5c9b0eb2c954d3fd79fa53b9c8e1210e  -
-#310 ca321d92975f2b07d359dfcce5f8fffb  -
-#311 b712b16cef4a1ab3f2d3a3c53e33530d  -
-#312 6b5200d60cf6a84d9901ccd68d9f13ce  -
-#313 1b669d6e00b0f5c77af796d10e88f20f  -
-#314 ef8e0cddf36928173cc00294caa8b19c  -
-#315 6cd8bb0df86810093f3e93d292e144d7  -
-#316 25817640aee50fa387399f7968853caf  -
-#317 4b53b287e2ae45395cbc31317a658b29  -
-#318 98f3ef809bc5e4888fb43534c9cbab93  -
-#319 a3fca5ba55c09b676027a5ea53ed07d0  -
-#320 37d585b19065127f7cc2ee9e206a7b48  -
-#321 cbde00ae5d71998af0b833e8c0ea6729  -
-#322 eb06c49fc5f3b883be02dfe6fca9be66  -
-#323 d5f7ae292c72f099c848c74670d04bdc  -
-#324 bd50373b0baa061954dfa6f1ceef6512  -
-#325 39b45bde24df9b41f32467db2c1dc036  -
-#326 3bf9f5cf3b1cf73f32c4f9708868d38b  -
-#327 fc0b23d2824ca08271950f7cede0a0bd  -
-#328 1dd1a55a9dc310368ad2afd7614a983f  -
-#329 289873223bcff99fa8bfea1b57059f64  -
-#330 6a5ca6b528e44245bc7803b25983c8d0  -
-#331 bccc6247b395c129b7ff77ae15047940  -
-#332 fbbb070569ae121f6b6f22257eaef0b2  -
-#333 337eef478652682039ca593cd9ccaf30  -
-#334 50962bf7f0e611ae84603c92c2087078  -
-#335 ce9145bc89a613e167011919e1ed859e  -
-#336 17d24c73f98831b59a1af3a45e89835e  -
-#337 0cbf89f840b97f5cd5c8d0c275d51270  -
-#338 774d719911782330fcd6e76c38e49233  -
-#339 45084bfb30f0793eefd084c654e70698  -
-#340 bd683094eed6bf4faac69169ba517bd6  -
-#341 2ccb48019bc01cda65f509c1d31d2fc9  -
-#342 2fef7cc7c9b24f9a37b63c85b24a999a  -
-#343 1608cc4f11dfd20a29586353970d8490  -
-#344 cf8c90020b16d7fdda010494d45c8471  -
-#345 47aa3937b31eeb6a56bcc2f6f46d6311  -
-#346 05db9f97743ffe6a7cce43494c4f4d00  -
-#347 76639b5b52622b63239dcd512f58a1d2  -
-#348 1b1588be2d4329edc2977ee1e64565c5  -
-#349 cdad443e680be5769b8c4ccd89de83c1  -
-#350 457dc9e195422bfc6b51a567a2c4ae0b  -
-#351 45667b9e0514e446ec186d25ee083c77  -
-#352 7d7102271a5905ae213e35a5d9335fa2  -
-#353 117da2d581b0a6d47ba0f0190be3260e  -
-#354 9439f3a8f78cee524ecbf154f7c79182  -
-#355 34fe89b683c608235f69bcf6d7fc7fc3  -
-#356 3f5349b333c2c267416844c9e5fe02f4  -
-#357 83b51c48b772fabaf00e859a7c832da7  -
-#358 638facc35524d7e8e46432da568f60b0  -
-#359 7e6b4d633cacc582dda950735f2ac439  -
-#360 3588f5fc8722ee8c0b524d64ab350fa4  -
-#361 5619f1ba1c50a214148c87ae3d7dfc59  -
-#362 c347fa7377571315cd15b4266389d98d  -
-#363 d8d26b8f7a28d267427189a0e58aa38b  -
-#364 6f44f83de8ffc0c602fadcc68e78603c  -
-#365 0b30aceed2f273eaaf6598be5e1461ff  -
-#366 6613a98247f1208697be39273c415d0e  -
-#367 c0b60442de7a03e5c872d2cb42663529  -
-#368 ddec0acdf2f57a68e67d6ec93b292c4f  -
-#369 67feb5bcd952bbbb96a77d200da44ed6  -
-#370 ab41acf2f39979eb9765f2764f276a7f  -
-#371 a6217bc89972ebc011fd93ab12aaa65d  -
-#372 8498adc54017234c7c9e6abecb40e056  -
-#373 febf3041c88f57b1945e7722edf99970  -
-#374 c100c0d7d729ded949fa2d321ecf5813  -
-#375 9c26ecca4798eae63259792d17e9a19c  -
-#376 82087cc09bfbc28c644d82903463b0cf  -
-#377 cb68a7738a2c1961b9e04eff8ecca313  -
-#378 25f50bb1edca99d1ac5440c38a7ef3da  -
-#379 cf82c682c2fae466c2c39a6e96d73efe  -
-#380 6504b1e77f9b6598a347f8479c6b3373  -
-#381 50c2f3a7eaec11f41b7c777c6832e3bb  -
-#382 1907de6323440b4293e0db4951238dca  -
-#383 c1ffaa9c31f5d0ee11b7ecd9b52f4d48  -
-#384 ab100a10fcbbe16d2e1ef8fb9ddac372  -
-#385 6576654d9050e562d502d2943688d8f7  -
-#386 c92c593a2e2e105bf680cafc3ed9b895  -
-#387 3733934b3b7084ded45db1a41044773f  -
-#388 a65cb2e802de33be43fd617e5dec7780  -
-#389 2dd89efe6fbf7a0b3b4858d9dc9f97e6  -
-#390 205165b3898941d42f4f25cecb8c9319  -
-#391 0d9beb823e88039f5b89799470f576e9  -
-#392 4ef71c9e7b5963a9a8ba3b7290881f90  -
-#393 750e3bea2235d2939f4247d661d5721e  -
-#394 2e3bef565430fe15d45348b70754d584  -
-#395 09312b9283b89d6229e46d4511d5e5d0  -
-#396 21869296690212282c3859e83e5dd6f0  -
-#397 206dddc02de4e78a10660b83f0b63157  -
-#398 7ef68e32928f1a91b22019314bd2e87d  -
-#399 48e4f0970a9fe5cd5e64a870f193ff83  -
-#400 416053af3995ec82caef0e92c85e6e72  -
-#401 b9365be307a2a61f5ee7c4a656690b5c  -
-#402 4eacad3b03c77b16ff249cce114f363c  -
-#403 d172bd3a5f2aa5461c442af5bd3f825d  -
-#404 41c2d2456376828bd1d53535c0458742  -
-#405 e5cb5c1551696b9adde79d891137d4af  -
-#406 d78ef51a930277156db5920ab9977796  -
-#407 2ee9a5c7a1d0453539ee70e90578bff8  -
-#408 0d7f2f029073ede43aa383951d98bf6f  -
-#409 c09a4c9f0429a8e3bbe9e61f624ab958  -
-#410 d3247a7b0cc1085cba9ccd37dfdc43d8  -
-#411 96db7ffe62e4459c077e8e30b8fa2e97  -
-#412 9b5470369cca8da21dafa7b24369c65f  -
-#413 42d2aa65c4f7ecd9ff115b7cba86e6cd  -
-#414 b05d6cb508fa9495b1e0faf83b41a877  -
-#415 4a93882ac5d085caca998bac089409f4  -
-#416 eca1a87e1a22b1ab95f4ffd8a85e812f  -
-#417 f904d9d9442bdd0cc148784d30c151f9  -
-#418 dae3399002de724ba1a215972896c774  -
-#419 41cfd476d7c25349d6ca001d22bee928  -
-#420 68d46823821f8e6a24ebbcec19c7a278  -
-#421 5acd18d0e2e0c226580ef7b365b5ff7a  -
-#422 14a63294b5048e13459b8b32351debcd  -
-#423 2984b02874887cf5d299faf2d8f5574c  -
-#424 f03118d38b25a1d2d4d5abc1fb3b8b5f  -
-#425 ba683feeb36c5ac2df96e4268d512b44  -
-#426 658f0e16de53e5a1f2e8360798ae3831  -
-#427 817b04f71ec39c0b143ae5a905a485bb  -
-#428 d3354e51b72e3093e05d4df8df652cf7  -
-#429 ce8480dc3feab2df3af47a30768c0995  -
-#430 2038414994a72d0cea9b61b4d886cfec  -
-#431 29788c62afbce310f491fa759c789ae8  -
-#432 7c44c15a6d711a4b066174882f111eaf  -
-#433 037c1272d2d3acb9bdc4bc6a55f561be  -
-#434 0c9a352f2f4162c9eb1bf4ab47701c6e  -
-#435 ff659ed027e241f6ada0c3c3f59f7dc3  -
-#436 62ba24edb0f575349027ee4a2e7f4e10  -
-#437 6a74ab4c1044b45ef0f787a70c3454ca  -
-#438 218a8aa20c9e7ea36b0cd2deb5c1a0e6  -
-#439 37da9cb77e276b7871443e3fd8b38105  -
-#440 192c1dae933a669fe963aeef28e553af  -
-#441 2df0f901ff8055f8e0392b431bd6cfff  -
-#442 7ce0f07fc8cc8163e597ae685c67db5e  -
-#443 a3f05fd4927dca984fff4ae2072f1b23  -
-#444 f71c403dc29a50e3ba716db764f051fa  -
-#445 1dc278aa61abfcdbe9b3fa443fafed9d  -
-#446 5af0d9abf3ab6824457b7da0c33d8050  -
-#447 eaaaf8a2dd5a2fedffb9eccb0dd2420e  -
-#448 261bde15925374d5791f8b2f74ab87a0  -
-#449 0ebdfcbd82e0f0d07652892aab49f13b  -
-#450 9c636e51b5c212a79965309f562b383e  -
-#451 d2af7e69ca96d1f63ec6b0aabafea583  -
-#452 36ec3af8ad2d062d899c9c2fd9ace7e5  -
-#453 20688bd4732c555cd10befe13eaf8dce  -
-#454 3c7b7eaf7788921fd8fdd49b659b184c  -
-#455 18f9818ce6378bc9a2e711f064283172  -
-#456 a28a17051df35648dd754d0840827a58  -
-#457 bcf301c90c6f0be26a79004ba9a35a9f  -
-#458 281a1225ac24edb4d995c4ffb33902df  -
-#459 4f907a63c1933b0da9deb030d4908212  -
-#460 f8770c7d0a9cd9e084c9f6aabcc2a8b4  -
-#461 dcc1c63e7d33aa1e0acb0760644715d1  -
-#462 bf535de46c30f859f730d5a619b956af  -
-#463 95a76a528c435a7fcf3c4f73260c82c7  -
-#464 3a5542985a0831cc0d38a9b7d5835606  -
-#465 bc7e04fc1b93d92d9a376dc76dd07e44  -
-#466 85020c2682625b77e803cd36a3703728  -
-#467 c8c4b718eea4bb75ed0b132ec409b536  -
-#468 3e35933eb45f1f49f5ac476931d34d82  -
-#469 9fcf546b82d3070eca12529cd38131f0  -
-#470 2e35b2703cafc063719ce5b5a3b507e7  -
-#471 e68b7d84805de8c0cd3d516897273291  -
-#472 c4eb8925ee19e48440579c2f68dcf178  -
-#473 a6a609331f750d09e2bcd7d81635633e  -
-#474 3f6deb359cc658317229df3ffc074cbe  -
-#475 0b4f33439f06733af5f5382684a4097a  -
-#476 6c4d1ccd697702d817578462241dba51  -
-#477 65eb241fdefb71886578ce647e43e490  -
-#478 b9ed5d01eb4017a57c9e8221aad37011  -
-#479 acb9d18e54f4c14e652576949f563838  -
-#480 8ab48e6135ae559ede9e393caa7415d1  -
-#481 c3ab73a1ac611098be530395469573d3  -
-#482 6fececc427a6411d95334633cce8842e  -
-#483 542e3aca6b53cf2e63af3cdb23b96523  -
-#484 03d71adf82b4dfcc5116b94c18a48ad3  -
-#485 a090aeee1fcec5d0fb33868a22282e06  -
-#486 30cc6f6e0e8da58e25c13771edb01e52  -
-#487 64a90f98f5759860608242dd119ee22e  -
-#488 ed9e56ec5ba4db3f12ffa0c485abc1e8  -
-#489 568d812625f51dbefbbe28b1832c6d73  -
-#490 c82cb6bd4f676996a0afcc9054e3457a  -
-#491 a7aebc52b65826c571aa4c0cca23cc2e  -
-#492 a9c55250ac9c6783d7b4a0f7eafb3d43  -
-#493 245bc45354c084c2190aecc5ee6d018b  -
-#494 fcbdecb6e594443c6bb0aba9019d00bc  -
-#495 ec3f2fc07cdcc240ee1bd9720147bd88  -
-#496 1b3c64b26fb2f648491125a4a7d473e7  -
-#497 5fc278032da7485bafeb07fa244a8ee2  -
-#498 ff1e2e8ef8df41915e97cdd0d08115be  -
-#499 a8c9bb906b1a41d8ad64f2e0c9e1850d  -
-#500 91f408ace29f71bee073c1698d757762  -
+#3 82bda29de417d2df2f671eac7dba43a1
+#4 24dad8ce1538e18b8c2e34157b704e92
+#5 0c45ddf147ddb721c716801d4919731b
+#6 94906b46c902c0ef48a7eb6c93be6429
+#7 02d4e74e5f58548b6f29eaf4b853a4a2
+#8 d98f911d17d283f59c481e50973d81a5
+#9 ebb3907958a7749877d79dd471b71675
+#10 666e2c9cc99c6c71b25dcde093e788e0
+#11 c7eacddaa05a257645a56cf4a6a3a25b
+#12 92064482c814e68c2218b0cacf49a019
+#13 94167da3569556f366756c616e70824c
+#14 943d42c08e7a4ac7e3b575b41254d5e7
+#15 b9becc2f84b38f9bc625fe16cd16f7f1
+#16 c82cf2cdc9e3e29cd9d4ba668655cb21
+#17 a42ef3360fdbef678923895c5c365377
+#18 416a9331c73176bea94464fc52cf9269
+#19 bc8bba222c40989feee14b987b0c0d3d
+#20 6fc181452d6dad856d06fa0a2957132b
+#21 bb11df3e21df0dbd713779802b85cbdc
+#22 abfd83f6dc018a64e80661747ce6a14b
+#23 0657a5c63aca1b9d231ccc15a98432c8
+#24 872661409d2d041a1985f480f24e88c5
+#25 4ab712433cf2cea729a1f8d806cf57a4
+#26 fb8d50e4e7a3c0f4e25a7c144057c45a
+#27 b6332b2e43dfdef00e8587342e905e25
+#28 64ebf47c6f9044152162b4ab1799a0d3
+#29 b6787d5f56ac169e831d08f5feb11fcf
+#30 0f76e4299fa3ed146767e657f88df565
+#31 dea98c4b2d294146b7a7e267c5be51e1
+#32 5a8c571aafbceb47f4241b24139b2bb3
+#33 22c735c905f032aa85669344182c9864
+#34 c02599aa13262a9f6cb2594f2617c67c
+#35 714db750216e3d658acbc46bf9e712ce
+#36 8a2f38d3d7073f16a5adc0b7b9749a26
+#37 aee12b90a6f7d0583ee175483ac4c412
+#38 eb8127c94dc5f254cce529009b0cc571
+#39 607a7fba49fa577f541f2e4d73e7600a
+#40 87bb1474f8c8c2df915a7828c4962345
+#41 d333d26e7bd02d6f61bb96ea6d3902e8
+#42 fa56081e291bf4c9fec1b78ae01076fd
+#43 f7968cac9e974e46ac6cf1663beeee03
+#44 c66890b1248ac123fe1c6fe1f1ba7f4c
+#45 ee0d7ac330cf80cffa6d4b14c2030cad
+#46 25b339bef605fef194b2a19f0dac3a20
+#47 913db99a921ea0286609f1cde4002374
+#48 b2f75b90936a366d1426f65216cb513f
+#49 3781150bbaee75479939572fde7ec9f1
+#50 4d10cdee9c7192c471fa667065e370e2
+#51 9766c81ac0f9cfaca420edd225d995af
+#52 c4081666eee7fdd31928361654f11911
+#53 404ecc883564b44567acee7b1077b519
+#54 1ced6ccb28de261dfd88d587caf2584e
+#55 db8fe9a94b4e5b398ebba7262e905971
+#56 b1bf8d1ac771c904de4039e1695af31f
+#57 4da61f69639e0d3fbd992e0d055ce9f2
+#58 ac6b8b8e145d0a164fcf05ee20ed0923
+#59 7f81135954f37d9a95f5dc92ecb66278
+#60 8d65b7932702ab9fbf7f629843827848
+#61 bf81c9d7f66fc7286da9b86d37b37a83
+#62 f79c51bbd4c378dfe1244784230edd19
+#63 72aa4e3c323d5c2edbc878db6a40ee9f
+#64 82ed063f5a42306b9900c77b9bbe048d
+#65 f3deca015897b79f51872ad03f5053a4
+#66 f94b5276dd19a1e57f92f1429404cce4
+#67 e0731ee05ceea5badaa0ddccf25a744e
+#68 a452319236ad81e0ccc566145802a73e
+#69 692d5d08f7beef23692c0f1f01baa5d9
+#70 f96b70a6bde9ab1716863f15dd6d6937
+#71 838658916db809653db28f3dff0cfec1
+#72 3cb8d618d2781dd9ee2fd00a77645e0c
+#73 43c2b830ae73a7de529dc79b82f54e7e
+#74 2c68bf9ab9a19653d329ef45b4f27850
+#75 97124355666035d9e97931b651e8f519
+#76 e72d2a4b737e90802200a48f5aed142c
+#77 d765a6e80135e66f4b08be7aebff290b
+#78 949c8f1a1812fdcd731f5ddec839e7d1
+#79 df5fca352df3435fdedb88ea39c71aa1
+#80 a07cbb70e05dbe977ed0a7741dabb0d7
+#81 541c5c3613285804bb769350348b27a3
+#82 bc2f253672ba86c199e084eeee783c0f
+#83 5975e71a831d0fb7a80bd62bc46cadf8
+#84 27627442936727b16dbb85c0af459941
+#85 fc8a6d926b5389b2a68fb3331595bda2
+#86 4ba8eac20a9d8cb3157debb349522b5a
+#87 cab35b9da003215092614c4df0d57f3b
+#88 41118bd75735d81aadecdcd81bc2f995
+#89 19cc25bdf75fc55f9eec1486ecc079bd
+#90 71b6f4b56aca7eaa4a04e518520100e6
+#91 8a89d045a8d21d4184daf9c00c2b0358
+#92 bccaccfe4b7d37e4577ad79db523390f
+#93 6149b8f9c3386c311debc574d8df1ffd
+#94 2888c3de6b2ee12c92db4ed801156d18
+#95 1ef33eda2dc7e554ce0296e00804794d
+#96 f2b18e834c095ed7b1d8bb38231f9e90
+#97 7faee3129dac624f8ea1953b1781b5ee
+#98 8829b83b0eae1b7aeb27f98cadfc4488
+#99 34f6ccdabf5312c5acb6c44048588e7a
+#100 6d848a67146b777a68b6a7fd9e682706
+#101 fe3768ff2132e865e2a9f2af60e44e07
+#102 335d1204d2f141f35d1bf014a76bc455
+#103 d9fe131ac4d3be35afc7cd0be19d7215
+#104 7905a7af9a0f2bf0509f9ce361fef588
+#105 6b5353fe1aebb09eb721f90b3e2e1154
+#106 0e7862f660c2953f877c250900f1bf1a
+#107 26f3b3ef2abcc0f4aa2b31cc02b620e8
+#108 9eb5c9584fe7dcd0b4550dd1293e2529
+#109 ea4827cd5aea108be6f8e3118865d0e4
+#110 6c8fa5d95f47d7ab6e36f980d7fea13d
+#111 2d80b059147122b31baac3fc41ed4aa8
+#112 9b0cfa2093520a66cbd8bfbbc5862dd3
+#113 2658fbbfb28b1e6ce1d2a0c309138356
+#114 65477811600fff0edfd6966510bfedef
+#115 f538051b7bec13f75890244508c26d15
+#116 b5300a034c5ca0c27000e204de4dbbe3
+#117 a7d3916beaad7026c381f81d48300772
+#118 59cafef5ec8706e0a74d367f3ce8d732
+#119 86499c42638c73689a105e7188bbe7e5
+#120 3100576045958e0c602c23b21fff55c3
+#121 01022d1843331befecd31a9ffd701ea0
+#122 e7ac396187ed41342d47a9fca9f47640
+#123 e08e7ec858ddcccc28049cc19f4105df
+#124 36c29910ba78fd95a8d3e6881c9e3ee8
+#125 67b0b8aaf66bff7e1ab244738a324972
+#126 0878e1128f7a012b814aa871adf20817
+#127 2824ef1eb6df987409a2af6e92651428
+#128 cfb508cc03b395614ff16c0cddd9fdc5
+#129 9ebaf4988037819ab7a9a9ee91c16c3e
+#130 ee96eece48248e413e239e5e5dad67f9
+#131 9ba0d8a809cbbbfb10e0b5d6827e9082
+#132 6baa28e638a649ae65c13372aa6c4657
+#133 f0d9abbf77ebb476ab2809b9c6e2785c
+#134 11468505468be403acae1f7a060407cc
+#135 ac4c69d3d09781596e7ccb965be1f921
+#136 3e600f7ba4e246fff877a9865e16969d
+#137 48332da046bb503414fd3266e2286d9c
+#138 d48d34e0050c3a2d382ad13c82a02259
+#139 2946a0ed2a6a74fdf9270b7cccae5f9a
+#140 85072a43ddf43fbd18b22f4a51205d52
+#141 28a11d6124bbabdd4f799a320ed73be8
+#142 f3912629e701305e93c2f96c34ce4ce0
+#143 18916a511872d2447eb7604013e2382a
+#144 387ab254b7a6d742e7bb9dc881241c8b
+#145 6d9491c3176be6cf0996e027a80136e1
+#146 5ac02f352d6fc4a30e9bfdbbc74e73b6
+#147 f6737435244d1e13a01605a9c70129b6
+#148 d6aa4e3560583e6a654804dce461008c
+#149 60eb89b2f235749399e9c79d5e2c64f2
+#150 4a04bff1931a02dd8cb09f703a814176
+#151 cd8b5731ba307dd39d8f5b59d8ab2e7f
+#152 ef3dc50913fee8414be6ad97e6353895
+#153 6d09c96cc2f0cf2c655ba24e41c4dc51
+#154 1063abbcfc32c5c3e927004512d9a882
+#155 bbd9c8e17926ea3f1a015db52c65917b
+#156 c6eec09132815780d2b0c4841959c629
+#157 d772a190f74ba84ad0ce8397cbee43dd
+#158 9a609091cb13eaf399b14ab44ab6ba10
+#159 5b1dfcf7beffc5f14b638c899a9d5133
+#160 2b9aa142c095339fef97b9325b48f4d4
+#161 3e3ed61d6867665c78180883f10ebf6b
+#162 145d2f5f22c6d12d69f4a4b2fb8f21c2
+#163 a38554c60fa2d0a10a492e73c31a92f5
+#164 03bd91134763059aa435483744e217da
+#165 296f9c0b5da643fde1985527e2f0d441
+#166 72a5dcef623ab3bf480b20bb372f4575
+#167 75d22b87cd6434ce01cd56d72aa554fc
+#168 9a1c9ac1e0a6207b18495714584b323b
+#169 aba4f83f3291e9a23832d51a6b9d01a8
+#170 0c9ef6408fa3a8efea70bc58e018497d
+#171 6e1aba59c93fd1284d03fd3bcea0e6cc
+#172 9935edef634c03b164be5a63527c156a
+#173 cf737b17150ede95d26c503df2d6601a
+#174 bf2437cb5092eb76d90911ed49f53fb3
+#175 f247064802278968d3c0bb5f918efcf9
+#176 2d65e3b356577c1d47bae22ef1614573
+#177 43acd24b9a6321aed4401e0274a5130c
+#178 da99f8ea392c6c06e2cc3095ea1da321
+#179 bfe313e4437c3718a823bc68331a521c
+#180 2687563a37f52d3a1a84cae36cb6203c
+#181 892ea1353ed86f79ddff058a3d988255
+#182 556cee8e26d277ef7a5664e799b68a55
+#183 4d4afa19625b50998931bef7c510551e
+#184 d717b9eb5d92338c1b6d77767993336a
+#185 869ce5399cf7810ea0c18a2d777907bf
+#186 24240a0cfb2cafc158ebb51f80d683e5
+#187 defbb1d8af6550ffc31e4f8ffa32e49d
+#188 1ee48ed5d1600e942924025f0e89dca1
+#189 306b16302ce7b4250a6cd4ebd791ece5
+#190 84064ede7ab8516cdf3e7af40731e04c
+#191 35ea42c86240dccb522a2546b9fbe4be
+#192 4dab1185a534905c7482d5559cae8359
+#193 f51cfd8c8b1af08694c2f8137641a4c2
+#194 6974145e7c5cda227179c242b4be89bb
+#195 4dbf1a6bda847b93655958b89ddd0266
+#196 311fd096917b5fd4a2ae91080e0b1048
+#197 912add98d56805c901d72e9fab3ab8b4
+#198 3ecc521586bc504f7cfbcb1bd61d357f
+#199 01c2830220bee1e9d601662080e637a2
+#200 2cd92f6575edb027ccab9ddc608f2ec1
+#201 2e49473e9553b473ddc29c4dd189f859
+#202 0201fadb5245c29e1435ff99fd91ad0e
+#203 b4875f00137e4bd634d00cf7c003a572
+#204 138be0f2406cb31f3172e6994a71a801
+#205 64dc97d3fbc20a459d774f3dd99d3f18
+#206 6c0225763fb72e5e9ae48c1a1d9b08c3
+#207 2fc89ea3f0aecfb50e9cf046f7bd4877
+#208 614e04282b8fc7ca6a0f4ecdd93c271d
+#209 114a3dd67e675d5b2fb1daffe2c05691
+#210 e129b3ec1dca7dcbda9ec302815695cf
+#211 b817a2d8ee7e7de95259b7197a72760b
+#212 236285fc933eb5272ce7801f8cc199e8
+#213 81822b38fb8d0b15e95307fac085f59f
+#214 7346109d63250343ea4104a6f08add21
+#215 4dd9ead55af1c6a8a40c76a3be24be84
+#216 f41730985a70c24cdedd0c06b7ec2bb2
+#217 753cc9a6f3732fa33a805110f85baebd
+#218 ca747b3cc30a437a0eb720f6426c3e68
+#219 f040509f461504d8395d6e51e357b3bb
+#220 a449800d724c3092fa793319a9db7e8a
+#221 f39fe7eb4a658bd57489bd2862a1014a
+#222 cf51cbc5fb5b58f8ab81dd11986168ad
+#223 360315c2088a2727752cbd47a0a5e1a7
+#224 dc4ce856d4e82857a5e0106988cd50a8
+#225 8e514c56d89ec2f49894bbfcdbf70b5c
+#226 441197fbed2310b50d86ec2d3e4a1a5b
+#227 f20754f82a21d88d759b0bb5ee1d77e0
+#228 68e9c435caac7b82d98914c1e34ae9a9
+#229 6e2997748aa79b9ca8c262f50ad5fb0f
+#230 aa832b8c1ef6c7cf4003c43962d9ca47
+#231 cee5685c78f7f343cb17465082c8bd48
+#232 cfe8743f0e0c38143dfcd07dfb432369
+#233 7c144daa9b60588e32df5fdb648cdaec
+#234 f077ad128480108801db71d8527f22b4
+#235 4083ea9649b29bbd689864adaea9b966
+#236 98e3b2477ac46f5c7e8c4251e8aee0dc
+#237 15a6c60e5092812b773519a19c23d980
+#238 e4b8e3afffdb09402df75920c091c165
+#239 504867e81659b4a34812641e2f8ed734
+#240 0847ae5b62be4e66f4545a77b276eed4
+#241 8673db164e84a935e05617f7deebe75f
+#242 fe06d84a9e7ed40792c244565ed204b1
+#243 5f83fad12eb7e3172331a10a96039fc5
+#244 9ba07ac135249346d07cdbd26530a88a
+#245 a4bd5ea44c4f22f3eab77635114e3a9f
+#246 04c01c7fa321875c0dcde0a5fa914ed8
+#247 ba68f7dbf7123d68ea915398bd0e2262
+#248 14f3b349a1d71fe7cb2630d924f702ad
+#249 4e6e157de59115c53838ee80bd53fba9
+#250 0fafd0ee8113fd25c72a51183d88e1f1
+#251 b2a01c19846b047e1889acfe45aa4770
+#252 3947abbf0c2f39e7410a88c970364667
+#253 b165aaf57c6301e65b53575cc732b450
+#254 db90f1a111053b40c0c4cc3047608502
+#255 50c38590e0b5366452e56c31426895cd
+#256 99f02f44a4829a431ec7b15ed95542c7
+#257 9ef3e98f31b505eb3702f1c06b163e12
+#258 561282cc559ebfe2feadf1bc2fef1ba0
+#259 a1915d647ed63a19ceea5d881e3a7623
+#260 9630c02b9f37de3ccc595a2b3cf929c6
+#261 8e9368de7df1162d6e7a1504bf40d34f
+#262 b8cf1dd4836e86e80fca49f6c5f333cd
+#263 413ef21853a60cefbf8de20ff85c80f5
+#264 af392a76a9d156e8d3f457117ad5ed62
+#265 ebaa0dd7b1fd9c08a00b258cbcf7bca7
+#266 07a78258dc9aa099e5e19815b08b1879
+#267 7377fadd9e14fd43b876b4a3849e9a8c
+#268 f5d4c19caccf72af3c9fa261e3fc9030
+#269 890190d5b55db2e1b0d9236e8db5275b
+#270 dc6fe48ddb2ea45f7bd7751a8cb7e5dd
+#271 0a414c94c8837c611deabac46165907a
+#272 122f64ece5d5ce44475ae8314e50fcaa
+#273 11391ab5c2a0a48bdbf9328b2defef2b
+#274 ae295d49cd95f360caa8312fe71c466a
+#275 d3c4cf5cdba66fb06d97fa82bc15d67f
+#276 b0a7fbd2416f0aa8f80c6893b02f6041
+#277 d32a445ce9e16cd6d6710cacb38f54bb
+#278 87618116a939e9e160190e9310f7af5f
+#279 4a01ecd049ddb33024171282990575e0
+#280 bd9db5e8e6852efa5cc17ef0a13df87a
+#281 15793570d8610be892f002f781e97a7e
+#282 e936eece3a412aae35102099b3d2901e
+#283 febf84f11cf8ac57bf9b317740f796ab
+#284 58cc0a69edfdbe0ce8b3edadb014bf71
+#285 0c191781c0ef1f3243ff5824d31e9d88
+#286 45d071171841dd8f3046c6ea833e82b8
+#287 717723d83d1d67dee6ac65eaddd76e6a
+#288 cf22c8088972c1e99e0e6069350ba077
+#289 8e8f3219fecea53e9b09443002bfcc95
+#290 d629479cf3aa935da1e574f784081dc8
+#291 ee69e33c1a542cfc2135ab02c8833b58
+#292 4ab02ec1a4a5d56a6821e4a41f2cdda7
+#293 cc6821793142a2f8b04c1c4c936b1666
+#294 35a3819567b746c1b3d49711c16617f1
+#295 47c96d7e76bab1aae3056109d04b26cd
+#296 b3708ce7240281fdb9c2feb28c9db901
+#297 1c37ed4f5068c2ec82d8e88aba97c5f8
+#298 82418a963ec3f184cd9a39a735419af9
+#299 8c92820fa6543f9dd2de6bf25d953a17
+#300 9d8fbe6412be6f3d9305d3d21f4101e1
+#301 ece2a2eb6ddd66719278c66078721cc8
+#302 b2408ad0660fbb8d82e4b72e59b84a25
+#303 29b2c70cf135b3204a2170dedc5a9a79
+#304 1f68a7f5fb92d5ee5fedce508122d259
+#305 66d716dfac231ad394b98bdef3c6b176
+#306 21e747759437b6aba453e8e2220e6b98
+#307 a5022f7511a1aa802f9d0e4f06599469
+#308 5eb04cb7704162496080ba054f249b7b
+#309 b3877554e823bc2ba6f7ffae7b1ea2de
+#310 11e933d8dac9d927aecf0657911e5df5
+#311 bf206ebc099b2d65b3518e5bbff74867
+#312 6a1788087e68c932646559afd1221965
+#313 1f245dd3c7d6018ec283e8e6cabe4f31
+#314 89591e03c1e3a55f7da03d03009b904b
+#315 486cc18cd59e54fb0ceae81968373484
+#316 f1d2e94f6c5ac2d7a14a346afe3197f5
+#317 d61982dc8914e831a48344b273fd9a36
+#318 d2dbd2cabc668832406957116299fc28
+#319 74ae3273c4a7380687daf8ec63dd5d71
+#320 cb9a09cb873d402bfe07abdd68ce393b
+#321 981a886535a0cbbfa209d3c06d6fed98
+#322 299cc45f29940262911d8f27395c56c9
+#323 0e517cfd9eb46aabdceb9340eee6bad9
+#324 b136933c0a24adb27a179189139b0a60
+#325 670f10245c79dcb32e367a928152c634
+#326 2082ec1134ffd08bf1a55c74c5489448
+#327 742e0425f412fd1bd9bc7b8b43b5f0be
+#328 7f36dbd9fa21b240e0c2558b5a0943e4
+#329 58c8c54182f4b73b2786ff34678c45fb
+#330 0d02c3450ac1934b8ebf2eb6075e7eca
+#331 a10b2a7f2dc043e45ce99be21278719d
+#332 83b89b955333cf42d25afec3cf4277b0
+#333 871a9301b2b747637c0b102b50afc70b
+#334 e8d3f545a83dff3bc6237bd8edee4558
+#335 092e9eeffe8a6ff6db12a1831d4e8b05
+#336 a78801a061ce5074413276da3154cf88
+#337 7b017f01cdd00c1cf359b4eb67c64a0f
+#338 407f6d83cdb1788cc78347f952c35f6e
+#339 dcedd2ca68b0c75ed3ecac04d68f2e0c
+#340 36fc7b84912a761efe5c497c42f5e578
+#341 f3f5f46427d36d946176904a358d6e22
+#342 51b59904a8e2aa19f6523573c6b97284
+#343 48078bc6a5e94bc4d4c216495f42c018
+#344 9f9da77b96480f5af0b92f3367f411e3
+#345 0d012b10a7b7aebe42cccf924bd9c9a4
+#346 bda6fb8986c3f9b9bedb636cf5d7e626
+#347 95fb1d04faae0f523f169d27bf918f19
+#348 2c92fc452ac2b8c7c034313d4be35a04
+#349 61e856602d14406c439127a12cef0fd7
+#350 86d56a45653c3c37df28b16ce3b67bfe
+#351 26a717eef1828094046d74fc95d52ee8
+#352 fc477b9bf99f3ff22ffb38b79bf8e409
+#353 983af37e2a8b977c16dbb7211f186821
+#354 548bbd9b7532223108ddbfc0775e0d1a
+#355 8f13534d6f8a2f61ad6486f1be19cb55
+#356 b6585eb740711f56d7259e9cf9c309f6
+#357 6fec7d60528a31491614b97b29dcff15
+#358 bbf97ab249d0e36ad0c0b3c81147d6c1
+#359 11223e847ba1691555d3d368a33ff379
+#360 ae3a1b45626c73c0ef27e3280fd6456f
+#361 1573d84cb1eddf607ab88ca406c0a8dd
+#362 02930c3a40592a75245ea44ff8089284
+#363 fbd97f16d1a88e3d6c783494f0d5923f
+#364 783cfdf47e9225aec28ade17975359a5
+#365 4abdadb36071553e6ae6cdd97d2d493e
+#366 b995263a8aeb60327f21db22644f0457
+#367 76e3bb01cc51e678b2c87fff8ac58dcf
+#368 86141fa38e6521c7e5b81a61d4ea2bd9
+#369 cc57e050f639ef9965ac1a47d13dccbe
+#370 ee9f5bc843de735cf21f7673782fc019
+#371 898bb9baa212951d790a050e2f485c10
+#372 9bbaaa9dcaef9a142a370c0193f9b617
+#373 8eda727321876c4cd45a0f1b209bde05
+#374 76a967d1bfa38b09a52711325fa56a00
+#375 1b30a6d83a42f83804cdcb3960ec8f06
+#376 206093f0253c53bae4e073f98737d524
+#377 bdb7c8b950d6089ba07a126d6c06a091
+#378 049b3fc5814aa037ba879db3b0a2a4ea
+#379 f9c67db0b15cd27b831559d8de175bd0
+#380 9c7180eae6cfb854b05435a7e3afb23e
+#381 e7f6cd25bdc71f5cc1af11237b44a2b0
+#382 3be1381566b3b65fc621790876b2b0f5
+#383 e0931bf828aeaf0e234741f6d536b82d
+#384 e2f99c91c17610c7d0286ba09c06f7b8
+#385 5c1481f7daceef2037b9d00b70f551bd
+#386 957b854136a6c2d9b3968a11cc44f879
+#387 868b46047ec77fb77da519ca0f2b1305
+#388 afca622ea074efbf5a2817fb2ec641cf
+#389 3b457dd488cbdc1d78c3107ea1e70a14
+#390 3af71eb38f15e05f0f19337a00105efc
+#391 1d77aac1d56701f613acacc753588e86
+#392 a15c487ba5c36c36dad93d4734da892f
+#393 222ce7300775adc474d62341e7e5734c
+#394 a5c3af723e3ccb9be2b50a91d9d4ae40
+#395 49156190e04464bb5ba5ff9c91867ad1
+#396 1391f8a41d867e8a344199bd61e6ee4c
+#397 75367d95dad8ecf11f541605bd1f7eee
+#398 ae347d2d7709e27613a58c5dc11fbe95
+#399 7bd074299309ba5003df6db2f3611351
+#400 9aa8089d34bc38bea839aebe772b1ee8
+#401 3dd864b39f52654c4be0fd686a06a0d4
+#402 b030585bd79803e41ab0af72eba2138e
+#403 cd2032ea43a510b2f6c006a88dc62671
+#404 490a7d338e39c9f7c491a84de6db95db
+#405 92a36a463c2313b4e610f17c6c07f6cd
+#406 c9f18ee1cf2ff202910dc4788c8818e0
+#407 f79056506da8f62464dad93c5fcc3aa4
+#408 2266ee6394b3b761e64b73315cf1a3dc
+#409 d45f74ed46abdfbac78919a82598cbc7
+#410 d370d3f1a294dbf0d9b7a2c5e072585f
+#411 262858d017ae36fa32394da088c6021e
+#412 aa391d55c497ede77e4de0529a77eff0
+#413 a563bc621f5d1b4c9cc35708c5fc0f51
+#414 6b93878413003dbb71359657802ba4bc
+#415 947cb10037c3a12ff525fc02b12c25bc
+#416 f00aa56bbcf17a05330a66740faa5f96
+#417 364912944b2dad8778178e122c5bb419
+#418 e857d10dbbb87539761331b639e99071
+#419 171c922dee7b1754142e7c91177b1922
+#420 0effe554f00f1def2b0169ac71fdd3ba
+#421 a20e600bec36509588c5d8db6039458b
+#422 99caf4cbfd11936e4d4b016b60e64957
+#423 e7933f1443920e96a428abbee893e2c1
+#424 d6752c3f91a34257e97875da7a63e170
+#425 6414f987240a6d99ff4263d07ce1bd32
+#426 01fbbc5a1f6ecbc6d093ddfb738ca8b2
+#427 3ed2df589a1ce533232da2d4bc2a03ba
+#428 782a5d56c65feb414133879c0054444d
+#429 1852ed612c0510dc3e81817ada33212c
+#430 e8ed9d7bd10aa07566bf0b2652b510bb
+#431 db7c0b87b391b3c67765f51f0370910b
+#432 9bd4595ff164a1e6c47a1f1550ffe73d
+#433 2486ad27e0a80bea48d24c146dc121d7
+#434 bd23f04437df85cef81308940715ef66
+#435 1d2995d4fde64e5a25f46190d25a9d5d
+#436 0973e51425c089615fa12aa4af3599dc
+#437 92590ce7c5a2a5ce870f444905842157
+#438 eaf9d165f38b562ab57c2bb6c85a33ab
+#439 160b43fcd46eb9b9fd8e00d18e3c620f
+#440 c5a226e29195d71336242cbd86e6a5ae
+#441 66e0e2c065b1d7709113188cb1df4ef6
+#442 f0506036f074f3febf9638ca81921b75
+#443 813d3bde279f1ba30c034e5330f37ff7
+#444 a0dc8ff74dfb8c0b0d763d375d4dd51f
+#445 2449b76c30a13e1c87eb52c6cd3ef3f1
+#446 2773574eaae9a0e3a42efdf1762c00c7
+#447 af58c8008a807a77e23ad023932ba6e7
+#448 3c25582e6290e293b53822778873853d
+#449 8fbe05e5a3e8f350a201ce707baf338c
+#450 821876a13fabf917e82a49eadf4f43e1
+#451 f60f06ea7255bea0c6a7f6d3bfbb4b2b
+#452 23349a6c0ee237755ade55e66ca2570d
+#453 57c4d67599db6592633149defe03efd1
+#454 1d4f0c7de485213e3329b221ec9a1e91
+#455 af59a418fec494cd9b62ed996c7dcd3f
+#456 bd33479ae1425244207e9dec5ac5d440
+#457 87888c312e6092ffef7d1b8c7dacc8a7
+#458 97ab2fae89e40a529ed21cd9123cf2b2
+#459 24856c56b4c23b03934b18221102d877
+#460 b9ffa3d212d6342e90e83e1a8e2a7be3
+#461 aef503da7d06dff55701b9adb84b5b74
+#462 930a8cd038d577fbd65cd81ac29cb871
+#463 2e0d211813281c6276013c924582c022
+#464 e5ca383e67856430bd1c9ba0360adfe1
+#465 c1389259424c5a60432806c158f0cd56
+#466 015b7a53db721d6e7fe2804e853bcdc4
+#467 1df810d448697349205597147e85c351
+#468 646f582ae1e0fb8ec7e88584f849ea23
+#469 ada2da725d6992c9fe293dfbee7a0a2d
+#470 94d9fa958ff5c335c9b957422caf1972
+#471 84bd140f0c0f1d2d4286d181bb90631f
+#472 b7aa37b5b5648e5ffa3073b80774fdd8
+#473 6fa93af3fb2b648c7c7f1b8f618ffd36
+#474 5b9ba408d85b8d66b2e8b4cc167a866e
+#475 0c8fec8da4e8b8c91338ff16e1b775a9
+#476 aa4fd6e89f4db212d8c2916831000a94
+#477 6e1953710ad6ab9c0c3abcae13f09c37
+#478 a4628f8cb597ce690e9998872a54c450
+#479 ed23ef02aa92833805b91f4807510dc8
+#480 a50fbb3b5cd3deb2100807a742fb5398
+#481 573edd12745a35dd298a7cb908977bef
+#482 89a35507d5db6a65f9921a4ceb3265ac
+#483 bab64753c559b2d493f47dde4579622f
+#484 8d45f658bd4e45a32881ebcabb1fb4cd
+#485 677a17aa11e972812be34f36979e2088
+#486 5bfecfd57c8199f5bc9e17f5f201d731
+#487 9fdcb6ec8766b8caab66b67d4f657a31
+#488 7aa03c5d436c72440fb431b17a23c26e
+#489 57f0f6d136c7b66ec635ee356ce9bbf3
+#490 219f19d26f69c0c5357bb8cd0a9cab68
+#491 d6cb00285e4620a82b3b8cee5bd35e2a
+#492 99058e535cd81cadc1d150cb5f17b101
+#493 71b33b7df398a9036963608fa335796f
+#494 7e22acb050d94de11d02cc0cd7640bff
+#495 92b08dae7ecae8d046e1d41ef4f6d17e
+#496 7bf9e700884545e6c7d61c345e720476
+#497 42dac46ba52a7b580c2dc09db18e9a2e
+#498 7f534b2e28d439fa851850b7ab624ce9
+#499 11e6e3d3f055701e14492831312883ad
+#500 711e49d37d7c37ccd3f9b2f747055f90
diff --git a/tests/generic/536 b/tests/generic/536
index c3b1d38f..986ea1ee 100755
--- a/tests/generic/536
+++ b/tests/generic/536
@@ -47,9 +47,9 @@ _scratch_shutdown -f
 # second file should also be zero filled.
 _scratch_cycle_mount
 echo file.1 | tee -a $seqres.full
-hexdump $SCRATCH_MNT/file.1 | tee -a $seqres.full | grep ab
+_hexdump $SCRATCH_MNT/file.1 | tee -a $seqres.full | grep ab
 echo file.2 | tee -a $seqres.full
-hexdump $SCRATCH_MNT/file.2 | tee -a $seqres.full | grep ab
+_hexdump $SCRATCH_MNT/file.2 | tee -a $seqres.full | grep ab
 
 status=0
 exit
diff --git a/tests/generic/567 b/tests/generic/567
index 3f5907c3..40a97d2d 100755
--- a/tests/generic/567
+++ b/tests/generic/567
@@ -39,10 +39,10 @@ $XFS_IO_PROG -t -f \
 $testfile | _filter_xfs_io
 
 echo "==== Pre-Remount ==="
-hexdump -C $testfile
+_hexdump $testfile
 _scratch_cycle_mount
 echo "==== Post-Remount =="
-hexdump -C $testfile
+_hexdump $testfile
 
 status=0
 exit
diff --git a/tests/generic/567.out b/tests/generic/567.out
index 8ca73fa9..0e826ed3 100644
--- a/tests/generic/567.out
+++ b/tests/generic/567.out
@@ -2,18 +2,18 @@ QA output created by 567
 wrote 12288/12288 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 ==== Pre-Remount ===
-00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
+000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
 *
-00000800  59 59 59 59 59 59 59 59  59 59 59 59 59 59 59 59  |YYYYYYYYYYYYYYYY|
+000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  >YYYYYYYYYYYYYYYY<
 *
-00002800  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
+002800 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
 *
-00003000
+003000
 ==== Post-Remount ==
-00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
+000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
 *
-00000800  59 59 59 59 59 59 59 59  59 59 59 59 59 59 59 59  |YYYYYYYYYYYYYYYY|
+000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  >YYYYYYYYYYYYYYYY<
 *
-00002800  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
+002800 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
 *
-00003000
+003000
diff --git a/tests/generic/612 b/tests/generic/612
index dd17944d..9c023a65 100755
--- a/tests/generic/612
+++ b/tests/generic/612
@@ -47,7 +47,7 @@ echo "Reflink copy from b to a"
 cp --reflink=always $DIR/b $DIR/a
 
 echo "Contents of b"
-hexdump -C $DIR/b
+_hexdump $DIR/b
 
 # Cycle mount to get stuff out of cache
 _test_cycle_mount
@@ -62,7 +62,7 @@ $XFS_IO_PROG -c "pwrite -S 0xa 0k -b 4k 4k" \
 $XFS_IO_PROG -c fsync $DIR/a
 
 echo "Contents of b now:"
-hexdump -C $DIR/b
+_hexdump $DIR/b
 
 # success, all done
 status=0
diff --git a/tests/generic/612.out b/tests/generic/612.out
index 237a9638..6f36cca9 100644
--- a/tests/generic/612.out
+++ b/tests/generic/612.out
@@ -4,15 +4,15 @@ wrote 2097152/2097152 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Reflink copy from b to a
 Contents of b
-00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
 *
-00200000
+200000
 Write to a
 wrote 4096/4096 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 1048576/1048576 bytes at offset 4096
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Contents of b now:
-00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
 *
-00200000
+200000
diff --git a/tests/generic/639 b/tests/generic/639
index c30f7644..abb91c80 100755
--- a/tests/generic/639
+++ b/tests/generic/639
@@ -33,7 +33,7 @@ $XFS_IO_PROG -c "pwrite -q 32 32" $testfile
 
 # dump what we think is in there
 echo "The result should be 64 bytes filled with 0xcd:"
-hexdump -C $testfile
+_hexdump $testfile
 
 status=0
 exit
diff --git a/tests/generic/639.out b/tests/generic/639.out
index 9bf0bac9..ee5ad91a 100644
--- a/tests/generic/639.out
+++ b/tests/generic/639.out
@@ -1,5 +1,5 @@
 QA output created by 639
 The result should be 64 bytes filled with 0xcd:
-00000000  cd cd cd cd cd cd cd cd  cd cd cd cd cd cd cd cd  |................|
+000000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >................<
 *
-00000040
+000040
-- 
2.31.1

