Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0E2C4338F
	for <linux-fstests@archiver.kernel.org>; Tue, 27 Jul 2021 02:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B08260F94
	for <linux-fstests@archiver.kernel.org>; Tue, 27 Jul 2021 02:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbhG0B4C (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 26 Jul 2021 21:56:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22478 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233727AbhG0B4C (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 26 Jul 2021 21:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627353390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xhj5yfsn1R2smCFf1WTxvMtxnK2FrVjPs8PHo869m/I=;
        b=CcUxaQ/4xZPYBb+4IuY7i/SSXykgZ6XTLoHAEqtBgPYlndNrDuUW2UmW6FP4IdnosRTDZS
        nwO62OnbDoWXjm7e8ta83h20f4dzVdyMjQflpYx+o7jw7iXpolY5SR9sXEd+435Ns7jyYt
        C02a6raZKHy8CUSHZVhqJ8yWbe66ub0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-wmw8Lv8eP9mZaKDzoxvDQQ-1; Mon, 26 Jul 2021 22:36:28 -0400
X-MC-Unique: wmw8Lv8eP9mZaKDzoxvDQQ-1
Received: by mail-pj1-f71.google.com with SMTP id f1-20020a17090a8e81b029017720af1cf6so532759pjo.9
        for <fstests@vger.kernel.org>; Mon, 26 Jul 2021 19:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=xhj5yfsn1R2smCFf1WTxvMtxnK2FrVjPs8PHo869m/I=;
        b=sXl5qshfT6gxGcS/qOIdXVebawbfEhu0K3hYB9ooNFsiDDvDDhO2Q8R5tt4/5/+WhH
         7NvnOfKcBg31bvGQtKQmgysLRyKry21NhTfiaIOFoHxnVfzERc328c7rtafhRbYgOExQ
         5/gg073rBV49JwEjvbDWCHs0FGup4RgX/KFBYQWmwqraYxUJBJd65I35YkGXB1RM9otU
         y4CYkE7a2k5XG4Ke7nZVctCDjN8yhTMb6v3snxoFZ4mUy/ys054Bky5G1ulO5dG3Xpar
         43NPx0iJmlmnruXikMYiNAArWpqy17hwmb8cQPZK24IShwjPi7AWY2s4czfnEeH0Vs1F
         YBHg==
X-Gm-Message-State: AOAM531lsIbTh5kyaYoD+/kscdcMcGnqyvO4mHdXbxSRxwxHQFFjJlfB
        lUAc0LlM9WG6QyYBM1a/HkZ+jrL2eEv6nQQWOUmpAaarWkXP25WfMLIVsqmxOtbqa4x6R9NQb7V
        bLufjAdSZX03IEkwXKQ==
X-Received: by 2002:a17:902:6509:b029:12b:5175:43b8 with SMTP id b9-20020a1709026509b029012b517543b8mr16967770plk.60.1627353387664;
        Mon, 26 Jul 2021 19:36:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwihzuVn74sr5PjU67JQUfAYtMGbD5VFwPg3k+jGNbIQq+xlQ0ZXtNmwGM/uopjf97tAm3Myg==
X-Received: by 2002:a17:902:6509:b029:12b:5175:43b8 with SMTP id b9-20020a1709026509b029012b517543b8mr16967751plk.60.1627353387400;
        Mon, 26 Jul 2021 19:36:27 -0700 (PDT)
Received: from fedora ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d9sm1236220pgm.89.2021.07.26.19.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 19:36:27 -0700 (PDT)
Date:   Tue, 27 Jul 2021 10:41:42 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v5] generic: test small swapfile without page-aligned
 contiguous blocks
Message-ID: <20210727024142.4uld5df3akaxw54t@fedora>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
        fstests@vger.kernel.org
References: <20210726094605.513174-1-zlang@redhat.com>
 <20210726181157.GA8586@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726181157.GA8586@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jul 26, 2021 at 11:11:57AM -0700, Darrick J. Wong wrote:
> On Mon, Jul 26, 2021 at 05:46:05PM +0800, Zorro Lang wrote:
> > If a swapfile doesn't contain even a single page-aligned contiguous
> > range of blocks, it's an invalid swapfile, and might cause kernel
> > issue. This case covered commit 5808fecc5723 ("iomap: Fix negative
> > assignment to unsigned sis->pages in iomap_swapfile_activate").
> > 
> > Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > ---
> > 
> > Hi,
> > 
> > V5 rebase this case on the latest xfstests, to match the "group info" change:
> > https://lore.kernel.org/fstests/60d89a67.1c69fb81.86c2c.d6c4@mx.google.com/
> > 
> > Thanks,
> > Zorro
> > 
> >  tests/generic/640     | 77 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/640.out |  2 ++
> >  2 files changed, 79 insertions(+)
> >  create mode 100755 tests/generic/640
> >  create mode 100644 tests/generic/640.out
> > 
> > diff --git a/tests/generic/640 b/tests/generic/640
> > new file mode 100755
> > index 00000000..494fcc1b
> > --- /dev/null
> > +++ b/tests/generic/640
> > @@ -0,0 +1,77 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2021 Red Hat Inc.  All Rights Reserved.
> > +#
> > +# FS QA Test 640
> > +#
> > +# Test small swapfile which doesn't contain even a single page-aligned contiguous
> > +# range of blocks. This case covered commit 5808fecc5723 ("iomap: Fix negative
> > +# assignment to unsigned sis->pages in iomap_swapfile_activate").
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick swap
> > +
> > +# Import common functions
> > +. ./common/filter
> > +
> > +# real QA test starts here
> > +_supported_fs generic
> > +_require_scratch
> > +_require_scratch_swapfile
> > +_require_test_program mkswap
> > +_require_test_program swapon
> > +_require_xfs_io_command fcollapse
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
> > +bsize=`_get_file_block_size $SCRATCH_MNT`
> > +# Due to we need page-unaligned blocks, so blocksize < pagesize is necessary.
> > +# If not, try to make a smaller enough block size
> > +if [ $bsize -ge $psize ];then
> > +	_scratch_unmount
> > +	_scratch_mkfs_blocksized 1024 >> $seqres.full 2>&1
> > +	if [ $? -ne 0 ];then
> > +		_notrun "Can't make filesystem block size < page size."
> > +	fi
> > +	_scratch_mount
> > +	bsize=`_get_file_block_size $SCRATCH_MNT`
> > +	if [ $bsize -ne 1024 ];then
> > +		_notrun "Can't force 1024-byte file block size."
> > +	fi
> > +fi
> > +swapfile=$SCRATCH_MNT/$seq.swapfile
> > +make_unaligned_swapfile $swapfile
> > +# Expect EINVAL from swapon. If not, might miss 5808fecc5723 ("iomap: Fix
> > +# negative assignment to unsigned sis->pages in iomap_swapfile_activate")
> > +$here/src/swapon $swapfile
> > +# Further testing, check if swap size <= swapfile size, if swapon passed
> > +if [ $? -eq 0 ];then
> > +	swapsize=$(awk -v fname="$swapfile" '{if ($1~fname) print $3}' /proc/swaps)
> > +	swapsize=$((swapsize * 1024))
> > +	filesize=$(_get_filesize $swapfile)
> > +	if [ $swapsize -gt $filesize ]; then
> > +		echo "Allocated swap size($swapsize) shouldn't be greater than swapfile size($filesize)"
> > +	fi
> > +fi
> > +swapoff $swapfile 2>/dev/null
> 
> Do we actually need swapoff if swapon failed?  Or are you merely being
> cautious?

Maybe cautious :) I thought it won't affect this testing even if swapon failed,
so moving it into above "if [ $? -eq 0 ] ... fi" or just keep it at the end all
good to me. Is there anything wrong I missed ?

Thanks,
Zorro

> 
> --D
> 
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/generic/640.out b/tests/generic/640.out
> > new file mode 100644
> > index 00000000..e1ab5390
> > --- /dev/null
> > +++ b/tests/generic/640.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 640
> > +swapon: Invalid argument
> > -- 
> > 2.31.1
> > 
> 

