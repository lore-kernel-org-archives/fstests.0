Return-Path: <SRS0=++Hp=ZV=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A7DC432C0
	for <linux-fstests@archiver.kernel.org>; Fri, 29 Nov 2019 07:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3593E2086A
	for <linux-fstests@archiver.kernel.org>; Fri, 29 Nov 2019 07:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfK2H1v (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 29 Nov 2019 02:27:51 -0500
Received: from snd00002.auone-net.jp ([111.86.247.2]:65062 "EHLO
        dmta0005-f.auone-net.jp" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726215AbfK2H1v (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 29 Nov 2019 02:27:51 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Nov 2019 02:27:51 EST
Received: from ppp.dion.ne.jp by dmta0003.auone-net.jp with ESMTP
          id <20191129072108857.YEGH.25002.ppp.dion.ne.jp@dmta0003.auone-net.jp>
          for <fstests@vger.kernel.org>; Fri, 29 Nov 2019 16:21:08 +0900
Date:   Fri, 29 Nov 2019 16:21:08 +0900
From:   Kusanagi Kouichi <slash@ac.auone-net.jp>
To:     fstests@vger.kernel.org
Subject: [PATCH] common/filter: Don't use strtonum
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Message-Id: <20191129072108857.YEGH.25002.ppp.dion.ne.jp@dmta0003.auone-net.jp>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

It's a gawk extension and not needed. Make tests pass with non-gawk.

Signed-off-by: Kusanagi Kouichi <slash@ac.auone-net.jp>
---
 common/filter | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

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
-- 
2.24.0

