Received: from mx1.redhat.com ([209.132.183.28]:62292 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751030AbdG0KwJ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 27 Jul 2017 06:52:09 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3686988E60
        for <fstests@vger.kernel.org>; Thu, 27 Jul 2017 10:52:09 +0000 (UTC)
Date: Thu, 27 Jul 2017 18:52:05 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfs: test xfs_metadump for leaked strings
Message-ID: <20170727105205.GD9167@eguan.usersys.redhat.com>
References: <f96cbce4-faf0-6a30-508b-39e5d2c17f8b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f96cbce4-faf0-6a30-508b-39e5d2c17f8b@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Jul 26, 2017 at 03:33:20PM -0500, Eric Sandeen wrote:
> xfs_metadump by default sanitizes the image so that all strings
> longer than 5 chars are obfusccated, and all stale data in metadata
> blocks (i.e. unused/unwritten data) is zeroed out.  We didn't have
> a test for this, though, so this does it.
> 
> It patterns 256M of the scratch device, then uses djwong's
> populate infrastructure to write all types of metadata,
> metadumps & mdrestores it, then looks for either the leaked
> pre-pattern or any leaked strings or filenames.
> 
> The strings we look for are, unfortunately, a bit ad-hoc based on
> what is currently used in the populate routines.

I don't have a better idea to avoid this either..

Some minor issues below.

> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> this exposes a bug in xfs_metadump, sending a fix for that soon
> 
> 
> diff --git a/tests/xfs/425 b/tests/xfs/425
> new file mode 100755
> index 0000000..02cb60f
> --- /dev/null
> +++ b/tests/xfs/425
> @@ -0,0 +1,121 @@
> +#! /bin/bash
> +# FS QA Test 425
> +#
> +# Look for stale data leaks in an xfs_metadump
> +#
> +# If this fails, get the byte offsets of the leaked strings
> +# which are found, then on the restored image in $SCRATCH_MNT,
                                                     ^^^^^^^^^^ TEST_DIR?
> +# do:
> +#
> +# xfs_db> blockget -n
> +# xfs_db> convert byte $BYTE daddr
> +# $RESULT
> +# xfs_db> daddr $RESULT
> +# xfs_db> blockuse -n
> +#
> +# to see information about the metadata block which contains the
> +# leaked string in question
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2017 Red Hat, Inc.  All Rights Reserved.
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +#-----------------------------------------------------------------------
> +#
> +
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
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/populate
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs xfs
> +_supported_os Linux
> +_require_test
> +_require_scratch
> +_require_populate_commands
> +
> +METADUMP_FILE="${TEST_DIR}/${seq}_metadump"
> +MDRESTORE_FILE="${TEST_DIR}/${seq}_mdrestore"
> +
> +echo "Silence is golden"
> +
> +# Pattern the scratch disk, mkfs, and restore.
> +$XFS_IO_PROG -d -c "pwrite 0 256M" $SCRATCH_DEV > $seqres.full 2>&1
> +_scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1
> +_scratch_populate nofill >> $seqres.full 2>&1
> +
> +# populate unmounts the fs for us
> +
> +_scratch_metadump $METADUMP_FILE 

Trailing whitespace in above line.

> +xfs_mdrestore $METADUMP_FILE $MDRESTORE_FILE
> +
> +# Grep for stale data (leaked cd cd pattern) or strings
> +# from populate routine
> +
> +hexdump -C $MDRESTORE_FILE | grep \
> +"cd cd cd cd\| \
> +41 41 41 41\|\
> +42 42 42 42\|\
> +43 43 43 43\|\
> +44 44 44 44\|\
> +61 61 61 61\|\
> +62 62 62 62\|\
> +63 63 63 63\|\
> +64 64 64 64\|\
> +dummy\|\
> +S_IF\|\
> +FMT_\|\
> +INLINE\|\
> +BLOCK\|\
> +LEAF\|\
> +NODE\|\
> +BTREE\|\
> +LOCAL\|\
> +EXTENTS\|\
> +REMOTE\|\
> +ATTR\|\
> +SYSTEM\|\
> +TRUSTED\|\
> +SECURITY\|\
> +attrvalfile\|\
> +unused\|\
> +BNOBT\|\
> +RMAPBT\|\
> +RTRMAPBT\|\
> +REFCOUNTBT" && echo "Leaked data found; see comments in test to debug"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/group b/tests/xfs/group
> index 185487d..d550224 100644
> --- a/tests/xfs/group
> +++ b/tests/xfs/group
> @@ -422,3 +422,4 @@
>  422 dangerous_scrub dangerous_online_repair
>  423 dangerous_scrub
>  424 auto quick dump
> +425 auto,metadata

A single space to separate different groups, not ','. And there's no
425.out file :)

Thanks,
Eryu
