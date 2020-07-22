Return-Path: <SRS0=o+XN=BB=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8D0C433E0
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Jul 2020 06:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E34F20787
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Jul 2020 06:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUQBegBI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgGVGim (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 22 Jul 2020 02:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgGVGil (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 22 Jul 2020 02:38:41 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8A6C061794
        for <fstests@vger.kernel.org>; Tue, 21 Jul 2020 23:38:41 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w126so488569pfw.8
        for <fstests@vger.kernel.org>; Tue, 21 Jul 2020 23:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=cyggu9MEatAdF4d0r3Q9vySor1v5D4o3RFsOHieVvrE=;
        b=WUQBegBIFSBzMxxnLCHMaFqsZdjG8NIXEgmLJVdfLQrgVqr6/9fau5dpLbOLt3bdvg
         fkE9dTTDHBC/pgGmtUfmgaCSDAz618py2U0sU5WTp9Rsh/LsmWkSaGswDUVTUK/U9Erl
         q+GRP02wbQceDNHOOWaly7HT3LJCqrT0mITCE2xNPBrqos1eqQugblvU/SCyspibrfsh
         N+QiybQKtSU3EgrNYR86pVMIC2wdHsEyXv3FlxqYu+TJKyrQ22d6Ph1uhSDaMTMYlQEH
         to3BYl6NCeLygF8QsUyasIwrAQ3IAGieWEeB8iHdccFIbBC6mPFMiVDVbkq9xFey67S/
         ymfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=cyggu9MEatAdF4d0r3Q9vySor1v5D4o3RFsOHieVvrE=;
        b=bHMZ3t0yM+pEJpP8FXxAXmGGm0syqN0MUMMQdrj6UP1rsfBeJcCJwxRrmUiSDsGQ3Z
         6tgKWvy1S6LLYsouMkhbps604SmNdDrtPuH/XrjsYS3Ev5D+9stPrt8E3aU2b2CqW9iJ
         IzfXwMP9tNFgjarTN9kSS0V4KeJrhru6O5klWAz5BigRtiogECXlbeA4SEeekB1rtUF1
         qKU0YGCDRfV9hPWLtNd4lvj0mNUktXhJUSphjW+VA8eOz/0gsMgPyIHFONn8LQ5jtiZR
         qMHxxaA2fFpxbKU1BfS8laFCAYq6nATGQ+Z6fzSnxL0JwVvA0W4ulKf2cfOdL8kGPAeh
         S0AA==
X-Gm-Message-State: AOAM532DeRJ155Moefty2/w+Diw2bvzPEshIvg1Qmomez7FKCISrQ7Bf
        ZTr+ohlfVjUDuVP4bgP3vdgddwrwe+o=
X-Google-Smtp-Source: ABdhPJyU6jL9FwirGlKi0h5N3wVMMwfs02tI5T/Ixge5+OWEW7XcIpIpk8TQSHrynyH9ptOzlWPdkQ==
X-Received: by 2002:a62:8045:: with SMTP id j66mr26844652pfd.162.1595399920488;
        Tue, 21 Jul 2020 23:38:40 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id o14sm5160567pjw.3.2020.07.21.23.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 23:38:39 -0700 (PDT)
Date:   Wed, 22 Jul 2020 14:38:32 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     fstests@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic/501: count with PAGE_SIZE instead of KB
Message-ID: <20200722063832.dpxn7weosdy2zp64@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hard coded reflink offset/length numbers are not working well on 64K page
size arch like ppc64le, reporting:
	+XFS_IOC_CLONE_RANGE: Invalid argument

Because they are not aligned with the current PAGE_SIZE.

Translate original numbers into multiples of PAGE_SIZE. Then we're writing
different testfiles with different md5sums when PAGE_SIZE is different.
So we need to link different output file based on the current PAGE_SIZE.

This testcase is covering a btrfs regression which has been fixed in
v4.18. I tried to reproduce it on 4.17 kernel but failed with and
without this patch.

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
 .gitignore                            |  1 +
 tests/generic/501                     | 17 +++++++++++++----
 tests/generic/{501.out => 501.out.4K} |  0
 tests/generic/501.out.64K             |  5 +++++
 4 files changed, 19 insertions(+), 4 deletions(-)
 rename tests/generic/{501.out => 501.out.4K} (100%)
 create mode 100644 tests/generic/501.out.64K

diff --git a/.gitignore b/.gitignore
index 5f5c4a0f..39318615 100644
--- a/.gitignore
+++ b/.gitignore
@@ -263,6 +263,7 @@
 /tests/xfs/033.out
 /tests/xfs/071.out
 /tests/xfs/096.out
+/tests/generic/501.out
 
 # cscope files
 cscope.*
diff --git a/tests/generic/501 b/tests/generic/501
index 0d1f6ffe..4e589cda 100755
--- a/tests/generic/501
+++ b/tests/generic/501
@@ -9,6 +9,7 @@
 # the file again and then power fail, after we mount again the filesystem, no
 # file data was lost or corrupted.
 #
+seqfull=$0
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 echo "QA output created by $seq"
@@ -42,14 +43,22 @@ _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
 _mount_flakey
 
-$XFS_IO_PROG -f -c "pwrite -S 0x18 9000K 6908K" $SCRATCH_MNT/foo >>$seqres.full
-$XFS_IO_PROG -f -c "pwrite -S 0x20 2572K 156K" $SCRATCH_MNT/bar >>$seqres.full
+pagesz=$(getconf PAGE_SIZE)
+
+if [ $pagesz -eq 65536 ] ; then
+	ln -sf $seqfull.out.64K $seqfull.out
+elif [ $pagesz -eq 4096 ] ; then
+	ln -sf $seqfull.out.4K $seqfull.out
+fi
+
+$XFS_IO_PROG -f -c "pwrite -S 0x18 $((2250*pagesz)) $((1727*pagesz))" $SCRATCH_MNT/foo >>$seqres.full
+$XFS_IO_PROG -f -c "pwrite -S 0x20 $((643*pagesz)) $((39*pagesz))" $SCRATCH_MNT/bar >>$seqres.full
 
 # We clone from file foo into a range of file bar that overlaps the existing
 # extent at file bar. The destination offset of the reflink operation matches
-# the eof position of file bar minus 4Kb.
+# the eof position of file bar minus 1 PAGE_SIZE.
 $XFS_IO_PROG -c "fsync" \
-	     -c "reflink ${SCRATCH_MNT}/foo 0 2724K 15908K" \
+	     -c "reflink ${SCRATCH_MNT}/foo 0 $((681*pagesz)) $((3977*pagesz))" \
 	     -c "fsync" \
 	     $SCRATCH_MNT/bar >>$seqres.full
 
diff --git a/tests/generic/501.out b/tests/generic/501.out.4K
similarity index 100%
rename from tests/generic/501.out
rename to tests/generic/501.out.4K
diff --git a/tests/generic/501.out.64K b/tests/generic/501.out.64K
new file mode 100644
index 00000000..7e1013b2
--- /dev/null
+++ b/tests/generic/501.out.64K
@@ -0,0 +1,5 @@
+QA output created by 501
+File bar digest before power failure:
+3058797b969076e91c518cb206b21163  SCRATCH_MNT/bar
+File bar digest after power failure:
+3058797b969076e91c518cb206b21163  SCRATCH_MNT/bar
-- 
2.20.1

