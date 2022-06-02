Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582F0C43334
	for <linux-fstests@archiver.kernel.org>; Thu,  2 Jun 2022 01:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbiFBBFY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Jun 2022 21:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbiFBBFX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Jun 2022 21:05:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF0626EE9E
        for <fstests@vger.kernel.org>; Wed,  1 Jun 2022 18:05:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB8F6615B6
        for <fstests@vger.kernel.org>; Thu,  2 Jun 2022 01:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545C5C385A5;
        Thu,  2 Jun 2022 01:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654131919;
        bh=EbIfzAwxJzdf6gZIm6hHdlDi81giljh3d6nRABiX+Q4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mnFQPlCE2/0paQ63d5XauObzm688bYuz+v8ScTdw/+SYlJb+FB+sDjNeQDdOfn7uq
         vItMPSUXdH+YUBjJKc3I6lVWZ1NRFCy009K9BRu0Jc8g54unJysl1LbgNJEvi356ux
         5ezn1plKm+f/MDSUoq34FQMzNh9F5/bBKh09Jc8hDFQ5epCMjXedixh8wlGOxDuXus
         juy5+5xfKedEfgAgiUowuA5lKDHNzyY8hd8CiJHvlkH9P9HbC3XIsvnYga7AixLNP6
         /5d5JCNazQ/jy/mjOufWy04Q1qvUNPnjNoNAGiIdcpMnJXmICjiFk4BBVEpVUffbJC
         z0xUzKvOFJxNw==
Date:   Wed, 1 Jun 2022 18:05:18 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/8] xfstests: Add Log Attribute Replay test
Message-ID: <YpgMzoX0W/t1m1DC@magnolia>
References: <20220602003126.2903779-1-david@fromorbit.com>
 <20220602003126.2903779-2-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602003126.2903779-2-david@fromorbit.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jun 02, 2022 at 10:31:19AM +1000, Dave Chinner wrote:
> From: Allison Henderson <allison.henderson@oracle.com>
> 
> This patch adds tests to exercise the log attribute error
> inject and log replay. These tests aim to cover cases where attributes
> are added, removed, and overwritten in each format (shortform, leaf,
> node). Error inject is used to replay these operations from the log.
> 
> dchinner: sanitise md5sum input to just attr values.
> dchinner: correct md5sums.
> dchinner: ensure replace tests use different values so recovery can
>           determine the replace was replayed correctly.
> dchinner: don't remove corpse in _cleanup - scratch devices don't
> 	  require cleanup, and if the test fails we want to leave
> 	  the broken state for post-mortem analysis.
> dchinner: only run on v5 filesystems.
> 
> Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
> Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  tests/xfs/600     | 179 +++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/600.out | 188 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 367 insertions(+)
>  create mode 100755 tests/xfs/600
>  create mode 100644 tests/xfs/600.out
> 
> diff --git a/tests/xfs/600 b/tests/xfs/600
> new file mode 100755
> index 00000000..0ff41e13
> --- /dev/null
> +++ b/tests/xfs/600
> @@ -0,0 +1,179 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022, Oracle and/or its affiliates.  All Rights Reserved.
> +#
> +# FS QA Test 600
> +#
> +# Log attribute replay test
> +#
> +. ./common/preamble
> +_begin_fstest auto quick attr
> +
> +# get standard environment, filters and checks
> +. ./common/filter
> +. ./common/attr
> +. ./common/inject
> +
> +_cleanup()
> +{
> +	rm -rf $tmp.*
> +	test -w /sys/fs/xfs/debug/larp && \
> +		echo 0 > /sys/fs/xfs/debug/larp
> +}
> +
> +test_attr_replay()
> +{
> +	testfile=$testdir/$1
> +	attr_name=$2
> +	attr_value=$3
> +	flag=$4
> +	error_tag=$5
> +
> +	# Inject error
> +	_scratch_inject_error $error_tag
> +
> +	# Set attribute
> +	echo "$attr_value" | ${ATTR_PROG} -$flag "$attr_name" $testfile 2>&1 | \
> +			    _filter_scratch
> +
> +	# FS should be shut down, touch will fail
> +	touch $testfile 2>&1 | _filter_scratch
> +
> +	# Remount to replay log
> +	_scratch_remount_dump_log >> $seqres.full
> +
> +	# FS should be online, touch should succeed
> +	touch $testfile
> +
> +	# Verify attr recovery
> +	$ATTR_PROG -l $testfile | _filter_scratch
> +	echo -n "$attr_name: "
> +	$ATTR_PROG -q -g $attr_name $testfile | md5sum;
> +
> +	echo ""
> +}
> +
> +create_test_file()
> +{
> +	filename=$testdir/$1
> +	count=$2
> +	attr_value=$3
> +
> +	touch $filename
> +
> +	for i in `seq $count`
> +	do
> +		$ATTR_PROG -s "attr_name$i" -V $attr_value $filename >> \
> +			$seqres.full
> +	done
> +}
> +
> +# real QA test starts here
> +_supported_fs xfs
> +
> +_require_scratch
> +_require_scratch_xfs_crc
> +_require_attrs
> +_require_xfs_io_error_injection "larp"
> +_require_xfs_io_error_injection "da_leaf_split"
> +_require_xfs_io_error_injection "attr_leaf_to_node"
> +_require_xfs_sysfs debug/larp
> +test -w /sys/fs/xfs/debug/larp || _notrun "larp knob not writable"
> +
> +# turn on log attributes
> +echo 1 > /sys/fs/xfs/debug/larp
> +
> +attr16="0123456789ABCDEF"
> +attr64="$attr16$attr16$attr16$attr16"
> +attr256="$attr64$attr64$attr64$attr64"
> +attr1k="$attr256$attr256$attr256$attr256"
> +attr4k="$attr1k$attr1k$attr1k$attr1k"
> +attr8k="$attr4k$attr4k"
> +attr16k="$attr8k$attr8k"
> +attr32k="$attr16k$attr16k"
> +attr64k="$attr32k$attr32k"
> +
> +echo "*** mkfs"
> +_scratch_mkfs >/dev/null
> +
> +echo "*** mount FS"
> +_scratch_mount
> +
> +testdir=$SCRATCH_MNT/testdir
> +mkdir $testdir
> +
> +# empty, inline
> +create_test_file empty_file1 0
> +test_attr_replay empty_file1 "attr_name" $attr64 "s" "larp"
> +test_attr_replay empty_file1 "attr_name" $attr64 "r" "larp"
> +
> +# empty, internal
> +create_test_file empty_file2 0
> +test_attr_replay empty_file2 "attr_name" $attr1k "s" "larp"
> +test_attr_replay empty_file2 "attr_name" $attr1k "r" "larp"
> +
> +# empty, remote
> +create_test_file empty_file3 0
> +test_attr_replay empty_file3 "attr_name" $attr64k "s" "larp"
> +test_attr_replay empty_file3 "attr_name" $attr64k "r" "larp"
> +
> +# inline, inline
> +create_test_file inline_file1 1 $attr16
> +test_attr_replay inline_file1 "attr_name2" $attr64 "s" "larp"
> +test_attr_replay inline_file1 "attr_name2" $attr64 "r" "larp"
> +
> +# inline, internal
> +create_test_file inline_file2 1 $attr16
> +test_attr_replay inline_file2 "attr_name2" $attr1k "s" "larp"
> +test_attr_replay inline_file2 "attr_name2" $attr1k "r" "larp"
> +
> +# inline, remote
> +create_test_file inline_file3 1 $attr16
> +test_attr_replay inline_file3 "attr_name2" $attr64k "s" "larp"
> +test_attr_replay inline_file3 "attr_name2" $attr64k "r" "larp"
> +
> +# extent, internal
> +create_test_file extent_file1 1 $attr1k
> +test_attr_replay extent_file1 "attr_name2" $attr1k "s" "larp"
> +test_attr_replay extent_file1 "attr_name2" $attr1k "r" "larp"
> +
> +# extent, inject error on split
> +create_test_file extent_file2 3 $attr1k
> +test_attr_replay extent_file2 "attr_name4" $attr1k "s" "da_leaf_split"
> +
> +# extent, inject error on fork transition
> +create_test_file extent_file3 3 $attr1k
> +test_attr_replay extent_file3 "attr_name4" $attr1k "s" "attr_leaf_to_node"
> +
> +# extent, remote
> +create_test_file extent_file4 1 $attr1k
> +test_attr_replay extent_file4 "attr_name2" $attr64k "s" "larp"
> +test_attr_replay extent_file4 "attr_name2" $attr64k "r" "larp"
> +
> +# remote, internal
> +create_test_file remote_file1 1 $attr64k
> +test_attr_replay remote_file1 "attr_name2" $attr1k "s" "larp"
> +test_attr_replay remote_file1 "attr_name2" $attr1k "r" "larp"
> +
> +# remote, remote
> +create_test_file remote_file2 1 $attr64k
> +test_attr_replay remote_file2 "attr_name2" $attr64k "s" "larp"
> +test_attr_replay remote_file2 "attr_name2" $attr64k "r" "larp"
> +
> +# replace shortform with different value
> +create_test_file sf_file 2 $attr64
> +test_attr_replay sf_file "attr_name2" $attr16 "s" "larp"
> +
> +# replace leaf with different value
> +create_test_file leaf_file 3 $attr1k
> +test_attr_replay leaf_file "attr_name2" $attr256 "s" "larp"
> +
> +# replace node with a different value
> +create_test_file node_file 1 $attr64k
> +$ATTR_PROG -s "attr_name2" -V $attr1k $testdir/node_file \
> +		>> $seqres.full
> +test_attr_replay node_file "attr_name2" $attr256 "s" "larp"
> +
> +echo "*** done"
> +status=0
> +exit
> diff --git a/tests/xfs/600.out b/tests/xfs/600.out
> new file mode 100644
> index 00000000..fe25ea3e
> --- /dev/null
> +++ b/tests/xfs/600.out
> @@ -0,0 +1,188 @@
> +QA output created by 600
> +*** mkfs
> +*** mount FS
> +attr_set: Input/output error
> +Could not set "attr_name" for SCRATCH_MNT/testdir/empty_file1
> +touch: cannot touch 'SCRATCH_MNT/testdir/empty_file1': Input/output error
> +Attribute "attr_name" has a 65 byte value for SCRATCH_MNT/testdir/empty_file1
> +attr_name: cfbe2a33be4601d2b655d099a18378fc  -
> +
> +attr_remove: Input/output error
> +Could not remove "attr_name" for SCRATCH_MNT/testdir/empty_file1
> +touch: cannot touch 'SCRATCH_MNT/testdir/empty_file1': Input/output error
> +attr_name: attr_get: No data available
> +Could not get "attr_name" for /mnt/scratch/testdir/empty_file1

SCRATCH_MNT, not /mnt/scratch?

--D

> +d41d8cd98f00b204e9800998ecf8427e  -
> +
> +attr_set: Input/output error
> +Could not set "attr_name" for SCRATCH_MNT/testdir/empty_file2
> +touch: cannot touch 'SCRATCH_MNT/testdir/empty_file2': Input/output error
> +Attribute "attr_name" has a 1025 byte value for SCRATCH_MNT/testdir/empty_file2
> +attr_name: 9fd415c49d67afc4b78fad4055a3a376  -
> +
> +attr_remove: Input/output error
> +Could not remove "attr_name" for SCRATCH_MNT/testdir/empty_file2
> +touch: cannot touch 'SCRATCH_MNT/testdir/empty_file2': Input/output error
> +attr_name: attr_get: No data available
> +Could not get "attr_name" for /mnt/scratch/testdir/empty_file2
> +d41d8cd98f00b204e9800998ecf8427e  -
> +
> +attr_set: Input/output error
> +Could not set "attr_name" for SCRATCH_MNT/testdir/empty_file3
> +touch: cannot touch 'SCRATCH_MNT/testdir/empty_file3': Input/output error
> +Attribute "attr_name" has a 65536 byte value for SCRATCH_MNT/testdir/empty_file3
> +attr_name: 7f6fd1b6d872108bd44bd143cbcdfa19  -
> +
> +attr_remove: Input/output error
> +Could not remove "attr_name" for SCRATCH_MNT/testdir/empty_file3
> +touch: cannot touch 'SCRATCH_MNT/testdir/empty_file3': Input/output error
> +attr_name: attr_get: No data available
> +Could not get "attr_name" for /mnt/scratch/testdir/empty_file3
> +d41d8cd98f00b204e9800998ecf8427e  -
> +
> +attr_set: Input/output error
> +Could not set "attr_name2" for SCRATCH_MNT/testdir/inline_file1
> +touch: cannot touch 'SCRATCH_MNT/testdir/inline_file1': Input/output error
> +Attribute "attr_name1" has a 16 byte value for SCRATCH_MNT/testdir/inline_file1
> +Attribute "attr_name2" has a 65 byte value for SCRATCH_MNT/testdir/inline_file1
> +attr_name2: cfbe2a33be4601d2b655d099a18378fc  -
> +
> +attr_remove: Input/output error
> +Could not remove "attr_name2" for SCRATCH_MNT/testdir/inline_file1
> +touch: cannot touch 'SCRATCH_MNT/testdir/inline_file1': Input/output error
> +Attribute "attr_name1" has a 16 byte value for SCRATCH_MNT/testdir/inline_file1
> +attr_name2: attr_get: No data available
> +Could not get "attr_name2" for /mnt/scratch/testdir/inline_file1
> +d41d8cd98f00b204e9800998ecf8427e  -
> +
> +attr_set: Input/output error
> +Could not set "attr_name2" for SCRATCH_MNT/testdir/inline_file2
> +touch: cannot touch 'SCRATCH_MNT/testdir/inline_file2': Input/output error
> +Attribute "attr_name2" has a 1025 byte value for SCRATCH_MNT/testdir/inline_file2
> +Attribute "attr_name1" has a 16 byte value for SCRATCH_MNT/testdir/inline_file2
> +attr_name2: 9fd415c49d67afc4b78fad4055a3a376  -
> +
> +attr_remove: Input/output error
> +Could not remove "attr_name2" for SCRATCH_MNT/testdir/inline_file2
> +touch: cannot touch 'SCRATCH_MNT/testdir/inline_file2': Input/output error
> +Attribute "attr_name1" has a 16 byte value for SCRATCH_MNT/testdir/inline_file2
> +attr_name2: attr_get: No data available
> +Could not get "attr_name2" for /mnt/scratch/testdir/inline_file2
> +d41d8cd98f00b204e9800998ecf8427e  -
> +
> +attr_set: Input/output error
> +Could not set "attr_name2" for SCRATCH_MNT/testdir/inline_file3
> +touch: cannot touch 'SCRATCH_MNT/testdir/inline_file3': Input/output error
> +Attribute "attr_name2" has a 65536 byte value for SCRATCH_MNT/testdir/inline_file3
> +Attribute "attr_name1" has a 16 byte value for SCRATCH_MNT/testdir/inline_file3
> +attr_name2: 7f6fd1b6d872108bd44bd143cbcdfa19  -
> +
> +attr_remove: Input/output error
> +Could not remove "attr_name2" for SCRATCH_MNT/testdir/inline_file3
> +touch: cannot touch 'SCRATCH_MNT/testdir/inline_file3': Input/output error
> +Attribute "attr_name1" has a 16 byte value for SCRATCH_MNT/testdir/inline_file3
> +attr_name2: attr_get: No data available
> +Could not get "attr_name2" for /mnt/scratch/testdir/inline_file3
> +d41d8cd98f00b204e9800998ecf8427e  -
> +
> +attr_set: Input/output error
> +Could not set "attr_name2" for SCRATCH_MNT/testdir/extent_file1
> +touch: cannot touch 'SCRATCH_MNT/testdir/extent_file1': Input/output error
> +Attribute "attr_name2" has a 1025 byte value for SCRATCH_MNT/testdir/extent_file1
> +Attribute "attr_name1" has a 1024 byte value for SCRATCH_MNT/testdir/extent_file1
> +attr_name2: 9fd415c49d67afc4b78fad4055a3a376  -
> +
> +attr_remove: Input/output error
> +Could not remove "attr_name2" for SCRATCH_MNT/testdir/extent_file1
> +touch: cannot touch 'SCRATCH_MNT/testdir/extent_file1': Input/output error
> +Attribute "attr_name1" has a 1024 byte value for SCRATCH_MNT/testdir/extent_file1
> +attr_name2: attr_get: No data available
> +Could not get "attr_name2" for /mnt/scratch/testdir/extent_file1
> +d41d8cd98f00b204e9800998ecf8427e  -
> +
> +attr_set: Input/output error
> +Could not set "attr_name4" for SCRATCH_MNT/testdir/extent_file2
> +touch: cannot touch 'SCRATCH_MNT/testdir/extent_file2': Input/output error
> +Attribute "attr_name4" has a 1025 byte value for SCRATCH_MNT/testdir/extent_file2
> +Attribute "attr_name2" has a 1024 byte value for SCRATCH_MNT/testdir/extent_file2
> +Attribute "attr_name3" has a 1024 byte value for SCRATCH_MNT/testdir/extent_file2
> +Attribute "attr_name1" has a 1024 byte value for SCRATCH_MNT/testdir/extent_file2
> +attr_name4: 9fd415c49d67afc4b78fad4055a3a376  -
> +
> +attr_set: Input/output error
> +Could not set "attr_name4" for SCRATCH_MNT/testdir/extent_file3
> +touch: cannot touch 'SCRATCH_MNT/testdir/extent_file3': Input/output error
> +Attribute "attr_name4" has a 1025 byte value for SCRATCH_MNT/testdir/extent_file3
> +Attribute "attr_name2" has a 1024 byte value for SCRATCH_MNT/testdir/extent_file3
> +Attribute "attr_name3" has a 1024 byte value for SCRATCH_MNT/testdir/extent_file3
> +Attribute "attr_name1" has a 1024 byte value for SCRATCH_MNT/testdir/extent_file3
> +attr_name4: 9fd415c49d67afc4b78fad4055a3a376  -
> +
> +attr_set: Input/output error
> +Could not set "attr_name2" for SCRATCH_MNT/testdir/extent_file4
> +touch: cannot touch 'SCRATCH_MNT/testdir/extent_file4': Input/output error
> +Attribute "attr_name2" has a 65536 byte value for SCRATCH_MNT/testdir/extent_file4
> +Attribute "attr_name1" has a 1024 byte value for SCRATCH_MNT/testdir/extent_file4
> +attr_name2: 7f6fd1b6d872108bd44bd143cbcdfa19  -
> +
> +attr_remove: Input/output error
> +Could not remove "attr_name2" for SCRATCH_MNT/testdir/extent_file4
> +touch: cannot touch 'SCRATCH_MNT/testdir/extent_file4': Input/output error
> +Attribute "attr_name1" has a 1024 byte value for SCRATCH_MNT/testdir/extent_file4
> +attr_name2: attr_get: No data available
> +Could not get "attr_name2" for /mnt/scratch/testdir/extent_file4
> +d41d8cd98f00b204e9800998ecf8427e  -
> +
> +attr_set: Input/output error
> +Could not set "attr_name2" for SCRATCH_MNT/testdir/remote_file1
> +touch: cannot touch 'SCRATCH_MNT/testdir/remote_file1': Input/output error
> +Attribute "attr_name2" has a 1025 byte value for SCRATCH_MNT/testdir/remote_file1
> +Attribute "attr_name1" has a 65536 byte value for SCRATCH_MNT/testdir/remote_file1
> +attr_name2: 9fd415c49d67afc4b78fad4055a3a376  -
> +
> +attr_remove: Input/output error
> +Could not remove "attr_name2" for SCRATCH_MNT/testdir/remote_file1
> +touch: cannot touch 'SCRATCH_MNT/testdir/remote_file1': Input/output error
> +Attribute "attr_name1" has a 65536 byte value for SCRATCH_MNT/testdir/remote_file1
> +attr_name2: attr_get: No data available
> +Could not get "attr_name2" for /mnt/scratch/testdir/remote_file1
> +d41d8cd98f00b204e9800998ecf8427e  -
> +
> +attr_set: Input/output error
> +Could not set "attr_name2" for SCRATCH_MNT/testdir/remote_file2
> +touch: cannot touch 'SCRATCH_MNT/testdir/remote_file2': Input/output error
> +Attribute "attr_name2" has a 65536 byte value for SCRATCH_MNT/testdir/remote_file2
> +Attribute "attr_name1" has a 65536 byte value for SCRATCH_MNT/testdir/remote_file2
> +attr_name2: 7f6fd1b6d872108bd44bd143cbcdfa19  -
> +
> +attr_remove: Input/output error
> +Could not remove "attr_name2" for SCRATCH_MNT/testdir/remote_file2
> +touch: cannot touch 'SCRATCH_MNT/testdir/remote_file2': Input/output error
> +Attribute "attr_name1" has a 65536 byte value for SCRATCH_MNT/testdir/remote_file2
> +attr_name2: attr_get: No data available
> +Could not get "attr_name2" for /mnt/scratch/testdir/remote_file2
> +d41d8cd98f00b204e9800998ecf8427e  -
> +
> +attr_set: Input/output error
> +Could not set "attr_name2" for SCRATCH_MNT/testdir/sf_file
> +touch: cannot touch 'SCRATCH_MNT/testdir/sf_file': Input/output error
> +Attribute "attr_name1" has a 64 byte value for SCRATCH_MNT/testdir/sf_file
> +Attribute "attr_name2" has a 17 byte value for SCRATCH_MNT/testdir/sf_file
> +attr_name2: 9a6eb1bc9da3c66a9b495dfe2fe8a756  -
> +
> +attr_set: Input/output error
> +Could not set "attr_name2" for SCRATCH_MNT/testdir/leaf_file
> +touch: cannot touch 'SCRATCH_MNT/testdir/leaf_file': Input/output error
> +Attribute "attr_name2" has a 257 byte value for SCRATCH_MNT/testdir/leaf_file
> +Attribute "attr_name3" has a 1024 byte value for SCRATCH_MNT/testdir/leaf_file
> +Attribute "attr_name1" has a 1024 byte value for SCRATCH_MNT/testdir/leaf_file
> +attr_name2: f4ea5799d72a0a9bf2d56a685c9cba7a  -
> +
> +attr_set: Input/output error
> +Could not set "attr_name2" for SCRATCH_MNT/testdir/node_file
> +touch: cannot touch 'SCRATCH_MNT/testdir/node_file': Input/output error
> +Attribute "attr_name2" has a 257 byte value for SCRATCH_MNT/testdir/node_file
> +Attribute "attr_name1" has a 65536 byte value for SCRATCH_MNT/testdir/node_file
> +attr_name2: f4ea5799d72a0a9bf2d56a685c9cba7a  -
> +
> +*** done
> -- 
> 2.35.1
> 
