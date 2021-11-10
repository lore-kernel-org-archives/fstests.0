Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A80C433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 10 Nov 2021 12:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E4D261168
	for <linux-fstests@archiver.kernel.org>; Wed, 10 Nov 2021 12:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbhKJMoS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 10 Nov 2021 07:44:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:21653 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231472AbhKJMoR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 10 Nov 2021 07:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636548090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uOzgmDajjs48568W8K0hi2s/v1spGbssSCUDxHwT7BU=;
        b=Gq9gQMepQ/NJ7uA0ogw4iShLiELaCrtY7jjQfjb2e5zUsWGdwn4I2frqmd2UJuOqF8Pmhh
        QKBjLPWBzigP6QhQFETwNpSr4UiO6wFT+0F+t1TWZvH0UG7TLEJ9IZMOHhx4CENRKIZGmU
        o3qsfvVNl4T5eJcxpqcw3Ul3B2kxEvA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-FkMMQ9bLNE26KbcjMDWN4w-1; Wed, 10 Nov 2021 07:41:28 -0500
X-MC-Unique: FkMMQ9bLNE26KbcjMDWN4w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 943A119251A8
        for <fstests@vger.kernel.org>; Wed, 10 Nov 2021 12:41:27 +0000 (UTC)
Received: from andromeda.lan (unknown [10.40.193.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D98335DF5D
        for <fstests@vger.kernel.org>; Wed, 10 Nov 2021 12:41:26 +0000 (UTC)
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH V2 1/2] common/rc: Enable _format_swapfile to return the swap size
Date:   Wed, 10 Nov 2021 13:41:18 +0100
Message-Id: <20211110124119.43974-2-cmaiolino@redhat.com>
In-Reply-To: <20211110124119.43974-1-cmaiolino@redhat.com>
References: <20211110124119.43974-1-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Once the kernel is free to not map the full swap file during a swapon call,
it can be useful to know the exact size of the swap area created during
_format_swapfile().

To achieve this, it is needed to change other _format_swapfile() callers to drop
the return value if not required, otherwise, it will be printed to stdout making
such tests to fail.

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
V2:
	- return swap size in bytes
	- add a function description to _format_swapfile
	- update other _format_swapfile() callers to discard its
	  return value
	- rephrase patch's description

 common/rc         | 10 +++++++---
 tests/btrfs/173   |  2 +-
 tests/btrfs/174   |  2 +-
 tests/btrfs/175   |  4 ++--
 tests/btrfs/176   |  2 +-
 tests/btrfs/177   |  2 +-
 tests/generic/356 |  2 +-
 tests/generic/357 |  2 +-
 tests/generic/493 |  2 +-
 tests/generic/494 |  2 +-
 tests/generic/554 |  2 +-
 tests/generic/569 |  2 +-
 12 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/common/rc b/common/rc
index 7f693d39..c3f05f76 100644
--- a/common/rc
+++ b/common/rc
@@ -2584,9 +2584,11 @@ _require_odirect()
 	rm -f $testfile 2>&1 > /dev/null
 }
 
+# Format a swapfile and return its size in bytes
 _format_swapfile() {
 	local fname="$1"
 	local sz="$2"
+	local swap_log=""
 
 	rm -f "$fname"
 	touch "$fname"
@@ -2595,8 +2597,10 @@ _format_swapfile() {
 	$CHATTR_PROG +C "$fname" > /dev/null 2>&1
 	_pwrite_byte 0x61 0 "$sz" "$fname" >> $seqres.full
 	# Ignore permission complaints on filesystems that don't support perms
-	$MKSWAP_PROG "$fname" 2>&1 >> $seqres.full | \
-		grep -v "insecure permission"
+	swap_log=$($MKSWAP_PROG "$fname" 2>&1 | grep -v "insecure permission")
+	echo $swap_log >> $seqres.full
+
+	echo $swap_log | grep -oP '\w+(?= bytes)'
 }
 
 _swapon_file() {
@@ -2628,7 +2632,7 @@ _require_scratch_swapfile()
 	_scratch_mount
 
 	# Minimum size for mkswap is 10 pages
-	_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
+	_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10)) > /dev/null
 
 	# ext* has supported all variants of swap files since their
 	# introduction, so swapon should not fail.
diff --git a/tests/btrfs/173 b/tests/btrfs/173
index 1252587c..9f53143e 100755
--- a/tests/btrfs/173
+++ b/tests/btrfs/173
@@ -31,7 +31,7 @@ swapoff "$SCRATCH_MNT/swap" >/dev/null 2>&1
 
 echo "Compressed file"
 rm -f "$SCRATCH_MNT/swap"
-_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
+_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10)) > /dev/null
 $CHATTR_PROG +c "$SCRATCH_MNT/swap" 2>&1 | grep -o "Invalid argument while setting flags"
 
 status=0
diff --git a/tests/btrfs/174 b/tests/btrfs/174
index 8bf856ae..3bb5e7f9 100755
--- a/tests/btrfs/174
+++ b/tests/btrfs/174
@@ -20,7 +20,7 @@ _scratch_mount
 
 $BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/swapvol" >> $seqres.full
 swapfile="$SCRATCH_MNT/swapvol/swap"
-_format_swapfile "$swapfile" $(($(get_page_size) * 10))
+_format_swapfile "$swapfile" $(($(get_page_size) * 10)) > /dev/null
 swapon "$swapfile"
 
 # Turning off nocow doesn't do anything because the file is not empty, not
diff --git a/tests/btrfs/175 b/tests/btrfs/175
index bf0ede25..6f7832a5 100755
--- a/tests/btrfs/175
+++ b/tests/btrfs/175
@@ -18,7 +18,7 @@ _check_minimal_fs_size $((1024 * 1024 * 1024))
 
 cycle_swapfile() {
 	local sz=${1:-$(($(get_page_size) * 10))}
-	_format_swapfile "$SCRATCH_MNT/swap" "$sz"
+	_format_swapfile "$SCRATCH_MNT/swap" "$sz" > /dev/null
 	swapon "$SCRATCH_MNT/swap" 2>&1 | _filter_scratch
 	swapoff "$SCRATCH_MNT/swap" > /dev/null 2>&1
 }
@@ -47,7 +47,7 @@ _scratch_mkfs >> $seqres.full 2>&1
 _scratch_mount
 # Create the swap file, then add the device. That way we know it's all on one
 # device.
-_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
+_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10)) > /dev/null
 scratch_dev2="$(echo "${SCRATCH_DEV_POOL}" | awk '{ print $2 }')"
 $BTRFS_UTIL_PROG device add -f "$scratch_dev2" "$SCRATCH_MNT"
 swapon "$SCRATCH_MNT/swap" 2>&1 | _filter_scratch
diff --git a/tests/btrfs/176 b/tests/btrfs/176
index 41b02eb6..8d624d5a 100755
--- a/tests/btrfs/176
+++ b/tests/btrfs/176
@@ -29,7 +29,7 @@ scratch_dev3="$(echo "${SCRATCH_DEV_POOL}" | awk '{ print $3 }')"
 echo "Remove device"
 _scratch_mkfs >> $seqres.full 2>&1
 _scratch_mount
-_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
+_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10)) > /dev/null
 $BTRFS_UTIL_PROG device add -f "$scratch_dev2" "$SCRATCH_MNT"
 swapon "$SCRATCH_MNT/swap" 2>&1 | _filter_scratch
 # We know the swap file is on device 1 because we added device 2 after it was
diff --git a/tests/btrfs/177 b/tests/btrfs/177
index b2050236..2fd11e89 100755
--- a/tests/btrfs/177
+++ b/tests/btrfs/177
@@ -63,7 +63,7 @@ dd if=/dev/zero of="$SCRATCH_MNT/refill" bs=4096 >> $seqres.full 2>&1
 # of the filesystem was used, so the swap file must be in the new part of the
 # filesystem.
 $BTRFS_UTIL_PROG filesystem resize $((3 * fssize)) "$SCRATCH_MNT" | convert_resize_output
-_format_swapfile "$swapfile" $((32 * 1024 * 1024))
+_format_swapfile "$swapfile" $((32 * 1024 * 1024)) > /dev/null
 swapon "$swapfile"
 
 # Free up the first 1GB of the filesystem.
diff --git a/tests/generic/356 b/tests/generic/356
index fa6c0585..ffc7bed5 100755
--- a/tests/generic/356
+++ b/tests/generic/356
@@ -39,7 +39,7 @@ blocks=160
 blksz=65536
 
 echo "Initialize file"
-_format_swapfile "$testdir/file1" $((blocks * blksz))
+_format_swapfile "$testdir/file1" $((blocks * blksz)) > /dev/null
 swapon $testdir/file1
 
 touch "$testdir/file2"
diff --git a/tests/generic/357 b/tests/generic/357
index dc9a91a4..ce748f85 100755
--- a/tests/generic/357
+++ b/tests/generic/357
@@ -39,7 +39,7 @@ blocks=160
 blksz=65536
 
 echo "Initialize file"
-_format_swapfile "$testdir/file1" $((blocks * blksz))
+_format_swapfile "$testdir/file1" $((blocks * blksz)) > /dev/null
 touch "$testdir/file2"
 $CHATTR_PROG +C "$testdir/file2" >/dev/null 2>&1
 _cp_reflink $testdir/file1 $testdir/file2 2>&1 | _filter_scratch
diff --git a/tests/generic/493 b/tests/generic/493
index a26a908d..c2fd72f6 100755
--- a/tests/generic/493
+++ b/tests/generic/493
@@ -27,7 +27,7 @@ blocks=160
 blksz=65536
 
 echo "Initialize file"
-_format_swapfile "$testdir/file1" $((blocks * blksz))
+_format_swapfile "$testdir/file1" $((blocks * blksz)) > /dev/null
 swapon "$testdir/file1"
 
 touch "$testdir/file2"
diff --git a/tests/generic/494 b/tests/generic/494
index 2e14fab8..b41c938d 100755
--- a/tests/generic/494
+++ b/tests/generic/494
@@ -26,7 +26,7 @@ blocks=160
 blksz=65536
 
 echo "Initialize file"
-_format_swapfile "$testdir/file1" $((blocks * blksz))
+_format_swapfile "$testdir/file1" $((blocks * blksz)) > /dev/null
 swapon "$testdir/file1"
 
 echo "Try to truncate"
diff --git a/tests/generic/554 b/tests/generic/554
index c1984285..b9efee0d 100755
--- a/tests/generic/554
+++ b/tests/generic/554
@@ -30,7 +30,7 @@ _scratch_mount
 $XFS_IO_PROG -f -c "pwrite -S 0x61 0 128k" $SCRATCH_MNT/file >> $seqres.full 2>&1
 
 echo swap files return ETXTBUSY
-_format_swapfile $SCRATCH_MNT/swapfile 16m
+_format_swapfile $SCRATCH_MNT/swapfile 16m > /dev/null
 _swapon_file $SCRATCH_MNT/swapfile
 
 $XFS_IO_PROG -f -c "copy_range -l 32k $SCRATCH_MNT/file" $SCRATCH_MNT/swapfile
diff --git a/tests/generic/569 b/tests/generic/569
index 1dc54da8..c5dcfefe 100755
--- a/tests/generic/569
+++ b/tests/generic/569
@@ -31,7 +31,7 @@ _scratch_mount >> $seqres.full 2>&1
 
 testfile=$SCRATCH_MNT/$seq.swap
 
-_format_swapfile $testfile 20m
+_format_swapfile $testfile 20m > /dev/null
 
 # Can you modify the swapfile via previously open file descriptors?
 for verb in 1 2 3 4; do
-- 
2.31.1

