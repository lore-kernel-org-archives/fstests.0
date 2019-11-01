Return-Path: <SRS0=OCqJ=YZ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D171ECA9ED1
	for <linux-fstests@archiver.kernel.org>; Fri,  1 Nov 2019 11:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9AA621897
	for <linux-fstests@archiver.kernel.org>; Fri,  1 Nov 2019 11:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfKALAz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 1 Nov 2019 07:00:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:57682 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726711AbfKALAz (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 1 Nov 2019 07:00:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 82014B31A
        for <fstests@vger.kernel.org>; Fri,  1 Nov 2019 11:00:53 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 412BE1E47DD; Fri,  1 Nov 2019 12:00:53 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     fstests@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] generic/382: Make test independent of fs allocation
Date:   Fri,  1 Nov 2019 12:00:45 +0100
Message-Id: <20191101110046.24994-2-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191101110046.24994-1-jack@suse.cz>
References: <20191101110046.24994-1-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Test generic/382 depends on filesystem allocating exactly 30M of blocks
when writing 30M file. This is not true for some filesystems - e.g. for
ext2 due to indirect blocks - while leads to false positive failures.
In this case, the test is not actually interested in comparing exact
usage, rather in verifying the ability to write 30M worth of data. So
instead of comparing 'xfs_quota report' output, just depend on detecting
error when writing files.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/generic/382     |  9 ++-------
 tests/generic/382.out | 12 ------------
 2 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/tests/generic/382 b/tests/generic/382
index 50816f69a915..5ae229052bdc 100755
--- a/tests/generic/382
+++ b/tests/generic/382
@@ -67,21 +67,16 @@ do_test()
 	$XFS_QUOTA_PROG -x -c "report $type -N -bi" $SCRATCH_MNT | grep -v ^root | _filter_spaces
 
 	## blocks default quota test ##
-	_user_do "$XFS_IO_PROG -f -c \"pwrite 0 30M\" -c \"fsync\" $SCRATCH_MNT/data" | _filter_xfs_io
-	echo "$qname blocks quota after write 30M data"
-	$XFS_QUOTA_PROG -x -c "report $type -N -b" $SCRATCH_MNT | grep -v ^root | _filter_spaces
+	_user_do "$XFS_IO_PROG -f -c \"pwrite 0 30M\" -c \"fsync\" $SCRATCH_MNT/data" 2>&1 | _filter_xfs_io
 
 	rm -f ${SCRATCH_MNT}/* >/dev/null 2>&1
 
 	## inode default quota test ##
 	for ((i=0; i<30; i++));do
-		_user_do "echo -n > ${SCRATCH_MNT}/file${i}"
+		_user_do "echo -n > ${SCRATCH_MNT}/file${i}" 2>&1
 	done
 	sync
 
-	echo "$qname inode quota after creating 30 inodes"
-	$XFS_QUOTA_PROG -x -c "report $type -N -i" $SCRATCH_MNT | grep -v ^root | _filter_spaces
-
 	rm -f ${SCRATCH_MNT}/* >/dev/null 2>&1
 }
 
diff --git a/tests/generic/382.out b/tests/generic/382.out
index ad32ccd334bd..a538ca67368c 100644
--- a/tests/generic/382.out
+++ b/tests/generic/382.out
@@ -5,21 +5,9 @@ fsgqa 0 40960 40960 00 [--------] 0 40 40 00 [--------]
 
 wrote 31457280/31457280 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-user blocks quota after write 30M data
-fsgqa 30720 40960 40960 00 [--------]
-
-user inode quota after creating 30 inodes
-fsgqa 30 40 40 00 [--------]
-
 === group quota test ===
 group blocks and inode limit
 fsgqa 0 40960 40960 00 [--------] 0 40 40 00 [--------]
 
 wrote 31457280/31457280 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-group blocks quota after write 30M data
-fsgqa 30720 40960 40960 00 [--------]
-
-group inode quota after creating 30 inodes
-fsgqa 30 40 40 00 [--------]
-
-- 
2.16.4

