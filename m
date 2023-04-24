Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D11EC7618E
	for <linux-fstests@archiver.kernel.org>; Mon, 24 Apr 2023 14:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjDXOLp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 24 Apr 2023 10:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjDXOLn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Apr 2023 10:11:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5E46EA8
        for <fstests@vger.kernel.org>; Mon, 24 Apr 2023 07:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682345453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AowmwuSQVk04sdcG4Y4Vke0Vd6MNcqzFZD/B8/TR3GE=;
        b=PUMS9RLsYg/CKfyIkY/NKMbQ+nR6JypDzNS96AUYtEvi1OiJlIbHbt6RLUCEb6k0kZYWp+
        r8RSzvyNhr5GockNFBwJu7qaphoAdgXAOlS0KYXfxIS9E8AeICw1Q5oQ4+XtLgm/F8sa7U
        1YDIVWhtNsNf5Yp17ZwQU9Y/rXkn5rA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-61aMPIPKOhu9fH-z97FEVA-1; Mon, 24 Apr 2023 10:10:50 -0400
X-MC-Unique: 61aMPIPKOhu9fH-z97FEVA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21BED87A9E2;
        Mon, 24 Apr 2023 14:10:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D00E714171B8;
        Mon, 24 Apr 2023 14:10:48 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     fstests@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>, Eryu Guan <guan@eryu.me>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jeffrey Altman <jaltman@auristor.com>,
        linux-afs@lists.infradead.org
Subject: [PATCH v2 1/6] Add AFS support
Date:   Mon, 24 Apr 2023 15:10:37 +0100
Message-Id: <20230424141042.450535-2-dhowells@redhat.com>
In-Reply-To: <20230424141042.450535-1-dhowells@redhat.com>
References: <20230424141042.450535-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Add support for the AFS filesystem.  AFS is a network filesystem and there
are a number of features it doesn't support.

 - No mkfs.  (Kind of.  An AFS volume server can be asked to create a new
   volume, but that's probably best left to AFS-specific test suites.
   Further, a volume would need to be destroyed before another of the same
   name could be created; it's not simply a matter of overwriting the old
   one as it is on a blockdev with a block-based filesystem.)

 - No fsck.  (Kind of - the server can be asked to salvage a volume, but it
   may involve taking the server offline).

 - No richacls.  AFS has its own ACL system.

 - No atimes.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
---
 build/rpm/xfstests.spec.in |  2 +-
 check                      |  3 ++-
 common/config              | 15 +++++++++++---
 common/rc                  | 42 ++++++++++++++++++++++++++++++++------
 4 files changed, 51 insertions(+), 11 deletions(-)

diff --git a/build/rpm/xfstests.spec.in b/build/rpm/xfstests.spec.in
index e0f7c5f9..3dce41ef 100644
--- a/build/rpm/xfstests.spec.in
+++ b/build/rpm/xfstests.spec.in
@@ -17,7 +17,7 @@ Group: System Environment/Base
 
 %description
 The XFS regression test suite.  Also includes some support for
-acl, attr, udf, and nfs testing.  Contains around 200 specific tests
+acl, attr, udf, nfs and afs testing.  Contains around 200 specific tests
 for userspace & kernelspace.
 
 %prep
diff --git a/check b/check
index 1a58a2b2..d4bb4126 100755
--- a/check
+++ b/check
@@ -57,6 +57,7 @@ usage()
 
 check options
     -nfs		test NFS
+    -afs		test AFS
     -glusterfs		test GlusterFS
     -cifs		test CIFS
     -9p			test 9p
@@ -280,7 +281,7 @@ while [ $# -gt 0 ]; do
 	case "$1" in
 	-\? | -h | --help) usage ;;
 
-	-nfs|-glusterfs|-cifs|-9p|-fuse|-virtiofs|-pvfs2|-tmpfs|-ubifs)
+	-nfs|-afs|-glusterfs|-cifs|-9p|-fuse|-virtiofs|-pvfs2|-tmpfs|-ubifs)
 		FSTYP="${1:1}"
 		;;
 	-overlay)
diff --git a/common/config b/common/config
index 6c8cb3a5..25fbec14 100644
--- a/common/config
+++ b/common/config
@@ -301,6 +301,7 @@ export BTRFS_TUNE_PROG=$(type -P btrfstune)
 export BTRFS_CORRUPT_BLOCK_PROG=$(type -P btrfs-corrupt-block)
 export XFS_FSR_PROG=$(type -P xfs_fsr)
 export MKFS_NFS_PROG="false"
+export MKFS_AFS_PROG="false"
 export MKFS_CIFS_PROG="false"
 export MKFS_OVERLAY_PROG="false"
 export MKFS_REISER4_PROG=$(type -P mkfs.reiser4)
@@ -353,6 +354,9 @@ _common_mount_opts()
 	nfs)
 		echo $NFS_MOUNT_OPTIONS
 		;;
+	afs)
+		echo $AFS_MOUNT_OPTIONS
+		;;
 	cifs)
 		echo $CIFS_MOUNT_OPTIONS
 		;;
@@ -420,6 +424,9 @@ _mkfs_opts()
 	nfs)
 		export MKFS_OPTIONS=$NFS_MKFS_OPTIONS
 		;;
+	afs)
+		export MKFS_OPTIONS=$AFS_MKFS_OPTIONS
+		;;
 	cifs)
 		export MKFS_OPTIONS=$CIFS_MKFS_OPTIONS
 		;;
@@ -510,6 +517,8 @@ _source_specific_fs()
 	nfs)
 		. ./common/nfs
 		;;
+	afs)
+		;;
 	cifs)
 		;;
 	9p)
@@ -588,9 +597,9 @@ _check_device()
 	fi
 
 	case "$FSTYP" in
-	9p|fuse|tmpfs|virtiofs)
-		# 9p, fuse and virtiofs mount tags are just plain strings, so anything is allowed
-		# tmpfs doesn't use mount source, ignore
+	9p|fuse|tmpfs|virtiofs|afs)
+		# 9p, fuse, virtiofs and afs mount tags are just plain strings,
+		# so anything is allowed tmpfs doesn't use mount source, ignore
 		;;
 	ceph)
 		# ceph has two different possible syntaxes for mount devices. The
diff --git a/common/rc b/common/rc
index 90749343..8b8cb714 100644
--- a/common/rc
+++ b/common/rc
@@ -569,6 +569,9 @@ _test_mkfs()
     nfs*)
 	# do nothing for nfs
 	;;
+    afs*)
+	# do nothing for afs
+	;;
     cifs)
 	# do nothing for cifs
 	;;
@@ -614,6 +617,9 @@ _try_mkfs_dev()
     nfs*)
 	# do nothing for nfs
 	;;
+    afs*)
+	# do nothing for afs
+	;;
     9p)
 	# do nothing for 9p
 	;;
@@ -660,7 +666,7 @@ _mkfs_dev()
     rm -f $tmp.mkfserr $tmp.mkfsstd
 }
 
-# remove all files in $SCRATCH_MNT, useful when testing on NFS/CIFS
+# remove all files in $SCRATCH_MNT, useful when testing on NFS/AFS/CIFS
 _scratch_cleanup_files()
 {
 	case $FSTYP in
@@ -688,7 +694,7 @@ _scratch_mkfs()
 	local mkfs_status
 
 	case $FSTYP in
-	nfs*|cifs|ceph|overlay|glusterfs|pvfs2|9p|fuse|virtiofs)
+	nfs*|afs|cifs|ceph|overlay|glusterfs|pvfs2|9p|fuse|virtiofs)
 		# unable to re-create this fstyp, just remove all files in
 		# $SCRATCH_MNT to avoid EEXIST caused by the leftover files
 		# created in previous runs
@@ -1571,7 +1577,7 @@ _check_mounted_on()
 
 	if [ -n "$type" -a "`_fs_type $dev`" != "$type" ]; then
 		echo "$devname=$dev is mounted but not a type $type filesystem"
-		# raw $DF_PROG cannot handle NFS/CIFS/overlay correctly
+		# raw $DF_PROG cannot handle NFS/AFS/CIFS/overlay correctly
 		_df_device $dev
 		return 3 # 3 = mounted as wrong type
 	fi
@@ -1610,6 +1616,15 @@ _require_scratch_nocheck()
 			_notrun "this test requires a valid \$SCRATCH_MNT"
 		fi
 		;;
+	afs)
+		echo $SCRATCH_DEV | grep -q "^%" > /dev/null 2>&1
+		if [ -z "$SCRATCH_DEV" -o "$?" != "0" ]; then
+			_notrun "this test requires a valid \$SCRATCH_DEV"
+		fi
+		if [ ! -d "$SCRATCH_MNT" ]; then
+			_notrun "this test requires a valid \$SCRATCH_MNT"
+		fi
+		;;
 	ceph)
 		echo $SCRATCH_DEV | grep -qE "=/|:/" > /dev/null 2>&1
 		if [ -z "$SCRATCH_DEV" -o "$?" != "0" ]; then
@@ -1810,6 +1825,15 @@ _require_test()
 			_notrun "this test requires a valid \$TEST_DIR"
 		fi
 		;;
+	afs)
+		echo $TEST_DEV | grep -q "^%" > /dev/null 2>&1
+		if [ -z "$TEST_DEV" -o "$?" != "0" ]; then
+			_notrun "this test requires a valid \$TEST_DEV"
+		fi
+		if [ ! -d "$TEST_DIR" ]; then
+			_notrun "this test requires a valid \$TEST_DIR"
+		fi
+		;;
 	ceph)
 		echo $TEST_DEV | grep -qE "=/|:/" > /dev/null 2>&1
 		if [ -z "$TEST_DEV" -o "$?" != "0" ]; then
@@ -2923,7 +2947,7 @@ _scratch_mkfs_richacl()
 		;;
 	ext4)   _scratch_mkfs -O richacl
 		;;
-	nfs*|cifs|overlay)
+	nfs*|afs|cifs|overlay)
 		_scratch_mkfs
 		;;
 	esac
@@ -3163,6 +3187,9 @@ _check_test_fs()
     nfs)
 	# no way to check consistency for nfs
 	;;
+    afs)
+	# no way to check consistency for afs
+	;;
     cifs)
 	# no way to check consistency for cifs
 	;;
@@ -3227,6 +3254,9 @@ _check_scratch_fs()
     nfs*)
 	# Don't know how to check an NFS filesystem, yet.
 	;;
+    afs*)
+	# Don't know how to check an AFS filesystem, yet.
+	;;
     cifs)
 	# Don't know how to check a CIFS filesystem, yet.
 	;;
@@ -3996,7 +4026,7 @@ _require_atime()
 {
 	_exclude_scratch_mount_option "noatime"
 	case $FSTYP in
-	nfs|cifs|virtiofs)
+	nfs|afs|cifs|virtiofs)
 		_notrun "atime related mount options have no effect on $FSTYP"
 		;;
 	esac
@@ -4532,7 +4562,7 @@ _require_congruent_file_oplen()
 	local oplen="$2"
 
 	case $FSTYP in
-	nfs*|cifs|9p|virtiofs|ceph|glusterfs|overlay|pvfs2)
+	nfs*|afs|cifs|9p|virtiofs|ceph|glusterfs|overlay|pvfs2)
 		# Network filesystems don't know about (or tell the client
 		# about) the underlying file allocation unit and they generally
 		# pass the file IO request to the underlying filesystem, so we

