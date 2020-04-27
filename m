Return-Path: <SRS0=187c=6L=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0B1C55199
	for <linux-fstests@archiver.kernel.org>; Mon, 27 Apr 2020 09:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40FC6206B6
	for <linux-fstests@archiver.kernel.org>; Mon, 27 Apr 2020 09:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W3D24oMs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgD0Jfc (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 27 Apr 2020 05:35:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43860 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726003AbgD0Jfc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 27 Apr 2020 05:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587980128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dl6Bgl6ulpEps1Me86gEYo/nB3Zcixpnczs7D2avJyE=;
        b=W3D24oMsLoMlv4xD8hudxu7kD89dOZI6Aq1YuIbSmJNlTZUyvFpK2gzW1/DmRJR37m1Fzl
        G3YlN3VOeGWrfvEU75wAGu9hZoGjOpEAZ6RIq10RvTkHurroAnCA5srB33Vyjn7KSP4SF2
        HhqKF7ZziNJCJrqiquIjOqW/WewlMrk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-MPeG0f6AMR6xZJKTFnKdvw-1; Mon, 27 Apr 2020 05:35:23 -0400
X-MC-Unique: MPeG0f6AMR6xZJKTFnKdvw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0C87EC1A1
        for <fstests@vger.kernel.org>; Mon, 27 Apr 2020 09:35:22 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1027760CD3;
        Mon, 27 Apr 2020 09:35:21 +0000 (UTC)
Date:   Mon, 27 Apr 2020 17:48:02 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] ext4: ext4 mount sanity test
Message-ID: <20200427094802.GF14282@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: Lukas Czerner <lczerner@redhat.com>,
        fstests@vger.kernel.org
References: <20200422152012.28588-1-lczerner@redhat.com>
 <20200423111829.31657-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423111829.31657-1-lczerner@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Apr 23, 2020 at 01:18:29PM +0200, Lukas Czerner wrote:
> Add test to validate that the ext4 mount options are properly recognized,
> validated and applied to avoid regression as ext4 moves to the new mount
> API.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> ---

Hi Lukas,

How can I make this test run pass. I always get many errors[1] on upstream kernel
5.6. Is there a stable way to make it passed on most kernel version? I think an
important thing is making sure the test case stable.

Thanks,
Zorro

[1]
# ./check ext4/002
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 xxx-xxxxx-xx 5.6.0-rc5-xfs
MKFS_OPTIONS  -- /dev/mapper/testvg-scratchdev
MOUNT_OPTIONS -- -o acl,user_xattr -o context=system_u:object_r:root_t:s0 /dev/mapper/testvg-scratchdev /mnt/scratch                                                                          
                                                                                                                                                                                              
ext4/002        [failed, exit status 1]- output mismatch (see /root/git/xfstests-dev/results//ext4/002.out.bad)                                                                               
    --- tests/ext4/002.out      2020-04-26 13:43:33.867689308 +0800                                                                                                                           
    +++ /root/git/xfstests-dev/results//ext4/002.out.bad        2020-04-26 13:44:22.670986282 +0800                                                                                           
    @@ -1,2 +1,83 @@
     QA output created by 002
     Silence is golden.                                                                                                                                                                       
    +mounting ext2 "bsddf" checking "bsddf" (not found) FAILED
    +mounting ext2 "minixdf" checking "minixdf" (not found) FAILED
    +mounting ext2 "grpid" checking "grpid" (not found) FAILED
    +mounting ext2 "bsdgroups" checking "grpid" (not found) FAILED
    +mounting ext2 "nogrpid" checking "nogrpid" (not found) FAILED
    ...
    (Run 'diff -u /root/git/xfstests-dev/tests/ext4/002.out /root/git/xfstests-dev/results//ext4/002.out.bad'  to see the entire diff)                                                        
Ran: ext4/002
Failures: ext4/002
Failed 1 of 1 tests

> v2: ext4 driver can support ext3 and ext2 as well so check the
>     compatibility for those fs as well
> 
>  tests/ext4/002     | 509 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/002.out |   2 +
>  tests/ext4/group   |   1 +
>  3 files changed, 512 insertions(+)
>  create mode 100755 tests/ext4/002
>  create mode 100644 tests/ext4/002.out
> 
> diff --git a/tests/ext4/002 b/tests/ext4/002
> new file mode 100755
> index 00000000..eda4a2dd
> --- /dev/null
> +++ b/tests/ext4/002
> @@ -0,0 +1,509 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Red Hat, Inc., Lukas Czerner <lczerner@redhat.com>.
> +#
> +# FS QA Test 002
> +#
> +# Sanity check of ext4 mount options
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
> +	if [ -n "$LOOP_LOGDEV" ];then
> +		_destroy_loop_device $LOOP_LOGDEV 2>/dev/null
> +	fi
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/quota
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +echo "Silence is golden."
> +
> +_supported_fs ext2 ext3 ext4
> +_supported_os Linux
> +_require_scratch
> +_require_quota
> +_require_loop
> +
> +LOG=""
> +print_log() {
> +	LOG="$LOG $@"
> +}
> +
> +KERNEL_VERSION=`uname -r | cut -d'.' -f1,2`
> +kernel_gte() {
> +	gte=`echo "$KERNEL_VERSION >= $1" | $BC_PROG`
> +	[ $gte -eq 1 ] && return 0
> +	return 1
> +}
> +
> +# This test is only relevant for the newer kernel
> +kernel_gte 4.19 || _notrun "This test is only relevant for kernel versions 5.7 and higher"
> +
> +IGNORED="remount,defaults,ignored,removed"
> +CHECK_MINFO="lazytime"
> +ERR=0
> +
> +test_mnt() {
> +	findmnt -n $SCRATCH_DEV > /dev/null 2>&1
> +	[ $? -ne 0 ] && return $?
> +
> +	if [ $# -eq 1 ]; then
> +		OPTS=$1
> +	elif [ $# -eq 2 ]; then
> +		OPTS=$2
> +	else
> +		return 0
> +	fi
> +
> +	print_log "checking \"$OPTS\" "
> +	# test options in /proc/fs/ext4/dev/options
> +	(
> +	ret=0
> +	IFS=','
> +	for option in $OPTS; do
> +		if echo $IGNORED | grep -w $option; then
> +			continue
> +		fi
> +
> +		[ $option = "noload" ] && option="norecovery"
> +
> +		if [[ $option = ^* ]]; then
> +			expected=1
> +		else
> +			expected=0
> +		fi
> +		option=${option#^}
> +
> +		if echo $CHECK_MINFO | grep -w $option; then
> +			findmnt -n -o OPTIONS $SCRATCH_DEV | grep $option
> +			ret=$?
> +		else
> +			grep $option /proc/fs/ext4/$(basename $SCRATCH_DEV)/options
> +			ret=$?
> +		fi
> +
> +		if [ $ret -ne $expected ]; then
> +			exit 1
> +		fi
> +	done
> +	) > /dev/null 2>&1
> +	return $?
> +}
> +
> +fail() {
> +	print_log "   FAILED"
> +	ERR=$((ERR+1))
> +	echo $LOG | tee -a $seqres.full
> +	LOG=""
> +}
> +
> +ok() {
> +	print_log "   OK"
> +	echo $LOG >> $seqres.full
> +	LOG=""
> +}
> +
> +simple_mount() {
> +	_mount $* >> $seqres.full 2>&1
> +}
> +
> +# $1 - can hold -n option, if it does argumetns are shifted
> +# $1 - options to test
> +# $2 - if provided it's the option string to check for
> +do_mnt() {
> +	device=$SCRATCH_DEV
> +	# If -n argument is provided do not specify $SCRATCH_DEV
> +	# usefull for remount
> +	if [ "$1" == "-n" ]; then
> +		unset device
> +		shift
> +	fi
> +
> +	if [ -z "$1" ]; then
> +		simple_mount $device $SCRATCH_MNT
> +		ret=$?
> +	else
> +		simple_mount -o $1 $device $SCRATCH_MNT
> +		ret=$?
> +	fi
> +	if [ $ret -eq 0 ]; then
> +		test_mnt $1 $2
> +		ret=$?
> +		[ $ret -ne 0 ] && print_log "(not found)"
> +	else
> +		print_log "(failed mount)"
> +	fi
> +
> +	return $ret
> +}
> +
> +not_mnt() {
> +	print_log "SHOULD FAIL mounting $fstype \"$1\" "
> +	do_mnt $@
> +	if [ $? -eq 0 ]; then
> +		fail
> +	else
> +		ok
> +	fi
> +	$UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
> +}
> +
> +_mnt() {
> +	print_log "mounting $fstype \"$1\" "
> +	do_mnt $@
> +	if [ $? -ne 0 ]; then
> +		fail
> +	else
> +		ok
> +	fi
> +}
> +
> +mnt() {
> +	_mnt $*
> +	$UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
> +}
> +
> +# $1 - options to mount with
> +# $2 - options to remount with
> +remount() {
> +	# First do this specifying both dev and mnt
> +	print_log "mounting $fstype \"$1\" "
> +	do_mnt $1
> +	[ $? -ne 0 ] && fail && return
> +	print_log "remounting \"$2\" "
> +	do_mnt remount,$2 $3
> +	if [ $? -ne 0 ]; then
> +		fail
> +		$UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
> +		return
> +	else
> +		ok
> +	fi
> +	$UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
> +
> +	# Now just specify mnt
> +	print_log "mounting $fstype \"$1\" "
> +	do_mnt $1
> +	[ $? -ne 0 ] && fail && return
> +	print_log "remounting (MNT ONLY) \"$2\" "
> +	do_mnt -n remount,$2 $3
> +	if [ $? -ne 0 ]; then
> +		fail
> +	else
> +		ok
> +	fi
> +
> +	$UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
> +}
> +
> +# $1 - options to mount with, or -r argument
> +# $2 - options to remount with
> +_not_remount() {
> +	remount_only=0
> +	# If -r is specified we're going to do remount only
> +	if [ "$1" == "-r" ]; then
> +		remount_only=1
> +		# Dont need shift since first argument would
> +		# have been consumed by mount anyway
> +	fi
> +
> +	if [ $remount_only -eq 0 ]; then
> +		print_log "mounting $fstype \"$1\" "
> +		do_mnt $1
> +		[ $? -ne 0 ] && fail && return
> +	fi
> +	print_log "SHOULD FAIL remounting $fstype \"$2\" "
> +	do_mnt remount,$2 $3
> +	if [ $? -eq 0 ]; then
> +		fail
> +	else
> +		ok
> +	fi
> +
> +	# Now just specify mnt
> +	print_log "SHOULD FAIL remounting $fstype (MNT ONLY) \"$2\" "
> +	do_mnt -n remount,$2 $3
> +	if [ $? -eq 0 ]; then
> +		fail
> +	else
> +		ok
> +	fi
> +}
> +
> +not_remount() {
> +	_not_remount $*
> +	$UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
> +}
> +
> +
> +do_mkfs() {
> +	mke2fs -T $fstype -Fq $* >> $seqres.full 2>&1 ||
> +	_fail "mkfs failed - $MKFS_EXT4_PROG -Fq $* $SCRATCH_DEV"
> +}
> +
> +not_ext2() {
> +	if [[ $fstype == "ext2" ]]; then
> +		not_$*
> +	else
> +		$*
> +	fi
> +}
> +
> +only_ext4() {
> +	if [[ $fstype == "ext4" ]]; then
> +		$*
> +	else
> +		not_$*
> +	fi
> +}
> +
> +# Create logdev for external journal
> +LOOP_IMG=$tmp.logdev
> +truncate -s 100M $LOOP_IMG
> +LOOP_LOGDEV=`_create_loop_device $LOOP_IMG`
> +majmin=`stat -c "%t:%T" $LOOP_LOGDEV`
> +LOGDEV_DEVNUM=`echo "${majmin%:*}*2^8 + ${majmin#*:}" | bc`
> +
> +# Test all the extN file system supported by ext4 driver
> +fstype=
> +for fstype in ext2 ext3 ext4; do
> +
> +	$UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
> +	$UMOUNT_PROG $SCRATCH_DEV 2> /dev/null
> +
> +	do_mkfs $SCRATCH_DEV
> +
> +	# do we have fstype support ?
> +	do_mnt
> +	if [ $? -ne 0 ]; then
> +		print_log "$fstype not supported. Skipping..."
> +		ok
> +		continue
> +	fi
> +	$UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
> +
> +	not_mnt failme
> +	mnt
> +	mnt bsddf
> +	mnt minixdf
> +	mnt grpid
> +	mnt bsdgroups grpid
> +	mnt nogrpid
> +	mnt sysvgroups nogrpid
> +	mnt resgid=1001
> +	mnt resuid=1001
> +	mnt sb=131072
> +	mnt errors=continue
> +	mnt errors=panic
> +	mnt errors=remount-ro
> +	mnt nouid32
> +	mnt debug
> +	mnt oldalloc removed
> +	mnt orlov removed
> +	mnt user_xattr
> +	mnt nouser_xattr
> +	not_ext2 mnt noload norecovery
> +	mnt bh removed
> +	mnt nobh removed
> +	not_ext2 mnt commit=7
> +	mnt min_batch_time=200
> +	mnt max_batch_time=10000
> +	only_ext4 mnt journal_checksum
> +	only_ext4 mnt nojournal_checksum
> +	only_ext4 mnt journal_async_commit,data=writeback
> +	mnt abort ignored
> +	not_ext2 mnt data=journal
> +	not_ext2 mnt data=ordered
> +	not_ext2 mnt data=writeback
> +	not_ext2 mnt data_err=abort
> +	not_ext2 mnt data_err=ignore ignored
> +	mnt usrjquota=aquota.user,jqfmt=vfsv0
> +	not_mnt usrjquota=aquota.user
> +	mnt usrjquota= ignored
> +	mnt grpjquota=aquota.group,jqfmt=vfsv0
> +	not_mnt grpjquota=aquota.group
> +	mnt grpjquota= ignored
> +	mnt jqfmt=vfsold
> +	mnt jqfmt=vfsv0
> +	mnt jqfmt=vfsv1
> +	mnt grpquota
> +	mnt quota
> +	mnt noquota
> +	mnt usrquota
> +	mnt grpquota
> +	mnt barrier
> +	mnt barrier=0 nobarrier
> +	mnt barrier=1 barrier
> +	mnt barrier=99 barrier
> +	mnt nobarrier
> +	mnt i_version
> +	#mnt dax
> +	mnt stripe=512
> +	only_ext4 mnt delalloc
> +	only_ext4 mnt nodelalloc
> +	mnt warn_on_error
> +	mnt nowarn_on_error
> +	mnt lazytime
> +	mnt nolazytime ^lazytime
> +	not_mnt debug_want_extra_isize=512
> +	mnt debug_want_extra_isize=32 ignored
> +	mnt mblk_io_submit removed
> +	mnt nomblk_io_submit removed
> +	mnt block_validity
> +	mnt noblock_validity
> +	mnt inode_readahead_blks=16
> +	not_ext2 mnt journal_ioprio=6 ignored
> +	mnt auto_da_alloc=0 noauto_da_alloc
> +	mnt auto_da_alloc=1 auto_da_alloc
> +	mnt auto_da_alloc=95 auto_da_alloc
> +	mnt auto_da_alloc
> +	mnt noauto_da_alloc
> +	only_ext4 mnt dioread_nolock
> +	kernel_gte 5.6 && only_ext4 mnt nodioread_nolock
> +	kernel_gte 5.6 && only_ext4 mnt dioread_lock nodioread_nolock
> +	mnt discard
> +	mnt nodiscard
> +	mnt init_itable=20
> +	mnt init_itable
> +	mnt init_itable=0
> +	mnt noinit_itable
> +	mnt max_dir_size_kb=4096
> +	mnt test_dummy_encryption
> +	mnt nombcache
> +	mnt no_mbcache nombcache
> +	mnt check=none removed
> +	mnt nocheck removed
> +	mnt reservation removed
> +	mnt noreservation removed
> +	not_mnt journal=20
> +	not_mnt nonsenseoption
> +	not_mnt nonsenseoption=value
> +
> +	# generic remount check
> +	remount barrier nobarrier
> +	remount nobarrier barrier
> +	remount discard nodiscard
> +	remount nodiscard discard
> +
> +	# Quota remount check
> +	remount grpquota usrquota
> +	remount usrquota quota
> +	remount usrquota usrjquota=q.u,jqfmt=vfsv0
> +	remount grpquota grpjquota=q.g,jqfmt=vfsv0
> +
> +	not_remount usrquota grpjquota=q.g,jqfmt=vfsv0
> +	not_remount grpquota usrjquota=q.u,jqfmt=vfsv0
> +
> +	remount quota usrjquota=q.u,jqfmt=vfsv0
> +	not_remount quota grpjquota=q.g,jqfmt=vfsv0
> +
> +	remount usrjquota=q.u,jqfmt=vfsv0 grpjquota=q.g
> +	not_remount usrjquota=q.u,jqfmt=vfsv0 usrjquota=q.ua
> +	not_remount grpjquota=q.g,jqfmt=vfsv0 grpjquota=q.ga
> +
> +	remount usrjquota=q.u,jqfmt=vfsv0 usrquota usrjquota=q.u,jqfmt=vfsv0
> +	remount grpjquota=q.g,jqfmt=vfsv0 grpquota grpjquota=q.g,jqfmt=vfsv0
> +	not_remount usrjquota=q.u,jqfmt=vfsv0 grpquota
> +	not_remount grpjquota=q.g,jqfmt=vfsv0 usrquota
> +
> +	remount grpjquota=q.g,jqfmt=vfsv0 grpjquota= ^grpjquota=
> +	remount usrjquota=q.u,jqfmt=vfsv0 usrjquota= ^usrjquota=
> +	remount grpjquota=q.g,usrjquota=q.u,jqfmt=vfsv0 grpjquota=,usrjquota= ^grpjquota=,^usrjquota=
> +
> +	remount jqfmt=vfsv0 grpjquota=q.g
> +	remount jqfmt=vfsv0 usrjquota=q.u
> +
> +	if [[ $fstype != "ext2" ]]; then
> +		remount noload data=journal norecovery
> +		not_remount data=ordered data=journal
> +		not_remount data=journal data=writeback
> +		not_remount data=writeback data=ordered
> +	fi
> +
> +	do_mkfs -O journal_dev $LOOP_LOGDEV
> +	do_mkfs -J device=$LOOP_LOGDEV $SCRATCH_DEV
> +	mnt defaults
> +	mnt journal_path=$LOOP_LOGDEV ignored
> +	mnt journal_dev=$LOGDEV_DEVNUM ignored
> +	not_mnt journal_path=${LOOP_LOGDEV}_nonexistent ignored
> +	not_mnt journal_dev=123456 ignored
> +	not_mnt journal_dev=999999999999999 ignored
> +
> +	do_mkfs -E quotatype=prjquota $SCRATCH_DEV
> +	mnt prjquota
> +
> +	# test clearing/changing journalled quota when enabled
> +	echo "== Testing active journalled quota" >> $seqres.full
> +	_mnt prjquota,grpjquota=aquota.group,usrjquota=aquota.user,jqfmt=vfsv0
> +
> +	# Prepare and enable quota
> +	quotacheck -vugm $SCRATCH_MNT >> $seqres.full 2>&1
> +	quotaon -vug $SCRATCH_MNT >> $seqres.full 2>&1
> +
> +	_not_remount -r grpjquota=
> +	_not_remount -r usrjquota=aaquota.user
> +	_not_remount -r grpjquota=aaquota.group
> +	_not_remount -r jqfmt=vfsv1
> +	_not_remount -r noquota
> +	_mnt remount,usrquota,grpquota ^usrquota,^grpquota
> +	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
> +
> +	# test clearing/changing quota when enabled
> +	do_mkfs -E quotatype=^prjquota $SCRATCH_DEV
> +	not_mnt prjquota
> +	echo "== Testing active non-journalled quota" >> $seqres.full
> +	_mnt grpquota,usrquota
> +
> +	# Prepare and enable quota
> +	quotacheck -vugm $SCRATCH_MNT >> $seqres.full 2>&1
> +	quotaon -vug $SCRATCH_MNT >> $seqres.full 2>&1
> +
> +	_not_remount -r noquota
> +	_not_remount -r usrjquota=aquota.user
> +	_not_remount -r grpjquota=aquota.group
> +	_not_remount -r jqfmt=vfsv1
> +	_mnt remount,grpjquota= grpquota,^grpjquota
> +	_mnt remount,usrjquota= usrquota,^usrjquota
> +	_mnt remount,usrquota,grpquota usrquota,grpquota
> +	quotaoff -f $SCRATCH_MNT >> $seqres.full 2>&1
> +	_mnt remount,noquota ^usrquota,^grpquota,quota
> +	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
> +
> +	# Quota feature
> +	echo "== Testing quota feature " >> $seqres.full
> +	do_mkfs -O quota -E quotatype=prjquota $SCRATCH_DEV
> +	mnt usrjquota=aquota.user,jqfmt=vfsv0 ^usrjquota=
> +	mnt grpjquota=aquota.user,jqfmt=vfsv0 ^grpjquota=
> +	mnt jqfmt=vfsv1 ^jqfmt=
> +	mnt prjquota
> +	mnt usrquota
> +	mnt grpquota
> +	not_remount defaults usrjquota=aquota.user
> +	not_remount defaults grpjquota=aquota.user
> +	not_remount defaults jqfmt=vfsv1
> +	remount defaults grpjquota=,usrjquota= ignored
> +
> +done #for fstype in ext2 ext3 ext4; do
> +
> +$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
> +echo "$ERR errors encountered" >> $seqres.full
> +
> +status=$ERR
> +exit
> diff --git a/tests/ext4/002.out b/tests/ext4/002.out
> new file mode 100644
> index 00000000..c1642bfd
> --- /dev/null
> +++ b/tests/ext4/002.out
> @@ -0,0 +1,2 @@
> +QA output created by 002
> +Silence is golden.
> diff --git a/tests/ext4/group b/tests/ext4/group
> index a1adc553..b0aa781a 100644
> --- a/tests/ext4/group
> +++ b/tests/ext4/group
> @@ -4,6 +4,7 @@
>  # - comment line before each group is "new" description
>  #
>  001 auto prealloc quick zero
> +002 auto mount
>  003 auto quick
>  004 auto dump
>  005 auto quick metadata ioctl rw
> -- 
> 2.21.1
> 

