Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05332C54EAA
	for <linux-fstests@archiver.kernel.org>; Mon, 30 Jan 2023 22:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjA3W5W (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 30 Jan 2023 17:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjA3W5V (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 30 Jan 2023 17:57:21 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3B01631C
        for <fstests@vger.kernel.org>; Mon, 30 Jan 2023 14:57:20 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id z5so2201208qtn.8
        for <fstests@vger.kernel.org>; Mon, 30 Jan 2023 14:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEaftKX9wLA4N6Eg9oclIq/pupUeaJSI4SHIMurMO74=;
        b=Gz2u/ifLA7AJjMiudH0Up6obaCmiVtbNDl762YynV/1z4/xfztFWAgkgHB/pKxRS3H
         +lgboOBJDU9Btw2IZho7iB6wtsseHXafKiCCRHIuWT0zcNJsQIDjP+T+bci01+Zol6Bs
         vFcb/5HnORpF+yVQR5f3Auln1gD8HHoB8B27gnq0F34LjhyWomEG0KD/D/Gf2ZOIiIph
         g+U5kpHwnZEOSWO1v1RcrzWUWfHz74aWdLcHbGW3lydMiWmmZ8aAJfRYOOn9vQa7FatM
         0ZG4EOqG+1Vw+6y9x4MsgAiTW0BhY7DDldp2+RIu3qsqDZbleh+bnSP8ZnvGlKHp2PlG
         txVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qEaftKX9wLA4N6Eg9oclIq/pupUeaJSI4SHIMurMO74=;
        b=0ik2JLmep4qGXfmP+tsTXvasOtGlYUFMFlwX9kQGbHCoxBqQ7c3Tq5GLY6oQ5eQGLz
         8sRiHHKzcxktbdQQJhBFJ6dQyxo7mR6VYgH18qBLWZ0LhqOJe2tt3c9WkfxJpvxJ78vZ
         T+NBsHfDdk7GYQPL6F5l3MUUqFEXQeJoK9qctAM47eZxPlVLwgAfcaT1CwMiOSq4Ka7I
         7LSd3ZWavd721yMvK7LHMkgXj7R0ekNCw/DKuRQyNvqYmqqADckRc/BRe0rVCMlZ9G4L
         7gb8GiScPfVAMyQprL1PsF3Jgy81tk5tAAjjBMJltpUEPiaVGldqWCB8AFGRJweYjizB
         dSwg==
X-Gm-Message-State: AO0yUKVh89EQXDhFq9l6gdQOc2bNdqt+D9vY074awrMsQu52j5V22Tli
        K2KaFGvJC0Qqmo7JoPtMy5xP1ALOYUI=
X-Google-Smtp-Source: AK7set91a/Y0bfc8lQAzm/bIzvBXVbTfUk+MAr7rHgiVqMjDVtVTm3VkRtLC6/Dkm/Mfs7FvDFLLpw==
X-Received: by 2002:ac8:6614:0:b0:3b8:6d5a:3457 with SMTP id c20-20020ac86614000000b003b86d5a3457mr1602473qtp.6.1675119439312;
        Mon, 30 Jan 2023 14:57:19 -0800 (PST)
Received: from shiina-laptop.redhat.com ([2601:18f:47f:7270:54c1:7162:1772:f1d])
        by smtp.gmail.com with ESMTPSA id b25-20020ac844d9000000b003b82cb8748dsm6416332qto.96.2023.01.30.14.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 14:57:18 -0800 (PST)
From:   Hironori Shiina <shiina.hironori@gmail.com>
X-Google-Original-From: Hironori Shiina <shiina.hironori@fujitsu.com>
To:     fstests@vger.kernel.org
Cc:     Hironori Shiina <shiina.hironori@fujitsu.com>
Subject: [PATCH v3 1/2] xfs: add helper to create fake root inode
Date:   Mon, 30 Jan 2023 17:56:42 -0500
Message-Id: <20230130225643.148935-2-shiina.hironori@fujitsu.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230130225643.148935-1-shiina.hironori@fujitsu.com>
References: <20230130225643.148935-1-shiina.hironori@fujitsu.com>
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
 common/xfs    | 40 ++++++++++++++++++++++++++++++++++++++++
 tests/xfs/545 | 31 ++++---------------------------
 tests/xfs/554 | 35 ++++++-----------------------------
 tests/xfs/557 | 31 ++++---------------------------
 4 files changed, 54 insertions(+), 83 deletions(-)

diff --git a/common/xfs b/common/xfs
index a00d90a4..ba59889c 100644
--- a/common/xfs
+++ b/common/xfs
@@ -1556,3 +1556,43 @@ _xfs_get_inode_core_bytes()
 		echo 96
 	fi
 }
+
+# Create a file with a lower inode number than the root inode number. For this
+# creation, this function runs mkfs and mount on the scratch device with
+# options. This function prints the root inode number and the created inode
+# number.
+_scratch_xfs_create_fake_root()
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
+	[[ $inum -lt $root_inum ]] || _notrun "Could not set up test"
+
+	echo "$root_inum $inum"
+}
diff --git a/tests/xfs/545 b/tests/xfs/545
index ccb0dd6c..57a650ac 100755
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
+inums=($(_scratch_xfs_create_fake_root))
+root_inum=${inums[0]}
+fake_inum=${inums[1]}
 
 # Now try a dump and restore. Cribbed from xfs/068
 _create_dumpdir_stress
diff --git a/tests/xfs/554 b/tests/xfs/554
index 65084cb3..16fc052c 100755
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
+inums=($(_scratch_xfs_create_fake_root))
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
index 425695db..522c4f06 100644
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
+inums=($(_scratch_xfs_create_fake_root))
+root_inum=${inums[0]}
+fake_inum=${inums[1]}
 
 # Get root ino with XFS_BULK_IREQ_SPECIAL_ROOT
 bulkstat_root_inum=$($XFS_IO_PROG -c 'bulkstat_single root' $SCRATCH_MNT | grep bs_ino | awk '{print $3;}')
-- 
2.39.1

