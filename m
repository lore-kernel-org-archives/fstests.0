Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABFDC54EBE
	for <linux-fstests@archiver.kernel.org>; Tue, 10 Jan 2023 22:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbjAJWCD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 10 Jan 2023 17:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbjAJWB4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 10 Jan 2023 17:01:56 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620157649
        for <fstests@vger.kernel.org>; Tue, 10 Jan 2023 14:01:55 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so15026860pjj.4
        for <fstests@vger.kernel.org>; Tue, 10 Jan 2023 14:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnD+ubgYVPdWQUJDehnpgasD3iAeFab84dGjReKQWRo=;
        b=mpuG3jvfBP4c6qQaY2LvAYx6lRGwLjSfgodrgME2EV+nR8UWy72GnZgH8cXyunOMKk
         XWzrRRL+xgcG3JYEmmyLu3+/03clnAwb+XxdrJ0RCvfURnjVcIb/0mL9gpSJfyXGF2Ub
         SiyxP5KmXfX67p+V1uYQVREHLrVIx/QH97stq8XfzBHyjzVHXouK4hdO5dZnjhAGBJu3
         nqBnP99gtIEyCbaIqge8zjU4NpnO5fKpwYkhNnx6rv6UlAFBoiCd6Z+n8q94uOpS5R5i
         vzpypDVekPg2GJ/m6WlhaCgaWanOId49WId45Z9NCMd6up++0Z4OiaQGQtav+kZZgIqR
         EJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnD+ubgYVPdWQUJDehnpgasD3iAeFab84dGjReKQWRo=;
        b=u1MTa1WgiQBuZ75sxm9rqgLy2I4nFH/eCoXRrPEkbGf82ivlBUfw5yrD1TcP1KVmhQ
         pqch5vFxFw6E6dZ4pbPlPBzgcKWaGMhAofhhOzyI9EfweH2n583pSUrLHUVTv0Nh/sUt
         lxh2uEb33k3ljASE51QNcNMIyQPOaSfBgH64eK5L9v+N3IFXmmDIwi5RZ7eN6FL1p1ht
         kXbY/wKrNibTAt7WjhZhFi0p3fv9ib/vK0rOcLD7Umxjp7shYvislBScsChg3mQoP+mQ
         sfH6j9Oqa/jsDUGbeScBkdS7BbnAC1DSayLWzkznVZzNlqh0BXJVp56EbltMxlK7jakP
         5KCw==
X-Gm-Message-State: AFqh2kpthDv79RVXazDN7mePgWOCH6i5249j9UcwACg5ndqSPt6F6CNt
        /KXL0EL/mFfduUu10+0IQScX/UkYclA=
X-Google-Smtp-Source: AMrXdXvysVmproYPLnGdX4Oqv27Hc7BKyHn1Xpb1kvzNxDG4DvDgYlGZngRfHTB7rsdJPJghKe0mnw==
X-Received: by 2002:a05:6a20:8347:b0:b0:4f70:b2b2 with SMTP id z7-20020a056a20834700b000b04f70b2b2mr64603629pzc.46.1673388114853;
        Tue, 10 Jan 2023 14:01:54 -0800 (PST)
Received: from shiina-laptop.hsd1.ma.comcast.net ([2601:18f:47f:7270:54c1:7162:1772:f1d])
        by smtp.gmail.com with ESMTPSA id u8-20020a05620a454800b006fc7302cf89sm7936709qkp.28.2023.01.10.14.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 14:01:54 -0800 (PST)
From:   Hironori Shiina <shiina.hironori@gmail.com>
X-Google-Original-From: Hironori Shiina <shiina.hironori@fujitsu.com>
To:     fstests@vger.kernel.org
Cc:     Hironori Shiina <shiina.hironori@fujitsu.com>
Subject: [PATCH 1/2] xfs: add helper to create fake root inode
Date:   Tue, 10 Jan 2023 17:00:57 -0500
Message-Id: <20230110220058.139131-2-shiina.hironori@fujitsu.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110220058.139131-1-shiina.hironori@fujitsu.com>
References: <20230110220058.139131-1-shiina.hironori@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

xfsdump used to cause a problem when there is an inode whose number is
lower than the root inode number. This patch adds a helper function to
reproduce such a situation for regression tests.

Signed-off-by: Hironori Shiina <shiina.hironori@fujitsu.com>
---
 common/xfs    | 38 ++++++++++++++++++++++++++++++++++++++
 tests/xfs/545 | 31 ++++---------------------------
 tests/xfs/554 | 35 ++++++-----------------------------
 3 files changed, 48 insertions(+), 56 deletions(-)

diff --git a/common/xfs b/common/xfs
index 7eee76c0..745d48d1 100644
--- a/common/xfs
+++ b/common/xfs
@@ -1547,3 +1547,41 @@ _xfs_get_inode_core_bytes()
 		echo 96
 	fi
 }
+
+# Create a file with a lower inode number than the root inode number. For this
+# creation, this function runs mkfs and mount on the scratch device with
+# options. This function prints the root inode number and the created inode
+# number.
+_xfs_create_fake_root()
+{
+	local root_inum
+	local inum
+
+	# A large stripe unit will put the root inode out quite far
+	# due to alignment, leaving free blocks ahead of it.
+	_scratch_mkfs_xfs -d sunit=1024,swidth=1024 > $seqres.full 2>&1 || _fail "mkfs failed"
+
+	# Mounting /without/ a stripe should allow inodes to be allocated
+	# in lower free blocks, without the stripe alignment.
+	_scratch_mount -o sunit=0,swidth=0
+
+	local root_inum=$(stat -c %i $SCRATCH_MNT)
+
+	# Consume space after the root inode so that the blocks before
+	# root look "close" for the next inode chunk allocation
+	$XFS_IO_PROG -f -c "falloc 0 16m" $SCRATCH_MNT/fillfile
+
+	# And make a bunch of inodes until we (hopefully) get one lower
+	# than root, in a new inode chunk.
+	echo "root_inum: $root_inum" >> $seqres.full
+	for i in $(seq 0 4096) ; do
+		fname=$SCRATCH_MNT/$(printf "FILE_%03d" $i)
+		touch $fname
+		inum=$(stat -c "%i" $fname)
+		[[ $inum -lt $root_inum ]] && break
+	done
+
+	echo "created: $inum" >> $seqres.full
+
+	echo "$root_inum $inum"
+}
diff --git a/tests/xfs/545 b/tests/xfs/545
index ccb0dd6c..83785155 100755
--- a/tests/xfs/545
+++ b/tests/xfs/545
@@ -17,33 +17,10 @@ _supported_fs xfs
 _require_xfs_io_command "falloc"
 _require_scratch
 
-# A large stripe unit will put the root inode out quite far
-# due to alignment, leaving free blocks ahead of it.
-_scratch_mkfs_xfs -d sunit=1024,swidth=1024 > $seqres.full 2>&1
-
-# Mounting /without/ a stripe should allow inodes to be allocated
-# in lower free blocks, without the stripe alignment.
-_scratch_mount -o sunit=0,swidth=0
-
-root_inum=$(stat -c %i $SCRATCH_MNT)
-
-# Consume space after the root inode so that the blocks before
-# root look "close" for the next inode chunk allocation
-$XFS_IO_PROG -f -c "falloc 0 16m" $SCRATCH_MNT/fillfile
-
-# And make a bunch of inodes until we (hopefully) get one lower
-# than root, in a new inode chunk.
-echo "root_inum: $root_inum" >> $seqres.full
-for i in $(seq 0 4096) ; do
-	fname=$SCRATCH_MNT/$(printf "FILE_%03d" $i)
-	touch $fname
-	inum=$(stat -c "%i" $fname)
-	[[ $inum -lt $root_inum ]] && break
-done
-
-echo "created: $inum" >> $seqres.full
-
-[[ $inum -lt $root_inum ]] || _notrun "Could not set up test"
+# Create a filesystem which contains a fake root inode
+inums=($(_xfs_create_fake_root))
+root_inum=${inums[0]}
+fake_inum=${inums[1]}
 
 # Now try a dump and restore. Cribbed from xfs/068
 _create_dumpdir_stress
diff --git a/tests/xfs/554 b/tests/xfs/554
index 65084cb3..22ce7e28 100755
--- a/tests/xfs/554
+++ b/tests/xfs/554
@@ -21,33 +21,10 @@ _require_xfs_io_command "falloc"
 _require_scratch
 _require_xfsrestore_xflag
 
-# A large stripe unit will put the root inode out quite far
-# due to alignment, leaving free blocks ahead of it.
-_scratch_mkfs_xfs -d sunit=1024,swidth=1024 > $seqres.full 2>&1 || _fail "mkfs failed"
-
-# Mounting /without/ a stripe should allow inodes to be allocated
-# in lower free blocks, without the stripe alignment.
-_scratch_mount -o sunit=0,swidth=0
-
-root_inum=$(stat -c %i $SCRATCH_MNT)
-
-# Consume space after the root inode so that the blocks before
-# root look "close" for the next inode chunk allocation
-$XFS_IO_PROG -f -c "falloc 0 16m" $SCRATCH_MNT/fillfile
-
-# And make a bunch of inodes until we (hopefully) get one lower
-# than root, in a new inode chunk.
-echo "root_inum: $root_inum" >> $seqres.full
-for i in $(seq 0 4096) ; do
-	fname=$SCRATCH_MNT/$(printf "FILE_%03d" $i)
-	touch $fname
-	inum=$(stat -c "%i" $fname)
-	[[ $inum -lt $root_inum ]] && break
-done
-
-echo "created: $inum" >> $seqres.full
-
-[[ $inum -lt $root_inum ]] || _notrun "Could not set up test"
+# Create a filesystem which contains a fake root inode
+inums=($(_xfs_create_fake_root))
+root_inum=${inums[0]}
+fake_inum=${inums[1]}
 
 # Now try a dump and restore. Cribbed from xfs/068
 _create_dumpdir_stress
@@ -59,10 +36,10 @@ _do_dump_file
 
 # Set the wrong root inode number to the dump file
 # as problematic xfsdump used to do.
-$here/src/fake-dump-rootino $dump_file $inum
+$here/src/fake-dump-rootino $dump_file $fake_inum
 
 _do_restore_file -x | \
-sed -e "s/rootino #${inum}/rootino #FAKENO/g" \
+sed -e "s/rootino #${fake_inum}/rootino #FAKENO/g" \
 	-e "s/# to ${root_inum}/# to ROOTNO/g" \
 	-e "/entries processed$/s/[0-9][0-9]*/NUM/g"
 
-- 
2.39.0

