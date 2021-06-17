Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478B8C48BE8
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Jun 2021 02:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1245A610EA
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Jun 2021 02:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhFQCKy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 16 Jun 2021 22:10:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32858 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230402AbhFQCKy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 Jun 2021 22:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623895726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d97AtZN4FZccqFIxIvus/Ea+ZzFzpPrQkCBe4f4ZFxA=;
        b=U0JUcksWFaJlNET3q9fenTaj72dHSX9KsxRYlOvkdmZyYtCx48BLTsG28N3wp9oTFR/0rT
        TvTzIT1wBtv6UNmWjgytk99TVAcqKIsezyo6emdad69vJJ+oZWRrS4d50HcoDYMasNGoj+
        G0MTIhcB84dHhFSu51iwDzxRQjMKnWs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-EP1M0ohFNsq-Mr-GF1LlLA-1; Wed, 16 Jun 2021 22:08:43 -0400
X-MC-Unique: EP1M0ohFNsq-Mr-GF1LlLA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 665B01850606;
        Thu, 17 Jun 2021 02:08:42 +0000 (UTC)
Received: from localhost (unknown [10.66.61.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D321F60FC2;
        Thu, 17 Jun 2021 02:08:41 +0000 (UTC)
Date:   Thu, 17 Jun 2021 10:27:32 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org, riteshh@linux.ibm.com
Subject: Re: [PATCH v2] generic: test small swapfile without page-aligned
 contiguous blocks
Message-ID: <20210617022732.GK2978781@localhost.localdomain>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
        fstests@vger.kernel.org, riteshh@linux.ibm.com
References: <20210615161128.359980-1-zlang@redhat.com>
 <20210617001748.GA158186@locust>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617001748.GA158186@locust>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 16, 2021 at 05:17:48PM -0700, Darrick J. Wong wrote:
> On Wed, Jun 16, 2021 at 12:11:28AM +0800, Zorro Lang wrote:
> > If a swapfile doesn't contain even a single page-aligned contiguous
> > range of blocks, it's an invalid swapfile, and might cause kernel
> > issue. This case covered commit 5808fecc5723 ("iomap: Fix negative
> > assignment to unsigned sis->pages in iomap_swapfile_activate").
> > 
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > ---
> > 
> > Hi,
> > 
> > Sorry for the late V2, I just back from a longtime sick leave. V2 accord
> 
> :( I hope you're doing better!

Thanks, feel better now, trying to catch what I missed :)

> 
> > to the review points from djwong:
> >   https://lore.kernel.org/fstests/20210525160907.GB202095@locust/
> > But I didn't change the _scratch_mkfs_blocksized() helper in this patch.
> > 
> > CC Ritesh Harjani who's the original author of commit 5808fecc5723, and
> > looks like he sent another test case.
> > 
> > Thanks,
> > Zorro
> > 
> >  tests/generic/639     | 82 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/639.out |  2 ++
> >  tests/generic/group   |  1 +
> >  3 files changed, 85 insertions(+)
> >  create mode 100755 tests/generic/639
> >  create mode 100644 tests/generic/639.out
> > 
> > diff --git a/tests/generic/639 b/tests/generic/639
> > new file mode 100755
> > index 00000000..b371a6e9
> > --- /dev/null
> > +++ b/tests/generic/639
> > @@ -0,0 +1,82 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2021 Red Hat Inc.  All Rights Reserved.
> > +#
> > +# FS QA Test No. 639
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
> 
> _require_xfs_io_command fcollapse

Sure,

> 
> is needed above.
> 
> > +	chmod 0600 $fname
> > +	$CHATTR_PROG +C $fname > /dev/null 2>&1
> > +	$here/src/mkswap $fname
> > +}
> > +
> > +_scratch_mkfs >> $seqres.full 2>&1
> > +_scratch_mount
> > +psize=`get_page_size`
> > +bsize=`_get_file_block_size $SCRATCH_MNT`
> > +# Due to we need page-unaligned blocks, so blocksize < pagesize is necessary.
> > +# If not, try to make a smaller enough block size
> > +if [ $bsize -ge $psize ];then
> > +	_scratch_unmount
> > +	_scratch_mkfs_blocksized 1024 >> $seqres.full 2>&1
> > +	if [ $? -ne 0 ];then
> > +		_notrun "Can't make filesystem block size < page size"
> > +	fi
> > +	_scratch_mount
> > +	bsize=`_get_file_block_size $SCRATCH_MNT`
> > +	if [ $bsize -ne 1024 ];then
> > +		_notrun "1024 block size is necessary"
> 
> This error message probably should have a little more context.
> 
> 	_notrun "Could not force 1024-byte file block size."

Sure. If I don't need to wait your patchset (about new grouplist), I'll change
this case now.

Thanks,
Zorro

> 
> The logic in the test looks good to me now.
> 
> --D
> 
> > +	fi
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
> > diff --git a/tests/generic/639.out b/tests/generic/639.out
> > new file mode 100644
> > index 00000000..62c66537
> > --- /dev/null
> > +++ b/tests/generic/639.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 639
> > +Silence is golden
> > diff --git a/tests/generic/group b/tests/generic/group
> > index 9a636b23..48ffa3c7 100644
> > --- a/tests/generic/group
> > +++ b/tests/generic/group
> > @@ -641,3 +641,4 @@
> >  636 auto quick swap
> >  637 auto quick dir
> >  638 auto quick rw
> > +639 auto quick swap
> > -- 
> > 2.31.1
> > 
> 

