Received: from mx1.redhat.com ([209.132.183.28]:49520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751755AbdFPTks (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 16 Jun 2017 15:40:48 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CD76F8A003
        for <fstests@vger.kernel.org>; Fri, 16 Jun 2017 19:40:47 +0000 (UTC)
Received: from tleilax.poochiereds.net (ovpn-120-225.rdu2.redhat.com [10.10.120.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98FC718ABE
        for <fstests@vger.kernel.org>; Fri, 16 Jun 2017 19:40:47 +0000 (UTC)
From: Jeff Layton <jlayton@redhat.com>
Subject: [xfstests PATCH v5 2/5] ext3: allow it to put journal on a separate device when doing scratch_mkfs
Date: Fri, 16 Jun 2017 15:40:43 -0400
Message-Id: <20170616194046.15923-3-jlayton@redhat.com>
In-Reply-To: <20170616194046.15923-1-jlayton@redhat.com>
References: <20170616194046.15923-1-jlayton@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 common/rc | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 57001b47a8b7..43e160e91360 100644
--- a/common/rc
+++ b/common/rc
@@ -840,7 +840,16 @@ _scratch_mkfs()
 		mkfs_cmd="$MKFS_BTRFS_PROG"
 		mkfs_filter="cat"
 		;;
-	ext2|ext3)
+	ext3)
+		mkfs_cmd="$MKFS_PROG -t $FSTYP -- -F"
+		mkfs_filter="grep -v -e ^Warning: -e \"^mke2fs \""
+
+		# put journal on separate device?
+		[ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ] && \
+		$mkfs_cmd -O journal_dev $MKFS_OPTIONS $SCRATCH_LOGDEV && \
+		mkfs_cmd="$mkfs_cmd -J device=$SCRATCH_LOGDEV"
+		;;
+	ext2)
 		mkfs_cmd="$MKFS_PROG -t $FSTYP -- -F"
 		mkfs_filter="grep -v -e ^Warning: -e \"^mke2fs \""
 		;;
-- 
2.13.0

