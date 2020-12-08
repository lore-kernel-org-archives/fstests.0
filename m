Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEF9C4361B
	for <linux-fstests@archiver.kernel.org>; Tue,  8 Dec 2020 02:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE6A723A56
	for <linux-fstests@archiver.kernel.org>; Tue,  8 Dec 2020 02:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgLHCFt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 7 Dec 2020 21:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgLHCFs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 7 Dec 2020 21:05:48 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E18C061749
        for <fstests@vger.kernel.org>; Mon,  7 Dec 2020 18:05:08 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id q3so10791467pgr.3
        for <fstests@vger.kernel.org>; Mon, 07 Dec 2020 18:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xQKkLM83zbG1sXM1Wp+/iyauEyG+NpWxZ8lND5RI3+o=;
        b=FpondIB8DPisk/hs8fPf/EiCs2riWE6vugx7Jix/K72qTmv3vF07GIIkTKyBy9iyCG
         3puof64hK8NoUqmGJMdjejVL+cIN1QC2HjVzgqwwCAJaoFyF9OcpXT6ucrqScpElM6s+
         PsmwN7Kc9WlhLDj9vXxCcZglrXDuAj0sfRDSAIwtj3ACIhQ7zBc5lAEwP5+mQNYBHMqD
         LmWoJm/QQbLzL4GSICuZt9hfV/FDKaLVJ5Wy6H6tLAZEEOO9fI60tSqxkd9KcInCWNQK
         JYspxT8NkUCyX9JACJztmZGE/6cQGfYVoPRe2Y3lRHt0fZBm+WfeO4p7bt8YXoHDyuW+
         3SXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xQKkLM83zbG1sXM1Wp+/iyauEyG+NpWxZ8lND5RI3+o=;
        b=O5X9I5rSFtIZIlDgoAPAjobxW8FNnG1OggW5UUvEkg2cFKrEmsHP0AKhTphigvpwwN
         PiyL1lCG3XlVlgsc3IZcajA+apByEexk2ZJJbU7b+z14BXSNDRgJodrlxKJl9rMQZn8g
         TTu04qpJ/FvfsBCwisNarO2TnYsex9McAn5sQq8j57QvWxvBukWWChIXJpc39z2Vd+4T
         QC0g7LU4JJKxM0rxUaEPgY/u+8U8NCSIIXXxPlNE7xZVU8qd9Vh+diNC7jF9gypf87sT
         bUt54WcohBq+J35/CFqQxsJKNuuSytWrmYr0fkOZIgLWyrQfe+bwd7/739kCTaWhPq5W
         7B2Q==
X-Gm-Message-State: AOAM530ZYCGjHjHEnI16xmLqEDFeZVgqqKzfGzYndHgdPSBAAQ/LG8Tk
        nqf0S+pu22ZZ/ul+w+uKbB1YMwtVRc4=
X-Google-Smtp-Source: ABdhPJxxxsojKw5Ib53AradfjBHvwu/MdWLPritiaUdmL10Za1ICIIzblpuKg66eHx9HmOnO+xuq+A==
X-Received: by 2002:a17:90a:62c4:: with SMTP id k4mr1770778pjs.32.1607393107709;
        Mon, 07 Dec 2020 18:05:07 -0800 (PST)
Received: from xzhoux.usersys.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id na6sm671678pjb.12.2020.12.07.18.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 18:05:07 -0800 (PST)
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     fstests@vger.kernel.org
Cc:     Murphy Zhou <jencce.kernel@gmail.com>
Subject: [PATCH] common/filter: add _filter_stat
Date:   Tue,  8 Dec 2020 10:04:42 +0800
Message-Id: <20201208020442.16307-1-jencce.kernel@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

