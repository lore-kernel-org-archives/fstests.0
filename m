Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67505C43460
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Apr 2021 20:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44B5B61153
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Apr 2021 20:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbhDZUvB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 26 Apr 2021 16:51:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:59684 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234161AbhDZUvA (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 26 Apr 2021 16:51:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 188D6ABC2
        for <fstests@vger.kernel.org>; Mon, 26 Apr 2021 20:50:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DA82F1F2B59; Mon, 26 Apr 2021 22:50:16 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     fstests@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 2/2] Don't run tests that require block devices for virtual filesystems
Date:   Mon, 26 Apr 2021 22:50:12 +0200
Message-Id: <20210426205012.13241-3-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210426205012.13241-1-jack@suse.cz>
References: <20210426205012.13241-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Some tests require block device based filesystems (e.g. because they
setup dm device in a particular way). These tests then fail for tmpfs in
unusual ways (usually trying to call mkfs.tmpfs). Annotate these tests
as requiring block device based filesystem so that we gracefully exit
with _notrun. Also there's no point in simulating successful _mkfs_dev
for such filesystems since the test is unlikely to test anything
sensible. So delete that workaround from _mkfs_dev.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 common/rc         | 28 +++++++++++++---------------
 tests/generic/081 |  2 +-
 tests/generic/347 |  2 +-
 tests/generic/459 |  2 +-
 tests/generic/470 |  2 +-
 tests/generic/500 |  2 +-
 tests/generic/563 |  2 +-
 tests/generic/620 |  2 +-
 8 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/common/rc b/common/rc
index 2dd1b8ad9e35..aa51ccea0be2 100644
--- a/common/rc
+++ b/common/rc
@@ -677,21 +677,6 @@ _mkfs_dev()
 {
     local tmp=`mktemp -u`
     case $FSTYP in
-    nfs*)
-	# do nothing for nfs
-	;;
-    9p)
-	# do nothing for 9p
-	;;
-    virtiofs)
-	# do nothing for virtiofs
-	;;
-    overlay)
-	# do nothing for overlay
-	;;
-    pvfs2)
-	# do nothing for pvfs2
-	;;
     udf)
         $MKFS_UDF_PROG $MKFS_OPTIONS $* 2>$tmp.mkfserr 1>$tmp.mkfsstd
 	;;
@@ -1469,6 +1454,19 @@ _supported_fs()
 	then
 	    return
 	fi
+	if [ "$f" = "blkdev" ]
+	then
+	    case $FSTYP in
+	    nfs*)
+	    9p)
+	    virtiofs)
+	    overlay)
+	    pvfs2)
+	    tmpfs)
+		break
+		;;
+	    esac
+	fi
     done
 
     _notrun "not suitable for this filesystem type: $FSTYP"
diff --git a/tests/generic/081 b/tests/generic/081
index 5dff079852d3..3800a8cf9ef3 100755
--- a/tests/generic/081
+++ b/tests/generic/081
@@ -49,7 +49,7 @@ _cleanup()
 . ./common/filter
 
 # real QA test starts here
-_supported_fs generic
+_supported_fs blkdev
 _require_test
 _require_scratch_nocheck
 _require_dm_target snapshot
diff --git a/tests/generic/347 b/tests/generic/347
index cbc5150a3e54..693f2f8d5ec3 100755
--- a/tests/generic/347
+++ b/tests/generic/347
@@ -56,7 +56,7 @@ _workout()
 . ./common/rc
 . ./common/dmthin
 
-_supported_fs generic
+_supported_fs blkdev
 _require_scratch_nocheck
 _require_dm_target thin-pool
 
diff --git a/tests/generic/459 b/tests/generic/459
index a0b1507c28e4..6b37a4f2f056 100755
--- a/tests/generic/459
+++ b/tests/generic/459
@@ -43,7 +43,7 @@ _cleanup()
 
 # This tests for filesystem lockup not consistency, so don't check for fs
 # consistency after test
-_supported_fs generic
+_supported_fs blkdev
 _require_scratch_nocheck
 _require_dm_target thin-pool
 _require_dm_target snapshot
diff --git a/tests/generic/470 b/tests/generic/470
index d925affe60cf..36d047edf1c0 100755
--- a/tests/generic/470
+++ b/tests/generic/470
@@ -34,7 +34,7 @@ _cleanup()
 rm -f $seqres.full
 
 # real QA test starts here
-_supported_fs generic
+_supported_fs blkdev
 _require_scratch_nocheck
 _require_log_writes_dax_mountopt "dax"
 _require_dm_target thin-pool
diff --git a/tests/generic/500 b/tests/generic/500
index 085ddbf3d906..11599e786c41 100755
--- a/tests/generic/500
+++ b/tests/generic/500
@@ -44,7 +44,7 @@ _cleanup()
 rm -f $seqres.full
 
 # real QA test starts here
-_supported_fs generic
+_supported_fs blkdev
 _require_scratch_nocheck
 _require_dm_target thin-pool
 
diff --git a/tests/generic/563 b/tests/generic/563
index fe7394c0910c..c0cf9e9e7c97 100755
--- a/tests/generic/563
+++ b/tests/generic/563
@@ -41,7 +41,7 @@ rm -f $seqres.full
 # real QA test starts here
 
 # Modify as appropriate.
-_supported_fs generic
+_supported_fs blkdev
 _require_scratch_nocheck
 _require_cgroup2 io
 _require_loop
diff --git a/tests/generic/620 b/tests/generic/620
index 605594419d6c..6c80849f6457 100755
--- a/tests/generic/620
+++ b/tests/generic/620
@@ -40,7 +40,7 @@ _cleanup()
 rm -f $seqres.full
 
 # Modify as appropriate.
-_supported_fs generic
+_supported_fs blkdev
 _require_scratch_size_nocheck $((4 * 1024 * 1024)) #kB
 _require_scratch_16T_support
 _require_dmhugedisk
-- 
2.26.2

