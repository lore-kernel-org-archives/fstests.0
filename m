Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA53C433B4
	for <linux-fstests@archiver.kernel.org>; Sun, 25 Apr 2021 04:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74E2C61154
	for <linux-fstests@archiver.kernel.org>; Sun, 25 Apr 2021 04:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhDYEyD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 25 Apr 2021 00:54:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34775 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229648AbhDYEyC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 25 Apr 2021 00:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619326402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FRUmTjlS2/fNH+nrV+QzbgT1gM/1QPr1bNOFqHvxbVg=;
        b=AyvlGfEviDACJfTbBhc7NYbqy/em/+NrjsaUfnRqRs94EE5Kzmvx3qw2nMCegoFgM6EXYY
        4N1vltj9DYWY35xgx/88RKY5PsE5EM3RP0iOaEDgdHp4kZWDoPsIlFg4zyNyPybU+PXs0G
        UNaJ2+1Hf1Ct7FVUJPeNcKcltuMxJ80=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-6eAat3DwPQ-czYBXsbwMYg-1; Sun, 25 Apr 2021 00:53:19 -0400
X-MC-Unique: 6eAat3DwPQ-czYBXsbwMYg-1
Received: by mail-wr1-f69.google.com with SMTP id s9-20020a5d51090000b02901028ea30da6so16975211wrt.7
        for <fstests@vger.kernel.org>; Sat, 24 Apr 2021 21:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FRUmTjlS2/fNH+nrV+QzbgT1gM/1QPr1bNOFqHvxbVg=;
        b=NocJGccKIZz/Jh1nqirj2NsQB0zRhikTiFYpn/Sic/URueOfdMdXNqo0/Whyz2+5IG
         GHxh15xeWC0Jt2ie6M6O5yu2JlAvjcdE1oWlnipKyqGNQhckFWrV5Z6BpsZ6rub/t1wO
         LBOZqJe1Z3SiggW1SFRrm3pJpSjdcCqNAg2mPR8a9J5u7FIfTo+Gou89/DfcvlSSX3hB
         rVOQKaESvTIlp32BMSEvx0r7whK2kxKSbZ+w3vUhU5NolnrP7sHax6o1WAobjVrCsEJQ
         bzyqfVSI3CV0urwmub7KsmECWVMy/LbE42lyiixeCL1wiGZICfTiUz8rIVx/iEiR98wk
         oAzw==
X-Gm-Message-State: AOAM5317jQIstN18O6fVR+RQcHri5rL6LJ0wnEuN5m0ANfzRjLlI6YHn
        F1jK0KOOwFppGAZEysgxbIO4dHWHbOWHnqbG+hRhV3B+6WrTrC36c+awf1hzSlqm3Ssb6n8FR1t
        gA11THkxdHDMYwH+Xg49KqmGUy0u6/bN22Q==
X-Received: by 2002:adf:a4c4:: with SMTP id h4mr5488511wrb.340.1619326398542;
        Sat, 24 Apr 2021 21:53:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdXevm9n8VCtgfz7iHBSjKIc9d/ZYQ0LnE2gXl4PcJm4k1XsIM7XhlwlPRsV6wy0aEEAYefB/0aipAXljRgr4=
X-Received: by 2002:adf:a4c4:: with SMTP id h4mr5488494wrb.340.1619326398354;
 Sat, 24 Apr 2021 21:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210422153147.1049666-1-bxue@redhat.com> <YIKqZZTRZPFjtQwh@bfoster>
In-Reply-To: <YIKqZZTRZPFjtQwh@bfoster>
From:   Boyang Xue <bxue@redhat.com>
Date:   Sun, 25 Apr 2021 12:53:07 +0800
Message-ID: <CAHLe9YajTPYfwn-K6t2gk=ybyYrOAkqHf1zSzkqbiekbQ2JVcQ@mail.gmail.com>
Subject: Re: [PATCH v2] generic/563: tolerate small reads in "write ->
 read/write" sub-test
To:     Brian Foster <bfoster@redhat.com>
Cc:     fstests@vger.kernel.org, Ming Lei <minlei@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Brian,

Please find my reply below inline.

On Fri, Apr 23, 2021 at 7:07 PM Brian Foster <bfoster@redhat.com> wrote:
>
> On Thu, Apr 22, 2021 at 11:31:47PM +0800, bxue@redhat.com wrote:
> > From: Boyang Xue <bxue@redhat.com>
> >
> > On ext2/ext3, it's expected that several single block metadata reads can occur
> > when writing to file in the same cgroup (the stack is like below[1]). The
> > purpose of the "write -> read/write" subtest is to make sure the larger pwrite
> > is accounted to the correct cgroup, not necessarily enforce that zero bytes are
> > read in service of the write. This patch fixes the sub-test in order to tolerate
> > small reads in 1st cgroup.
> >
> > [1] Callchain of the read:
> >
> > @ext3_read_bio[
> >     submit_bio+1
> >     submit_bh_wbc+365
> >     ext4_read_bh+72
> >     ext4_get_branch+201
> >     ext4_ind_map_blocks+382
> >     ext4_map_blocks+295
> >     _ext4_get_block+170
> >     __block_write_begin_int+328
> >     ext4_write_begin+541
> >     generic_perform_write+213
> >     ext4_buffered_write_iter+167
> >     new_sync_write+345
> >     vfs_write+438
> >     __x64_sys_pwrite64+140
> >     do_syscall_64+51
> >     entry_SYSCALL_64_after_hwframe+68
> > , 5793, 12]: 3
> >
> > Signed-off-by: Boyang Xue <bxue@redhat.com>
> > ---
> > Hi,
> >
> > This patch fix the "write -> read/write" sub-test in order to tolerate
> > small reads in service of the write (like read metadata).
> >
> > Change from v1:
> > (1) More details in commit log, including example call stack
> > (2) Set the fixed tolerance value to 33792 for accuracy
> > (3) Update percentage tolerance value to fixed value 0, where doesn't
> > fail the test
> >
> > Tested pass on ext2/ext3/ext4 x 1k/2k/4k blksize.
> >
> > Thanks,
> > Boyang
> >
> >  tests/generic/563 | 20 +++++++++++++-------
> >  1 file changed, 13 insertions(+), 7 deletions(-)
> >
> > diff --git a/tests/generic/563 b/tests/generic/563
> > index b113eacf..44394b4b 100755
> > --- a/tests/generic/563
> > +++ b/tests/generic/563
> > @@ -60,6 +60,8 @@ check_cg()
> >       cgname=$(basename $cgroot)
> >       expectedread=$2
> >       expectedwrite=$3
> > +     readtol=$4
> > +     writetol=$5
> >       rbytes=0
> >       wbytes=0
> >
> > @@ -71,8 +73,8 @@ check_cg()
> >                       awk -F = '{ print $2 }'`
> >       fi
> >
> > -     _within_tolerance "read" $rbytes $expectedread 5% -v
> > -     _within_tolerance "write" $wbytes $expectedwrite 5% -v
> > +     _within_tolerance "read" $rbytes $expectedread $readtol -v
> > +     _within_tolerance "write" $wbytes $expectedwrite $writetol -v
> >  }
> >
> >  # Move current process to another cgroup.
> > @@ -113,7 +115,7 @@ $XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" -c fsync \
> >       $SCRATCH_MNT/file >> $seqres.full 2>&1
> >  switch_cg $cgdir
> >  $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
> > -check_cg $cgdir/$seq-cg $iosize $iosize
> > +check_cg $cgdir/$seq-cg $iosize $iosize 5% 5%

Here the write tolerance has to be 5% rather than 0, since testing
with ext2, the write bytes are slightly larger than $iosize (8392704
vs 8388608).

> >
> >  # Write from one cgroup then read and write from a second. Writes are charged to
> >  # the first group and nothing to the second.
> > @@ -126,8 +128,12 @@ $XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" $SCRATCH_MNT/file \
> >       >> $seqres.full 2>&1
> >  switch_cg $cgdir
> >  $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
> > -check_cg $cgdir/$seq-cg 0 $iosize
> > -check_cg $cgdir/$seq-cg-2 0 0
> > +# Use a fixed value tolerance for the expected value of zero here
> > +# because filesystems might perform a small number of metadata reads to
> > +# complete the write. On ext2/3 with 1k block size, the read bytes is
> > +# as large as 33792.
> > +check_cg $cgdir/$seq-cg 0 $iosize 33792 0
>
> Shouldn't that last parameter (write tolerance) remain as 5%?

In my test on ext2/3/4 with 1k/2k/4k, the write tolerance here always
equals $iosize in this sub-test. So make it 0 rather 5%, I hope it
will gate future behavior change more sensitively.

>
> > +check_cg $cgdir/$seq-cg-2 0 0 0 0
> >
> >  # Read from one cgroup, read & write from a second. Both reads and writes are
> >  # charged to the first group and nothing to the second.
> > @@ -140,8 +146,8 @@ $XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" $SCRATCH_MNT/file \
> >       >> $seqres.full 2>&1
> >  switch_cg $cgdir
> >  $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
> > -check_cg $cgdir/$seq-cg $iosize $iosize
> > -check_cg $cgdir/$seq-cg-2 0 0
> > +check_cg $cgdir/$seq-cg $iosize $iosize 5% 0
>
> And here too? Otherwise the patch LGTM.

The same reason as above.

If the write tolerance mismatch confuses future readers, I can put a
comment to explain. Maybe a single comment like this?

```
# Read and write from a single group.
echo "read/write"
reset
switch_cg $cgdir/$seq-cg
$XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" -c fsync \
        $SCRATCH_MNT/file >> $seqres.full 2>&1
switch_cg $cgdir
$XFS_IO_PROG -c fsync $SCRATCH_MNT/file
# write bytes is slightly larger than $iosize on ext2  <=== new comment
check_cg $cgdir/$seq-cg $iosize $iosize 5% 5%
```

Thanks for the review!

-Boyang

> Brian
>
> > +check_cg $cgdir/$seq-cg-2 0 0 0 0
> >
> >  echo "-io" > $cgdir/cgroup.subtree_control || _fail "subtree control"
> >
> > --
> > 2.27.0
> >
>

