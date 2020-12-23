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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211FAC433E0
	for <linux-fstests@archiver.kernel.org>; Wed, 23 Dec 2020 01:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF9C422573
	for <linux-fstests@archiver.kernel.org>; Wed, 23 Dec 2020 01:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgLWB7g (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 22 Dec 2020 20:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbgLWB7f (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Dec 2020 20:59:35 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72D6C0613D3
        for <fstests@vger.kernel.org>; Tue, 22 Dec 2020 17:58:55 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id p18so9591261pgm.11
        for <fstests@vger.kernel.org>; Tue, 22 Dec 2020 17:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ig2zqzPeBhaln+7+aRrS7n7t2s2sAoaaNRwWcPi80A0=;
        b=QguNVqkeFBYiK3O0HziKabPGinIo8FQ3RT0AMd8/9CEpNY+QOfoydRVBTvkHRfcyn8
         kPDzKqNvfgDTN3NKFwu5/yrTOwcnyjflrgfqUpRWhAv4OxDiZEv3qsYdTVHNp4iinP1E
         X26eh8AK3VX2J+zUZ6SFT7A9SWPvXXbNmpnM1vOtUGK3s6rBw1eTxHJE29jj4VAzpHu7
         8MTHn68wySyRCfS7IQDwIART9fjLW/IqBNDFUrjRb03q3swq4dxyfMf/PzMmMEMMlE5S
         ePNr5wzPrrf1KkIoKK4i9Uu34oj1QbVkgG78VV0awvPaC1mycWE6u48x+X+vPpnOEg3g
         jqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ig2zqzPeBhaln+7+aRrS7n7t2s2sAoaaNRwWcPi80A0=;
        b=C33bgG4stO7IffHTCH8B3PeCEmlFpOpGEA5c+2NioFPHbL/pNP3zNZca5Au+dvxXSc
         4/2MTA2ePMzTIVlT2p8j96ATAJQd0/5ix1r7kMNjFQTDbpeCOL9ybyyi+xYAY6izNsTo
         m3VOvulOBRi6mnFWvPFkZwJPsEnSNqVIN0+jgWu8ztAJFbzsw31xVbwHGB16Mrjfw/TY
         kCk5tngdfCOscLvPQHjeivJdMfj7kEQHPlhfB0vlGGtLE5uVuGcls1o2YDSD4Bs09GGQ
         Wh6MGzPOGjiVbKEZmf5uuuVisLLyKC3P87K7vbYCWp/LsA23KoLetnJpJ4qoduoLR2/M
         7OxA==
X-Gm-Message-State: AOAM530o5QdQpi44RqZj9QvCQltrC4mq9Ks86TG5nD3Giwfb4vocl8aF
        JkP43o/h0vxSO2MpBIi8m6/YNQwu0Fc=
X-Google-Smtp-Source: ABdhPJxWrQKwIiMZSDT8SxVH7Af0YenkBNZwNTZ1xTB/qKnJg2aLEhHtwj6XhAvZWffD2SqTirnCWw==
X-Received: by 2002:a63:4b0e:: with SMTP id y14mr22464417pga.161.1608688734481;
        Tue, 22 Dec 2020 17:58:54 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s23sm3882176pgj.29.2020.12.22.17.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 17:58:53 -0800 (PST)
Date:   Wed, 23 Dec 2020 09:58:45 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     fstests@vger.kernel.org
Cc:     Eryu Guan <guan@eryu.me>, Murphy Zhou <jencce.kernel@gmail.com>
Subject: [PATCH v2] common/filter: add _filter_stat
Message-ID: <20201223015845.43wmv4ulitdecqah@xzhoux.usersys.redhat.com>
References: <20201208020442.16307-1-jencce.kernel@gmail.com>
 <20201220144041.GZ3853@desktop>
 <20201222070529.rqvun74aoocharcg@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222070529.rqvun74aoocharcg@xzhoux.usersys.redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

New stat(1) starts to use statx(2) call. If file does not exist,
it breaks golden output like this:

-stat: cannot stat 'SCRATCH_MNT/xxx': No such file or directory
+stat: cannot statx 'SCRATCH_MNT/xxx': No such file or directory

Add this filter to fix it, and add this filter to testcases that
need it.

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---

v2:
  filter "stat" to "statx"

 common/filter         |   6 ++
 tests/generic/397     |   6 +-
 tests/generic/397.out |   6 +-
 tests/generic/435     |   2 +-
 tests/generic/435.out |   2 +-
 tests/generic/440     |   2 +-
 tests/generic/440.out |   2 +-
 tests/xfs/348         |   2 +-
 tests/xfs/348.out     | 188 +++++++++++++++++++++---------------------
 9 files changed, 111 insertions(+), 105 deletions(-)

diff --git a/common/filter b/common/filter
index a8b3882f..2f3277f7 100644
--- a/common/filter
+++ b/common/filter
@@ -510,6 +510,12 @@ _filter_mv()
 	sed -e "s/^renamed //"
 }
 
+# New stat(1) uses statx(2)
+_filter_stat()
+{
+	sed -e "s/\<cannot stat\>/cannot statx/"
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
diff --git a/tests/generic/397.out b/tests/generic/397.out
index 2f55c5d6..6804c7ab 100644
--- a/tests/generic/397.out
+++ b/tests/generic/397.out
@@ -1,6 +1,6 @@
 QA output created by 397
-stat: cannot stat 'SCRATCH_MNT/edir/empty': No such file or directory
-stat: cannot stat 'SCRATCH_MNT/edir/symlink': No such file or directory
+stat: cannot statx 'SCRATCH_MNT/edir/empty': No such file or directory
+stat: cannot statx 'SCRATCH_MNT/edir/symlink': No such file or directory
 8
 1
 Required key not available
@@ -10,4 +10,4 @@ mkdir: cannot create directory 'SCRATCH_MNT/edir/newdir': Required key not avail
 mkdir: cannot create directory 'SCRATCH_MNT/edir/0123456789abcdef': Required key not available
 ln: failed to create symbolic link 'SCRATCH_MNT/edir/newlink': Required key not available
 ln: failed to create symbolic link 'SCRATCH_MNT/edir/0123456789abcdef': Required key not available
-stat: cannot stat 'SCRATCH_MNT/edir': No such file or directory
+stat: cannot statx 'SCRATCH_MNT/edir': No such file or directory
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
diff --git a/tests/generic/435.out b/tests/generic/435.out
index 9ed547dd..3628b8f9 100644
--- a/tests/generic/435.out
+++ b/tests/generic/435.out
@@ -1,4 +1,4 @@
 QA output created by 435
 100000
 100000
-stat: cannot stat 'SCRATCH_MNT/edir': No such file or directory
+stat: cannot statx 'SCRATCH_MNT/edir': No such file or directory
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
 
diff --git a/tests/generic/440.out b/tests/generic/440.out
index 372b7975..82b89b83 100644
--- a/tests/generic/440.out
+++ b/tests/generic/440.out
@@ -9,5 +9,5 @@ cat: SCRATCH_MNT/edir/symlink: No such file or directory
 
 ***** Child has key, but parent doesn't *****
 contents
-stat: cannot stat 'SCRATCH_MNT/edir/file': No such file or directory
+stat: cannot statx 'SCRATCH_MNT/edir/file': No such file or directory
 contents
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
diff --git a/tests/xfs/348.out b/tests/xfs/348.out
index 17d9be23..0d407718 100644
--- a/tests/xfs/348.out
+++ b/tests/xfs/348.out
@@ -23,13 +23,13 @@ would have junked entry "DIR" in directory PARENT_INO
 would have junked entry "EMPTY" in directory PARENT_INO
 would have junked entry "FIFO" in directory PARENT_INO
 would have junked entry "SYMLINK" in directory PARENT_INO
-stat: cannot stat 'SCRATCH_MNT/test/DIR': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/DATA': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/EMPTY': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/SYMLINK': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/CHRDEV': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/BLKDEV': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/FIFO': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/DIR': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/DATA': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/EMPTY': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/SYMLINK': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/CHRDEV': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/BLKDEV': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/FIFO': Structure needs cleaning
 
 ===== Setting dt=1 to all files:
 core.mode = 010644
@@ -43,10 +43,10 @@ would have junked entry "DATA" in directory PARENT_INO
 would have junked entry "DIR" in directory PARENT_INO
 would have junked entry "EMPTY" in directory PARENT_INO
 would have junked entry "SYMLINK" in directory PARENT_INO
-stat: cannot stat 'SCRATCH_MNT/test/DIR': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/DATA': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/EMPTY': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/SYMLINK': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/DIR': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/DATA': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/EMPTY': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/SYMLINK': Structure needs cleaning
 stat: 'SCRATCH_MNT/test/CHRDEV' is a fifo
 stat: 'SCRATCH_MNT/test/BLKDEV' is a fifo
 stat: 'SCRATCH_MNT/test/FIFO' is a fifo
@@ -63,10 +63,10 @@ would have junked entry "DATA" in directory PARENT_INO
 would have junked entry "DIR" in directory PARENT_INO
 would have junked entry "EMPTY" in directory PARENT_INO
 would have junked entry "SYMLINK" in directory PARENT_INO
-stat: cannot stat 'SCRATCH_MNT/test/DIR': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/DATA': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/EMPTY': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/SYMLINK': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/DIR': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/DATA': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/EMPTY': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/SYMLINK': Structure needs cleaning
 stat: 'SCRATCH_MNT/test/CHRDEV' is a character special file
 stat: 'SCRATCH_MNT/test/BLKDEV' is a character special file
 stat: 'SCRATCH_MNT/test/FIFO' is a character special file
@@ -86,13 +86,13 @@ would have junked entry "DIR" in directory PARENT_INO
 would have junked entry "EMPTY" in directory PARENT_INO
 would have junked entry "FIFO" in directory PARENT_INO
 would have junked entry "SYMLINK" in directory PARENT_INO
-stat: cannot stat 'SCRATCH_MNT/test/DIR': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/DATA': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/EMPTY': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/SYMLINK': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/CHRDEV': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/BLKDEV': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/FIFO': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/DIR': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/DATA': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/EMPTY': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/SYMLINK': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/CHRDEV': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/BLKDEV': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/FIFO': Structure needs cleaning
 
 ===== Setting dt=4 to all files:
 core.mode = 040644
@@ -109,11 +109,11 @@ would have junked entry "EMPTY" in directory PARENT_INO
 would have junked entry "FIFO" in directory PARENT_INO
 stat: 'SCRATCH_MNT/test/DIR' is a directory
 stat: 'SCRATCH_MNT/test/DATA' is a directory
-stat: cannot stat 'SCRATCH_MNT/test/EMPTY': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/SYMLINK': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/CHRDEV': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/BLKDEV': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/FIFO': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/EMPTY': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/SYMLINK': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/CHRDEV': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/BLKDEV': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/FIFO': Structure needs cleaning
 
 ===== Setting dt=5 to all files:
 core.mode = 050644
@@ -130,13 +130,13 @@ would have junked entry "DIR" in directory PARENT_INO
 would have junked entry "EMPTY" in directory PARENT_INO
 would have junked entry "FIFO" in directory PARENT_INO
 would have junked entry "SYMLINK" in directory PARENT_INO
-stat: cannot stat 'SCRATCH_MNT/test/DIR': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/DATA': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/EMPTY': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/SYMLINK': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/CHRDEV': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/BLKDEV': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/FIFO': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/DIR': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/DATA': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/EMPTY': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/SYMLINK': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/CHRDEV': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/BLKDEV': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/FIFO': Structure needs cleaning
 
 ===== Setting dt=6 to all files:
 core.mode = 060644
@@ -150,10 +150,10 @@ would have junked entry "DATA" in directory PARENT_INO
 would have junked entry "DIR" in directory PARENT_INO
 would have junked entry "EMPTY" in directory PARENT_INO
 would have junked entry "SYMLINK" in directory PARENT_INO
-stat: cannot stat 'SCRATCH_MNT/test/DIR': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/DATA': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/EMPTY': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/SYMLINK': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/DIR': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/DATA': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/EMPTY': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/SYMLINK': Structure needs cleaning
 stat: 'SCRATCH_MNT/test/CHRDEV' is a block special file
 stat: 'SCRATCH_MNT/test/BLKDEV' is a block special file
 stat: 'SCRATCH_MNT/test/FIFO' is a block special file
@@ -173,13 +173,13 @@ would have junked entry "DIR" in directory PARENT_INO
 would have junked entry "EMPTY" in directory PARENT_INO
 would have junked entry "FIFO" in directory PARENT_INO
 would have junked entry "SYMLINK" in directory PARENT_INO
-stat: cannot stat 'SCRATCH_MNT/test/DIR': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/DATA': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/EMPTY': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/SYMLINK': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/CHRDEV': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/BLKDEV': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/FIFO': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/DIR': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/DATA': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/EMPTY': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/SYMLINK': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/CHRDEV': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/BLKDEV': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/FIFO': Structure needs cleaning
 
 ===== Setting dt=10 to all files:
 core.mode = 0100644
@@ -194,13 +194,13 @@ would have junked entry "CHRDEV" in directory PARENT_INO
 would have junked entry "DIR" in directory PARENT_INO
 would have junked entry "FIFO" in directory PARENT_INO
 would have junked entry "SYMLINK" in directory PARENT_INO
-stat: cannot stat 'SCRATCH_MNT/test/DIR': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/DIR': Structure needs cleaning
 stat: 'SCRATCH_MNT/test/DATA' is a regular file
 stat: 'SCRATCH_MNT/test/EMPTY' is a regular empty file
-stat: cannot stat 'SCRATCH_MNT/test/SYMLINK': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/CHRDEV': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/BLKDEV': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/FIFO': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/SYMLINK': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/CHRDEV': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/BLKDEV': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/FIFO': Structure needs cleaning
 
 ===== Setting dt=11 to all files:
 core.mode = 0110644
@@ -217,13 +217,13 @@ would have junked entry "DIR" in directory PARENT_INO
 would have junked entry "EMPTY" in directory PARENT_INO
 would have junked entry "FIFO" in directory PARENT_INO
 would have junked entry "SYMLINK" in directory PARENT_INO
-stat: cannot stat 'SCRATCH_MNT/test/DIR': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/DATA': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/EMPTY': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/SYMLINK': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/CHRDEV': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/BLKDEV': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/FIFO': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/DIR': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/DATA': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/EMPTY': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/SYMLINK': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/CHRDEV': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/BLKDEV': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/FIFO': Structure needs cleaning
 
 ===== Setting dt=12 to all files:
 core.mode = 0120644
@@ -239,13 +239,13 @@ would have junked entry "DATA" in directory PARENT_INO
 would have junked entry "DIR" in directory PARENT_INO
 would have junked entry "EMPTY" in directory PARENT_INO
 would have junked entry "FIFO" in directory PARENT_INO
-stat: cannot stat 'SCRATCH_MNT/test/DIR': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/DIR': Structure needs cleaning
 stat: 'SCRATCH_MNT/test/DATA' is a symbolic link
-stat: cannot stat 'SCRATCH_MNT/test/EMPTY': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/EMPTY': Structure needs cleaning
 stat: 'SCRATCH_MNT/test/SYMLINK' is a symbolic link
-stat: cannot stat 'SCRATCH_MNT/test/CHRDEV': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/BLKDEV': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/FIFO': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/CHRDEV': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/BLKDEV': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/FIFO': Structure needs cleaning
 
 ===== Setting dt=13 to all files:
 core.mode = 0130644
@@ -262,13 +262,13 @@ would have junked entry "DIR" in directory PARENT_INO
 would have junked entry "EMPTY" in directory PARENT_INO
 would have junked entry "FIFO" in directory PARENT_INO
 would have junked entry "SYMLINK" in directory PARENT_INO
-stat: cannot stat 'SCRATCH_MNT/test/DIR': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/DATA': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/EMPTY': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/SYMLINK': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/CHRDEV': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/BLKDEV': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/FIFO': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/DIR': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/DATA': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/EMPTY': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/SYMLINK': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/CHRDEV': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/BLKDEV': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/FIFO': Structure needs cleaning
 
 ===== Setting dt=14 to all files:
 core.mode = 0140644
@@ -282,10 +282,10 @@ would have junked entry "DATA" in directory PARENT_INO
 would have junked entry "DIR" in directory PARENT_INO
 would have junked entry "EMPTY" in directory PARENT_INO
 would have junked entry "SYMLINK" in directory PARENT_INO
-stat: cannot stat 'SCRATCH_MNT/test/DIR': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/DATA': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/EMPTY': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/SYMLINK': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/DIR': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/DATA': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/EMPTY': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/SYMLINK': Structure needs cleaning
 stat: 'SCRATCH_MNT/test/CHRDEV' is a socket
 stat: 'SCRATCH_MNT/test/BLKDEV' is a socket
 stat: 'SCRATCH_MNT/test/FIFO' is a socket
@@ -305,13 +305,13 @@ would have junked entry "DIR" in directory PARENT_INO
 would have junked entry "EMPTY" in directory PARENT_INO
 would have junked entry "FIFO" in directory PARENT_INO
 would have junked entry "SYMLINK" in directory PARENT_INO
-stat: cannot stat 'SCRATCH_MNT/test/DIR': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/DATA': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/EMPTY': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/SYMLINK': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/CHRDEV': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/BLKDEV': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/FIFO': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/DIR': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/DATA': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/EMPTY': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/SYMLINK': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/CHRDEV': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/BLKDEV': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/FIFO': Structure needs cleaning
 
 ===== Setting dt=16 to all files:
 core.mode = 0160644
@@ -328,13 +328,13 @@ would have junked entry "DIR" in directory PARENT_INO
 would have junked entry "EMPTY" in directory PARENT_INO
 would have junked entry "FIFO" in directory PARENT_INO
 would have junked entry "SYMLINK" in directory PARENT_INO
-stat: cannot stat 'SCRATCH_MNT/test/DIR': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/DATA': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/EMPTY': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/SYMLINK': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/CHRDEV': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/BLKDEV': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/FIFO': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/DIR': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/DATA': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/EMPTY': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/SYMLINK': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/CHRDEV': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/BLKDEV': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/FIFO': Structure needs cleaning
 
 ===== Setting dt=17 to all files:
 core.mode = 0170644
@@ -351,10 +351,10 @@ would have junked entry "DIR" in directory PARENT_INO
 would have junked entry "EMPTY" in directory PARENT_INO
 would have junked entry "FIFO" in directory PARENT_INO
 would have junked entry "SYMLINK" in directory PARENT_INO
-stat: cannot stat 'SCRATCH_MNT/test/DIR': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/DATA': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/EMPTY': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/SYMLINK': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/CHRDEV': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/BLKDEV': Structure needs cleaning
-stat: cannot stat 'SCRATCH_MNT/test/FIFO': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/DIR': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/DATA': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/EMPTY': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/SYMLINK': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/CHRDEV': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/BLKDEV': Structure needs cleaning
+stat: cannot statx 'SCRATCH_MNT/test/FIFO': Structure needs cleaning
-- 
2.20.1

