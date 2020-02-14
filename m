Return-Path: <SRS0=rSMp=4C=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBFAC2BA83
	for <linux-fstests@archiver.kernel.org>; Fri, 14 Feb 2020 15:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A695C24654
	for <linux-fstests@archiver.kernel.org>; Fri, 14 Feb 2020 15:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbgBNPS7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:18:59 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54679 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729546AbgBNPS7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 14 Feb 2020 10:18:59 -0500
Received: from mail-qt1-f198.google.com ([209.85.160.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1j2ck4-00022R-GQ
        for fstests@vger.kernel.org; Fri, 14 Feb 2020 15:18:56 +0000
Received: by mail-qt1-f198.google.com with SMTP id r30so1827171qtb.10
        for <fstests@vger.kernel.org>; Fri, 14 Feb 2020 07:18:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ME41u9Tp07L1X77zLOoHPTip6xACtBhTzDmaBFGHOOM=;
        b=asILEg3g1Tc3eHkG9g71F82IKveestQzCBBKJStrE0e+ox+4EjXr2mgveZDXf+NslX
         3Yv9PGR85QgeGEhKj7g1EGg/LasnDbTX2nO3ZK4Xpak7bF0l+aJjrL+zYyC3tyG+ZZ8G
         XSrKeQoaHJ50MSoiL+gdKuB6DsnAK5CIsRsXhPsfu7c3N3QPHz8LbwaEY5MZO2UU9DR4
         E8MX9VkCcfEY69V4M2rrotRI4WaEnb764wV9EK20MxRKhcwUgud+jaT8qqiKnLFzLfli
         AtNhmiXcAWtZgbvZePVK1v4FJXT2IhG8MNMy5ZbHHkFw7wDLkCRsSLT0Fwh/p2pWqFZu
         aIqw==
X-Gm-Message-State: APjAAAX1+GCxOXM6brR7dTrTp4M3FQZo88D1ftLrV25u5ZVKOSm0TrJA
        q9WppBo6WFZiYqjvoKyAL+GvTXBWlrNQXaNSEAKff3xnv3sfycuTDECRBS+QgURH21jg2ZLe+ml
        kXWi6lS8aYxVarhVxL3vMX9OoaJ8e9LzPD/U=
X-Received: by 2002:a0c:f193:: with SMTP id m19mr2470496qvl.154.1581693535378;
        Fri, 14 Feb 2020 07:18:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqzwDqdcbhHypUBGB7UZvecSR25qQwQby/UmpXUfXTNQxuXsUibMBbNf9N6i1Vgi/qa8vnhvDw==
X-Received: by 2002:a0c:f193:: with SMTP id m19mr2470465qvl.154.1581693535051;
        Fri, 14 Feb 2020 07:18:55 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:4e7:1017:a97b:ff5a:85e:d3eb])
        by smtp.gmail.com with ESMTPSA id s22sm3403933qke.19.2020.02.14.07.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 07:18:54 -0800 (PST)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     fstests@vger.kernel.org
Cc:     Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2 2/5] tests/overlay: mount: replace overlay hardcode with OVL_FSTYP variable
Date:   Fri, 14 Feb 2020 12:18:45 -0300
Message-Id: <20200214151848.8328-3-mfo@canonical.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214151848.8328-1-mfo@canonical.com>
References: <20200214151848.8328-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This allows other filesystem types to actually be used in these tests.

Well, aufs does not support the options used in most of them anyway,
so just let it fail to mount (instead of implementing common helpers
for middle layers.)

On fuse-overlayfs (coming) the options should be supported/compatible,
and thus just work, so no further changes are needed.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
---
 tests/overlay/011 | 2 +-
 tests/overlay/035 | 2 +-
 tests/overlay/052 | 4 ++--
 tests/overlay/053 | 4 ++--
 tests/overlay/062 | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/overlay/011 b/tests/overlay/011
index 1d09341b250a..0b39416c9835 100755
--- a/tests/overlay/011
+++ b/tests/overlay/011
@@ -53,7 +53,7 @@ $SETFATTR_PROG -n "trusted.overlay.opaque" -v "y" $upperdir/testdir
 # $upperdir overlaid on top of $lowerdir, so that "trusted.overlay.opaque"
 # xattr should be honored and should not be listed
 # mount readonly, because there's no upper and workdir
-$MOUNT_PROG -t overlay -o ro -o lowerdir=$upperdir:$lowerdir $OVL_BASE_SCRATCH_MNT $SCRATCH_MNT
+$MOUNT_PROG -t $OVL_FSTYP -o ro -o lowerdir=$upperdir:$lowerdir $OVL_BASE_SCRATCH_MNT $SCRATCH_MNT
 
 # Dump trusted.overlay xattr, we should not see the "opaque" xattr
 _getfattr -d -m overlay $SCRATCH_MNT/testdir
diff --git a/tests/overlay/035 b/tests/overlay/035
index c0aae935bcf1..bbb158f319cd 100755
--- a/tests/overlay/035
+++ b/tests/overlay/035
@@ -52,7 +52,7 @@ mkdir -p $lowerdir1 $lowerdir2 $upperdir $workdir
 
 # Mount overlay with lower layers only.
 # Verify that overlay is mounted read-only and that it cannot be remounted rw.
-$MOUNT_PROG -t overlay -o"lowerdir=$lowerdir2:$lowerdir1" \
+$MOUNT_PROG -t $OVL_FSTYP -o"lowerdir=$lowerdir2:$lowerdir1" \
 			$OVL_BASE_SCRATCH_MNT $SCRATCH_MNT
 touch $SCRATCH_MNT/foo 2>&1 | _filter_scratch
 $MOUNT_PROG -o remount,rw $SCRATCH_MNT 2>&1 | _filter_ro_mount
diff --git a/tests/overlay/052 b/tests/overlay/052
index b1cf0da64bbf..35a7b5f1a903 100755
--- a/tests/overlay/052
+++ b/tests/overlay/052
@@ -147,7 +147,7 @@ unmount_dirs
 
 # Check encode/decode/read of lower file handles on lower layers only r/o overlay.
 # For non-upper overlay mount, nfs_export requires disabling redirect_dir.
-$MOUNT_PROG -t overlay $OVL_BASE_SCRATCH_MNT $SCRATCH_MNT \
+$MOUNT_PROG -t $OVL_FSTYP $OVL_BASE_SCRATCH_MNT $SCRATCH_MNT \
 			-o ro,redirect_dir=nofollow,nfs_export=on,lowerdir=$middle:$lower
 test_file_handles $SCRATCH_MNT/lowertestdir -rp
 test_file_handles $SCRATCH_MNT/lowertestdir/subdir -rp
@@ -158,7 +158,7 @@ unmount_dirs
 # Overlay lookup cannot follow the redirect from $upper/lowertestdir.new to
 # $lower/lowertestdir. Instead, we mount an overlay subtree rooted at these
 # directories.
-$MOUNT_PROG -t overlay $OVL_BASE_SCRATCH_MNT $SCRATCH_MNT \
+$MOUNT_PROG -t $OVL_FSTYP $OVL_BASE_SCRATCH_MNT $SCRATCH_MNT \
 		-o ro,redirect_dir=nofollow,nfs_export=on,lowerdir=$upper/lowertestdir.new:$lower/lowertestdir
 test_file_handles $SCRATCH_MNT -r
 test_file_handles $SCRATCH_MNT/subdir -rp
diff --git a/tests/overlay/053 b/tests/overlay/053
index ff95424741ec..5ac19b32c3cb 100755
--- a/tests/overlay/053
+++ b/tests/overlay/053
@@ -169,7 +169,7 @@ unmount_dirs
 
 # Check encode/decode/read of lower file handles on lower layers only r/o overlay.
 # For non-upper overlay mount, nfs_export requires disabling redirect_dir.
-$MOUNT_PROG -t overlay $OVL_BASE_SCRATCH_MNT $SCRATCH_MNT \
+$MOUNT_PROG -t $OVL_FSTYP $OVL_BASE_SCRATCH_MNT $SCRATCH_MNT \
 			-o ro,redirect_dir=nofollow,nfs_export=on,lowerdir=$middle:$lower
 test_file_handles $SCRATCH_MNT/lowertestdir -rp
 test_file_handles $SCRATCH_MNT/lowertestdir/subdir -rp
@@ -180,7 +180,7 @@ unmount_dirs
 # Overlay lookup cannot follow the redirect from $upper/lowertestdir.new to
 # $lower/lowertestdir. Instead, we mount an overlay subtree rooted at these
 # directories.
-$MOUNT_PROG -t overlay $OVL_BASE_SCRATCH_MNT $SCRATCH_MNT \
+$MOUNT_PROG -t $OVL_FSTYP $OVL_BASE_SCRATCH_MNT $SCRATCH_MNT \
 		-o ro,redirect_dir=nofollow,nfs_export=on,lowerdir=$upper/lowertestdir.new:$lower/lowertestdir
 test_file_handles $SCRATCH_MNT -r
 test_file_handles $SCRATCH_MNT/subdir -rp
diff --git a/tests/overlay/062 b/tests/overlay/062
index 2c86a4b6fd1e..afd3562bfd33 100755
--- a/tests/overlay/062
+++ b/tests/overlay/062
@@ -72,7 +72,7 @@ create_test_files $lowertestdir
 $MOUNT_PROG --bind $lowertestdir $lowertestdir
 
 # For non-upper overlay mount, nfs_export requires disabling redirect_dir.
-$MOUNT_PROG -t overlay $OVL_BASE_SCRATCH_MNT $SCRATCH_MNT \
+$MOUNT_PROG -t $OVL_FSTYP $OVL_BASE_SCRATCH_MNT $SCRATCH_MNT \
 	-o ro,redirect_dir=nofollow,nfs_export=on,lowerdir=$lower:$lower2
 
 # Decode an overlay directory file handle, whose underlying lower dir dentry
-- 
2.20.1

