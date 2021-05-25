Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B698C2B9F8
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 13:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBF926141B
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 13:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbhEYNfa (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 May 2021 09:35:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40458 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233193AbhEYNfa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 May 2021 09:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621949640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TBiDkeqLVI05GEmHTLk4pwA9cBazNHikSxOrFTIr+Do=;
        b=KujhowH4PNuWwNdV0IdLIyDFhR5SQv+i9ibdtanlq4rYrptvnZ7Jr84M4Laa/jTA9zYzVz
        2UZu+pbISLfviAfbp66nHp57HY+l5kPkbyT3u2aFrNhHtH11zMxC7cCtgDEE1rpHdUmbHO
        jVQiKqeIFFqNpoEWizpFbaLoMyByaIs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-uamZC5nMOsuQ0I-55xslgA-1; Tue, 25 May 2021 09:33:58 -0400
X-MC-Unique: uamZC5nMOsuQ0I-55xslgA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42748106BB34;
        Tue, 25 May 2021 13:33:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-24.rdu2.redhat.com [10.10.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73B43101E24F;
        Tue, 25 May 2021 13:33:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/9] Add AFS support
From:   David Howells <dhowells@redhat.com>
To:     fstests@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org
Date:   Tue, 25 May 2021 14:33:55 +0100
Message-ID: <162194963567.4011860.18154245673640393670.stgit@warthog.procyon.org.uk>
In-Reply-To: <162194962878.4011860.5561077785368723619.stgit@warthog.procyon.org.uk>
References: <162194962878.4011860.5561077785368723619.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

 build/rpm/xfstests.spec.in |    2 +-
 check                      |    2 ++
 common/config              |   12 +++++++++++-
 common/rc                  |   42 +++++++++++++++++++++++++++++++++++++-----
 4 files changed, 51 insertions(+), 7 deletions(-)

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
index ba192042..90abdbbd 100755
--- a/check
+++ b/check
@@ -56,6 +56,7 @@ usage()
 
 check options
     -nfs		test NFS
+    -afs		test AFS
     -glusterfs		test GlusterFS
     -cifs		test CIFS
     -9p			test 9p
@@ -278,6 +279,7 @@ while [ $# -gt 0 ]; do
 	-\? | -h | --help) usage ;;
 
 	-nfs)		FSTYP=nfs ;;
+	-afs)		FSTYP=afs ;;
 	-glusterfs)	FSTYP=glusterfs ;;
 	-cifs)		FSTYP=cifs ;;
 	-9p)		FSTYP=9p ;;
diff --git a/common/config b/common/config
index 1a269349..f0536b87 100644
--- a/common/config
+++ b/common/config
@@ -259,6 +259,7 @@ export BTRFS_CONVERT_PROG=$(type -P btrfs-convert)
 export BTRFS_TUNE_PROG=$(type -P btrfstune)
 export XFS_FSR_PROG=$(type -P xfs_fsr)
 export MKFS_NFS_PROG="false"
+export MKFS_AFS_PROG="false"
 export MKFS_CIFS_PROG="false"
 export MKFS_OVERLAY_PROG="false"
 export MKFS_REISER4_PROG=$(type -P mkfs.reiser4)
@@ -308,6 +309,9 @@ _mount_opts()
 	nfs)
 		export MOUNT_OPTIONS=$NFS_MOUNT_OPTIONS
 		;;
+	afs)
+		export MOUNT_OPTIONS=$AFS_MOUNT_OPTIONS
+		;;
 	cifs)
 		export MOUNT_OPTIONS=$CIFS_MOUNT_OPTIONS
 		;;
@@ -366,6 +370,9 @@ _test_mount_opts()
 	nfs)
 		export TEST_FS_MOUNT_OPTS=$NFS_MOUNT_OPTIONS
 		;;
+	afs)
+		export TEST_FS_MOUNT_OPTS=$AFS_MOUNT_OPTIONS
+		;;
 	glusterfs)
 		export TEST_FS_MOUNT_OPTS=$GLUSTERFS_MOUNT_OPTIONS
 		;;
@@ -392,6 +399,9 @@ _mkfs_opts()
 	nfs)
 		export MKFS_OPTIONS=$NFS_MKFS_OPTIONS
 		;;
+	afs)
+		export MKFS_OPTIONS=$AFS_MKFS_OPTIONS
+		;;
 	cifs)
 		export MKFS_OPTIONS=$CIFS_MKFS_OPTIONS
 		;;
@@ -492,7 +502,7 @@ _check_device()
 	fi
 
 	case "$FSTYP" in
-	9p|tmpfs|virtiofs)
+	9p|afs|tmpfs|virtiofs)
 		# 9p and virtiofs mount tags are just plain strings, so anything is allowed
 		# tmpfs doesn't use mount source, ignore
 		;;
diff --git a/common/rc b/common/rc
index b18cf61e..f24d0e87 100644
--- a/common/rc
+++ b/common/rc
@@ -123,6 +123,8 @@ case "$FSTYP" in
     nfs)
 	 . ./common/nfs
 	 ;;
+    afs)
+	 ;;
     cifs)
 	 ;;
     9p)
@@ -637,6 +639,9 @@ _test_mkfs()
     nfs*)
 	# do nothing for nfs
 	;;
+    afs*)
+	# do nothing for afs
+	;;
     cifs)
 	# do nothing for cifs
 	;;
@@ -680,6 +685,9 @@ _mkfs_dev()
     nfs*)
 	# do nothing for nfs
 	;;
+    afs*)
+	# do nothing for afs
+	;;
     9p)
 	# do nothing for 9p
 	;;
@@ -722,7 +730,7 @@ _mkfs_dev()
     rm -f $tmp.mkfserr $tmp.mkfsstd
 }
 
-# remove all files in $SCRATCH_MNT, useful when testing on NFS/CIFS
+# remove all files in $SCRATCH_MNT, useful when testing on NFS/AFS/CIFS
 _scratch_cleanup_files()
 {
 	case $FSTYP in
@@ -750,7 +758,7 @@ _scratch_mkfs()
 	local mkfs_status
 
 	case $FSTYP in
-	nfs*|cifs|ceph|overlay|glusterfs|pvfs2|9p|virtiofs)
+	nfs*|afs|cifs|ceph|overlay|glusterfs|pvfs2|9p|virtiofs)
 		# unable to re-create this fstyp, just remove all files in
 		# $SCRATCH_MNT to avoid EEXIST caused by the leftover files
 		# created in previous runs
@@ -1501,7 +1509,7 @@ _check_mounted_on()
 
 	if [ -n "$type" -a "`_fs_type $dev`" != "$type" ]; then
 		echo "$devname=$dev is mounted but not a type $type filesystem"
-		# raw $DF_PROG cannot handle NFS/CIFS/overlay correctly
+		# raw $DF_PROG cannot handle NFS/AFS/CIFS/overlay correctly
 		_df_device $dev
 		return 3 # 3 = mounted as wrong type
 	fi
@@ -1540,6 +1548,15 @@ _require_scratch_nocheck()
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
 	pvfs2)
 		echo $SCRATCH_DEV | grep -q "://" > /dev/null 2>&1
 		if [ -z "$SCRATCH_DEV" -o "$?" != "0" ]; then
@@ -1696,6 +1713,15 @@ _require_test()
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
 	cifs)
 		echo $TEST_DEV | grep -q "//" > /dev/null 2>&1
 		if [ -z "$TEST_DEV" -o "$?" != "0" ]; then
@@ -2748,7 +2774,7 @@ _scratch_mkfs_richacl()
 		;;
 	ext4)   _scratch_mkfs -O richacl
 		;;
-	nfs*|cifs|overlay)
+	nfs*|afs|cifs|overlay)
 		_scratch_mkfs
 		;;
 	esac
@@ -2972,6 +2998,9 @@ _check_test_fs()
     nfs)
 	# no way to check consistency for nfs
 	;;
+    afs)
+	# no way to check consistency for afs
+	;;
     cifs)
 	# no way to check consistency for cifs
 	;;
@@ -3033,6 +3062,9 @@ _check_scratch_fs()
     nfs*)
 	# Don't know how to check an NFS filesystem, yet.
 	;;
+    afs*)
+	# Don't know how to check an AFS filesystem, yet.
+	;;
     cifs)
 	# Don't know how to check a CIFS filesystem, yet.
 	;;
@@ -3737,7 +3769,7 @@ _require_atime()
 {
 	_exclude_scratch_mount_option "noatime"
 	case $FSTYP in
-	nfs|cifs|virtiofs)
+	nfs|afs|cifs|virtiofs)
 		_notrun "atime related mount options have no effect on $FSTYP"
 		;;
 	esac


