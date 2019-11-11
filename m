Return-Path: <SRS0=0kg8=ZD=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF50C43331
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Nov 2019 14:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBDD222C2
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Nov 2019 14:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfKKOuG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:50:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:52856 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726979AbfKKOuF (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 11 Nov 2019 09:50:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 11B86B034;
        Mon, 11 Nov 2019 14:50:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 587111E4AD8; Mon, 11 Nov 2019 15:49:58 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <fstests@vger.kernel.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eryu Guan <guaneryu@gmail.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 3/3] generic/050: Consistently remove traling dot from umount output
Date:   Mon, 11 Nov 2019 15:49:53 +0100
Message-Id: <20191111144953.23871-4-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191111144953.23871-1-jack@suse.cz>
References: <20191111144953.23871-1-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

We did not consistently remove trailing dot from umount output which can
presumably lead to false failures with particular versions of
util-linux. Make sure all umount output is properly filtered.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/generic/050              | 4 ++--
 tests/generic/050.out.xfsquota | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/generic/050 b/tests/generic/050
index 1c275d8b0601..cf2b93814267 100755
--- a/tests/generic/050
+++ b/tests/generic/050
@@ -67,7 +67,7 @@ touch $SCRATCH_MNT/foo 2>&1 | _filter_scratch
 #	http://oss.sgi.com/bugzilla/show_bug.cgi?id=807
 #
 echo "unmounting read-only filesystem"
-_scratch_unmount 2>&1 | _filter_scratch
+_scratch_unmount 2>&1 | _filter_scratch | _filter_ending_dot
 
 echo "setting device read-write"
 blockdev --setrw $SCRATCH_DEV
@@ -105,7 +105,7 @@ _scratch_unmount 2>&1 | _filter_scratch | _filter_ending_dot
 echo "mounting filesystem with -o norecovery on a read-only device:"
 _try_scratch_mount -o norecovery 2>&1 | _filter_ro_mount
 echo "unmounting read-only filesystem"
-_scratch_unmount 2>&1 | _filter_scratch
+_scratch_unmount 2>&1 | _filter_scratch | _filter_ending_dot
 
 echo "setting device read-write"
 blockdev --setrw $SCRATCH_DEV
diff --git a/tests/generic/050.out.xfsquota b/tests/generic/050.out.xfsquota
index 49b46241b39f..f204bd2fbe70 100644
--- a/tests/generic/050.out.xfsquota
+++ b/tests/generic/050.out.xfsquota
@@ -4,7 +4,7 @@ mounting read-only block device:
 mount: /mnt-scratch: permission denied
 touching file on read-only filesystem (should fail)
 unmounting read-only filesystem
-umount: SCRATCH_DEV: not mounted.
+umount: SCRATCH_DEV: not mounted
 setting device read-write
 mounting read-write block device:
 touch files
@@ -19,7 +19,7 @@ umount: SCRATCH_DEV: not mounted
 mounting filesystem with -o norecovery on a read-only device:
 mount: /mnt-scratch: permission denied
 unmounting read-only filesystem
-umount: SCRATCH_DEV: not mounted.
+umount: SCRATCH_DEV: not mounted
 setting device read-write
 mounting filesystem that needs recovery with -o ro:
 *** done
-- 
2.16.4

