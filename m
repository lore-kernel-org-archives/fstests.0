Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B53C433B4
	for <linux-fstests@archiver.kernel.org>; Thu, 22 Apr 2021 09:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C158561422
	for <linux-fstests@archiver.kernel.org>; Thu, 22 Apr 2021 09:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235339AbhDVJcy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 22 Apr 2021 05:32:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21802 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230341AbhDVJcv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 22 Apr 2021 05:32:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619083936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=81TLple0Tx+u9fKEIlYsaGfArXaYg3zHr8ALFE3L7LM=;
        b=D0GtTV7Sjh93Vjk/vvyjFCM9L9hjZhKaqyfe9+aLyEw6CWDXjQfHH47/ZUOAeQYCEFKBLk
        79yPTgPSmxDxMf0+tzQfiwAyui2NPNCl0NO1xK7q3dqaU3CLA0Ct7bhnrDIxBhmB6BpX3T
        RIE1AeLQX0o3xjCMB/3Oqrxgx11AUnE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-w7BDBDDYMjGvTCV2mXV7_g-1; Thu, 22 Apr 2021 05:31:43 -0400
X-MC-Unique: w7BDBDDYMjGvTCV2mXV7_g-1
Received: by mail-wr1-f70.google.com with SMTP id v20-20020a5d59140000b02901028c7a1f7dso13540877wrd.18
        for <fstests@vger.kernel.org>; Thu, 22 Apr 2021 02:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=81TLple0Tx+u9fKEIlYsaGfArXaYg3zHr8ALFE3L7LM=;
        b=hCcuKWhlp+sy6YpvW+WOxXgzTzMM4/QX2D6nviVGtFI68exSq1WGHB8+dGFwJm6NM+
         yRxAGJTqMZKTlWjW4CmMVjRHt8B8v+baJ2pFX7zTnks7mRJOfEnR6dU58SI9tcBWv0s+
         x/08nqpv/0lerVYIlpXBl5CmgSdg0lvZmqF/hcyjOzG3GLco0AZPbdnVuJQBxfBd1kiP
         SqhmMzaUUGRYS1N1E4RUgjmHf1VjN8kvPUJ94SGwKvWw84ArIekDW5RTjUesSOJaKT56
         iEtSACXEYpt+bY6CPkLjngakCstaXwXAQTfLsF93Ix1EIeKHEwcM5fC8RRXB4iTvTmj3
         BPdw==
X-Gm-Message-State: AOAM533yYGkAbg1KBQZGJDO8+EhCt3paXhnxGax8q0wHdUUgcbaFQmX7
        elNax3pmptEvJjR/LFKNG4ZCy/68JWK/ZGJGN6YhxWdZh36kzK30CbyADafX6RjMUkkeAejYQuH
        2yg3mgczjQq0JHDdwUw1xC3hSXppc4D9qXw==
X-Received: by 2002:adf:e747:: with SMTP id c7mr2920510wrn.220.1619083902029;
        Thu, 22 Apr 2021 02:31:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTDZXblAFe5kVfqDR5lGbbIul0JKTgKK4wrWrd484TEu3k2qGuai/8F02ovjDHBixn8CXKfowh3XfgvU19AvA=
X-Received: by 2002:adf:e747:: with SMTP id c7mr2920494wrn.220.1619083901770;
 Thu, 22 Apr 2021 02:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210415062744.826644-1-bxue@redhat.com> <YIBKawaUlcyiETie@bfoster>
In-Reply-To: <YIBKawaUlcyiETie@bfoster>
From:   Boyang Xue <bxue@redhat.com>
Date:   Thu, 22 Apr 2021 17:31:29 +0800
Message-ID: <CAHLe9YZcZi-ihhozVy=WEYXg1cy1-b+e7zi0kf6vqsPeSOzYvA@mail.gmail.com>
Subject: Re: [PATCH v1] generic/563: tolerate small reads in "write ->
 read/write" sub-test
To:     Brian Foster <bfoster@redhat.com>
Cc:     fstests@vger.kernel.org, Ming Lei <minlei@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Brian,

Thanks for the review. Please find my reply inline below.

On Wed, Apr 21, 2021 at 11:53 PM Brian Foster <bfoster@redhat.com> wrote:
>
> On Thu, Apr 15, 2021 at 02:27:44PM +0800, bxue@redhat.com wrote:
> > From: Boyang Xue <bxue@redhat.com>
> >
> > On ext2/ext3, there're small reads when writing to file in the same cgroup.
> > Since this sub-test tests that if read/write from 2nd cgroup is both 0 after
> > writing in 1st cgroup, these small reads from 1st cgroup should not fail the
> > test. This patch fixes the sub-test in order to tolerate small reads in 1st
> > cgroup.
> >
> > Signed-off-by: Boyang Xue <bxue@redhat.com>
> > ---
> > Hi,
> >
> > I found generic/563 fails on ext2/ext3 on the latest kernel:
> >
> > [root@kvm109 repo_xfstests]# ./check generic/563
> > FSTYP         -- ext3
> > PLATFORM      -- Linux/x86_64 kvm109 5.12.0-0.rc3.170.xx.x86_64 #1 SMP Tue Mar
> > 16 12:02:55 EDT 2021
> > MKFS_OPTIONS  -- -b 4096 /dev/vda3
> > MOUNT_OPTIONS -- -o rw,relatime,seclabel -o context=system_u:object_r:root_t:s0
> > /dev/vda3 /scratch
> >
> > generic/563 4s ... - output mismatch (see
> > /tmp/tmp.hMWbgkavD4/repo_xfstests/results//generic/563.out.bad)
> >     --- tests/generic/563.out   2021-04-01 02:07:16.303329895 -0400
> >     +++ /tmp/tmp.hMWbgkavD4/repo_xfstests/results//generic/563.out.bad
> > 2021-04-01 03:06:19.240329895 -0400
> >     @@ -3,7 +3,8 @@
> >      read is in range
> >      write is in range
> >      write -> read/write
> >     -read is in range
> >     +read has value of 12288
> >     +read is NOT in range 0 .. 0
> >      write is in range
> >     ...
> >     (Run 'diff -u /tmp/tmp.hMWbgkavD4/repo_xfstests/tests/generic/563.out
> > /tmp/tmp.hMWbgkavD4/repo_xfstests/results//generic/563.out.bad'  to see the
> > entire diff)
> > Ran: generic/563
> > Failures: generic/563
> > Failed 1 of 1 tests
> > ```
> >
> > generic/563 code
> > ```
> > ...
> > # Write from one cgroup then read and write from a second. Writes are charged to
> > # the first group and nothing to the second.
> > echo "write -> read/write"
> > reset  <== I have injected commands here for check, it turns out it indeed
> > resets rbytes and wbytes both to 0.
> > switch_cg $cgdir/$seq-cg
> > $XFS_IO_PROG -c "pwrite 0 $iosize" $SCRATCH_MNT/file >> $seqres.full 2>&1
> > switch_cg $cgdir/$seq-cg-2
> > $XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" $SCRATCH_MNT/file \
> >       >> $seqres.full 2>&1
> > switch_cg $cgdir
> > $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
> > check_cg $cgdir/$seq-cg 0 $iosize  <== problem here, expected read bytes = 0,
> > but it's 12288
> > check_cg $cgdir/$seq-cg-2 0 0
> > ...
> > ```
> >
> > local.config
> > ```
> > FSTYP="ext3"
> > TEST_DIR="/test"
> > TEST_DEV="/dev/vda2"
> > SCRATCH_MNT="/scratch"
> > SCRATCH_DEV="/dev/vda3"
> > LOGWRITES_MNT="/logwrites"
> > LOGWRITES_DEV="/dev/vda6"
> > MKFS_OPTIONS="-b 4096"
> > MOUNT_OPTIONS="-o rw,relatime,seclabel"
> > TEST_FS_MOUNT_OPTS="-o rw,relatime,seclabel"
> > ```
> >
> > I think the "write -> read/write" sub-test should test if the read/write bytes
> > in 2nd cgroup both are 0, after writing in the 1st cgroup. Given that it writes
> > 8MB in cgroup, dozens of small reads in service of the write (like read
> > metadata) is not part of the goal of the sub-test, and should be tolerate,
> > rather than fail the test.
> >
> > Currently, the expected read bytes in the 1st cgroup is strictly 0. This patch
> > sets a fixed tolerant value, so read bytes in the range of 0-(tolerant value) is
> > tolerant, doesn't fail the test.
> >
> > I have run the original test on ext2/ext3/ext4 with 1k/2k/4k blksize on x86_64,
> > aarch64, s390x, ppc64le, to determine the tolerant value. It turns out the
> > maximum read bytes in the tests is 33792. So I think set the tolerant value
> > to 33800 is adequate.
> >
> > Please help review this patch. Thanks.
> >
> > -Boyang
> >
> >  tests/generic/563 | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/tests/generic/563 b/tests/generic/563
> > index b113eacf..83146721 100755
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
> >
> >  # Write from one cgroup then read and write from a second. Writes are charged to
> >  # the first group and nothing to the second.
> > @@ -126,8 +128,8 @@ $XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" $SCRATCH_MNT/file \
> >       >> $seqres.full 2>&1
> >  switch_cg $cgdir
> >  $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
> > -check_cg $cgdir/$seq-cg 0 $iosize
> > -check_cg $cgdir/$seq-cg-2 0 0
> > +check_cg $cgdir/$seq-cg 0 $iosize 33800 5%
>
> Any reason for the 33800 value as opposed to an even 32k? Also a brief
> comment might be useful:

Test results from ext2/3/4 1k/2k/4k blksize shows the largest possible
value of the read bytes is 33792, so I chose this a bit larger value.
In my next version of the patch, I'm thinking fix the value to 33792,
for accuracy. Does it look better?

>
> # Use a fixed value tolerance for the expected value of zero here
> # because filesystems might perform a small number of metadata reads to
> # complete the write.

Thanks. I'm pasting this comment in the next version.

>
> > +check_cg $cgdir/$seq-cg-2 0 0 5% 5%
> >
>
> I'm not sure it ever really makes sense to have a percentage tolerance
> when the expected values are zero. This is the case with the current
> implementation simply because the tolerance is hardcoded in the helper
> function. If we're going to pass the tolerances for each test along with
> the expected values, it might make a bit more sense to pass along a 0
> tolerance where that is expected. Otherwise the rest LGTM. Thanks for
> sending the patch..

Good idea. I'll fix the test in this way.

>
> Brian
>
> >  # Read from one cgroup, read & write from a second. Both reads and writes are
> >  # charged to the first group and nothing to the second.
> > @@ -140,8 +142,8 @@ $XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" $SCRATCH_MNT/file \
> >       >> $seqres.full 2>&1
> >  switch_cg $cgdir
> >  $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
> > -check_cg $cgdir/$seq-cg $iosize $iosize
> > -check_cg $cgdir/$seq-cg-2 0 0
> > +check_cg $cgdir/$seq-cg $iosize $iosize 5% 5%
> > +check_cg $cgdir/$seq-cg-2 0 0 5% 5%
> >
> >  echo "-io" > $cgdir/cgroup.subtree_control || _fail "subtree control"
> >
> > --
> > 2.27.0
> >
>

I will fix all these together with more details in the commit log, and
post the next version soon.

Thanks!
-Boyang

