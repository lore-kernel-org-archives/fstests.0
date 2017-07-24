Received: from mx1.redhat.com ([209.132.183.28]:50794 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932250AbdGXPAl (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 24 Jul 2017 11:00:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 520F0267DF
        for <fstests@vger.kernel.org>; Mon, 24 Jul 2017 15:00:41 +0000 (UTC)
Date: Mon, 24 Jul 2017 10:00:35 -0500
From: "Bill O'Donnell" <billodo@redhat.com>
Subject: Re: [PATCH v5] xfs/424: test xfs_db to ensure type size taken into
 account with new type
Message-ID: <20170724150035.GA5307@redhat.com>
References: <20170712183112.5255-1-billodo@redhat.com>
 <20170721145319.5087-1-billodo@redhat.com>
 <20170724115441.GE9167@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170724115441.GE9167@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jul 24, 2017 at 07:54:41PM +0800, Eryu Guan wrote:
> On Fri, Jul 21, 2017 at 09:53:19AM -0500, Bill O'Donnell wrote:
> > xfs_db should take type size into account when setting type.
> > If type size isn't updated whenever type is set, a false crc
> > error can occur due to the stale size. This test checks for
> > that false crc error.
> > 
> > Signed-off-by: Bill O'Donnell <billodo@redhat.com>
> > ---
> > v2: Clarify commit message and test comments. Add a few more test cases.
> > v3: Add more test cases. Use _scratch_xfs_db instead of $XFS_DB_PROG to
> >     accomodate fses with external logs. Remove superfluous daddr and type
> >     commands.
> > v4: Skip select tests and make a corresponding note in the comments. Add
> >     test for type inode (note: depends on pending xfsprogs patch
> >     xfs_db: properly set inode type).
> > v5: Cleanup tabs/spaces and whitespace. Rename local function filter_dbval().
> >     Remove unneeded _scratch_unmount. Add "Silence is golden" output.
> > 
> >  tests/xfs/424     | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/xfs/424.out |   2 ++
> >  tests/xfs/group   |   1 +
> >  3 files changed, 106 insertions(+)
> >  create mode 100755 tests/xfs/424
> >  create mode 100644 tests/xfs/424.out
> > 
> > diff --git a/tests/xfs/424 b/tests/xfs/424
> > new file mode 100755
> > index 00000000..d5603d03
> > --- /dev/null
> > +++ b/tests/xfs/424
> > @@ -0,0 +1,103 @@
> > +#! /bin/bash
> > +# FS QA Test 424
> > +#
> > +# xfs_db should take type size into account when setting type.
> > +# If type size isn't updated whenever type is set, a false crc
> > +# error can occur due to the stale size. This test checks for
> > +# that false crc error.
> > +#
> > +#-----------------------------------------------------------------------
> > +# Copyright (c) 2017 Red Hat, Inc.  All Rights Reserved.
> > +#
> > +# This program is free software; you can redistribute it and/or
> > +# modify it under the terms of the GNU General Public License as
> > +# published by the Free Software Foundation.
> > +#
> > +# This program is distributed in the hope that it would be useful,
> > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > +# GNU General Public License for more details.
> > +#
> > +# You should have received a copy of the GNU General Public License
> > +# along with this program; if not, write the Free Software Foundation,
> > +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> > +#-----------------------------------------------------------------------
> > +#
> > +
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=`pwd`
> > +tmp=/tmp/$$
> > +status=1	# failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +	cd /
> > +	rm -f $tmp.*
> > +}
> > +
> > +filter_dbval()
> > +{
> > +	awk '{ print $4 }'
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# Modify as appropriate
> > +_supported_os Linux
> > +_supported_fs xfs
> > +_require_scratch
> > +
> > +echo "Silence is golden."
> > +
> > +# real QA test starts here
> > +
> > +# for different sector sizes, ensure no CRC errors are falsely reported.
> > +
> > +# Supported types include: agf, agfl, agi, attr3, bmapbta,
> > +# bmapbtd, bnobt, cntbt, data, dir3, dqblk, inobt, inodata,
> > +# inode, log, rtbitmap, rtsummary, sb, symlink, text, finobt.
> > +# For various sector sizes, test some types that involve type size.
> > +#
> > +# NOTE: skip attr3, bmapbta, bmapbtd, dir3, dqblk, inodata, symlink
> > +# rtbitmap, rtsummary, log
> > +#
> > +for SECTOR_SIZE in 512 1024 2048 4096; do
> 
> Sorry, I just found this today, this may not work with 4k sector disks.
> Seems we need to work out the supported sector sizes from
> `_min_dio_alignment $SCRATCH_DEV`, e.g.
> 
> sec_sz=`_min_dio_alignment $SCRATCH_DEV`
> while [ $sec_sz -le 4096 ]; do
> 	sector_sizes="$sector_sizes $sec_sz"
> 	sec_sz=$((sec_sz * 2))
> done
> 
> for SECTOR_SIZE in $sector_sizes; do
> ...
> 
> > +$MKFS_XFS_PROG -f -s size=$SECTOR_SIZE $SCRATCH_DEV > /dev/null
> 
> And the indention of this MKFS_XFS_PROG seems wrong :)

Ahh! Good catch, and thank you. I'll submit a v6.

-Bill



> 
> Thanks,
> Eryu
> 
> > +
> > +	for TYPE in agf agi agfl sb; do
> > +		DADDR=`_scratch_xfs_db -c "$TYPE" -c "daddr" | filter_dbval`
> > +		_scratch_xfs_db -c "daddr $DADDR" -c "type $TYPE"
> > +	done
> > +
> > +	DADDR=`_scratch_xfs_db -c "sb" -c "addr rootino" -c "daddr" |
> > +		filter_dbval`
> > +	_scratch_xfs_db -c "daddr $DADDR" -c "type inode"
> > +	DADDR=`_scratch_xfs_db -c "agf" -c "addr bnoroot" -c "daddr" |
> > +		filter_dbval`
> > +	_scratch_xfs_db -c "daddr $DADDR" -c "type bnobt"
> > +	DADDR=`_scratch_xfs_db -c "agf" -c "addr cntroot" -c "daddr" |
> > +		filter_dbval`
> > +	_scratch_xfs_db -c "daddr $DADDR" -c "type cntbt"
> > +	DADDR=`_scratch_xfs_db -c "agi" -c "addr root" -c "daddr" |
> > +		filter_dbval`
> > +	_scratch_xfs_db -c "daddr $DADDR" -c "type inobt"
> > +	DADDR=`_scratch_xfs_db -c "agi" -c "addr free_root" -c "daddr" |
> > +		filter_dbval`
> > +	_scratch_xfs_db -c "daddr $DADDR" -c "type finobt"
> > +
> > +	_scratch_xfs_db -c "daddr $DADDR" -c "type text"
> > +	_scratch_xfs_db -c "daddr $DADDR" -c "type data"
> > +done
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/xfs/424.out b/tests/xfs/424.out
> > new file mode 100644
> > index 00000000..ca196cd9
> > --- /dev/null
> > +++ b/tests/xfs/424.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 424
> > +Silence is golden.
> > diff --git a/tests/xfs/group b/tests/xfs/group
> > index ffdb0615..75c8280c 100644
> > --- a/tests/xfs/group
> > +++ b/tests/xfs/group
> > @@ -421,3 +421,4 @@
> >  421 auto quick clone dedupe
> >  422 dangerous_scrub dangerous_online_repair
> >  423 dangerous_scrub
> > +424 auto quick db
> > -- 
> > 2.13.3
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
