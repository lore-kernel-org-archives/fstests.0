Received: from mx1.redhat.com ([209.132.183.28]:59738 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750997AbdG0Lz3 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 27 Jul 2017 07:55:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 110243345B4
        for <fstests@vger.kernel.org>; Thu, 27 Jul 2017 11:55:29 +0000 (UTC)
Date: Thu, 27 Jul 2017 07:55:28 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH v2] generic: test read around EOF
Message-ID: <20170727115527.GA3858@bfoster.bfoster>
References: <20170726104804.25903-1-zlang@redhat.com>
 <20170726144843.GA60481@bfoster.bfoster>
 <20170727034609.GQ4858@dhcp12-143.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170727034609.GQ4858@dhcp12-143.nay.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 27, 2017 at 11:46:09AM +0800, Zorro Lang wrote:
> On Wed, Jul 26, 2017 at 10:48:43AM -0400, Brian Foster wrote:
> > On Wed, Jul 26, 2017 at 06:48:04PM +0800, Zorro Lang wrote:
> > > As posix standard, if the file offset is at or past the end of file,
> > > no bytes are read, and read() returns zero. But there was a bug,
> > > when DIO read offset is just past the EOF a little, but in the same
> > > block with EOF, read returns different negative values.
> > > 
> > > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > > ---
> > > 
> > > Hi,
> > > 
> > > V2 did below changes:
> > > 1) move falloc, resvsp, allocsp related test to be special test,
> > >    no standard output
> > > 2) pick up pread related test into read_test() function
> > > 
> > 
> > I think Eric eventually narrowed down this problem to something
> > that could be reproduced by the following:
> > 
> > xfs_io -fc "pwrite 0 1024" /mnt/file
> > xfs_io -d -c "pread 1536 512" /mnt/file
> > 
> > The problem only occurred when a block was allocated at the offset of
> > the post-eof DIO read. I suppose it couldn't hurt to test buffered read
> > along with DIO, as well as the other cases of an unwritten block or
> > hole. But given all that, I'm still wondering if this test could be
> > simplified quite a bit to something that effectively does this:
> > 
> > BSIZE=4096
> > SSIZE=512
> > FILE=/mnt/file
> > 
> > rm -f $FILE
> > xfs_io -fc "pwrite 0 $SSIZE" $FILE
> > xfs_io -d -c "pread $(($BSIZE - $SSIZE)) $SSIZE" $FILE || echo "fail"
> > xfs_io -c "pread $(($BSIZE - $SSIZE)) $SSIZE" $FILE || echo "fail"
> > 
> > ... and then maybe repeat the above stanza 2 more times using a
> > "truncate" and "falloc" to create the file. I don't think the
> > XFS-specific preallocation commands are necessary. They result in the
> > same layout and we have other tests for those commands. Otherwise, this
> > could be cleaned up a bit, perhaps detect the BSIZE==SSIZE case and
> > _notrun, etc. Thoughts in general?
> 
> Thanks Brian, I just try to cover more test conditions 
> 

Yes, I understand...

> I. different read range around EOF
> 1) read from a range < EOF
> 2) read from a range contains EOF
> 3) read from a range > EOF, but in same block.
> 4) read from a range far far away > EOF
> 
> II. different read mode:
> 1) buffer read
> 2) DIO read
> 3) sync buffer read
> 4) sync DIO read
> 
> III. different extents
> 1) no extents before and after EOF
> 2) written extents before EOF
> 3) unwritten extents before and after EOF
> 4) unwritten extents before EOF
> 

I guess the first thing that stood out to me is the fairly complicated
implementation. Do we really need to use double-nested loops to
accomplish all this? It makes it difficult to follow what the expected
state is for each test. For example, is the intent of truncate after
pwrite to trim post-eof blocks, or is the intent really to test EOF over
a hole? Note that the former looks like the actual behavior.

>From reading through the implementation, it seemed that the test could
be simplified. Using the various I/O modes to create the same file state
seems spurious when all we really need to cover are the various file
states (written, unwritten, hole). If we want to test every possible way
to create an unwritten extent in XFS, for example, we should do that in
an independent test from one that is intended to test I/O boundary
conditions around EOF with varying block allocation states. This test
should just pick the most generic mechanism to create the unwritten
block and use it, because they all effectively do the same thing.

The same kind of thing seems to apply to using sync I/O or not.. I'm not
sure what that's really intended to test, particularly when we're using
different modes just to create the original file. If we're testing a
read I/O along EOF boundaries with a written block, just pick a generic
way to create the block (i.e., pwrite + fsync) and leave the testing of
sync vs. async vs. buffered vs. dio to another test with a more clear
intent of testing those various I/O modes. Just my .02.

> And "I.3 + II.2/4 + III.2" is the reproducer for "74cedf9b6c60
> direct-io: Fix negative return from dio read beyond eof". Others
> are only extend testing, they'll all pass, except hit some bugs.
> 
> I was wondering _notrun when BSIZE==SSIZE, but for the current
> code, the case won't fail if BSIZE==SSIZE, so I keep it for it
> no hurt.
> 

Yeah, it ultimately depends on the context of the test. The current
implementation might still have tests that will run as expected, though
we should at least have comments to point out what tests might not
necessarily be valid in this scenario. The more focused test I posted
above might make more sense to skip, since it clearly isn't covering the
intended test case in that situation and a _notrun is more clear to the
tester.

Brian

> Thanks,
> Zorro
> 
> > 
> > Brian
> > 
> > > Thanks,
> > > Zorro
> > > 
> > >  tests/generic/450     | 171 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  tests/generic/450.out |  50 +++++++++++++++
> > >  tests/generic/group   |   1 +
> > >  3 files changed, 222 insertions(+)
> > >  create mode 100755 tests/generic/450
> > >  create mode 100644 tests/generic/450.out
> > > 
> > > diff --git a/tests/generic/450 b/tests/generic/450
> > > new file mode 100755
> > > index 00000000..5fbe7f0c
> > > --- /dev/null
> > > +++ b/tests/generic/450
> > > @@ -0,0 +1,171 @@
> > > +#! /bin/bash
> > > +# FS QA Test 450
> > > +#
> > > +# Test read around EOF. If the file offset is at or past the end of file,
> > > +# no bytes are read, and read() returns zero. But there was a bug, when
> > > +# DIO read offset is just past the EOF a little, but in the same block
> > > +# with EOF, read returns different negative values.
> > > +#
> > > +#-----------------------------------------------------------------------
> > > +# Copyright (c) 2017 Red Hat, Inc.  All Rights Reserved.
> > > +#
> > > +# This program is free software; you can redistribute it and/or
> > > +# modify it under the terms of the GNU General Public License as
> > > +# published by the Free Software Foundation.
> > > +#
> > > +# This program is distributed in the hope that it would be useful,
> > > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > +# GNU General Public License for more details.
> > > +#
> > > +# You should have received a copy of the GNU General Public License
> > > +# along with this program; if not, write the Free Software Foundation,
> > > +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> > > +#-----------------------------------------------------------------------
> > > +#
> > > +
> > > +seq=`basename $0`
> > > +seqres=$RESULT_DIR/$seq
> > > +echo "QA output created by $seq"
> > > +
> > > +here=`pwd`
> > > +tmp=/tmp/$$
> > > +status=1	# failure is the default!
> > > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > > +
> > > +_cleanup()
> > > +{
> > > +	cd /
> > > +	rm -f $tmp.*
> > > +	rm -f $tfile
> > > +}
> > > +
> > > +# get standard environment, filters and checks
> > > +. ./common/rc
> > > +. ./common/filter
> > > +
> > > +# remove previous $seqres.full before test
> > > +rm -f $seqres.full
> > > +
> > > +# real QA test starts here
> > > +
> > > +# Modify as appropriate.
> > > +_supported_fs generic
> > > +_supported_os Linux
> > > +_require_test
> > > +
> > > +tfile=$TEST_DIR/testfile_${seq}
> > > +ssize=`blockdev --getss $TEST_DEV`
> > > +bsize=`_get_block_size $TEST_DIR`
> > > +
> > > +rm -f $tfile 2>/dev/null
> > > +
> > > +# check xfs_io pread result, especially for
> > > +# Param1: expected pread return
> > > +# Param2: expected pread count
> > > +# Param3: expected pread offset
> > > +#
> > > +# If any of above values are not as expected, the output keeps
> > > +# using the real value
> > > +check_xfs_io_read()
> > > +{
> > > +	RETURN=$1
> > > +	COUNT=$2
> > > +	OFFSET=$3
> > > +
> > > +	$AWK_PROG -v ret="$RETURN" -v cnt="$COUNT" -v off="$OFFSET" '
> > > +		/read/{
> > > +			split($2, bytes, "/")
> > > +
> > > +			retval=bytes[1]
> > > +			count=bytes[2]
> > > +			offset=$NF
> > > +
> > > +			if(retval == ret) retval="X"
> > > +			if(count == cnt) count="XX"
> > > +			if(offset == off) offset="XXX"
> > > +
> > > +			printf("read [%s/%s %s]\n", retval, count, offset)
> > > +
> > > +			next
> > > +		}
> > > +	'
> > > +}
> > > +
> > > +
> > > +# +-----------------------------------------+
> > > +# |    block    |    block    |    block    |
> > > +# +------------------------------------------
> > > +# | sect | sect | sect | sect | sect | sect |
> > > +#                                  |
> > > +#                                 EOF
> > > +# |<----------- move EOF --------->| xxxxxx |
> > > +# [pread1]
> > > +#               [           pread2          ]
> > > +#                                    [pread3]     ...   [pread4]
> > > +#
> > > +# Run below steps with differnt $operation and $openflag
> > > +#
> > > +# 1) use $operation (alloc/reserve/truncate ...) to move EOF
> > > +# 2) read (pread1) the first sector doesn't contain EOF
> > > +# 3) read (pread2) the 2nd and 3rd blocks contain EOF
> > > +# 4) read (pread3) the last sector which just out of EOF
> > > +# 5) read (pread4) at far far away from EOF
> > > +#
> > > +# NOTE: This case generally test on sector size < block size, but equal is fine
> > > +#
> > > +asize=$((bsize * 3))
> > > +tsize=$((asize - ssize - 100))
> > > +
> > > +read_test()
> > > +{
> > > +	$XFS_IO_PROG $oflag -c "pread 0 $ssize" $tfile | \
> > > +		check_xfs_io_read "$ssize" "$ssize" "0"
> > > +
> > > +	$XFS_IO_PROG $oflag -c "pread $bsize $((bsize * 2))" $tfile | \
> > > +		check_xfs_io_read "$((tsize - bsize))" "$((bsize * 2))" "$bsize"
> > > +
> > > +	$XFS_IO_PROG $oflag -c "pread $((bsize * 3 - ssize)) $ssize" $tfile | \
> > > +		check_xfs_io_read "0" "$ssize" "$((bsize * 3 - ssize))"
> > > +
> > > +	$XFS_IO_PROG $oflag -c "pread $((bsize * 100)) $ssize" $tfile | \
> > > +		check_xfs_io_read "0" "$ssize" "$((bsize * 100))"
> > > +}
> > > +
> > > +# Generic test
> > > +for oflag in "" "-d" "-s" "-sd"; do
> > > +	for oper in "pwrite 0 ${tsize}" "truncate ${tsize}"; do
> > > +		echo "## Test ${oper%% *} and read with open ${oflag} ##" | \
> > > +			tee -a $seqres.full
> > > +
> > > +		$XFS_IO_PROG -ft -c "$oper" $tfile >>$seqres.full
> > > +
> > > +		read_test
> > > +
> > > +		echo | tee -a $seqres.full
> > > +	done
> > > +done
> > > +
> > > +# XFS test
> > > +echo "## Extra testing, no output is expected below ##"
> > > +for oflag in "" "-d" "-s" "-sd"; do
> > > +	for oper in "falloc 0 ${tsize}" \
> > > +		    "resvsp 0 ${asize}" \
> > > +		    "allocsp ${tsize} 0"; do
> > > +		echo "## Test ${oper%% *} and read with open ${oflag} ##" >> $seqres.full
> > > +
> > > +		# Drop all output, for some filesystems don't support these
> > > +		# test operations
> > > +		$XFS_IO_PROG -ft -c "truncate ${tsize}" -c "$oper" $tfile >>$seqres.full 2>&1
> > > +
> > > +		# For keeping golden image consistency in different filesystems,
> > > +		# drop the output, but not error output
> > > +		read_test >>$seqres.full
> > > +
> > > +		echo >> $seqres.full
> > > +	done
> > > +done
> > > +
> > > +# success, all done
> > > +status=0
> > > +exit
> > > diff --git a/tests/generic/450.out b/tests/generic/450.out
> > > new file mode 100644
> > > index 00000000..ad2570e8
> > > --- /dev/null
> > > +++ b/tests/generic/450.out
> > > @@ -0,0 +1,50 @@
> > > +QA output created by 450
> > > +## Test pwrite and read with open  ##
> > > +read [X/XX XXX]
> > > +read [X/XX XXX]
> > > +read [X/XX XXX]
> > > +read [X/XX XXX]
> > > +
> > > +## Test truncate and read with open  ##
> > > +read [X/XX XXX]
> > > +read [X/XX XXX]
> > > +read [X/XX XXX]
> > > +read [X/XX XXX]
> > > +
> > > +## Test pwrite and read with open -d ##
> > > +read [X/XX XXX]
> > > +read [X/XX XXX]
> > > +read [X/XX XXX]
> > > +read [X/XX XXX]
> > > +
> > > +## Test truncate and read with open -d ##
> > > +read [X/XX XXX]
> > > +read [X/XX XXX]
> > > +read [X/XX XXX]
> > > +read [X/XX XXX]
> > > +
> > > +## Test pwrite and read with open -s ##
> > > +read [X/XX XXX]
> > > +read [X/XX XXX]
> > > +read [X/XX XXX]
> > > +read [X/XX XXX]
> > > +
> > > +## Test truncate and read with open -s ##
> > > +read [X/XX XXX]
> > > +read [X/XX XXX]
> > > +read [X/XX XXX]
> > > +read [X/XX XXX]
> > > +
> > > +## Test pwrite and read with open -sd ##
> > > +read [X/XX XXX]
> > > +read [X/XX XXX]
> > > +read [X/XX XXX]
> > > +read [X/XX XXX]
> > > +
> > > +## Test truncate and read with open -sd ##
> > > +read [X/XX XXX]
> > > +read [X/XX XXX]
> > > +read [X/XX XXX]
> > > +read [X/XX XXX]
> > > +
> > > +## Extra testing, no output is expected below ##
> > > diff --git a/tests/generic/group b/tests/generic/group
> > > index a04cc900..0b29be0a 100644
> > > --- a/tests/generic/group
> > > +++ b/tests/generic/group
> > > @@ -452,3 +452,4 @@
> > >  447 auto quick clone
> > >  448 auto quick rw
> > >  449 auto quick acl enospc
> > > +450 auto quick rw
> > > -- 
> > > 2.13.3
> > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
