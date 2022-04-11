Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39880C433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Apr 2022 16:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240546AbiDKQjw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 11 Apr 2022 12:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348663AbiDKQjv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 11 Apr 2022 12:39:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FD773B2A7
        for <fstests@vger.kernel.org>; Mon, 11 Apr 2022 09:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649695052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hwbpuUZh4UL4kZpkgAV2cEx0RnAP4Gqitc0ulGcFuek=;
        b=Ja5E+BgPtuhfoaa85HgnL1xf/S9F/SIO9YCIslu1/Qxy0Hg5eN4q+alPEVuj0CMSOpg0TT
        GtB5RDEr52QF1RPDdAN0ACv4Njmy9Ie6qkxXPOT7FyZ04eDV8IBMr5sOgLh3KfZ2lhCnlZ
        M+IIjPc1/H6AkrF+oUKxTNd1IC9oTL0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-wxF7n0Z_P-eLBV9GtRP-Gw-1; Mon, 11 Apr 2022 12:37:29 -0400
X-MC-Unique: wxF7n0Z_P-eLBV9GtRP-Gw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A58E11C04B61;
        Mon, 11 Apr 2022 16:37:28 +0000 (UTC)
Received: from zlang-laptop.redhat.com (ovpn-12-187.pek2.redhat.com [10.72.12.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85A619D61;
        Mon, 11 Apr 2022 16:37:25 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Cc:     guan@eryu.me
Subject: [PATCH v3 1/2] xfstests: replace hexdump with od command
Date:   Tue, 12 Apr 2022 00:37:09 +0800
Message-Id: <20220411163710.2157888-2-zlang@redhat.com>
In-Reply-To: <20220411163710.2157888-1-zlang@redhat.com>
References: <20220411163710.2157888-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
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
index 17629801..ad60fad1 100644
--- a/common/rc
+++ b/common/rc
@@ -4906,6 +4906,18 @@ _require_kernel_config()
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
index f1e8b0a8..939692eb 100755
--- a/tests/generic/404
+++ b/tests/generic/404
@@ -110,7 +110,7 @@ for (( block=3; block<=500; block++ )); do
 	# or blocks are in correct order, this commit:
 	#   2b3864b32403 ("ext4: do not polute the extents cache while shifting extents")
 	#
-	md5=`hexdump -e '16/1 "%_p" "\n"' $testfile | md5sum`
+	md5=`od -An -c $testfile | md5sum`
 	printf "#%d %s\n" "$block" "$md5"
 done
 
diff --git a/tests/generic/404.out b/tests/generic/404.out
index 9623cc2a..2880a59e 100644
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
+#3 d5562922bd01c2def22f4225aaacd1c2  -
+#4 e5f7593f700782765f56f83bd355079b  -
+#5 837132f2781fe2153853fba18f5767a2  -
+#6 ff35d6b4461189846c6eb9e1fecfdda8  -
+#7 c6da6180691decb6e365f5b5a222241c  -
+#8 91f7aad51e10aafc550f0622d9662b2e  -
+#9 1798f55394e4627379f2c8ca705c1fb3  -
+#10 45c62c4137b971ec844119361a20e9e5  -
+#11 d8152a64ea495a677b5d199355f66aa6  -
+#12 b9c755322ccb93006363c0092a5ee755  -
+#13 8a38c7fb654d8acbbe449d8f5d1e6dc3  -
+#14 4b4a51949b8d6ffe481ff068908272b4  -
+#15 30699dd504b8d2ce64d294ccc062bbc1  -
+#16 543eeb88f32e75f93f6537e59b25f8e6  -
+#17 9394c31d17d43af545be3c8854742208  -
+#18 c38aff421cfbfa5a31ca61705db17bbd  -
+#19 24aeee0996471a820feb84ca281270f6  -
+#20 c024e6d4a0ed4cb619d0d42e49ac538f  -
+#21 2432a83b52b89ad262483dcb0d3a8634  -
+#22 46d0c05d732e8b898d35a5250a2914b3  -
+#23 c2cf9e9324168a1bdee5f646d6fa7bad  -
+#24 93dbf94aafe3cf06e201f047e8f897c8  -
+#25 81aefc3b3709cf7e4ab474347a477caf  -
+#26 7718670b6d23bd05d0533f14f04bf452  -
+#27 e31fa2313b029b63f49d0cd989a1fa89  -
+#28 ef1e1ee57c2e07ac9831f79254c54a33  -
+#29 427dc7903688705517ea50ec2bcda1a5  -
+#30 300a25a000e96c0d9cc8c4191221649f  -
+#31 4ec4f8af749bc7161010db71a009d790  -
+#32 8200b15e91b1d865c0dd7e65f0152aa7  -
+#33 2e5c627c050525b80906ab6edcb625a6  -
+#34 2beaf294e6220d1b447c8ce0db186565  -
+#35 867d5b0427fae7287fd4360d64e901c4  -
+#36 0c89408220063edc5db47b244cb5815d  -
+#37 419d11e031fc33e587d92208d60fe73b  -
+#38 a179448d3005e565dfce12657ded6872  -
+#39 75e8fcfdc9a760dac0a02160bae83a26  -
+#40 49b0a366321174ba93384b8acba3484f  -
+#41 f56e56df00385341ddd1e5242ca7f3c1  -
+#42 5575be655eba62878a024e20d1fb7ddb  -
+#43 ee55b48c99ac228ec0932ce0b3790ed2  -
+#44 f8456ca58733703aafbf575d95e9d2a6  -
+#45 0d890c48700ae8f6e992f01f736d334e  -
+#46 436d82f25d1c6c7607c9c672a24a3780  -
+#47 6ead14b8448aefd802c3a08e193f7ba5  -
+#48 8ca07d36cd44689c6b3b27770c13b170  -
+#49 d522ad80f1ec31680e859fbdde8535da  -
+#50 e41928debb9ba03fb5e68e408197205a  -
+#51 1031e47c6cdc969b59899fe7c150292a  -
+#52 36fdf921a87ec5451efb9c8edad3790c  -
+#53 5d464e32abb1235e0d11c09699b4cb7a  -
+#54 60e6286f2c618c801669aef26b3f3479  -
+#55 574617479e525be26df00ca8205e5948  -
+#56 ba4bf511209e73ba3749aee2b580ff64  -
+#57 0ee54e25aab6ddb43e26ba5d9401aef2  -
+#58 03bc8e590b6beac2e154ad417382caea  -
+#59 b4bf4815dd849cbc63536623412d5d58  -
+#60 6ed2c2c00a4876122a3412b492d54ec1  -
+#61 90b283ef67e61056dc30adb6f9738cd6  -
+#62 2f6b932580dcdc868c2e6367f7243f4d  -
+#63 6c8f4c7fe3a5f9adf6f806e19e438ab0  -
+#64 1c6eb8f0bad6db54cdb40c519e36ebc0  -
+#65 12ff70b9ed19ab870198e14b76838928  -
+#66 1f57bd362faa064ef7988554e260d507  -
+#67 a75fbd63eecc9df99cfbc245a1cacc31  -
+#68 57adac1241bdf7db5b510e5d4761653c  -
+#69 ada45ad6641885ce1b76ffa9d084c03e  -
+#70 d4ed14a9c13c2a90fdf1cb02f2d29f60  -
+#71 62536c2f0f48dd4dd77491e1fda7602b  -
+#72 57db6eafd0b070684a3c8b9c272f53f3  -
+#73 64e42993b2846c08567830a03393c149  -
+#74 61e3ac03c779592e9ff51839de6ff956  -
+#75 ca870235c1781cc4c6416c73533f7c0a  -
+#76 3c1df0e8cab28862c89a3540651cab43  -
+#77 211f22ed5f2255a22c3af7a7c2f608d7  -
+#78 1c3469c5f818a907351d7e8ddadb77b9  -
+#79 d8d0c2892320999f3fcd430b7de70550  -
+#80 b65b305b0aaddc2b66d16b37022567b8  -
+#81 0b754a882ed3f13c88ae19ec764cde1d  -
+#82 0824e8d8a35b52b5a3ce85a5bc719801  -
+#83 c506e33e587e542cdb87daeef7e059d2  -
+#84 85051bc8947d3809315904b0b04c129c  -
+#85 a21f86b74775b2a684ae7d02160ef90a  -
+#86 f444c659008fd8161ee37aa34a7a41b8  -
+#87 c1c7e8b22569a397c1aad1be2720b0ff  -
+#88 733d76e751fd17f30259ee17a002aab2  -
+#89 dd0f6d83379622838dc736dd5abdefc0  -
+#90 5c984177326ad637417114944673af73  -
+#91 97db15b0a88838f20f58c1a99370f744  -
+#92 f54e6bc5c5fcb045f427a3b410baa7d4  -
+#93 8327f892d9a21cbe1794c5e855256322  -
+#94 c0752c11b43e6119c132d7a54dfdcb03  -
+#95 189abce9c6b3ef63796613a98c47b978  -
+#96 33c85c6b6c807bfd83406352c3b99edf  -
+#97 f20a270fd45e7e5fc9da3bd4d42d6e16  -
+#98 15256cec5418f0c024f48fa11b2e28c0  -
+#99 ea7f43f342b778b6ed88269c0618be69  -
+#100 24912ede6dd19eb8b5a476d0f432afe9  -
+#101 ef44119dc54ca97afb1d576f189a8a5e  -
+#102 d76288f0ba0652cc12137d0bd2184bdb  -
+#103 61fd7af710b1ebb469d8e4d9f8012c68  -
+#104 9abc88b56a3f625692a576ba968108be  -
+#105 774c5ff756ba78e09ee184f4f3ac0712  -
+#106 17b923c26e44b81eafb27f641a97f879  -
+#107 d259a0342c50032f19dc16bd7fc1c490  -
+#108 b04d9f0306ded13b4cb91901d38938cf  -
+#109 6112916571e9304d270659840a23c748  -
+#110 2a3e6e89b0d764362c9c788b45e7d4c2  -
+#111 d36fdcb7f75baa041d6df857f17b0731  -
+#112 e79202a683a5869eb58f59e564e472d8  -
+#113 95ec12a1da0bc9ed2b57b0b72e629ba6  -
+#114 56e4d0d07ff371b8e4d16a0d38763382  -
+#115 39f708354885569ec0273206c54b02f5  -
+#116 8306b168fbc12c9b96e09951c6a4696b  -
+#117 3e65077aca42b3328cbe6636eb47cb4b  -
+#118 742b87d458b48f34df061d5445268448  -
+#119 a1b765f87adb38884a3e902e516000e1  -
+#120 f46f0dd041ea3dfdee9dd8ca0367981b  -
+#121 253a4401bc29a1989b9066ca26b1edf7  -
+#122 a89618da4c7b8a844e13f608c0191d8b  -
+#123 bd5fa94bfc71ad7b21f7055d31e27a45  -
+#124 1365a878a773e29b7641e69323b1aa6a  -
+#125 e6156bf9342b13689f8765478f48bf11  -
+#126 fbbd1f9e2176f66e7724fafdc2abf0a1  -
+#127 dd2b237266ada98a1e107f70003c300d  -
+#128 851b331ded90b233967f7e67858725d6  -
+#129 0f1df8479bf9000c1dc31ec723fc9e52  -
+#130 2c4d196347d318817f48aad6fd945c88  -
+#131 b2159cca0c052303c2738e58b79073a1  -
+#132 9bf6191db1b30f1258cee87d7a261925  -
+#133 7544c0c0a62f64bf0295bda63a0f7f87  -
+#134 4c687b54b76e488623c2d29ef748e857  -
+#135 7175d89174076d79098cbba4f2c0b340  -
+#136 377121c04602c10b3c5665bcb10b1f48  -
+#137 c7786e08290304945bf17923dd179ccd  -
+#138 21ef6f1ad7e4cd95742621e0c818e2b0  -
+#139 85b9054f46e8756483eacedbe26fc2da  -
+#140 7fd3ecfa72af2a2117009beaa3fc5f2f  -
+#141 2c3cec047724ac3feea9b97bc2f27feb  -
+#142 2c8c3bac616479ea8854a3821590c111  -
+#143 6d1c0330e6e87a0d5125f8c8614c13d2  -
+#144 30fb90522b6e4f75f03f894199a00379  -
+#145 7b37c588e673e5fdc6e18ea48dbe8af7  -
+#146 868fe667da99b37afe8b405ac3467803  -
+#147 a943f9886f86cf6f26abfd826662ceea  -
+#148 3bc9b0f2565960616eb287a05e965e23  -
+#149 835a8dab98f6ac5cd50131e6c9cf4074  -
+#150 672a86ec553e134911c314538b1d246c  -
+#151 3c21c0f5ad912035478bf3ae971418b0  -
+#152 3fe7be1531ecdfbc10084e14fe7c7d68  -
+#153 6d4302bec07083765121eddb0ed26ad2  -
+#154 bb416dc1182863aaad6003234b5c6d3b  -
+#155 f4f4b393ea1fd5487f9f470cd0c89863  -
+#156 27423de22ab7ca5df8807437bda90e71  -
+#157 bdc006945f09638468bb4c2b1d475bf9  -
+#158 b702fbbb2a3e91903f438167a033f9c9  -
+#159 fd159753ce5c3d16840db43523646d6f  -
+#160 a3586d9d864de93f605275c3ba45bfc0  -
+#161 7c09d1987189bdf9ce5b88290e67ecee  -
+#162 2852fa065bbf09e07f46d47d716f4c16  -
+#163 8d9600088820ee39fe17065dca290f69  -
+#164 36b0ac4267b29ec3123c80fe4f7f7a80  -
+#165 127d1088fcf34e72fdca10998649d608  -
+#166 ece3e6bc4efcb556f4e26f62c3baeaf6  -
+#167 3086e166949ef1db0f5d5252b90e8638  -
+#168 e4e2e0a46f591c7e3a7f47ede4b945d0  -
+#169 cbe72750798fce811544227dd9ca8f79  -
+#170 b506cc10b41f8911dd4ac764b729cecb  -
+#171 b211967b098994f110a05d971d8df872  -
+#172 80e142dfc94d7a2e2a7b3a0b1be1b0e7  -
+#173 57e6887f5c8e21349444473b6d0d5aca  -
+#174 0bf3acb5a4f232f06a3ed87469b480f8  -
+#175 445246a06c542c36877a79c8e1f38c08  -
+#176 ae0ee407d192bab259381d2980d6d9cc  -
+#177 2b7cf418b41f692d47cca6b79587f365  -
+#178 e4ad262c3815ccd99e446122dee2f207  -
+#179 e11b83effa848a95d7c4b1b3d7521790  -
+#180 b509a6c3b54cdeac48eb20099f54f3de  -
+#181 18d0092dfcc2e85edb3534f9104ec7e8  -
+#182 27c39f51c80037724ef1381f61bb773a  -
+#183 c54d86713578d4899013962428ce20e7  -
+#184 1a3fc1ac425caa0d4e89a513fafb4ecc  -
+#185 ef85c88903c6e2dbbd5c9e4169834919  -
+#186 1942aa41ab9903b2354fa2b5a9e4cb3e  -
+#187 67d11a091d92bdae84b6a8ca64e78716  -
+#188 1f63ba8d3064fa334588964dacec3751  -
+#189 86a1ad7f201b7982b8d0d54adf8087fc  -
+#190 b1839c6298487779aaa1aa0351d55af5  -
+#191 ef2cf038ab79f144a020fad1a1ab9ad1  -
+#192 829a243795dded8e31245e3fd161e1d2  -
+#193 8910cbd8975d9fa8309792c74cca08cc  -
+#194 616fa1a69389ee9d72cef85fdc3cfb4e  -
+#195 1542c7036fc11e70a648161a1b6ba81f  -
+#196 e5e5301faf37451ff294887f7a34fc6e  -
+#197 0a2a379f14ef45b0edd1c6e79e4cb5b6  -
+#198 a042581ee6e5ac04fc5845505ae5571e  -
+#199 b4e0c1268b6981b41061eb2ab38fe08e  -
+#200 d5cf63599b3de2b47b4031d828986d01  -
+#201 3569606c8a40ac43d058f27e41a34bda  -
+#202 0e4d19efcff71b5a5421c8c729931233  -
+#203 ad030569e877cb5c09d71c44794a530b  -
+#204 6cc4c99ac22ec6b3a786c7df52989d28  -
+#205 d4b35c8a179139468b40316c341edc49  -
+#206 fa1f10a0e9f9fcd809d1f7c16767ae17  -
+#207 04eca02c5db47e7d7871206262b0e3e0  -
+#208 993f812816edac9171691db2c9325ec8  -
+#209 ac9b8ed10823c9ff3c7ae4546b25269d  -
+#210 f14c447deb194d96a1d7dfdef2ad9dc3  -
+#211 6a93bdbb3fd2ed0b57640a408f91216f  -
+#212 4704729f7596da0f682c2b3eb1a85297  -
+#213 6e3a87fe68c94b482ed8d9062835882c  -
+#214 40ffa48eedcf60a2aca003001e5f7a64  -
+#215 6a6a48a7521b4bdb67e7a75bb3cf034e  -
+#216 f5e289488e11f492bacc2d5a6de2ef45  -
+#217 c61226171c1a6d2d7e482612b080c6a7  -
+#218 fa0aea0bcbf201e693a75d01899349c0  -
+#219 a8d3261699fd8c047c9a9915d7fc1b86  -
+#220 7dd83fdeba3630b97d82bc6bd10f2c6e  -
+#221 4f8e6f718cc40246f76e981811d0e9fa  -
+#222 b2f22d726a8f82493b816963b8f85942  -
+#223 a7e5d702ca57aa92d33f93725953779f  -
+#224 1a62778e968975accfd74952d84b3741  -
+#225 b96bffac046b5ac6873f1ffe66879604  -
+#226 babe422fb8bc77a28bbc1fa0d9f02bce  -
+#227 6254d3fe44353051707ea92927d0dbdb  -
+#228 719b6c02624aea67389c9a55669cf575  -
+#229 3eaebf108554a1487aef12309636fa77  -
+#230 656a145e8ce2d30c5a0f23605295eaab  -
+#231 d82afa48e78c122353abfb0787f3d17a  -
+#232 28fe331e5d8f076aef8fc52272f43d10  -
+#233 9b42a65979b0d6a24e708e49ee2efd45  -
+#234 393dadeaa4cdb7f4c7b6b615e3e5529f  -
+#235 b88ca02ce15cd84fe1d2ee628319cb72  -
+#236 cbaa250566b9662849f09f7dc93bb7a1  -
+#237 2776b9e71402387564681e2d3ab7ba29  -
+#238 2d31d2c0ee6281921acdadcc43968c5c  -
+#239 fd2fcb4375a77019242ee8471de8533a  -
+#240 81d0592fe61b9ad503635b80b1c30bbc  -
+#241 cf7ed9b2dbed196c2088f1969dbffba0  -
+#242 b805f104f0bac11136ba102cd73fc24a  -
+#243 01c59bf3cb8f8b6cd63774db7a19c51b  -
+#244 8a262e0d8172bf99c2da29febc763c43  -
+#245 13e938182a07e9a456c7264c1d0789b8  -
+#246 68fa83d62c00a9c51fc78f8fa514ab67  -
+#247 595bc325c36d3decc9d571bd67e4e34e  -
+#248 78a1eea30e9caaf6c2e38b1850a87791  -
+#249 9d1f314e8e919b8a350c8c4ba2b7e108  -
+#250 39b7364611b7a8756833d66667973a29  -
+#251 5a30ef17e47fb62a4817744bfeaed581  -
+#252 e37124ed905848369e0c4a58097a8928  -
+#253 c2531e8be1ad3f6885ded0884b3caa30  -
+#254 810233cb8f4dcaec331b373fbbc46a5e  -
+#255 5b7c9afa1ef742c891bb2b16911a70a3  -
+#256 9647696eb24ca112080639f916f46eb1  -
+#257 0596c366d80427d86c9ff4a222818344  -
+#258 6496cc74071404a78f00d506c8fd7d9d  -
+#259 c92137074484ec595e3c359499d08442  -
+#260 448841f26c871d396305e132d8ef423d  -
+#261 9de74561a2653ebfb5bac5f341ddc305  -
+#262 e55723ffca15cfbcfc5ad0f7309ecbfc  -
+#263 329adfce75805f0f5160a2bde7cf309d  -
+#264 78e7b12ae40d0a8f6c87ad8243e49711  -
+#265 6a1139054e2c226d5abf06983bd7fb81  -
+#266 5e3add49ee2b8bf7f74ce8f4ad8b1266  -
+#267 66d42d5a3222b8262ffecef5c465066b  -
+#268 94eccec4dd776e92e0fbf70ac58f2b59  -
+#269 5a1f7e8c9773efe1433972e83edf2b95  -
+#270 0bbb0c32c60a0d19271c459582c15b33  -
+#271 2b7bff9186af590bf3796f3b6a03ec5b  -
+#272 973babf27abb4dc839630b3b70be4b92  -
+#273 9f88dba349c56f664300286dbe0e768c  -
+#274 478e2ae3576c6924dc7a935a81ae3766  -
+#275 c8c359daab7e486c8cccfbddb6eec7a1  -
+#276 7fe80c5b9310ed885f756e25dfd923cb  -
+#277 9ef32a6e753e29d9669ec9ff2a2bdcef  -
+#278 c8144e1e9e03d16173afaee0385d9815  -
+#279 3464df4d673938ba074988b3fd1c6972  -
+#280 a5c21b0e56fb3ef554ac6d03bafd4d6f  -
+#281 a8e06b32ff431385db3a91d243de6750  -
+#282 31ff4e5cd507cc17d2f372000302d37f  -
+#283 f725cbfdd7e64865e50abb9fcf001d36  -
+#284 132eff1ff4bf750d5ed45a6649ee89ac  -
+#285 33d3a3e2ddfb1cef8de59a95bfbc7203  -
+#286 784176f109f69b8733f244b7021c0ab2  -
+#287 3ed8826974bde881280c817e1398d0f5  -
+#288 c6dbb34e2816d5dfaba1eb5d3c3bbf56  -
+#289 879774daac87cc41ba8b321ea226225b  -
+#290 7c1457e522dd5f0f9fc9e480d25e81e2  -
+#291 546202629b1c7780e37cab8f5725a6b0  -
+#292 2a987c996e8e9db93d8e592d540b8b16  -
+#293 154752165525812568703bafd256f900  -
+#294 f969409d8ade2050f481972e83a65d37  -
+#295 0220ade479f972a8271c9eb221949b83  -
+#296 33b6020eddbfa5dbea7161ab784f701c  -
+#297 087df43fb0ac62212df682db5a59bfff  -
+#298 59a7e049e29cb79ab6142bc5d3d9ced7  -
+#299 35bc369ce3de481ee81a99897390c45d  -
+#300 81fa0548ef37b22e7e6859ae165c96d6  -
+#301 b69e27fa0942a82ca4f8832ffc886cc9  -
+#302 8b79a7493e5e3b161ae141dbe1c38e07  -
+#303 078cfebeaba23479a1ca72b1a8d9dd9e  -
+#304 2a34d559b7a2c325a9b588ab14ed9ed2  -
+#305 211101ff8052098f92f9c6b6f6c392a1  -
+#306 fe2fe61313ec045cac6d4a78a63a8023  -
+#307 983f6699c073d6f0161fab43d3701692  -
+#308 e33962846cccb55b0bbcac8bb6fd08e3  -
+#309 ed9fe18a4a0edaf87e3ce746578ddcba  -
+#310 e8ef52c85c6adc003073dbf4321de982  -
+#311 20e220d77f1e5b8b8b76e7f81611f2d7  -
+#312 04be279e76aa79ba50690bcd8a761d50  -
+#313 5a73488722db84c056e987533c0dcb80  -
+#314 e1e062dfc4f8a2a31bd4605e7bf03d4f  -
+#315 08b222df61c1bb72c13ab64ac580bf00  -
+#316 08843fccb65bb7cb602a2cf3dd7012f9  -
+#317 593301a0dafa51197cd00d5652dadbd4  -
+#318 c0fe1fc5ea8119beadfba3da52224136  -
+#319 b9b9b48a9a912ca8c5be63a602547945  -
+#320 e96825a8084ba0bc0bed701326069d03  -
+#321 6dee6a72039dcdb99fa757b34d0b6b7d  -
+#322 0f74fa71c4d62ddeb53ae3fc178257dc  -
+#323 a485b933d6e4a9fb72da27520ad4c76d  -
+#324 814bd8d17fe0d372d93d0c3ae92032c5  -
+#325 f2f3381d294cf21b3d39291b9a223d0b  -
+#326 646ee81885659082a2b1f53f2832cc66  -
+#327 b94a174b19f534175114e8614855064f  -
+#328 72e055e8eacad938de31b57f7e6239d7  -
+#329 d9eedaac16cdc680ea82067ef7afc74c  -
+#330 7dbc773c8021cae7da6956c4690018d7  -
+#331 3c870f71de6b4b0f52e73196bab9a367  -
+#332 2be8b273032c59467bd219c053719e09  -
+#333 493abeadcfd0d8c74c7888481f8d303e  -
+#334 c22393ac3be3387b8d2f9e204d774399  -
+#335 d95dc41ef11e5ef484e5a6d6e95f113c  -
+#336 fc98d7712076e145c0ab45f3cb10d3ff  -
+#337 791e604252465c32b9c8a326fb01539b  -
+#338 6b4e2f323768b045347fde4043b31cc5  -
+#339 0b2a7fee66b3db2cbf1ff5238d2d2643  -
+#340 572fa4be0a281bc6bbae2a892c600ecf  -
+#341 77d142be3eca6989ceab9d90e7396fe1  -
+#342 011548c6859cd0aa7e7bb8cedafa441a  -
+#343 17347414b2656700875cc617e7084871  -
+#344 04d3e63fa01999c655fad6b6a49b4eed  -
+#345 4e4bf527f9a5c6e7b21cbae95bbe5f4b  -
+#346 f01821507dadb92673ed5212df8c8e20  -
+#347 1ebb71e5441e68cc741ae5df4001b257  -
+#348 21badd206fe80711dbeb9de6c21c7c0d  -
+#349 f76542018b84120d2e1a02d53c43caf6  -
+#350 e88e04f559b2f00bb2f9ce835907b6e5  -
+#351 5108616ac302ecab4c7125b7072c2b89  -
+#352 5498870be11e50e1550c4ae91277c904  -
+#353 236775eb4e510b70889085c86e2d1c15  -
+#354 cb8132c6614f407ea1f27d1828b5c92d  -
+#355 ad631bf231e633880175ce3a8da5a976  -
+#356 2db68dad1b65fdbd14645624695e08f2  -
+#357 51a7839df69bcc064cc9fc499631e011  -
+#358 3ce4ee7197ba94e0c172f49e6bc869e1  -
+#359 5b29ad873052d82e11212bd58fb86b6d  -
+#360 ab7dd9d9fe30fb18c29fa1405206acfe  -
+#361 bc51ad13a299da752427233bb646bfad  -
+#362 0b8566d18c139264e6a0ca50a6407d4e  -
+#363 3b733c1e6e915a0c3daede684dace540  -
+#364 1ea4e997f44585bf1e1986520165a815  -
+#365 6fa4be253a5b63ac31f85d2bdfa43dde  -
+#366 b43080ca2e8385b5b16b17debd47247e  -
+#367 324e42b513c789e15725caada9d92062  -
+#368 f635c07e4e54f71344bfb656640e1cf4  -
+#369 a357711f2936db6a788cb61b7eff2ead  -
+#370 36f8fcf600f6056462958e2df381147a  -
+#371 be64978c731e65f8819b79893dd4dddd  -
+#372 654f4eccb25cf19c3c37682421f5c23e  -
+#373 3b40f5eecd6bd85d09a7fbffd5209309  -
+#374 0f818417214ee7274aa25324effad5b3  -
+#375 47b14b55fe292e0f3d079a202f182f85  -
+#376 b77ec30e93308d1d502346a2410f78aa  -
+#377 be7ac6b2ab3ac785086469faae3ca386  -
+#378 22efac95089ae46f9ceb1402b2e31f00  -
+#379 c4512fe0392ce753fa401b43af503a8c  -
+#380 c1a15699503ee445445667828bfd115e  -
+#381 41f9819c04b0bb355136b7c3036aab2a  -
+#382 337fd17338b12e7d3fe960a975b89c1f  -
+#383 240e1c7758d32410a59ecca8a5d4e9f9  -
+#384 1fefd13ab03cb8e9bc25946868fe57c9  -
+#385 77325eeab008cc341c4d7f6982b908cb  -
+#386 322b351c77c7a6781b1d0d8e58a21a57  -
+#387 3c2eb0e26437a6d7092d4796d046cf18  -
+#388 42db42d8e793ceb210e0014ec806ff49  -
+#389 becd69abae80ffe009022862c820b842  -
+#390 9c7fb47101d3d177dc86b18572d9b5ac  -
+#391 3aca347a1b7f9102c5685d8078876873  -
+#392 f0362d4e25aeb4c0c021eba32ff84e17  -
+#393 8e2c84fa5c5df76ea9e799c08fc279c7  -
+#394 ce25f350f90eb17745affce64c91f92b  -
+#395 897f9b492e24d0b5137a6f431466b162  -
+#396 953d77416b8f807a91e2a86e6e01ad47  -
+#397 b6368bf4a327ee67cd7fa7340ee47143  -
+#398 278f470cbe4fcb6a2342ac01a9150d83  -
+#399 6b0da0932c703d23837ea7bb18e44eb3  -
+#400 ab9fa9942e65e642d234da83625969ec  -
+#401 b13548ae4fafb75ddc87f241df8ad497  -
+#402 89239a1e39bdaa2c42c29585f4651e38  -
+#403 4a79e1d38b7d50eadb77da7f8b336338  -
+#404 5e9c1219568d4e42b2a4b9cad25b0420  -
+#405 5319efdba6fe6353ea3968a1172ea938  -
+#406 e4f68143aa48723af26e0f9e6f044c80  -
+#407 37d31407485c04bcab8eb78126732d82  -
+#408 01ab78be80861feb165cf6360c6a1901  -
+#409 3f1656a1e2e536effbb135be492e19e1  -
+#410 23846bc9e49f86b90eb7b83fc4ba352e  -
+#411 c4bf8650e326af6cce6c16e38a9c45d7  -
+#412 2f1fbf67b8b9f6f5ab936fbb6576ecf0  -
+#413 67e0d8b2848ed8af23fe49fca4a11bb4  -
+#414 a340b207c012ac5d11c49570584a5475  -
+#415 744e2e7fff279f78339f68e3cd6eab6b  -
+#416 5035622ed7cc3d4380301e7309fdbce3  -
+#417 ceb5be505205910fc50ab8c44e36eba0  -
+#418 116fa326726fc92d7365cb52e6fe167d  -
+#419 af83df3d89e720c7472ee5dcc734adaf  -
+#420 3755798ddddc841e8a681a436e1d7572  -
+#421 e841b352abe0521e692b429af9530299  -
+#422 aebdc7f42825fe413f61208d4c34fc2d  -
+#423 ec240eeefa287e8b86f166a0075aa770  -
+#424 22bb6a0e6702e340dc125f163acf9271  -
+#425 905cda54f7ee85d0378f0947982f0990  -
+#426 730305abad81e465adb0db2ee546e9b9  -
+#427 74749a9b858f2496a059362cfab4f665  -
+#428 887063578c85661ace320b948a576784  -
+#429 243f899365ce677157b9c9b60cd5f004  -
+#430 65ead1551077cb7e2b35f893fd7ce757  -
+#431 ff68f535921ca41b815f30cab1b54dcd  -
+#432 5eee083e5418f6d065c65c9324908297  -
+#433 354bf4761c4275196942141d93a83094  -
+#434 afb6e84e4fe9664b5186db9c3b0dc4ff  -
+#435 3c7fdf2edd8b9d147417cc3cad9c3ae7  -
+#436 3e260f0dc568c0cda97fd38091f7fdaa  -
+#437 0ec1ed23928a186d835f5d88c78358fb  -
+#438 a87f2d7f49ad684aee9a94d9afd60233  -
+#439 67aa3092cf0520555b55f30f9aaf8e5a  -
+#440 a8bbde5f20c0a5a59aa5c762d6280935  -
+#441 9663e56d50b045f5a8359fdfa83d9b62  -
+#442 9b951842b3f5064e4fb2f3fb67d9cc44  -
+#443 d449765e3cbd2c34a57f25c7b37a3775  -
+#444 d70f87dc3ae0bb5727030d3bb0a3299b  -
+#445 4ca8e9ed87ca8383556359c1a1ee90fa  -
+#446 8d05d5fa7140a541fb73ed4b62cc3ee7  -
+#447 ed3daaab4cce96a9d828670043230818  -
+#448 6a45de3d624ffcac30e9a001bbafa826  -
+#449 1af40394e7240a7d04a80fe6615bb005  -
+#450 3b3ef2195774dfcd450c339b0519dd15  -
+#451 777b4778e07d536fe921c7fa533de5ca  -
+#452 659e5470a2e91e827fa67af49c541d26  -
+#453 3a8bec0fb62f366787712e279c2a9ec6  -
+#454 00fed8013859d314a6cd82a418559079  -
+#455 b244639a6baf38918ebc465fbfc989bd  -
+#456 04bd0671a49e3fe321821123171d355c  -
+#457 27560491692b92bd9ba1a4d66e9d1d37  -
+#458 6c4d147c9c33c47bfac1b7c98c97e44d  -
+#459 7ef56f79cda968546f18ab39b5a26aca  -
+#460 68343927c603f8d4751fbede0c642a8b  -
+#461 31ae8b1d58dd48c15acf75486612e641  -
+#462 27145ceb9ad32fdd292cab5d9b873f08  -
+#463 47635a9c4dbd032a8d3a8c5b566ca8f5  -
+#464 0acaadf052dd6370fd7ccccfa8cc4b6b  -
+#465 75159dad67174946f51703e8ff6c0c70  -
+#466 fae4156ccdc465d0f729989fe5e84263  -
+#467 f89fa6636eacaf58be673d9c576b4c14  -
+#468 b8d2d7cbc99242e8870de3ea9c6a59a8  -
+#469 ed817d99b28dcc9d8f035bc1d7cab516  -
+#470 08f8ccdec28972e4e1237f2bbbe13ecc  -
+#471 68289cc2930f2ef272aef8f77bd8e9b4  -
+#472 f848545fa8321e3d925b0aef82d551fb  -
+#473 53291e3e404d36b07a5197bf95dd01b5  -
+#474 8e4657a6eeec1c0c741dcb1f13b621c4  -
+#475 68a5320f9e8b14ff97038f8894f6d231  -
+#476 efbfc528771686e4f55c1f5ad4ae29b6  -
+#477 0b68096303856442976c3ee55fca7fa0  -
+#478 0d2fca82b7ac384be218c941c533ab16  -
+#479 fd4870b2798aada41e9b920df0702d28  -
+#480 2e332c7f8ab24b55afbc0c49418215b4  -
+#481 f8c8a3e7ab4780af2b4ab08077e6ad6f  -
+#482 1ae6adc4ae386711c1f5256f3f2a79ef  -
+#483 4c04adeaccb2642fe87c5300eec5bb4a  -
+#484 944c404c2bc6788ea981e278b292a0d1  -
+#485 fcf83d3f4aaf390cdb80e65e8d699736  -
+#486 14758cfe75279cf12e7d039d34f1e5ef  -
+#487 c2e6cc1fdeac865f4f7c22c467a841ac  -
+#488 3b7dce1c3d8a361a989ffae49a66ea7c  -
+#489 ca28680633bdf1cd687afab7a8ff5cfb  -
+#490 308770e95321161d294fc2c520e8f11a  -
+#491 439932008b77142bee2dc66508690a73  -
+#492 5a8242b64810b861eb5b205acc4c4766  -
+#493 b90546ed35cf380362f3836ddd858ace  -
+#494 afe33f75cbdb0c91c24ae01624e27238  -
+#495 0e058d4bdb88d563f54fbafb24d4838f  -
+#496 b08325e31924cea6641588a71e5524a4  -
+#497 84cf0eef5fe919d18f656afe15e30c6c  -
+#498 6e99c02d5b4efb41d922895071be9242  -
+#499 93b2faa0d9a7dcd4483b930e72843d6a  -
+#500 0671d1505d65ae5fce0a9e040015853e  -
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

