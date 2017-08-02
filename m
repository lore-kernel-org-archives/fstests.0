Received: from aserp1040.oracle.com ([141.146.126.69]:31158 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752642AbdHBR33 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 2 Aug 2017 13:29:29 -0400
Date: Wed, 2 Aug 2017 10:29:22 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH Ve] xfs: test xfs_metadump for leaked strings
Message-ID: <20170802172922.GA4474@magnolia>
References: <f96cbce4-faf0-6a30-508b-39e5d2c17f8b@redhat.com>
 <4e801980-9ea5-efaf-f45c-d98df8f1f7e3@sandeen.net>
 <8c54de65-b80f-1581-6b55-8c8100ca9ffd@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c54de65-b80f-1581-6b55-8c8100ca9ffd@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Eric Sandeen <sandeen@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Tue, Aug 01, 2017 at 10:45:06PM -0500, Eric Sandeen wrote:
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
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> V2: include .out file, minor whitespace & typo edits
> V3: remove populate debug stuff that snuck in
> 
> diff --git a/tests/xfs/425 b/tests/xfs/425
> new file mode 100755
> index 0000000..dd11236
> --- /dev/null
> +++ b/tests/xfs/425
> @@ -0,0 +1,121 @@
> +#! /bin/bash
> +# FS QA Test 425
> +#
> +# Look for stale data leaks in an xfs_metadump
> +#
> +# If this fails, get the byte offset of the leaked strings
> +# which are found, then on the restored image in $TEST_DIR,
> +# do:
> +#
> +# xfs_db> blockget -n
> +# xfs_db> convert byte $BYTE daddr
> +# $RESULT
> +# xfs_db> daddr $RESULT
> +# xfs_db> blockuse -n
> +#
> +# to see information about the metadata block which contains the
> +# leaked strings
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

pwrite -b 1m to speed this up a bit...

> +_scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1
> +_scratch_populate nofill >> $seqres.full 2>&1
> +
> +# populate unmounts the fs for us
> +
> +_scratch_metadump $METADUMP_FILE
> +xfs_mdrestore $METADUMP_FILE $MDRESTORE_FILE
> +
> +# Grep for stale data (leaked cd cd pattern) or strings
> +# from populate routine
> +
> +hexdump -C $MDRESTORE_FILE | grep \

_require_command /usr/bin/hexdump "hexdump" ?

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

/me wonders if this grep pattern ought to be some kind of _filter
function in common/populate?  That way if the xfs populate command adds
more weird strings, the search pattern is right there in the rc file,
not buried in tests/xfs/ somewhere.

OTOH a good counterargument is that this is the only test that cares
about that, so why make it common code?  <sigh>

--D

> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/425.out b/tests/xfs/425.out
> new file mode 100644
> index 0000000..7a9714b
> --- /dev/null
> +++ b/tests/xfs/425.out
> @@ -0,0 +1,2 @@
> +QA output created by 425
> +Silence is golden
> diff --git a/tests/xfs/group b/tests/xfs/group
> index 185487d..d0d26ee 100644
> --- a/tests/xfs/group
> +++ b/tests/xfs/group
> @@ -422,3 +422,4 @@
>  422 dangerous_scrub dangerous_online_repair
>  423 dangerous_scrub
>  424 auto quick dump
> +425 auto metadata
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
