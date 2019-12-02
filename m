Return-Path: <SRS0=WWQL=ZY=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A16C432C0
	for <linux-fstests@archiver.kernel.org>; Mon,  2 Dec 2019 09:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233FA20705
	for <linux-fstests@archiver.kernel.org>; Mon,  2 Dec 2019 09:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfLBJnD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 2 Dec 2019 04:43:03 -0500
Received: from snd00012.auone-net.jp ([111.86.247.12]:58307 "EHLO
        dmta0004.auone-net.jp" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726251AbfLBJnD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 2 Dec 2019 04:43:03 -0500
Received: from ppp.dion.ne.jp by dmta0004.auone-net.jp with ESMTP
          id <20191202094302206.XGZM.12759.ppp.dion.ne.jp@dmta0004.auone-net.jp>
          for <fstests@vger.kernel.org>; Mon, 2 Dec 2019 18:43:02 +0900
Date:   Mon, 2 Dec 2019 18:43:01 +0900
From:   Kusanagi Kouichi <slash@ac.auone-net.jp>
To:     fstests@vger.kernel.org
Subject: [PATCH] common/filter: Don't use strtonum
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Message-Id: <20191202094302206.XGZM.12759.ppp.dion.ne.jp@dmta0004.auone-net.jp>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

It's a gawk extension and not needed. Make tests pass with non-gawk.

Signed-off-by: Kusanagi Kouichi <slash@ac.auone-net.jp>
---
 common/filter     | 23 +++++++++++++----------
 tests/generic/386 |  2 +-
 tests/xfs/009     | 10 +++++-----
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/common/filter b/common/filter
index 2477f386..e02cc0b9 100644
--- a/common/filter
+++ b/common/filter
@@ -241,9 +241,9 @@ _filter_xfs_io_units_modified()
 		/wrote/ {
 			split($2, bytes, "/")
 
-			bytes_written = strtonum(bytes[1])
+			bytes_written = bytes[1]
 
-			offset = strtonum($NF)
+			offset = $NF
 
 			unit_start = offset / unit_size
 			unit_start = int(unit_start)
@@ -487,14 +487,17 @@ _filter_busy_mount()
 _filter_od()
 {
 	BLOCK_SIZE=$(_get_block_size $SCRATCH_MNT)
-	$AWK_PROG -v block_size=$BLOCK_SIZE '
-		/^[0-9]+/ {
-			offset = strtonum("0"$1);
-			$1 = sprintf("%o", offset / block_size);
-			print $0;
-		}
-		/\*/
-	'
+	while read line
+	do
+		if test "$line" = '*'
+		then
+			printf '*\n'
+			continue
+		fi
+
+		offset="${line%% *}"
+		printf '%o%s\n' $((offset / BLOCK_SIZE)) "${line#$offset}"
+	done
 }
 
 # Remove quotes from failed mknod calls. Starting with Coreutils v8.25,
diff --git a/tests/generic/386 b/tests/generic/386
index 462c5869..ba6e654e 100755
--- a/tests/generic/386
+++ b/tests/generic/386
@@ -75,7 +75,7 @@ _filter_quota_rpt() {
 	# This function parses the human-readable values produced
 	# by xfs_quota output
 	function byte_size(value,  result) {
-		result = strtonum(value);
+		result = value;
 		unit = value;
 		gsub("[0-9][0-9]*", "", unit);
 		shift = index("KMGTPE", unit);
diff --git a/tests/xfs/009 b/tests/xfs/009
index 6a31514c..956c4772 100755
--- a/tests/xfs/009
+++ b/tests/xfs/009
@@ -66,12 +66,12 @@ _block_filter()
 
 	/CMD/ {
 		split($3, off, "=")
-		offset = strtonum(off[2])
+		offset = off[2]
 		if (offset != -1)
 			offset = offset / bsize
 
 		split($4, len, "=")
-		nr_blocks = strtonum(len[2])
+		nr_blocks = len[2]
 		if (nr_blocks != -1)
 			nr_blocks = nr_blocks / bsize
 
@@ -82,13 +82,13 @@ _block_filter()
 
 	/MAP/ {
 		split($2, off, "=")
-		offset = strtonum(off[2])
+		offset = off[2]
 		if (offset != -1)
 			offset = offset / bsize
 
 		split($3, len, "=")
 
-		nr_blocks = strtonum(len[2])
+		nr_blocks = len[2]
 
 		if (nr_blocks != -1)
 			nr_blocks = nr_blocks / bsize
@@ -100,7 +100,7 @@ _block_filter()
 
 	/TRUNCATE/ {
 		split($2, off, "=")
-		offset = strtonum(off[2]) / bsize
+		offset = off[2] / bsize
 
 		printf("    %s off=%s\n", $1, offset)
 
-- 
2.24.0

