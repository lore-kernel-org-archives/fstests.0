Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F2AC48BE5
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Jun 2021 03:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BCAA61159
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Jun 2021 03:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhFQDIK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 16 Jun 2021 23:08:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229456AbhFQDIK (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 16 Jun 2021 23:08:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54E5C613D5;
        Thu, 17 Jun 2021 03:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623899163;
        bh=VrADUOq/LOrmswF6ChXb3/XfQwXnKD6FRCYO6w3MfDw=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=X0QFUBliFZdHiXX6ETOaZqBvZ4bkBtJzn7DPpXJq4eTWSz4HVxvcfOpsZ5J9sI0Fr
         5I7QEHBW8RlI412jhmgj8jloCH5ZuE8obvz0JhZZZWXpJfZhlwJz23+z5oKWaT1V0F
         lXJqrhnfigYM/8U2OtxO9hfmqko19Yrc9xYrjZqRi1BocpOCK68ySDv+/XJwSLF9IQ
         009tASmnTz4FORypCVhbY2UGPCMDQmw7tTaNrOhTOQu8A3GlbKOfpW6vPWwQ7Dmttx
         Jx2Chtln4mV+QXYameCLABUx+bDaZ8kjrM3EjP63sFEatoDdeOMPB/uYbZ1EC+6Ype
         gc7BD+aYbxuvg==
Date:   Wed, 16 Jun 2021 20:06:02 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     fstests@vger.kernel.org, riteshh@linux.ibm.com
Subject: Re: [PATCH v2] generic: test small swapfile without page-aligned
 contiguous blocks
Message-ID: <20210617030602.GC158232@locust>
References: <20210615161128.359980-1-zlang@redhat.com>
 <20210617001748.GA158186@locust>
 <20210617022732.GK2978781@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617022732.GK2978781@localhost.localdomain>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jun 17, 2021 at 10:27:32AM +0800, Zorro Lang wrote:
> On Wed, Jun 16, 2021 at 05:17:48PM -0700, Darrick J. Wong wrote:
> > On Wed, Jun 16, 2021 at 12:11:28AM +0800, Zorro Lang wrote:
> > > If a swapfile doesn't contain even a single page-aligned contiguous
> > > range of blocks, it's an invalid swapfile, and might cause kernel
> > > issue. This case covered commit 5808fecc5723 ("iomap: Fix negative
> > > assignment to unsigned sis->pages in iomap_swapfile_activate").
> > > 
> > > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > > ---
> > > 
> > > Hi,
> > > 
> > > Sorry for the late V2, I just back from a longtime sick leave. V2 accord
> > 
> > :( I hope you're doing better!
> 
> Thanks, feel better now, trying to catch what I missed :)
> 
> > 
> > > to the review points from djwong:
> > >   https://lore.kernel.org/fstests/20210525160907.GB202095@locust/
> > > But I didn't change the _scratch_mkfs_blocksized() helper in this patch.
> > > 
> > > CC Ritesh Harjani who's the original author of commit 5808fecc5723, and
> > > looks like he sent another test case.
> > > 
> > > Thanks,
> > > Zorro
> > > 
> > >  tests/generic/639     | 82 +++++++++++++++++++++++++++++++++++++++++++
> > >  tests/generic/639.out |  2 ++
> > >  tests/generic/group   |  1 +
> > >  3 files changed, 85 insertions(+)
> > >  create mode 100755 tests/generic/639
> > >  create mode 100644 tests/generic/639.out
> > > 
> > > diff --git a/tests/generic/639 b/tests/generic/639
> > > new file mode 100755
> > > index 00000000..b371a6e9
> > > --- /dev/null
> > > +++ b/tests/generic/639
> > > @@ -0,0 +1,82 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2021 Red Hat Inc.  All Rights Reserved.
> > > +#
> > > +# FS QA Test No. 639
> > > +#
> > > +# Test small swapfile which doesn't contain even a single page-aligned contiguous
> > > +# range of blocks. This case covered commit 5808fecc5723 ("iomap: Fix negative
> > > +# assignment to unsigned sis->pages in iomap_swapfile_activate").
> > > +#
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
> > > +_supported_fs generic
> > > +_require_scratch
> > > +_require_scratch_swapfile
> > > +_require_test_program mkswap
> > > +_require_test_program swapon
> > > +
> > > +make_unaligned_swapfile()
> > > +{
> > > +	local fname=$1
> > > +	local n=$((psize / bsize - 1))
> > > +
> > > +	# Make sure the swapfile doesn't contain even a single page-aligned
> > > +	# contiguous range of blocks. This's necessary to cover the bug
> > > +	$XFS_IO_PROG -f -t -c "pwrite 0 $(((psize + bsize) * n))" $fname >> $seqres.full 2>&1
> > > +	for((i=1; i<=n; i++));do
> > > +		$XFS_IO_PROG -c "fcollapse $(((psize - bsize) * i)) $bsize" $fname
> > > +	done
> > 
> > _require_xfs_io_command fcollapse
> 
> Sure,
> 
> > 
> > is needed above.
> > 
> > > +	chmod 0600 $fname
> > > +	$CHATTR_PROG +C $fname > /dev/null 2>&1
> > > +	$here/src/mkswap $fname
> > > +}
> > > +
> > > +_scratch_mkfs >> $seqres.full 2>&1
> > > +_scratch_mount
> > > +psize=`get_page_size`
> > > +bsize=`_get_file_block_size $SCRATCH_MNT`
> > > +# Due to we need page-unaligned blocks, so blocksize < pagesize is necessary.
> > > +# If not, try to make a smaller enough block size
> > > +if [ $bsize -ge $psize ];then
> > > +	_scratch_unmount
> > > +	_scratch_mkfs_blocksized 1024 >> $seqres.full 2>&1
> > > +	if [ $? -ne 0 ];then
> > > +		_notrun "Can't make filesystem block size < page size"
> > > +	fi
> > > +	_scratch_mount
> > > +	bsize=`_get_file_block_size $SCRATCH_MNT`
> > > +	if [ $bsize -ne 1024 ];then
> > > +		_notrun "1024 block size is necessary"
> > 
> > This error message probably should have a little more context.
> > 
> > 	_notrun "Could not force 1024-byte file block size."
> 
> Sure. If I don't need to wait your patchset (about new grouplist), I'll change
> this case now.

Nah, that whole patchset is at least another week (and reposting) away.

--D

> Thanks,
> Zorro
> 
> > 
> > The logic in the test looks good to me now.
> > 
> > --D
> > 
> > > +	fi
> > > +fi
> > > +swapfile=$SCRATCH_MNT/$seq.swapfile
> > > +make_unaligned_swapfile $swapfile
> > > +$here/src/swapon $swapfile
> > > +swapoff $swapfile
> > > +
> > > +echo "Silence is golden"
> > > +# success, all done
> > > +status=0
> > > +exit
> > > diff --git a/tests/generic/639.out b/tests/generic/639.out
> > > new file mode 100644
> > > index 00000000..62c66537
> > > --- /dev/null
> > > +++ b/tests/generic/639.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 639
> > > +Silence is golden
> > > diff --git a/tests/generic/group b/tests/generic/group
> > > index 9a636b23..48ffa3c7 100644
> > > --- a/tests/generic/group
> > > +++ b/tests/generic/group
> > > @@ -641,3 +641,4 @@
> > >  636 auto quick swap
> > >  637 auto quick dir
> > >  638 auto quick rw
> > > +639 auto quick swap
> > > -- 
> > > 2.31.1
> > > 
> > 
> 
