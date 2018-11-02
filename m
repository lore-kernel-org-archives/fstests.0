Received: from mail-it1-f195.google.com ([209.85.166.195]:37622 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbeKCGi7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 3 Nov 2018 02:38:59 -0400
Received: by mail-it1-f195.google.com with SMTP id e74-v6so5076067ita.2
        for <fstests@vger.kernel.org>; Fri, 02 Nov 2018 14:30:12 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
Subject: [PATCH 2/7] generic/{472,496}: fix swap file creation on Btrfs
Date: Fri,  2 Nov 2018 14:29:37 -0700
Message-Id: <6da5f398715af4f7478554920470a85e8a186b50.1541193856.git.osandov@fb.com>
In-Reply-To: <cover.1541193856.git.osandov@fb.com>
References: <cover.1541193856.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: kernel-team@fb.com, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Omar Sandoval <osandov@fb.com>

The swap file must be set nocow before it is written to, otherwise it is
ignored and Btrfs refuses to activate it as swap.

Fixes: 25ce9740065e ("generic: test swapfile creation, activation, and deactivation")
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 tests/generic/472 | 14 ++++++--------
 tests/generic/496 |  6 +++---
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/tests/generic/472 b/tests/generic/472
index 04ed3e73..aba4a007 100755
--- a/tests/generic/472
+++ b/tests/generic/472
@@ -42,13 +42,15 @@ _scratch_mount >>$seqres.full 2>&1
 
 swapfile=$SCRATCH_MNT/swap
 len=$((2 * 1048576))
-page_size=$(get_page_size)
 
 swapfile_cycle() {
 	local swapfile="$1"
+	local len="$2"
 
+	touch $swapfile
 	# Swap files must be nocow on Btrfs.
 	$CHATTR_PROG +C $swapfile >> $seqres.full 2>&1
+	_pwrite_byte 0x58 0 $len $swapfile >> $seqres.full
 	"$here/src/mkswap" $swapfile >> $seqres.full
 	"$here/src/swapon" $swapfile 2>&1 | _filter_scratch
 	swapoff $swapfile 2>> $seqres.full
@@ -57,20 +59,16 @@ swapfile_cycle() {
 
 # Create a regular swap file
 echo "regular swap" | tee -a $seqres.full
-_pwrite_byte 0x58 0 $len $swapfile >> $seqres.full
-swapfile_cycle $swapfile
+swapfile_cycle $swapfile $len
 
 # Create a swap file with a little too much junk on the end
 echo "too long swap" | tee -a $seqres.full
-_pwrite_byte 0x58 0 $((len + 3)) $swapfile >> $seqres.full
-swapfile_cycle $swapfile
+swapfile_cycle $swapfile $((len + 3))
 
 # Create a ridiculously small swap file.  Each swap file must have at least
 # two pages after the header page.
 echo "tiny swap" | tee -a $seqres.full
-tiny_len=$((page_size * 3))
-_pwrite_byte 0x58 0 $tiny_len $swapfile >> $seqres.full
-swapfile_cycle $swapfile
+swapfile_cycle $swapfile $(($(get_page_size) * 3))
 
 status=0
 exit
diff --git a/tests/generic/496 b/tests/generic/496
index 968b8012..3083eef0 100755
--- a/tests/generic/496
+++ b/tests/generic/496
@@ -49,8 +49,6 @@ page_size=$(get_page_size)
 swapfile_cycle() {
 	local swapfile="$1"
 
-	# Swap files must be nocow on Btrfs.
-	$CHATTR_PROG +C $swapfile >> $seqres.full 2>&1
 	"$here/src/mkswap" $swapfile >> $seqres.full
 	"$here/src/swapon" $swapfile 2>&1 | _filter_scratch
 	swapoff $swapfile 2>> $seqres.full
@@ -59,8 +57,10 @@ swapfile_cycle() {
 
 # Create a fallocated swap file
 echo "fallocate swap" | tee -a $seqres.full
-$XFS_IO_PROG -f -c "falloc 0 $len" $swapfile >> $seqres.full
+touch $swapfile
+# Swap files must be nocow on Btrfs.
 $CHATTR_PROG +C $swapfile >> $seqres.full 2>&1
+$XFS_IO_PROG -f -c "falloc 0 $len" $swapfile >> $seqres.full
 "$here/src/mkswap" $swapfile
 "$here/src/swapon" $swapfile >> $seqres.full 2>&1 || \
 	_notrun "fallocated swap not supported here"
-- 
2.19.1
