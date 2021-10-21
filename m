Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314DFC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 21 Oct 2021 19:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1383660FED
	for <linux-fstests@archiver.kernel.org>; Thu, 21 Oct 2021 19:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbhJUTML (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 21 Oct 2021 15:12:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27856 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230103AbhJUTML (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 Oct 2021 15:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634843394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x3n/buj3+Fx1YpxN8m/ECDov/n4bQC3WQzS8HRFSoKI=;
        b=YkRZmlfNt56azCbnsfR9YDZM5CbWRCoUSIU3Ih/jbddsGTIBMkBcekBwtNpH7jcx9E+bDi
        P6z9Ee1W4xz/I2kSACPiuYBY/2BQQYJnTBIyU7UML7kVaACNj87UfBgucqku+POqJRg8Hj
        ROeg6J6q9P9X1HIoxBRjMbiaxSwqqOQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-FXGB4nNbOymYbQG4Ecnjdw-1; Thu, 21 Oct 2021 15:09:52 -0400
X-MC-Unique: FXGB4nNbOymYbQG4Ecnjdw-1
Received: by mail-qv1-f69.google.com with SMTP id 4-20020a05621420a400b003831d93e2b5so1841600qvd.12
        for <fstests@vger.kernel.org>; Thu, 21 Oct 2021 12:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x3n/buj3+Fx1YpxN8m/ECDov/n4bQC3WQzS8HRFSoKI=;
        b=WgKLjtm9wQkut/oEn/jUuPIgF9x427ofY8OnSG4yaulENvMpZ5Zi8dxTGy+8pdxsMb
         bXPboRBH+bIhD3Q1jWSdfMKVk0qkClcYq0hHRwBNxwA656x+87LKuMhT3eer+jFIokuk
         oViPITgIylh3J7vrfgPwnMGEdHeumogLiqkH9lMWvRveClHox9BRBPSnbNwW9kwEfIHP
         P7kX0ozp5+39xMyQ0L+Ut+je/PaM3BKsrONX3oLZPIn1cnRPQqnQJrzUIXqoMzMfX1Ga
         sc9xDUaTR0z2rjDKiYF9czYUA72uJfnRiYwOifCRvilg5woP5ApxG03nrLrtBSS1tDDJ
         Ydzg==
X-Gm-Message-State: AOAM532WXwBXdwjkRTAq/znixD5uVy6MGOdfDNTQBy0T8lO1APn/W4/o
        qBY8DSoZ4f3fhP+DpOj81LiouNnk6AjIEUZ/BKf90Ox4u/VHI/lZHatdKPPkdfD9eJMW72ucoee
        2b+ajcqOf3m+AjeKOVg==
X-Received: by 2002:ad4:4522:: with SMTP id l2mr3101979qvu.19.1634843391980;
        Thu, 21 Oct 2021 12:09:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGbHBPWS+OFzIAOVSJu12I/IxW7M9sKwj8+CKWx9ihgSxGfdJ16dAh3yokI87lI3zcyXYD2Q==
X-Received: by 2002:ad4:4522:: with SMTP id l2mr3101952qvu.19.1634843391743;
        Thu, 21 Oct 2021 12:09:51 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id p9sm2852443qki.51.2021.10.21.12.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 12:09:51 -0700 (PDT)
Date:   Thu, 21 Oct 2021 15:09:49 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] generic: test COW writeback failure when overlapping
 non-shared blocks
Message-ID: <YXG6/f7tAV4+zYfy@bfoster>
References: <20211021163959.1887011-1-bfoster@redhat.com>
 <20211021184005.GV24307@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021184005.GV24307@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Oct 21, 2021 at 11:40:05AM -0700, Darrick J. Wong wrote:
> On Thu, Oct 21, 2021 at 12:39:59PM -0400, Brian Foster wrote:
> > Test that COW writeback that overlaps non-shared delalloc blocks
> > does not leave around stale delalloc blocks on I/O failure. This
> > triggers assert failures and free space accounting corruption on
> > XFS.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> > 
> > This test targets the problem addressed by the following patch in XFS:
> > 
> > https://lore.kernel.org/linux-xfs/20211021163330.1886516-1-bfoster@redhat.com/
> > 
> > Brian
> > 
> >  tests/generic/651     | 53 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/651.out |  2 ++
> >  2 files changed, 55 insertions(+)
> >  create mode 100755 tests/generic/651
> >  create mode 100644 tests/generic/651.out
> > 
> > diff --git a/tests/generic/651 b/tests/generic/651
> > new file mode 100755
> > index 00000000..8d4e6728
> > --- /dev/null
> > +++ b/tests/generic/651
> > @@ -0,0 +1,53 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2021 Red Hat, Inc.  All Rights Reserved.
> > +#
> > +# FS QA Test 651
> > +#
> > +# Test that COW writeback that overlaps non-shared delalloc blocks does not
> > +# leave around stale delalloc blocks on I/O failure. This triggers assert
> > +# failures and free space accounting corruption on XFS.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick clone
> > +
> > +_cleanup()
> > +{
> > +	_cleanup_flakey
> > +	cd /
> > +	rm -r -f $tmp.*
> > +}
> > +
> > +# Import common functions.
> > +. ./common/reflink
> > +. ./common/dmflakey
> > +
> > +# real QA test starts here
> > +_supported_fs generic
> > +_require_scratch_reflink
> > +_require_flakey_with_error_writes
> 
> _require_cp_reflink
> 
> > +
> > +_scratch_mkfs >> $seqres.full
> > +_init_flakey
> > +_mount_flakey
> > +
> > +# create two files that share a single block
> > +$XFS_IO_PROG -fc "pwrite 4k 4k" $SCRATCH_MNT/file1 >> $seqres.full
> 
> Please use:
> 
> blksz=$(_get_file_block_size $SCRATCH_MNT)
> $XFS_IO_PROG -fc "pwrite $blksz $blksz" $SCRATCH_MNT/file1 >> $seqres.full
> 
> So that this test will work properly on filesystems with bs > 4k.
> 

Yeah, I'll fix the various hardcoded sizes. Thanks.

> > +cp --reflink $SCRATCH_MNT/file1 $SCRATCH_MNT/file2
> 
> Nit: This could be shortened to use the _cp_reflink helper, though it
> doesn't really matter to me if you do.
> 

Didn't know we had it. I'll look into it.

> > +# Perform a buffered write across the shared and non-shared blocks. On XFS, this
> > +# creates a COW fork extent that covers the shared block as well as the just
> 
> Ah, the reason why there's a cow fork extent covering the delalloc
> reservation is due to the default cow extent size hint, right?  In that
> case, you need:
> 

Yeah..

> _require_xfs_io_command "cowextsize"
> $XFS_IO_PROG -c "cowextsize 0" $SCRATCH_MNT >> $seqres.full
> 
> to ensure that the speculative cow preallocation actually gets set up.
> Otherwise, I think test won't reproduce the bug if the test config has
> -d cowextsize=1 in the mkfs options.
> 

.. but then we aren't susceptible to the problem, right?

I sometimes waffle on whether it's better for a test to create a
problematic situation and test it, or run on the configuration specified
by the user and test a particular scenario against that. Maybe the
former makes more sense in this very specific test case, but then I
suppose "cowextsize blksz*2" (or whatever large enough value) is
probably more robust than "cowextsize 0" (which I assume means "default"
and thus can change, right)?

Brian

> > +# created non-shared delalloc block. Fail the writeback to verify that all
> > +# delayed allocation is cleaned up properly.
> > +_load_flakey_table $FLAKEY_ERROR_WRITES
> > +$XFS_IO_PROG -c "pwrite 0 8k" -c fsync $SCRATCH_MNT/file2 >> $seqres.full
> 
> $((2 * blksz)), not 8k
> 
> Other than that, this looks reasonable to me.  I'll go look at the fix
> patch now. :)
> 
> --D
> 
> > +_load_flakey_table $FLAKEY_ALLOW_WRITES
> > +
> > +# Try a post-fail reflink and then unmount. Both of these are known to produce
> > +# errors and/or assert failures on XFS if we trip over a stale delalloc block.
> > +cp --reflink $SCRATCH_MNT/file2 $SCRATCH_MNT/file3
> > +_unmount_flakey
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/generic/651.out b/tests/generic/651.out
> > new file mode 100644
> > index 00000000..bd44c80c
> > --- /dev/null
> > +++ b/tests/generic/651.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 651
> > +fsync: Input/output error
> > -- 
> > 2.31.1
> > 
> 

