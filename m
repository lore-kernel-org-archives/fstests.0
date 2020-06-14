Return-Path: <SRS0=StvD=73=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06C4C433E0
	for <linux-fstests@archiver.kernel.org>; Sun, 14 Jun 2020 20:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A359020739
	for <linux-fstests@archiver.kernel.org>; Sun, 14 Jun 2020 20:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GYeI5Bhj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgFNURf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 14 Jun 2020 16:17:35 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22256 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726648AbgFNURe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 14 Jun 2020 16:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592165851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GQQgVlvbBhQVt2GZDffSPNK0w1I0tGnOtsGKxP8vbm4=;
        b=GYeI5BhjVTYhmVGhMQmW84GsMLXTg0C3t/n1OaqiC6fmtWftly4Jp9GAiDhr5sJWz1bxUz
        oiWDrTR0VwD+cr6GLMqHlAzbgpGQMukHkhVgJS/NveyD6NJQhHPj4OSlBVfhlj9aSe92WR
        RSdezemX7YkNfK+7RAVKyI4evBpWYQ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-MKyamYMeN1-YHoAXTM4vFw-1; Sun, 14 Jun 2020 16:17:29 -0400
X-MC-Unique: MKyamYMeN1-YHoAXTM4vFw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4462102CE3C
        for <fstests@vger.kernel.org>; Sun, 14 Jun 2020 20:17:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-66.rdu2.redhat.com [10.10.114.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 429EA9CA0;
        Sun, 14 Jun 2020 20:17:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <172372.1592165126@warthog.procyon.org.uk>
References: <172372.1592165126@warthog.procyon.org.uk>
To:     fstests@vger.kernel.org
Cc:     dhowells@redhat.com
Subject: [WIP][PATCH] Add support for AFS
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <173886.1592165847.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Sun, 14 Jun 2020 21:17:27 +0100
Message-ID: <173887.1592165847@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Add AFS support.

---
 build/rpm/xfstests.spec.in   |    4 +-
 check                        |    2 +
 common/config                |   12 ++++++-
 common/rc                    |   71 +++++++++++++++++++++++++++++++++++++=
++----
 doc/requirement-checking.txt |   24 ++++++++++++++
 tests/generic/294            |   11 +++++-
 tests/generic/294.cfg        |    1 =

 tests/generic/294.out.mknod  |    6 +++
 tests/generic/314            |    1 =

 tests/generic/317            |    1 =

 10 files changed, 123 insertions(+), 10 deletions(-)

diff --git a/build/rpm/xfstests.spec.in b/build/rpm/xfstests.spec.in
index 338e8839..5a35fbf8 100644
--- a/build/rpm/xfstests.spec.in
+++ b/build/rpm/xfstests.spec.in
@@ -17,8 +17,8 @@ Group: System Environment/Base
 =

 %description
 The XFS regression test suite.  Also includes some support for
-acl, attr, dmapi, udf, and nfs testing.  Contains around 200 specific tes=
ts
-for userspace & kernelspace.
+acl, attr, dmapi, udf, nfs and afs testing.  Contains around 200 specific
+tests for userspace & kernelspace.
 =

 %prep
 if [ -f .census ] ; then
diff --git a/check b/check
index 2e148e57..8aba8345 100755
--- a/check
+++ b/check
@@ -53,6 +53,7 @@ usage()
 =

 check options
     -nfs		test NFS
+    -afs		test AFS
     -glusterfs		test GlusterFS
     -cifs		test CIFS
     -9p			test 9p
@@ -266,6 +267,7 @@ while [ $# -gt 0 ]; do
 	-\? | -h | --help) usage ;;
 =

 	-nfs)		FSTYP=3Dnfs ;;
+	-afs)		FSTYP=3Dafs ;;
 	-glusterfs)	FSTYP=3Dglusterfs ;;
 	-cifs)		FSTYP=3Dcifs ;;
 	-9p)		FSTYP=3D9p ;;
diff --git a/common/config b/common/config
index 8023273d..bc998af7 100644
--- a/common/config
+++ b/common/config
@@ -255,6 +255,7 @@ case "$HOSTOS" in
 	export BTRFS_TUNE_PROG=3D$(type -P btrfstune)
 	export XFS_FSR_PROG=3D$(type -P xfs_fsr)
 	export MKFS_NFS_PROG=3D"false"
+	export MKFS_AFS_PROG=3D"false"
 	export MKFS_CIFS_PROG=3D"false"
 	export MKFS_OVERLAY_PROG=3D"false"
 	export MKFS_REISER4_PROG=3D$(type -P mkfs.reiser4)
@@ -306,6 +307,9 @@ _mount_opts()
 	nfs)
 		export MOUNT_OPTIONS=3D$NFS_MOUNT_OPTIONS
 		;;
+	afs)
+		export MOUNT_OPTIONS=3D$AFS_MOUNT_OPTIONS
+		;;
 	cifs)
 		export MOUNT_OPTIONS=3D$CIFS_MOUNT_OPTIONS
 		;;
@@ -364,6 +368,9 @@ _test_mount_opts()
 	nfs)
 		export TEST_FS_MOUNT_OPTS=3D$NFS_MOUNT_OPTIONS
 		;;
+	afs)
+		export TEST_FS_MOUNT_OPTS=3D$AFS_MOUNT_OPTIONS
+		;;
 	glusterfs)
 		export TEST_FS_MOUNT_OPTS=3D$GLUSTERFS_MOUNT_OPTIONS
 		;;
@@ -390,6 +397,9 @@ _mkfs_opts()
 	nfs)
 		export MKFS_OPTIONS=3D$NFS_MKFS_OPTIONS
 		;;
+	afs)
+		export MKFS_OPTIONS=3D$AFS_MKFS_OPTIONS
+		;;
 	cifs)
 		export MKFS_OPTIONS=3D$CIFS_MKFS_OPTIONS
 		;;
@@ -487,7 +497,7 @@ _check_device()
 	fi
 =

 	case "$FSTYP" in
-	9p|tmpfs|virtiofs)
+	9p|afs|tmpfs|virtiofs)
 		# 9p and virtiofs mount tags are just plain strings, so anything is all=
owed
 		# tmpfs doesn't use mount source, ignore
 		;;
diff --git a/common/rc b/common/rc
index a6967831..17b3c538 100644
--- a/common/rc
+++ b/common/rc
@@ -139,6 +139,8 @@ case "$FSTYP" in
     nfs)
 	 . ./common/nfs
 	 ;;
+    afs)
+	 ;;
     cifs)
 	 ;;
     9p)
@@ -608,6 +610,9 @@ _test_mkfs()
     nfs*)
 	# do nothing for nfs
 	;;
+    afs*)
+	# do nothing for afs
+	;;
     cifs)
 	# do nothing for cifs
 	;;
@@ -651,6 +656,9 @@ _mkfs_dev()
     nfs*)
 	# do nothing for nfs
 	;;
+    afs*)
+	# do nothing for afs
+	;;
     9p)
 	# do nothing for 9p
 	;;
@@ -693,7 +701,7 @@ _mkfs_dev()
     rm -f $tmp.mkfserr $tmp.mkfsstd
 }
 =

-# remove all files in $SCRATCH_MNT, useful when testing on NFS/CIFS
+# remove all files in $SCRATCH_MNT, useful when testing on NFS/AFS/CIFS
 _scratch_cleanup_files()
 {
 	case $FSTYP in
@@ -721,7 +729,7 @@ _scratch_mkfs()
 	local mkfs_status
 =

 	case $FSTYP in
-	nfs*|cifs|ceph|overlay|glusterfs|pvfs2|9p|virtiofs)
+	nfs*|afs|cifs|ceph|overlay|glusterfs|pvfs2|9p|virtiofs)
 		# unable to re-create this fstyp, just remove all files in
 		# $SCRATCH_MNT to avoid EEXIST caused by the leftover files
 		# created in previous runs
@@ -1473,7 +1481,7 @@ _check_mounted_on()
 =

 	if [ -n "$type" -a "`_fs_type $dev`" !=3D "$type" ]; then
 		echo "$devname=3D$dev is mounted but not a type $type filesystem"
-		# raw $DF_PROG cannot handle NFS/CIFS/overlay correctly
+		# raw $DF_PROG cannot handle NFS/AFS/CIFS/overlay correctly
 		_df_device $dev
 		return 3 # 3 =3D mounted as wrong type
 	fi
@@ -1512,6 +1520,15 @@ _require_scratch_nocheck()
 			_notrun "this test requires a valid \$SCRATCH_MNT"
 		fi
 		;;
+	afs)
+		echo $SCRATCH_DEV | grep -q "^%" > /dev/null 2>&1
+		if [ -z "$SCRATCH_DEV" -o "$?" !=3D "0" ]; then
+			_notrun "this test requires a valid \$SCRATCH_DEV"
+		fi
+		if [ ! -d "$SCRATCH_MNT" ]; then
+			_notrun "this test requires a valid \$SCRATCH_MNT"
+		fi
+		;;
 	pvfs2)
 		echo $SCRATCH_DEV | grep -q "://" > /dev/null 2>&1
 		if [ -z "$SCRATCH_DEV" -o "$?" !=3D "0" ]; then
@@ -1636,6 +1653,15 @@ _require_test()
 			_notrun "this test requires a valid \$TEST_DIR"
 		fi
 		;;
+	afs)
+		echo $TEST_DEV | grep -q "^%" > /dev/null 2>&1
+		if [ -z "$TEST_DEV" -o "$?" !=3D "0" ]; then
+			_notrun "this test requires a valid \$TEST_DEV"
+		fi
+		if [ ! -d "$TEST_DIR" ]; then
+			_notrun "this test requires a valid \$TEST_DIR"
+		fi
+		;;
 	cifs)
 		echo $TEST_DEV | grep -q "//" > /dev/null 2>&1
 		if [ -z "$TEST_DEV" -o "$?" !=3D "0" ]; then
@@ -2526,7 +2552,7 @@ _scratch_mkfs_richacl()
 		;;
 	ext4)   _scratch_mkfs -O richacl
 		;;
-	nfs*|cifs|overlay)
+	nfs*|afs|cifs|overlay)
 		_scratch_mkfs
 		;;
 	esac
@@ -2741,6 +2767,9 @@ _check_test_fs()
     nfs)
 	# no way to check consistency for nfs
 	;;
+    afs)
+	# no way to check consistency for afs
+	;;
     cifs)
 	# no way to check consistency for cifs
 	;;
@@ -2802,6 +2831,9 @@ _check_scratch_fs()
     nfs*)
 	# Don't know how to check an NFS filesystem, yet.
 	;;
+    afs*)
+	# Don't know how to check an AFS filesystem, yet.
+	;;
     cifs)
 	# Don't know how to check a CIFS filesystem, yet.
 	;;
@@ -3414,7 +3446,7 @@ _require_atime()
 {
 	_exclude_scratch_mount_option "noatime"
 	case $FSTYP in
-	nfs|cifs)
+	nfs|afs|cifs)
 		_notrun "atime related mount options have no effect on $FSTYP"
 		;;
 	esac
@@ -4224,6 +4256,35 @@ _require_mknod()
 	rm -f $TEST_DIR/$seq.null
 }
 =

+_has_mknod()
+{
+	case $FSTYP in
+	afs)
+		return 1;;
+	*)
+		return 0;;
+	esac
+}
+
+_require_use_local_uidgid()
+{
+	case $FSTYP in
+	afs)
+		_notrun "$FSTYP doesn't honour local uid and gid"
+		;;
+	esac
+}
+
+_require_sgid_inheritance()
+{
+	case $FSTYP in
+	afs)
+		_notrun "SGID-based group ID inheritance is not supported on $FSTYP"
+		;;
+	esac
+
+}
+
 init_rc
 =

 #########################################################################=
#######
diff --git a/doc/requirement-checking.txt b/doc/requirement-checking.txt
index 45d2756b..c945e16a 100644
--- a/doc/requirement-checking.txt
+++ b/doc/requirement-checking.txt
@@ -16,6 +16,10 @@ they have.  This is done with _require_<xxx> macros, wh=
ich may take parameters.
 =

 	_require_chattr <letters>
 	_require_exportfs
+	_require_mknod
+	_has_mknod
+	_require_sgid_inheritance
+	_require_use_local_uidgid
 =

  (3) System call requirements.
 =

@@ -97,6 +101,26 @@ _require_exportfs
      The test also requires the use of the open_by_handle_at() system cal=
l and
      will be skipped if it isn't available in the kernel.
 =

+_require_mknod
+_has_mknod
+
+     The test requires that the $TEST_DEV filesystem supports mknod(2).
+     _require_mknod will cause the test to be skipped; _has_mknod returns=
 0 if
+     mknod is supported and 1 otherwise.
+
+_require_sgid_inheritance
+
+     The test required that the $TEST_DEV filesystem supports the inherit=
ance
+     of the SGID bit and the GID from a marked directory.  The test will =
be
+     skipped if not supported.
+
+_require_use_local_uidgid
+
+     The test requires that the $TEST_DEV filesystem sets the uid and gid=
 of a
+     newly created file to the creating process's fsuid and fsgid.  Remot=
e
+     filesystems, for example, may choose other settings or not even have=
 these
+     concepts available.  The test will be skipped if not supported.
+
 =

 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 SYSTEM CALL REQUIREMENTS
diff --git a/tests/generic/294 b/tests/generic/294
index 32c89b03..71f861de 100755
--- a/tests/generic/294
+++ b/tests/generic/294
@@ -8,6 +8,7 @@
 # we ask to create an already-existing entity on an RO filesystem
 #
 seq=3D`basename $0`
+seqfull=3D$0
 seqres=3D$RESULT_DIR/$seq
 echo "QA output created by $seq"
 =

@@ -34,8 +35,13 @@ _supported_os Linux
 _require_scratch
 _require_symlinks
 =

-rm -f $seqres.full
-_scratch_mkfs > $seqres.full 2>&1 || _fail "Could not mkfs scratch device=
"
+features=3D""
+if ! _has_mknod; then
+	features=3D"nomknod"
+fi
+_link_out_file "$features"
+
+_scratch_mkfs 2>&1 || _fail "Could not mkfs scratch device"
 =

 THIS_TEST_DIR=3D$SCRATCH_MNT/$seq.test
 =

@@ -57,5 +63,6 @@ _try_scratch_mount -o remount,ro || _fail "Could not rem=
ount scratch readonly"
 _create_files 2>&1 | _filter_scratch
 =

 # success, all done
+rm -f $seqres.full
 status=3D0
 exit
diff --git a/tests/generic/294.cfg b/tests/generic/294.cfg
new file mode 100644
index 00000000..c0466cde
--- /dev/null
+++ b/tests/generic/294.cfg
@@ -0,0 +1 @@
+nomknod: nomknod
diff --git a/tests/generic/294.out.mknod b/tests/generic/294.out.mknod
new file mode 100644
index 00000000..4aea9d82
--- /dev/null
+++ b/tests/generic/294.out.mknod
@@ -0,0 +1,6 @@
+QA output created by 294
+mknod: SCRATCH_MNT/294.test/testnode: Operation not permitted
+mknod: SCRATCH_MNT/294.test/testnode: Read-only file system
+mkdir: cannot create directory 'SCRATCH_MNT/294.test/testdir': File exist=
s
+touch: cannot touch 'SCRATCH_MNT/294.test/testtarget': Read-only file sys=
tem
+ln: creating symbolic link 'SCRATCH_MNT/294.test/testlink': File exists
diff --git a/tests/generic/314 b/tests/generic/314
index 03df81ce..13fdfc31 100755
--- a/tests/generic/314
+++ b/tests/generic/314
@@ -29,6 +29,7 @@ _cleanup()
 _supported_fs generic
 _require_test
 _require_user
+_require_sgid_inheritance
 =

 rm -rf $TEST_DIR/$seq-dir
 =

diff --git a/tests/generic/317 b/tests/generic/317
index 8ea9d81c..45e47a91 100755
--- a/tests/generic/317
+++ b/tests/generic/317
@@ -46,6 +46,7 @@ _require_scratch
 _require_user
 _require_ugid_map
 _require_userns
+_require_use_local_uidgid
 qa_user_id=3D`id -u $qa_user`
 =

 _filter_output()

