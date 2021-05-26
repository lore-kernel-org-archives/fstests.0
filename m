Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202E2C2B9F7
	for <linux-fstests@archiver.kernel.org>; Wed, 26 May 2021 03:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA61861437
	for <linux-fstests@archiver.kernel.org>; Wed, 26 May 2021 03:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbhEZD5P (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 May 2021 23:57:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31495 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231961AbhEZD5P (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 May 2021 23:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622001343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZkBB5gkzme5EB+arcYsR/SWZYI8di0oEshP/XIWWqvA=;
        b=ImWM2FHdSlf8oNLe3ydnIQZubK0WkrQzC0wkTfvYBVKfoNM7x3y48g3K+2RK3DZiPwYRCH
        jvacOJitCUSnfNH0dLY2GJNbhSOLdm38soaeYwvuZR72pUijLqHI3thcHrzdq/qOtONW5P
        yN5d65rwnhcEPn6ybiep52dYB2kcwf8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-e8mUfOjiNjaugMrQRNQXTQ-1; Tue, 25 May 2021 23:55:41 -0400
X-MC-Unique: e8mUfOjiNjaugMrQRNQXTQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B087D801107;
        Wed, 26 May 2021 03:55:40 +0000 (UTC)
Received: from localhost (unknown [10.66.61.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F2305D9CD;
        Wed, 26 May 2021 03:55:38 +0000 (UTC)
Date:   Wed, 26 May 2021 12:13:51 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] generic: test small swapfile without page-aligned
 contiguous blocks
Message-ID: <20210526041351.GE2978781@localhost.localdomain>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
        fstests@vger.kernel.org
References: <20210525044642.552682-1-zlang@redhat.com>
 <20210525044642.552682-2-zlang@redhat.com>
 <20210525160907.GB202095@locust>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525160907.GB202095@locust>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 25, 2021 at 09:09:07AM -0700, Darrick J. Wong wrote:
> On Tue, May 25, 2021 at 12:46:42PM +0800, Zorro Lang wrote:
> > If a swapfile doesn't contain even a single page-aligned contiguous
> > range of blocks, it's an invalid swapfile, and might cause kernel
> > issue. This case covered commit 5808fecc5723 ("iomap: Fix negative
> > assignment to unsigned sis->pages in iomap_swapfile_activate").
> > 
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > ---
> >  tests/generic/638     | 79 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/638.out |  2 ++
> >  tests/generic/group   |  1 +
> >  3 files changed, 82 insertions(+)
> >  create mode 100755 tests/generic/638
> >  create mode 100644 tests/generic/638.out
> > 
> > diff --git a/tests/generic/638 b/tests/generic/638
> > new file mode 100755
> > index 00000000..74bc39cb
> > --- /dev/null
> > +++ b/tests/generic/638
> > @@ -0,0 +1,79 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2021 Red Hat Inc.  All Rights Reserved.
> > +#
> > +# FS QA Test 638
> > +#
> > +# Test small swapfile which doesn't contain even a single page-aligned contiguous
> > +# range of blocks. This case covered commit 5808fecc5723 ("iomap: Fix negative
> > +# assignment to unsigned sis->pages in iomap_swapfile_activate").
> > +#
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
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# real QA test starts here
> > +_supported_fs generic
> > +_require_scratch
> > +_require_scratch_swapfile
> > +_require_test_program mkswap
> > +_require_test_program swapon
> > +
> > +make_unaligned_swapfile()
> > +{
> > +	local fname=$1
> > +	local n=$((psize / bsize - 1))
> > +
> > +	# Make sure the swapfile doesn't contain even a single page-aligned
> > +	# contiguous range of blocks. This's necessary to cover the bug
> > +	$XFS_IO_PROG -f -t -c "pwrite 0 $(((psize + bsize) * n))" $fname >> $seqres.full 2>&1
> > +	for((i=1; i<=n; i++));do
> > +		$XFS_IO_PROG -c "fcollapse $(((psize - bsize) * i)) $bsize" $fname
> > +	done
> > +	chmod 0600 $fname
> > +	$CHATTR_PROG +C $fname > /dev/null 2>&1
> > +	$here/src/mkswap $fname
> > +}
> > +
> > +_scratch_mkfs >> $seqres.full 2>&1
> > +_scratch_mount
> > +psize=`get_page_size`
> > +bsize=`_get_block_size $SCRATCH_MNT`
> 
> _get_file_block_size, since fcollapse requires arguments aligned to the
> file's allocation unit, which isn't necessarily the same as the fs block
> size (bigalloc, rt, etc.)...

You're right.

> 
> > +# Due to we need page-unaligned blocks, so blocksize < pagesize is necessary.
> > +# If not, try to make a smaller enough block size
> > +if [ $bsize -ge $psize ];then
> > +	_scratch_unmount
> > +	_scratch_mkfs_blocksized 1024 >> $seqres.full 2>&1
> 
> ...which leads me to the next question, which is: Should the above
> helper override mkfs options as necessary to enforce that the allocation
> unit is 1024 bytes?  Or is it time for a new helper?

Hmm... the _scratch_mkfs_blocksized() does:

    xfs)
        _scratch_mkfs_xfs $MKFS_OPTIONS -b size=$blocksize

_scratch_mkfs_xfs() already use $MKFS_OPTIONS internally, don't need to give
$MKFS_OPTIONS to it again. Although _scratch_mkfs_xfs deals with $MKFS_OPTIONS,
it just drops whole $MKFS_OPTIONS if there're conflicts.

The _scratch_mkfs_geom() does overwrite, but _scratch_mkfs_sized doesn't (sized
filesystem is rarely seen in local.config). We might let _scratch_mkfs_blocksized
learn _scratch_mkfs_geom.

> 
> > +	if [ $? -ne 0 ];then
> > +		_notrun "Can't make filesystem block size < page size"
> > +	fi
> > +	_scratch_mount
> > +	bsize=1024
> 
> You probably want to re-check _get_file_block_size to make sure that you
> actually got blocksize < pagesize in the format attempt.

Yes, you're right. _scratch_mkfs_blocksized can't make sure to get that blocksize.

Thanks,
Zorro

> 
> --D
> 
> > +fi
> > +swapfile=$SCRATCH_MNT/$seq.swapfile
> > +make_unaligned_swapfile $swapfile
> > +$here/src/swapon $swapfile
> > +swapoff $swapfile
> > +
> > +echo "Silence is golden"
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/generic/638.out b/tests/generic/638.out
> > new file mode 100644
> > index 00000000..3113b1e3
> > --- /dev/null
> > +++ b/tests/generic/638.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 638
> > +Silence is golden
> > diff --git a/tests/generic/group b/tests/generic/group
> > index b9614c69..5b9b3d1b 100644
> > --- a/tests/generic/group
> > +++ b/tests/generic/group
> > @@ -640,3 +640,4 @@
> >  635 auto quick atime bigtime shutdown
> >  636 auto quick swap
> >  637 auto quick rw
> > +638 auto quick swap
> > -- 
> > 2.31.1
> > 
> 

