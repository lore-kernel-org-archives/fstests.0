Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B247C433ED
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Apr 2021 12:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4379060FE6
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Apr 2021 12:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhDZMJ2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 26 Apr 2021 08:09:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40748 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231550AbhDZMJ1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 26 Apr 2021 08:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619438925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yVMtGxzVEHNDZDwrdVPJYr7m9WsUWxzFAeAymDm+8ao=;
        b=fdofeEhmPjQXUabdTg4FpMhB6UdCGWpo1YjTl6121NW7XXE+V+4BIRv6TT06XqSAUYFsQ4
        hv0yqgwJjmiGEcs040ht/XJYfolmRi471nZGR9jd2l4MwHj49OF3mXFGVu11YE+XwtH11f
        5yqLrSSIo1/fNgljJsE1TFpGepU4Cx8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-cH2eSwfTPjG0z3MzFq9RdQ-1; Mon, 26 Apr 2021 08:08:43 -0400
X-MC-Unique: cH2eSwfTPjG0z3MzFq9RdQ-1
Received: by mail-qt1-f199.google.com with SMTP id h2-20020a05622a1702b02901b9123889b0so13925675qtk.10
        for <fstests@vger.kernel.org>; Mon, 26 Apr 2021 05:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yVMtGxzVEHNDZDwrdVPJYr7m9WsUWxzFAeAymDm+8ao=;
        b=NEAEAFMjhs/5lMnIfo8g30XUbvAJATjYBfah+hRmDko5UrcFPOJ8V9Phfbtz+9Xn5s
         zR1QRI7XgZZk0g/NWy1X9WIuFKyHv+10aayp0h49wa/exw7R1GPOUNo+MfmtW2QKHT+M
         NAGk/ndAR/QzSCs5WggtbK/aIfncItH+ixsUibldmFgLgl/RBqNbHxA6FQk4OLQmZyJq
         F3WQHvsNnuWzKnib6/+kR77SV0lmM84nM4n2jydxQuoRb5IRUTIkWFLu6MLO7MGxGMB0
         K2grS6otOx8D/0u3Whurxyg7g4OWcqeWuXoyfZFBC4ChetDRuJiIPRP7MdiBggOksD4f
         SIIw==
X-Gm-Message-State: AOAM532cL24NZdEwR3frcWDGkNew7RZioyYtZS+wZlN12Tuzpnpu/lsi
        NrXOp4VACuLtdXV+BjSw8FE1sCK9G62gWDAWV+X2YRg42LEH1O+jl8+1rvbgbM5/ADSUmZTL7ug
        Lckrv40R5UMZ1Hvdqpg==
X-Received: by 2002:a37:7006:: with SMTP id l6mr16826906qkc.137.1619438922906;
        Mon, 26 Apr 2021 05:08:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHOCg5olIzgJA6H2ygaoJWxesqFcxb6/ImlOHt+/kroew4xAYefaHvlaFV1Lj66wzqomMhPA==
X-Received: by 2002:a37:7006:: with SMTP id l6mr16826872qkc.137.1619438922606;
        Mon, 26 Apr 2021 05:08:42 -0700 (PDT)
Received: from bfoster ([98.216.211.229])
        by smtp.gmail.com with ESMTPSA id i5sm10941459qka.0.2021.04.26.05.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 05:08:42 -0700 (PDT)
Date:   Mon, 26 Apr 2021 08:08:35 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Boyang Xue <bxue@redhat.com>
Cc:     fstests@vger.kernel.org, Ming Lei <minlei@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>
Subject: Re: [PATCH v2] generic/563: tolerate small reads in "write ->
 read/write" sub-test
Message-ID: <YIatQ0AWAc9wEcWs@bfoster>
References: <20210422153147.1049666-1-bxue@redhat.com>
 <YIKqZZTRZPFjtQwh@bfoster>
 <CAHLe9YajTPYfwn-K6t2gk=ybyYrOAkqHf1zSzkqbiekbQ2JVcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLe9YajTPYfwn-K6t2gk=ybyYrOAkqHf1zSzkqbiekbQ2JVcQ@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Apr 25, 2021 at 12:53:07PM +0800, Boyang Xue wrote:
> Hi Brian,
> 
> Please find my reply below inline.
> 
> On Fri, Apr 23, 2021 at 7:07 PM Brian Foster <bfoster@redhat.com> wrote:
> >
> > On Thu, Apr 22, 2021 at 11:31:47PM +0800, bxue@redhat.com wrote:
> > > From: Boyang Xue <bxue@redhat.com>
> > >
> > > On ext2/ext3, it's expected that several single block metadata reads can occur
> > > when writing to file in the same cgroup (the stack is like below[1]). The
> > > purpose of the "write -> read/write" subtest is to make sure the larger pwrite
> > > is accounted to the correct cgroup, not necessarily enforce that zero bytes are
> > > read in service of the write. This patch fixes the sub-test in order to tolerate
> > > small reads in 1st cgroup.
> > >
> > > [1] Callchain of the read:
> > >
> > > @ext3_read_bio[
> > >     submit_bio+1
> > >     submit_bh_wbc+365
> > >     ext4_read_bh+72
> > >     ext4_get_branch+201
> > >     ext4_ind_map_blocks+382
> > >     ext4_map_blocks+295
> > >     _ext4_get_block+170
> > >     __block_write_begin_int+328
> > >     ext4_write_begin+541
> > >     generic_perform_write+213
> > >     ext4_buffered_write_iter+167
> > >     new_sync_write+345
> > >     vfs_write+438
> > >     __x64_sys_pwrite64+140
> > >     do_syscall_64+51
> > >     entry_SYSCALL_64_after_hwframe+68
> > > , 5793, 12]: 3
> > >
> > > Signed-off-by: Boyang Xue <bxue@redhat.com>
> > > ---
> > > Hi,
> > >
> > > This patch fix the "write -> read/write" sub-test in order to tolerate
> > > small reads in service of the write (like read metadata).
> > >
> > > Change from v1:
> > > (1) More details in commit log, including example call stack
> > > (2) Set the fixed tolerance value to 33792 for accuracy
> > > (3) Update percentage tolerance value to fixed value 0, where doesn't
> > > fail the test
> > >
> > > Tested pass on ext2/ext3/ext4 x 1k/2k/4k blksize.
> > >
> > > Thanks,
> > > Boyang
> > >
> > >  tests/generic/563 | 20 +++++++++++++-------
> > >  1 file changed, 13 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/tests/generic/563 b/tests/generic/563
> > > index b113eacf..44394b4b 100755
> > > --- a/tests/generic/563
> > > +++ b/tests/generic/563
> > > @@ -60,6 +60,8 @@ check_cg()
> > >       cgname=$(basename $cgroot)
> > >       expectedread=$2
> > >       expectedwrite=$3
> > > +     readtol=$4
> > > +     writetol=$5
> > >       rbytes=0
> > >       wbytes=0
> > >
> > > @@ -71,8 +73,8 @@ check_cg()
> > >                       awk -F = '{ print $2 }'`
> > >       fi
> > >
> > > -     _within_tolerance "read" $rbytes $expectedread 5% -v
> > > -     _within_tolerance "write" $wbytes $expectedwrite 5% -v
> > > +     _within_tolerance "read" $rbytes $expectedread $readtol -v
> > > +     _within_tolerance "write" $wbytes $expectedwrite $writetol -v
> > >  }
> > >
> > >  # Move current process to another cgroup.
> > > @@ -113,7 +115,7 @@ $XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" -c fsync \
> > >       $SCRATCH_MNT/file >> $seqres.full 2>&1
> > >  switch_cg $cgdir
> > >  $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
> > > -check_cg $cgdir/$seq-cg $iosize $iosize
> > > +check_cg $cgdir/$seq-cg $iosize $iosize 5% 5%
> 
> Here the write tolerance has to be 5% rather than 0, since testing
> with ext2, the write bytes are slightly larger than $iosize (8392704
> vs 8388608).
> 

Yeah, for any non-zero values the write tolerance should always be 5%.
That's the historical behavior of the test.

> > >
> > >  # Write from one cgroup then read and write from a second. Writes are charged to
> > >  # the first group and nothing to the second.
> > > @@ -126,8 +128,12 @@ $XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" $SCRATCH_MNT/file \
> > >       >> $seqres.full 2>&1
> > >  switch_cg $cgdir
> > >  $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
> > > -check_cg $cgdir/$seq-cg 0 $iosize
> > > -check_cg $cgdir/$seq-cg-2 0 0
> > > +# Use a fixed value tolerance for the expected value of zero here
> > > +# because filesystems might perform a small number of metadata reads to
> > > +# complete the write. On ext2/3 with 1k block size, the read bytes is
> > > +# as large as 33792.
> > > +check_cg $cgdir/$seq-cg 0 $iosize 33792 0
> >
> > Shouldn't that last parameter (write tolerance) remain as 5%?
> 
> In my test on ext2/3/4 with 1k/2k/4k, the write tolerance here always
> equals $iosize in this sub-test. So make it 0 rather 5%, I hope it
> will gate future behavior change more sensitively.
> 

I think that deviates from the purpose of the test. I don't think we
want to filter this change in behavior down through folks' test
environments just because it happens to be exact in some cases. The
original purpose of the tolerance was to filter out this kind of noise
and test the general effectiveness of the cgroup writeback accounting,
not to capture and document current or future deviations from the exact
I/O sizes being used.

The problem this patch should fix is that the original test didn't
properly account for potential metadata I/O to support data I/O by
virtue of the 5% tolerance being applied to an iosize of 0. Otherwise, I
don't think it should change the behavior of the test in any way. You
could always create a new fs-specific test if you wanted to test for
precise accounting values for specific filesystem(s). Personally, I
don't think that's really necessary because when such a test fails it
seems more likely to me we'd end up just having to fix the test over
changing things on the kernel side, but that's just my .02.

Brian

> >
> > > +check_cg $cgdir/$seq-cg-2 0 0 0 0
> > >
> > >  # Read from one cgroup, read & write from a second. Both reads and writes are
> > >  # charged to the first group and nothing to the second.
> > > @@ -140,8 +146,8 @@ $XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" $SCRATCH_MNT/file \
> > >       >> $seqres.full 2>&1
> > >  switch_cg $cgdir
> > >  $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
> > > -check_cg $cgdir/$seq-cg $iosize $iosize
> > > -check_cg $cgdir/$seq-cg-2 0 0
> > > +check_cg $cgdir/$seq-cg $iosize $iosize 5% 0
> >
> > And here too? Otherwise the patch LGTM.
> 
> The same reason as above.
> 
> If the write tolerance mismatch confuses future readers, I can put a
> comment to explain. Maybe a single comment like this?
> 
> ```
> # Read and write from a single group.
> echo "read/write"
> reset
> switch_cg $cgdir/$seq-cg
> $XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" -c fsync \
>         $SCRATCH_MNT/file >> $seqres.full 2>&1
> switch_cg $cgdir
> $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
> # write bytes is slightly larger than $iosize on ext2  <=== new comment
> check_cg $cgdir/$seq-cg $iosize $iosize 5% 5%
> ```
> 
> Thanks for the review!
> 
> -Boyang
> 
> > Brian
> >
> > > +check_cg $cgdir/$seq-cg-2 0 0 0 0
> > >
> > >  echo "-io" > $cgdir/cgroup.subtree_control || _fail "subtree control"
> > >
> > > --
> > > 2.27.0
> > >
> >
> 

