Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4E7C2B9F4
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Jun 2021 04:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 395E66101D
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Jun 2021 04:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhFVEIP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 22 Jun 2021 00:08:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21799 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229452AbhFVEIP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Jun 2021 00:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624334759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fG0nZFd5bKRasYYMskIexxXg/2y6BSaKfdyPxYS+lA8=;
        b=FzVmWy/CnNWgj4opEAnuz4TrWExi/gytx8DgUUsVi9Raw7owDAO9v/RCKQ4oHiak38Jeam
        iXdJt9XcxsRfrpS8PwAzOFNXA/cUmRREYintJo6bxgSEVA+dyW6F67dsycvnxeWiv6i1lJ
        OtpQRBkWBjeUP9H8oduMXLGfmDOrkzU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-Qi33i9d1Ni2H800r44FcsA-1; Tue, 22 Jun 2021 00:05:57 -0400
X-MC-Unique: Qi33i9d1Ni2H800r44FcsA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1891362FC;
        Tue, 22 Jun 2021 04:05:55 +0000 (UTC)
Received: from localhost (unknown [10.66.61.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 59C9F5D6AD;
        Tue, 22 Jun 2021 04:05:55 +0000 (UTC)
Date:   Tue, 22 Jun 2021 12:24:55 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     riteshh <riteshh@linux.ibm.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v3] generic: test small swapfile without page-aligned
 contiguous blocks
Message-ID: <20210622042454.GP2978781@localhost.localdomain>
Mail-Followup-To: riteshh <riteshh@linux.ibm.com>, fstests@vger.kernel.org
References: <20210617050525.902967-1-zlang@redhat.com>
 <20210619011059.5elo3qtmvlp225oo@riteshh-domain>
 <20210619145915.GM2978781@localhost.localdomain>
 <20210619173315.vhu6brb6d3zuepg4@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210619173315.vhu6brb6d3zuepg4@riteshh-domain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Jun 19, 2021 at 11:03:15PM +0530, riteshh wrote:
> On 21/06/19 10:59PM, Zorro Lang wrote:
> > On Sat, Jun 19, 2021 at 06:40:59AM +0530, riteshh wrote:
> > > On 21/06/17 01:05PM, Zorro Lang wrote:
> > > > If a swapfile doesn't contain even a single page-aligned contiguous
> > > > range of blocks, it's an invalid swapfile, and might cause kernel
> > > > issue. This case covered commit 5808fecc5723 ("iomap: Fix negative
> > > > assignment to unsigned sis->pages in iomap_swapfile_activate").
> > >
> > > Hi Zorro,
> > >
> > > Sorry for getting late on this. So can you reproduce the issue described in the
> > > patch on latest upstream kernel too w/o the above kernel fix with this fstest?
> > >
> > > So how I remember it, this fix on older kernel prevented a kernel panic.
> > > But on latest kernel it prevented from adding a fake hugesize swapfile.
> > > In your test, I don't see a test for checking whether the swapfile which was
> > > getting added is of the appropriate size or not. Note that this was only
> > > happening with a tiny swapfile of 1 blocksize(totalsize) only.
> > >
> > > If you take a look at [1], we are also checking for
> > > +	# error case
> > > +	if [ $swapsize -gt $filesize ]; then
> > > +		status=1
> > > +		echo "Allocated swap size($swapsize) cannot be greater than swapfile size($filesize)"
> > > +	fi
> >
> > Hmm.. BTW, do we really need to check this? How about we expect to get EINVAL from
> > "$here/src/swapon" $SWAPFILE"?  Due to in fixed kernel, this command will print
> > "swapon: Invalid argument", and that's your patch does (return -EINVAL). But in
> > unfixed kernel, this test won't get "EINVAL" or get panic.
> 
> Yes, w/o the kernel fix a huge fake swapfile was getting added (which I guess
> could lead to some weird corruption upon usage by swap subsystem).
> Mainly such fstests is to avoid such bugs in future right, so I thought having
> that check as part of the fstest too will help.
> 
> Or do you think we should add such functionality as part of some generic
> swapon testing? Such that size of swap which gets added should be checked against
> the size of the swapfile? That will cover all cases I guess.

OK, I'll do both (EINVAL and swap size) check. Will send V4 and cc you.

Thanks,
Zorro

> 
> -ritesh
> 
> 
> 
> >
> > Thanks,
> > Zorro
> >
> > >
> > > [1]: https://patchwork.kernel.org/project/fstests/patch/e1f9798462ef60648db24b6291e1b149b114f2f2.1622105066.git.riteshh@linux.ibm.com/
> > >
> > > -ritesh
> > >
> > >
> > > >
> > > > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > > > ---
> > > >
> > > > Thanks the review from Darrick, V3 did below changes:
> > > > 1) Add _require_xfs_io_command fcollapse
> > > > 2) Change the notrun output if block size isn't 1024.
> > > >
> > > > Thanks,
> > > > Zorro
> > > >
> > > >  tests/generic/639     | 83 +++++++++++++++++++++++++++++++++++++++++++
> > > >  tests/generic/639.out |  2 ++
> > > >  tests/generic/group   |  1 +
> > > >  3 files changed, 86 insertions(+)
> > > >  create mode 100755 tests/generic/639
> > > >  create mode 100644 tests/generic/639.out
> > > >
> > > > diff --git a/tests/generic/639 b/tests/generic/639
> > > > new file mode 100755
> > > > index 00000000..c8d0c6c5
> > > > --- /dev/null
> > > > +++ b/tests/generic/639
> > > > @@ -0,0 +1,83 @@
> > > > +#! /bin/bash
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +# Copyright (c) 2021 Red Hat Inc.  All Rights Reserved.
> > > > +#
> > > > +# FS QA Test No. 639
> > > > +#
> > > > +# Test small swapfile which doesn't contain even a single page-aligned contiguous
> > > > +# range of blocks. This case covered commit 5808fecc5723 ("iomap: Fix negative
> > > > +# assignment to unsigned sis->pages in iomap_swapfile_activate").
> > > > +#
> > > > +seq=`basename $0`
> > > > +seqres=$RESULT_DIR/$seq
> > > > +echo "QA output created by $seq"
> > > > +
> > > > +here=`pwd`
> > > > +tmp=/tmp/$$
> > > > +status=1	# failure is the default!
> > > > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > > > +
> > > > +_cleanup()
> > > > +{
> > > > +	cd /
> > > > +	rm -f $tmp.*
> > > > +}
> > > > +
> > > > +# get standard environment, filters and checks
> > > > +. ./common/rc
> > > > +. ./common/filter
> > > > +
> > > > +# remove previous $seqres.full before test
> > > > +rm -f $seqres.full
> > > > +
> > > > +# real QA test starts here
> > > > +_supported_fs generic
> > > > +_require_scratch
> > > > +_require_scratch_swapfile
> > > > +_require_test_program mkswap
> > > > +_require_test_program swapon
> > > > +_require_xfs_io_command fcollapse
> > > > +
> > > > +make_unaligned_swapfile()
> > > > +{
> > > > +	local fname=$1
> > > > +	local n=$((psize / bsize - 1))
> > > > +
> > > > +	# Make sure the swapfile doesn't contain even a single page-aligned
> > > > +	# contiguous range of blocks. This's necessary to cover the bug
> > > > +	$XFS_IO_PROG -f -t -c "pwrite 0 $(((psize + bsize) * n))" $fname >> $seqres.full 2>&1
> > > > +	for((i=1; i<=n; i++));do
> > > > +		$XFS_IO_PROG -c "fcollapse $(((psize - bsize) * i)) $bsize" $fname
> > > > +	done
> > > > +	chmod 0600 $fname
> > > > +	$CHATTR_PROG +C $fname > /dev/null 2>&1
> > > > +	$here/src/mkswap $fname
> > > > +}
> > > > +
> > > > +_scratch_mkfs >> $seqres.full 2>&1
> > > > +_scratch_mount
> > > > +psize=`get_page_size`
> > > > +bsize=`_get_file_block_size $SCRATCH_MNT`
> > > > +# Due to we need page-unaligned blocks, so blocksize < pagesize is necessary.
> > > > +# If not, try to make a smaller enough block size
> > > > +if [ $bsize -ge $psize ];then
> > > > +	_scratch_unmount
> > > > +	_scratch_mkfs_blocksized 1024 >> $seqres.full 2>&1
> > > > +	if [ $? -ne 0 ];then
> > > > +		_notrun "Can't make filesystem block size < page size."
> > > > +	fi
> > > > +	_scratch_mount
> > > > +	bsize=`_get_file_block_size $SCRATCH_MNT`
> > > > +	if [ $bsize -ne 1024 ];then
> > > > +		_notrun "Can't force 1024-byte file block size."
> > > > +	fi
> > > > +fi
> > > > +swapfile=$SCRATCH_MNT/$seq.swapfile
> > > > +make_unaligned_swapfile $swapfile
> > > > +$here/src/swapon $swapfile
> > > > +swapoff $swapfile
> > > > +
> > > > +echo "Silence is golden"
> > > > +# success, all done
> > > > +status=0
> > > > +exit
> > > > diff --git a/tests/generic/639.out b/tests/generic/639.out
> > > > new file mode 100644
> > > > index 00000000..62c66537
> > > > --- /dev/null
> > > > +++ b/tests/generic/639.out
> > > > @@ -0,0 +1,2 @@
> > > > +QA output created by 639
> > > > +Silence is golden
> > > > diff --git a/tests/generic/group b/tests/generic/group
> > > > index 9a636b23..48ffa3c7 100644
> > > > --- a/tests/generic/group
> > > > +++ b/tests/generic/group
> > > > @@ -641,3 +641,4 @@
> > > >  636 auto quick swap
> > > >  637 auto quick dir
> > > >  638 auto quick rw
> > > > +639 auto quick swap
> > > > --
> > > > 2.31.1
> > > >
> > >
> >
> 

