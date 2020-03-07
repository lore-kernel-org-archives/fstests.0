Return-Path: <SRS0=YIgP=4Y=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92328C10F00
	for <linux-fstests@archiver.kernel.org>; Sat,  7 Mar 2020 10:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C452073C
	for <linux-fstests@archiver.kernel.org>; Sat,  7 Mar 2020 10:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgCGKzb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 7 Mar 2020 05:55:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:43850 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbgCGKzb (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 7 Mar 2020 05:55:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3E106AE62;
        Sat,  7 Mar 2020 10:55:29 +0000 (UTC)
From:   Anthony Iliopoulos <ailiopoulos@suse.com>
To:     fstests@vger.kernel.org
Cc:     zlang@redhat.com
Subject: [PATCH v2] xfs/513: fix allocsize on archs with pagesize larger than blocksize
Date:   Sat,  7 Mar 2020 11:54:57 +0100
Message-Id: <20200307105457.24688-1-ailiopoulos@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The minimum accepted allocsize mount option value is page size, which
causes the particular test to fail in architectures where page size >
block size. Fix it by basing the value on the platform page size rather
than the block size as obtained from mkfs. In addition add a filter so
that different values can be used without breaking the golden output.

Signed-off-by: Anthony Iliopoulos <ailiopoulos@suse.com>
---

Changes from v1 -> v2:

- renamed filter_pagesz to filter_xfs_opt
- renamed PAGE_SIZE to PAGESIZE

 tests/xfs/513     | 14 ++++++++++----
 tests/xfs/513.out |  2 +-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/tests/xfs/513 b/tests/xfs/513
index 70bc2f1c..094d0c6c 100755
--- a/tests/xfs/513
+++ b/tests/xfs/513
@@ -68,6 +68,11 @@ filter_loop()
 	    -e "s,\B$LOOP_SPARE_DEV,LOOP_SPARE_DEV,g"
 }
 
+filter_xfs_opt()
+{
+	sed -e "s,allocsize=$pagesz,allocsize=PAGESIZE,g"
+}
+
 # avoid the effection from MKFS_OPTIONS
 MKFS_OPTIONS=""
 do_mkfs()
@@ -165,7 +170,7 @@ do_test()
 	# Print each argument, include nil ones
 	echo -n "TEST:" | tee -a $seqres.full
 	for i in "$@";do
-		echo -n " \"$i\"" | filter_loop | tee -a $seqres.full
+		echo -n " \"$i\"" | filter_loop | filter_xfs_opt | tee -a $seqres.full
 	done
 	echo | tee -a $seqres.full
 
@@ -180,11 +185,12 @@ echo "** start xfs mount testing ..."
 # Test allocsize=size
 # Valid values for this option are page size (typically 4KiB) through to 1GiB
 do_mkfs
-if [ $dbsize -ge 1024 ];then
-	blsize="$((dbsize / 1024))k"
+pagesz=$(get_page_size)
+if [ $pagesz -ge 1024 ];then
+	pagesz="$((pagesz / 1024))k"
 fi
 do_test "" pass "allocsize" "false"
-do_test "-o allocsize=$blsize" pass "allocsize=$blsize" "true"
+do_test "-o allocsize=$pagesz" pass "allocsize=$pagesz" "true"
 do_test "-o allocsize=1048576k" pass "allocsize=1048576k" "true"
 do_test "-o allocsize=$((dbsize / 2))" fail
 do_test "-o allocsize=2g" fail
diff --git a/tests/xfs/513.out b/tests/xfs/513.out
index 9be18dd8..6681a7e8 100644
--- a/tests/xfs/513.out
+++ b/tests/xfs/513.out
@@ -5,7 +5,7 @@ QA output created by 513
 ** start xfs mount testing ...
 FORMAT: 
 TEST: "" "pass" "allocsize" "false"
-TEST: "-o allocsize=4k" "pass" "allocsize=4k" "true"
+TEST: "-o allocsize=PAGESIZE" "pass" "allocsize=PAGESIZE" "true"
 TEST: "-o allocsize=1048576k" "pass" "allocsize=1048576k" "true"
 TEST: "-o allocsize=2048" "fail"
 TEST: "-o allocsize=2g" "fail"
-- 
2.16.4

