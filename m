Return-Path: <SRS0=0zUf=6H=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E65C54FCB
	for <linux-fstests@archiver.kernel.org>; Thu, 23 Apr 2020 11:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DEAB2071E
	for <linux-fstests@archiver.kernel.org>; Thu, 23 Apr 2020 11:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FnH2SuIY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgDWLSl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 23 Apr 2020 07:18:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26568 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727918AbgDWLSk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 23 Apr 2020 07:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587640717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rdnuUqzCJeoEXBdUugsZ1f6TyMHeg47aJfsbTufXZJc=;
        b=FnH2SuIY2B6w10JsubKk2lY3hs424no9nbGEvBPzWXU3hbQknV9VnI25BQNss9nYVqT91h
        tLKQ6zQGHUv6mzkQwPuGHYxksqRJdKk4xD9mEGrwv9EqjnynXgRg3D42LOkQkHxwjJOGYd
        OxF4QQ4DA4lx3A7V9J6ULjU4AxGatxg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-dNC3KzYdNVq85rYWlDRfCw-1; Thu, 23 Apr 2020 07:18:33 -0400
X-MC-Unique: dNC3KzYdNVq85rYWlDRfCw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B97A9DB24
        for <fstests@vger.kernel.org>; Thu, 23 Apr 2020 11:18:32 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 059BA5D706
        for <fstests@vger.kernel.org>; Thu, 23 Apr 2020 11:18:31 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v2] ext4: ext4 mount sanity test
Date:   Thu, 23 Apr 2020 13:18:29 +0200
Message-Id: <20200423111829.31657-1-lczerner@redhat.com>
In-Reply-To: <20200422152012.28588-1-lczerner@redhat.com>
References: <20200422152012.28588-1-lczerner@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Add test to validate that the ext4 mount options are properly recognized,
validated and applied to avoid regression as ext4 moves to the new mount
API.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
v2: ext4 driver can support ext3 and ext2 as well so check the
    compatibility for those fs as well

 tests/ext4/002     | 509 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/002.out |   2 +
 tests/ext4/group   |   1 +
 3 files changed, 512 insertions(+)
 create mode 100755 tests/ext4/002
 create mode 100644 tests/ext4/002.out

diff --git a/tests/ext4/002 b/tests/ext4/002
new file mode 100755
index 00000000..eda4a2dd
--- /dev/null
+++ b/tests/ext4/002
@@ -0,0 +1,509 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Red Hat, Inc., Lukas Czerner <lczerner@redhat.com>.
+#
+# FS QA Test 002
+#
+# Sanity check of ext4 mount options
+#
+seq=3D`basename $0`
+seqres=3D$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=3D`pwd`
+tmp=3D/tmp/$$
+status=3D1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
+	if [ -n "$LOOP_LOGDEV" ];then
+		_destroy_loop_device $LOOP_LOGDEV 2>/dev/null
+	fi
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/quota
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+echo "Silence is golden."
+
+_supported_fs ext2 ext3 ext4
+_supported_os Linux
+_require_scratch
+_require_quota
+_require_loop
+
+LOG=3D""
+print_log() {
+	LOG=3D"$LOG $@"
+}
+
+KERNEL_VERSION=3D`uname -r | cut -d'.' -f1,2`
+kernel_gte() {
+	gte=3D`echo "$KERNEL_VERSION >=3D $1" | $BC_PROG`
+	[ $gte -eq 1 ] && return 0
+	return 1
+}
+
+# This test is only relevant for the newer kernel
+kernel_gte 4.19 || _notrun "This test is only relevant for kernel versio=
ns 5.7 and higher"
+
+IGNORED=3D"remount,defaults,ignored,removed"
+CHECK_MINFO=3D"lazytime"
+ERR=3D0
+
+test_mnt() {
+	findmnt -n $SCRATCH_DEV > /dev/null 2>&1
+	[ $? -ne 0 ] && return $?
+
+	if [ $# -eq 1 ]; then
+		OPTS=3D$1
+	elif [ $# -eq 2 ]; then
+		OPTS=3D$2
+	else
+		return 0
+	fi
+
+	print_log "checking \"$OPTS\" "
+	# test options in /proc/fs/ext4/dev/options
+	(
+	ret=3D0
+	IFS=3D','
+	for option in $OPTS; do
+		if echo $IGNORED | grep -w $option; then
+			continue
+		fi
+
+		[ $option =3D "noload" ] && option=3D"norecovery"
+
+		if [[ $option =3D ^* ]]; then
+			expected=3D1
+		else
+			expected=3D0
+		fi
+		option=3D${option#^}
+
+		if echo $CHECK_MINFO | grep -w $option; then
+			findmnt -n -o OPTIONS $SCRATCH_DEV | grep $option
+			ret=3D$?
+		else
+			grep $option /proc/fs/ext4/$(basename $SCRATCH_DEV)/options
+			ret=3D$?
+		fi
+
+		if [ $ret -ne $expected ]; then
+			exit 1
+		fi
+	done
+	) > /dev/null 2>&1
+	return $?
+}
+
+fail() {
+	print_log "   FAILED"
+	ERR=3D$((ERR+1))
+	echo $LOG | tee -a $seqres.full
+	LOG=3D""
+}
+
+ok() {
+	print_log "   OK"
+	echo $LOG >> $seqres.full
+	LOG=3D""
+}
+
+simple_mount() {
+	_mount $* >> $seqres.full 2>&1
+}
+
+# $1 - can hold -n option, if it does argumetns are shifted
+# $1 - options to test
+# $2 - if provided it's the option string to check for
+do_mnt() {
+	device=3D$SCRATCH_DEV
+	# If -n argument is provided do not specify $SCRATCH_DEV
+	# usefull for remount
+	if [ "$1" =3D=3D "-n" ]; then
+		unset device
+		shift
+	fi
+
+	if [ -z "$1" ]; then
+		simple_mount $device $SCRATCH_MNT
+		ret=3D$?
+	else
+		simple_mount -o $1 $device $SCRATCH_MNT
+		ret=3D$?
+	fi
+	if [ $ret -eq 0 ]; then
+		test_mnt $1 $2
+		ret=3D$?
+		[ $ret -ne 0 ] && print_log "(not found)"
+	else
+		print_log "(failed mount)"
+	fi
+
+	return $ret
+}
+
+not_mnt() {
+	print_log "SHOULD FAIL mounting $fstype \"$1\" "
+	do_mnt $@
+	if [ $? -eq 0 ]; then
+		fail
+	else
+		ok
+	fi
+	$UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
+}
+
+_mnt() {
+	print_log "mounting $fstype \"$1\" "
+	do_mnt $@
+	if [ $? -ne 0 ]; then
+		fail
+	else
+		ok
+	fi
+}
+
+mnt() {
+	_mnt $*
+	$UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
+}
+
+# $1 - options to mount with
+# $2 - options to remount with
+remount() {
+	# First do this specifying both dev and mnt
+	print_log "mounting $fstype \"$1\" "
+	do_mnt $1
+	[ $? -ne 0 ] && fail && return
+	print_log "remounting \"$2\" "
+	do_mnt remount,$2 $3
+	if [ $? -ne 0 ]; then
+		fail
+		$UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
+		return
+	else
+		ok
+	fi
+	$UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
+
+	# Now just specify mnt
+	print_log "mounting $fstype \"$1\" "
+	do_mnt $1
+	[ $? -ne 0 ] && fail && return
+	print_log "remounting (MNT ONLY) \"$2\" "
+	do_mnt -n remount,$2 $3
+	if [ $? -ne 0 ]; then
+		fail
+	else
+		ok
+	fi
+
+	$UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
+}
+
+# $1 - options to mount with, or -r argument
+# $2 - options to remount with
+_not_remount() {
+	remount_only=3D0
+	# If -r is specified we're going to do remount only
+	if [ "$1" =3D=3D "-r" ]; then
+		remount_only=3D1
+		# Dont need shift since first argument would
+		# have been consumed by mount anyway
+	fi
+
+	if [ $remount_only -eq 0 ]; then
+		print_log "mounting $fstype \"$1\" "
+		do_mnt $1
+		[ $? -ne 0 ] && fail && return
+	fi
+	print_log "SHOULD FAIL remounting $fstype \"$2\" "
+	do_mnt remount,$2 $3
+	if [ $? -eq 0 ]; then
+		fail
+	else
+		ok
+	fi
+
+	# Now just specify mnt
+	print_log "SHOULD FAIL remounting $fstype (MNT ONLY) \"$2\" "
+	do_mnt -n remount,$2 $3
+	if [ $? -eq 0 ]; then
+		fail
+	else
+		ok
+	fi
+}
+
+not_remount() {
+	_not_remount $*
+	$UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
+}
+
+
+do_mkfs() {
+	mke2fs -T $fstype -Fq $* >> $seqres.full 2>&1 ||
+	_fail "mkfs failed - $MKFS_EXT4_PROG -Fq $* $SCRATCH_DEV"
+}
+
+not_ext2() {
+	if [[ $fstype =3D=3D "ext2" ]]; then
+		not_$*
+	else
+		$*
+	fi
+}
+
+only_ext4() {
+	if [[ $fstype =3D=3D "ext4" ]]; then
+		$*
+	else
+		not_$*
+	fi
+}
+
+# Create logdev for external journal
+LOOP_IMG=3D$tmp.logdev
+truncate -s 100M $LOOP_IMG
+LOOP_LOGDEV=3D`_create_loop_device $LOOP_IMG`
+majmin=3D`stat -c "%t:%T" $LOOP_LOGDEV`
+LOGDEV_DEVNUM=3D`echo "${majmin%:*}*2^8 + ${majmin#*:}" | bc`
+
+# Test all the extN file system supported by ext4 driver
+fstype=3D
+for fstype in ext2 ext3 ext4; do
+
+	$UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
+	$UMOUNT_PROG $SCRATCH_DEV 2> /dev/null
+
+	do_mkfs $SCRATCH_DEV
+
+	# do we have fstype support ?
+	do_mnt
+	if [ $? -ne 0 ]; then
+		print_log "$fstype not supported. Skipping..."
+		ok
+		continue
+	fi
+	$UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
+
+	not_mnt failme
+	mnt
+	mnt bsddf
+	mnt minixdf
+	mnt grpid
+	mnt bsdgroups grpid
+	mnt nogrpid
+	mnt sysvgroups nogrpid
+	mnt resgid=3D1001
+	mnt resuid=3D1001
+	mnt sb=3D131072
+	mnt errors=3Dcontinue
+	mnt errors=3Dpanic
+	mnt errors=3Dremount-ro
+	mnt nouid32
+	mnt debug
+	mnt oldalloc removed
+	mnt orlov removed
+	mnt user_xattr
+	mnt nouser_xattr
+	not_ext2 mnt noload norecovery
+	mnt bh removed
+	mnt nobh removed
+	not_ext2 mnt commit=3D7
+	mnt min_batch_time=3D200
+	mnt max_batch_time=3D10000
+	only_ext4 mnt journal_checksum
+	only_ext4 mnt nojournal_checksum
+	only_ext4 mnt journal_async_commit,data=3Dwriteback
+	mnt abort ignored
+	not_ext2 mnt data=3Djournal
+	not_ext2 mnt data=3Dordered
+	not_ext2 mnt data=3Dwriteback
+	not_ext2 mnt data_err=3Dabort
+	not_ext2 mnt data_err=3Dignore ignored
+	mnt usrjquota=3Daquota.user,jqfmt=3Dvfsv0
+	not_mnt usrjquota=3Daquota.user
+	mnt usrjquota=3D ignored
+	mnt grpjquota=3Daquota.group,jqfmt=3Dvfsv0
+	not_mnt grpjquota=3Daquota.group
+	mnt grpjquota=3D ignored
+	mnt jqfmt=3Dvfsold
+	mnt jqfmt=3Dvfsv0
+	mnt jqfmt=3Dvfsv1
+	mnt grpquota
+	mnt quota
+	mnt noquota
+	mnt usrquota
+	mnt grpquota
+	mnt barrier
+	mnt barrier=3D0 nobarrier
+	mnt barrier=3D1 barrier
+	mnt barrier=3D99 barrier
+	mnt nobarrier
+	mnt i_version
+	#mnt dax
+	mnt stripe=3D512
+	only_ext4 mnt delalloc
+	only_ext4 mnt nodelalloc
+	mnt warn_on_error
+	mnt nowarn_on_error
+	mnt lazytime
+	mnt nolazytime ^lazytime
+	not_mnt debug_want_extra_isize=3D512
+	mnt debug_want_extra_isize=3D32 ignored
+	mnt mblk_io_submit removed
+	mnt nomblk_io_submit removed
+	mnt block_validity
+	mnt noblock_validity
+	mnt inode_readahead_blks=3D16
+	not_ext2 mnt journal_ioprio=3D6 ignored
+	mnt auto_da_alloc=3D0 noauto_da_alloc
+	mnt auto_da_alloc=3D1 auto_da_alloc
+	mnt auto_da_alloc=3D95 auto_da_alloc
+	mnt auto_da_alloc
+	mnt noauto_da_alloc
+	only_ext4 mnt dioread_nolock
+	kernel_gte 5.6 && only_ext4 mnt nodioread_nolock
+	kernel_gte 5.6 && only_ext4 mnt dioread_lock nodioread_nolock
+	mnt discard
+	mnt nodiscard
+	mnt init_itable=3D20
+	mnt init_itable
+	mnt init_itable=3D0
+	mnt noinit_itable
+	mnt max_dir_size_kb=3D4096
+	mnt test_dummy_encryption
+	mnt nombcache
+	mnt no_mbcache nombcache
+	mnt check=3Dnone removed
+	mnt nocheck removed
+	mnt reservation removed
+	mnt noreservation removed
+	not_mnt journal=3D20
+	not_mnt nonsenseoption
+	not_mnt nonsenseoption=3Dvalue
+
+	# generic remount check
+	remount barrier nobarrier
+	remount nobarrier barrier
+	remount discard nodiscard
+	remount nodiscard discard
+
+	# Quota remount check
+	remount grpquota usrquota
+	remount usrquota quota
+	remount usrquota usrjquota=3Dq.u,jqfmt=3Dvfsv0
+	remount grpquota grpjquota=3Dq.g,jqfmt=3Dvfsv0
+
+	not_remount usrquota grpjquota=3Dq.g,jqfmt=3Dvfsv0
+	not_remount grpquota usrjquota=3Dq.u,jqfmt=3Dvfsv0
+
+	remount quota usrjquota=3Dq.u,jqfmt=3Dvfsv0
+	not_remount quota grpjquota=3Dq.g,jqfmt=3Dvfsv0
+
+	remount usrjquota=3Dq.u,jqfmt=3Dvfsv0 grpjquota=3Dq.g
+	not_remount usrjquota=3Dq.u,jqfmt=3Dvfsv0 usrjquota=3Dq.ua
+	not_remount grpjquota=3Dq.g,jqfmt=3Dvfsv0 grpjquota=3Dq.ga
+
+	remount usrjquota=3Dq.u,jqfmt=3Dvfsv0 usrquota usrjquota=3Dq.u,jqfmt=3D=
vfsv0
+	remount grpjquota=3Dq.g,jqfmt=3Dvfsv0 grpquota grpjquota=3Dq.g,jqfmt=3D=
vfsv0
+	not_remount usrjquota=3Dq.u,jqfmt=3Dvfsv0 grpquota
+	not_remount grpjquota=3Dq.g,jqfmt=3Dvfsv0 usrquota
+
+	remount grpjquota=3Dq.g,jqfmt=3Dvfsv0 grpjquota=3D ^grpjquota=3D
+	remount usrjquota=3Dq.u,jqfmt=3Dvfsv0 usrjquota=3D ^usrjquota=3D
+	remount grpjquota=3Dq.g,usrjquota=3Dq.u,jqfmt=3Dvfsv0 grpjquota=3D,usrj=
quota=3D ^grpjquota=3D,^usrjquota=3D
+
+	remount jqfmt=3Dvfsv0 grpjquota=3Dq.g
+	remount jqfmt=3Dvfsv0 usrjquota=3Dq.u
+
+	if [[ $fstype !=3D "ext2" ]]; then
+		remount noload data=3Djournal norecovery
+		not_remount data=3Dordered data=3Djournal
+		not_remount data=3Djournal data=3Dwriteback
+		not_remount data=3Dwriteback data=3Dordered
+	fi
+
+	do_mkfs -O journal_dev $LOOP_LOGDEV
+	do_mkfs -J device=3D$LOOP_LOGDEV $SCRATCH_DEV
+	mnt defaults
+	mnt journal_path=3D$LOOP_LOGDEV ignored
+	mnt journal_dev=3D$LOGDEV_DEVNUM ignored
+	not_mnt journal_path=3D${LOOP_LOGDEV}_nonexistent ignored
+	not_mnt journal_dev=3D123456 ignored
+	not_mnt journal_dev=3D999999999999999 ignored
+
+	do_mkfs -E quotatype=3Dprjquota $SCRATCH_DEV
+	mnt prjquota
+
+	# test clearing/changing journalled quota when enabled
+	echo "=3D=3D Testing active journalled quota" >> $seqres.full
+	_mnt prjquota,grpjquota=3Daquota.group,usrjquota=3Daquota.user,jqfmt=3D=
vfsv0
+
+	# Prepare and enable quota
+	quotacheck -vugm $SCRATCH_MNT >> $seqres.full 2>&1
+	quotaon -vug $SCRATCH_MNT >> $seqres.full 2>&1
+
+	_not_remount -r grpjquota=3D
+	_not_remount -r usrjquota=3Daaquota.user
+	_not_remount -r grpjquota=3Daaquota.group
+	_not_remount -r jqfmt=3Dvfsv1
+	_not_remount -r noquota
+	_mnt remount,usrquota,grpquota ^usrquota,^grpquota
+	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
+
+	# test clearing/changing quota when enabled
+	do_mkfs -E quotatype=3D^prjquota $SCRATCH_DEV
+	not_mnt prjquota
+	echo "=3D=3D Testing active non-journalled quota" >> $seqres.full
+	_mnt grpquota,usrquota
+
+	# Prepare and enable quota
+	quotacheck -vugm $SCRATCH_MNT >> $seqres.full 2>&1
+	quotaon -vug $SCRATCH_MNT >> $seqres.full 2>&1
+
+	_not_remount -r noquota
+	_not_remount -r usrjquota=3Daquota.user
+	_not_remount -r grpjquota=3Daquota.group
+	_not_remount -r jqfmt=3Dvfsv1
+	_mnt remount,grpjquota=3D grpquota,^grpjquota
+	_mnt remount,usrjquota=3D usrquota,^usrjquota
+	_mnt remount,usrquota,grpquota usrquota,grpquota
+	quotaoff -f $SCRATCH_MNT >> $seqres.full 2>&1
+	_mnt remount,noquota ^usrquota,^grpquota,quota
+	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
+
+	# Quota feature
+	echo "=3D=3D Testing quota feature " >> $seqres.full
+	do_mkfs -O quota -E quotatype=3Dprjquota $SCRATCH_DEV
+	mnt usrjquota=3Daquota.user,jqfmt=3Dvfsv0 ^usrjquota=3D
+	mnt grpjquota=3Daquota.user,jqfmt=3Dvfsv0 ^grpjquota=3D
+	mnt jqfmt=3Dvfsv1 ^jqfmt=3D
+	mnt prjquota
+	mnt usrquota
+	mnt grpquota
+	not_remount defaults usrjquota=3Daquota.user
+	not_remount defaults grpjquota=3Daquota.user
+	not_remount defaults jqfmt=3Dvfsv1
+	remount defaults grpjquota=3D,usrjquota=3D ignored
+
+done #for fstype in ext2 ext3 ext4; do
+
+$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
+echo "$ERR errors encountered" >> $seqres.full
+
+status=3D$ERR
+exit
diff --git a/tests/ext4/002.out b/tests/ext4/002.out
new file mode 100644
index 00000000..c1642bfd
--- /dev/null
+++ b/tests/ext4/002.out
@@ -0,0 +1,2 @@
+QA output created by 002
+Silence is golden.
diff --git a/tests/ext4/group b/tests/ext4/group
index a1adc553..b0aa781a 100644
--- a/tests/ext4/group
+++ b/tests/ext4/group
@@ -4,6 +4,7 @@
 # - comment line before each group is "new" description
 #
 001 auto prealloc quick zero
+002 auto mount
 003 auto quick
 004 auto dump
 005 auto quick metadata ioctl rw
--=20
2.21.1

