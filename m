Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE6FC61DB3
	for <linux-fstests@archiver.kernel.org>; Thu, 12 Jan 2023 22:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240386AbjALW0D (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 Jan 2023 17:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240585AbjALWZe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 Jan 2023 17:25:34 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A073DBEA
        for <fstests@vger.kernel.org>; Thu, 12 Jan 2023 14:23:21 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id m12so11585039qvt.9
        for <fstests@vger.kernel.org>; Thu, 12 Jan 2023 14:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oW6p8ihPaOdhTS0g8LMLHmlZ0uWXSxbI5Q02Cthzk2E=;
        b=L6ibr6GrVEF4ykyxWS3w1kgatKzZWHVcpm4fKkwnAEOuZB+zlLFjwqfxlIWNqjZQfE
         0EhQ67I21sDSXXGlzmxwVJhEuEpoAtgnmtHjnvTt9/5YXWNg9ivVvI/PD3KSP3yPu514
         SNrMBcFD1DPIL+n7jLeTqug+AmLjx0U5U2hlHKtS0prI3d1lG7keGo3nFYO3zX0HG5CQ
         AdxBV2dBL2jReCTJ9mSrlY6Ah1C4IUR58kmyAku5BbEvEey+6+UESxtvNxwywTpdlrFg
         THJI2F6gNKu2GDOoCOHGnfwWUBvnKl3F4OrCLR+Wu0fW4feOiBItcfAD38AKTUWpk981
         lKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oW6p8ihPaOdhTS0g8LMLHmlZ0uWXSxbI5Q02Cthzk2E=;
        b=i13jFivAuBXrU1fppl++GnSxrbXvK1RnYNWRVQ0yUhaxpm+Vt1Yd/yfHR/TyNodSNN
         ddBVbqn4fOz3nJpEywYGKAH8UFFgbIYdvfhFMld5Zb6EIIkF1GDMP38BAEMEeULSOr2Z
         858tI0qdm6q7beJovVRcajIUvMXREk/TV7VVD3IFzywwq0uIiRQrvT+N/r4PHqzSwEMG
         2F39xPuxVRl4FeE07jbTDVXUT/mvfopSPWhAxe92OJOLHyZh77myHu7FpWuIPhROmxOF
         s4sUGT8LtBdyEypup27K21bRFJpvXGwWBLSIBRaTuNdSpz8Cb22mjPHc/uf9GM0/jqh/
         FfuQ==
X-Gm-Message-State: AFqh2kqa8phzRllqFhaKTujZpxaa3Z5FcuGtQBzjhVM+U6FY+tfAmjp/
        MCEIa6q7QGLV7QXyw/MzvHXQvUyDCe4=
X-Google-Smtp-Source: AMrXdXslnZFzBfrpu7PhWzCW8rel0tCp0MYCODta19uKJ2Qcnji7AGlBUr29bSgUU1mVnMNt7PIykg==
X-Received: by 2002:a05:6214:4206:b0:531:b5c1:20be with SMTP id nd6-20020a056214420600b00531b5c120bemr66084099qvb.7.1673562200232;
        Thu, 12 Jan 2023 14:23:20 -0800 (PST)
Received: from shiina-laptop.redhat.com ([2601:18f:47f:7270:54c1:7162:1772:f1d])
        by smtp.gmail.com with ESMTPSA id r8-20020a05620a298800b006bb29d932e1sm11701320qkp.105.2023.01.12.14.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 14:23:19 -0800 (PST)
From:   Hironori Shiina <shiina.hironori@gmail.com>
X-Google-Original-From: Hironori Shiina <shiina.hironori@fujitsu.com>
To:     fstests@vger.kernel.org
Cc:     Hironori Shiina <shiina.hironori@fujitsu.com>
Subject: [PATCH v2 1/2] xfs: add helper to create fake root inode
Date:   Thu, 12 Jan 2023 17:22:41 -0500
Message-Id: <20230112222242.153502-2-shiina.hironori@fujitsu.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230112222242.153502-1-shiina.hironori@fujitsu.com>
References: <20230112222242.153502-1-shiina.hironori@fujitsu.com>
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
 tests/xfs/557 | 31 ++++---------------------------
 4 files changed, 52 insertions(+), 83 deletions(-)

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
 
diff --git a/tests/xfs/557 b/tests/xfs/557
index 425695db..e1de919b 100644
--- a/tests/xfs/557
+++ b/tests/xfs/557
@@ -21,33 +21,10 @@ _require_scratch
 _fixed_by_kernel_commit XXXXXXXXXXXX \
 	"xfs: get root inode correctly at bulkstat"
 
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
 
 # Get root ino with XFS_BULK_IREQ_SPECIAL_ROOT
 bulkstat_root_inum=$($XFS_IO_PROG -c 'bulkstat_single root' $SCRATCH_MNT | grep bs_ino | awk '{print $3;}')
-- 
2.39.0

