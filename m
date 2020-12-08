Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37949C4361B
	for <linux-fstests@archiver.kernel.org>; Tue,  8 Dec 2020 10:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F344222ADF
	for <linux-fstests@archiver.kernel.org>; Tue,  8 Dec 2020 10:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbgLHKnk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 8 Dec 2020 05:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbgLHKnk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 8 Dec 2020 05:43:40 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45966C061749
        for <fstests@vger.kernel.org>; Tue,  8 Dec 2020 02:42:54 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id y10so5317704plr.10
        for <fstests@vger.kernel.org>; Tue, 08 Dec 2020 02:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=xQKkLM83zbG1sXM1Wp+/iyauEyG+NpWxZ8lND5RI3+o=;
        b=m0YlUtpRQQVE6KYeR4Eoprb+jKRouoO1AJ/Rxunt9jgVhAPIZlPmM6ZbZeXPyW7zk5
         LTdpU4uAECdFtrRZlEtdbIAwOlgHLRmqJqoxYKkrTTKG9U9OAo2WIz2xL5QX575m0xJY
         VvajqLhfVtLWtUjGR/wG7OHB6MTNFTu66P/maptem/YfjObY5PXz+NdDURnx9Zo2HRns
         2QE8BYvlfBh8JNxVEjoTZWrDoXoQ6b3x3pY1t3ZSXKdodl6nOGfdgu8LGUB+wtgzOGbO
         z3jZXUBXejl6i8bzv4NSv/2R5WwEQyAtqTiAjme+q5Xb7TZmC3naX55qcz+XBZu9v3zJ
         vtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=xQKkLM83zbG1sXM1Wp+/iyauEyG+NpWxZ8lND5RI3+o=;
        b=K+8hhqWy06KTzmH2Tmeejq9lyEFLjQDU9PKfI0p4XFGs/1NLBnBQ1OCgDXxLnCsCxF
         urij36pn+G4CihNbQJlqGbaXhKirqsVc75oeIsW0L4iX09ezrOBPLaCeCQqIZ79AMXVT
         6Yc04ucuWgKKen0EeOf8YoQv0zI4wm8mS5GyaGRFHoafKlkdnh4DreOUzE5G5LTTi+O4
         zBW+ognZHPzXYP6c5w0HOdhmTBuK/tTf20RWaDWF1C05xLp+My4hlGsEJjDMn/ePgmfZ
         ySiO6BgNMc5iLsXvHzGB6OuY0d9DO7eLIRdfBbPvnn36Ly6qYNsU+YqlsCR8Ii+jpB9P
         zfPQ==
X-Gm-Message-State: AOAM5319FsUDmCT6HykOkEFbfE0DgN5LZkOors4wpO1RiKDBvrLxi221
        b6N0AG1HkvagJvLhenPO7pGR6MD0dHo=
X-Google-Smtp-Source: ABdhPJydahbHgjZmc4lrDMq/e3DfbCi3mGaYcv0jyZL2mNoIenfaKl34pz5ZofowsHdBGf+rD5FyBw==
X-Received: by 2002:a17:902:d20d:b029:da:632a:d2bc with SMTP id t13-20020a170902d20db02900da632ad2bcmr20747051ply.43.1607424173273;
        Tue, 08 Dec 2020 02:42:53 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id o62sm2899222pjo.17.2020.12.08.02.42.52
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 02:42:52 -0800 (PST)
Date:   Tue, 8 Dec 2020 18:42:45 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] common/filter: add _filter_stat
Message-ID: <20201208104245.2dtfn6xz7qr6uga3@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

New stat(2) starts to use statx(7) call. Then if file does not
exist, it breaks golden output like this:

-stat: cannot stat 'SCRATCH_MNT/xxx': No such file or directory
+stat: cannot statx 'SCRATCH_MNT/xxx': No such file or directory

Add this filter to fix it, and add this filter to testcases that
need it.

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
 common/filter     | 6 ++++++
 tests/generic/397 | 6 +++---
 tests/generic/435 | 2 +-
 tests/generic/440 | 2 +-
 tests/xfs/348     | 2 +-
 5 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/common/filter b/common/filter
index a8b3882f..6fbf70c2 100644
--- a/common/filter
+++ b/common/filter
@@ -510,6 +510,12 @@ _filter_mv()
 	sed -e "s/^renamed //"
 }
 
+# New stat(2) uses statx(7)
+_filter_stat()
+{
+	sed -e "s/cannot statx/cannot stat/"
+}
+
 _filter_lostfound()
 {
 	sed -e '/^lost+found$/d'
diff --git a/tests/generic/397 b/tests/generic/397
index 97111555..bb4de31c 100755
--- a/tests/generic/397
+++ b/tests/generic/397
@@ -83,8 +83,8 @@ _unlink_session_encryption_key $keydesc
 _scratch_cycle_mount
 
 # Check that unencrypted names aren't there
-stat $SCRATCH_MNT/edir/empty |& _filter_scratch
-stat $SCRATCH_MNT/edir/symlink |& _filter_scratch
+stat $SCRATCH_MNT/edir/empty |& _filter_stat |& _filter_scratch
+stat $SCRATCH_MNT/edir/symlink |& _filter_stat |& _filter_scratch
 
 # Check that the correct numbers of files and subdirectories are there
 ls $SCRATCH_MNT/edir | wc -l
@@ -106,7 +106,7 @@ ln -s foo $SCRATCH_MNT/edir/0123456789abcdef |& _filter_scratch
 
 # Delete the encrypted directory (should succeed)
 rm -r $SCRATCH_MNT/edir
-stat $SCRATCH_MNT/edir |& _filter_scratch
+stat $SCRATCH_MNT/edir |& _filter_stat |& _filter_scratch
 
 # success, all done
 status=0
diff --git a/tests/generic/435 b/tests/generic/435
index 9f54c6c4..71c5a3f0 100755
--- a/tests/generic/435
+++ b/tests/generic/435
@@ -73,7 +73,7 @@ _scratch_cycle_mount
 # and ext4 reported a "Structure needs cleaning" error when removing files.
 find $SCRATCH_MNT/edir/ -type f | xargs stat -c %i | sort | uniq | wc -l
 rm -rf $SCRATCH_MNT/edir |& head -n 10
-stat $SCRATCH_MNT/edir |& _filter_scratch
+stat $SCRATCH_MNT/edir |& _filter_stat |& _filter_scratch
 
 # success, all done
 status=0
diff --git a/tests/generic/440 b/tests/generic/440
index d775f1e0..8a81d60a 100755
--- a/tests/generic/440
+++ b/tests/generic/440
@@ -87,7 +87,7 @@ _scratch_cycle_mount
 cat $SCRATCH_MNT/edir2/link
 exec 3< $SCRATCH_MNT/edir2/link # pin inode with cached key in memory
 _unlink_session_encryption_key $keydesc
-stat $SCRATCH_MNT/edir/file |& _filter_scratch
+stat $SCRATCH_MNT/edir/file |& _filter_stat |& _filter_scratch
 cat "$(find $SCRATCH_MNT/edir/ -type f)"
 exec 3>&-
 
diff --git a/tests/xfs/348 b/tests/xfs/348
index 194d9f99..208382fb 100755
--- a/tests/xfs/348
+++ b/tests/xfs/348
@@ -112,7 +112,7 @@ for dt in $dtypes; do
 		rm -f $tmp.stat.err
 		ftype=$(stat --printf=%F $testdir/$file 2>$tmp.stat.err)
 		if [ -s $tmp.stat.err ]; then
-			cat $tmp.stat.err
+			cat $tmp.stat.err | _filter_stat
 		else
 			echo "stat: '$testdir/$file' is a $ftype"
 			# Verify that readlink of a file posing as a symlink
-- 
2.20.1

