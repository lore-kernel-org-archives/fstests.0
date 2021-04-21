Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452DCC433ED
	for <linux-fstests@archiver.kernel.org>; Wed, 21 Apr 2021 15:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 008A76144E
	for <linux-fstests@archiver.kernel.org>; Wed, 21 Apr 2021 15:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240975AbhDUPwa (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 21 Apr 2021 11:52:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36316 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235510AbhDUPwa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 21 Apr 2021 11:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619020316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UY1Snorpdvz7uRd1ZmNOqLln4Vx/TRzDzwMyi1pNOxk=;
        b=eSNulOjkp4OTO7SvZy77QMGS1MT1y0c2ckbq7h0lnWmtrJ+cXXv9b2BgK/qS4eciIC9RkV
        M6ofGHQ10x7aGIXBAc+ziv1iCjvtcRI6tn/KI+8fxS8BYNNYtK3Y6zxfS+dx9hOV33TxP0
        afsFItHFlZ2Uzd24/moGSFccgyCph30=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-5oa7y6k0OVCJritUCVD5Lw-1; Wed, 21 Apr 2021 11:51:49 -0400
X-MC-Unique: 5oa7y6k0OVCJritUCVD5Lw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEC57107ACE6;
        Wed, 21 Apr 2021 15:51:48 +0000 (UTC)
Received: from bfoster (ovpn-112-25.rdu2.redhat.com [10.10.112.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E693B1B47E;
        Wed, 21 Apr 2021 15:51:47 +0000 (UTC)
Date:   Wed, 21 Apr 2021 11:51:46 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Boyang Xue <bxue@redhat.com>
Cc:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org,
        Ming Lei <minlei@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>
Subject: Re: [PATCH v1] generic/563: tolerate small reads in "write ->
 read/write" sub-test
Message-ID: <YIBKEqgYRtEnc/0v@bfoster>
References: <20210415062744.826644-1-bxue@redhat.com>
 <YHwpcP6nBL9n/AAT@desktop>
 <CAHLe9YYLQ3ztMs51M-H-ZXrfcCbrHBL1P2FOUT4TTJBrWbSKEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLe9YYLQ3ztMs51M-H-ZXrfcCbrHBL1P2FOUT4TTJBrWbSKEQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 19, 2021 at 02:06:16PM +0800, Boyang Xue wrote:
> (resend with plaintext due to previous email to
> fstests@vger.kernel.org has been rejected)
> 
> Hi Eryu,
> 
> The earliest version I have tested is kernel-5.9.0 and the latest
> kernel-4.18.0 (with kernel arg "systemd.unified_cgroup_hierarchy=1" ,
> or the test won't run). They both fails with the exact same log, like:
> 
> ```
> [root@kvm106 repo_xfstests]# ./check -d -T generic/563
> FSTYP         -- ext3
> PLATFORM      -- Linux/x86_64 kvm106 4.18.0-304.el8.x86_64 #1 SMP Tue
> Apr 6 05:19:59 EDT 2021
> MKFS_OPTIONS  -- -b 4096 /dev/vda3
> MOUNT_OPTIONS -- -o acl,user_xattr -o
> context=system_u:object_r:root_t:s0 /dev/vda3 /scratch
> 
> generic/563             [05:08:24]QA output created by 563
> read/write
> read is in range
> write is in range
> write -> read/write
> read has value of 12288
> read is NOT in range 0 .. 0
> write is in range
> read is in range
> write is in range
> read -> read/write
> read is in range
> write is in range
> read is in range
> write is in range
>  [05:08:27]- output mismatch (see
> /tmp/tmp.I3taRnCG0G/repo_xfstests/results//generic/563.out.bad)
>     --- tests/generic/563.out   2021-04-08 19:44:18.388630879 -0400
>     +++ /tmp/tmp.I3taRnCG0G/repo_xfstests/results//generic/563.out.bad
>  2021-04-19 05:08:27.650997209 -0400
>     @@ -3,7 +3,8 @@
>      read is in range
>      write is in range
>      write -> read/write
>     -read is in range
>     +read has value of 12288
>     +read is NOT in range 0 .. 0
>      write is in range
>     ...
>     (Run 'diff -u
> /tmp/tmp.I3taRnCG0G/repo_xfstests/tests/generic/563.out
> /tmp/tmp.I3taRnCG0G/repo_xfstests/results//generic/563.out.bad'  to
> see the entire diff)
> Ran: generic/563
> Failures: generic/563
> Failed 1 of 1 tests
> ```
> 
> I'm not sure what had been read for 12288 here, but either way, I
> think the read should not be part of the goal of this test, and should
> not fail the test.
> 

I think Ming Lei pointed out downstream that several single block
metadata reads can occur on ext3 during this subtest and this appears to
be expected behavior (stack below [1]). I'm not an expert on ext, but it
looks to me like it's reading the block mapping or some such in order to
direct the write. Given that, I think this patch generally has the right
idea. The purpose of the subtest is to make sure the larger pwrite is
accounted to the correct cgroup, not necessarily enforce that zero bytes
are read in service of the write.

It might be helpful to point out some of these details in the commit
log. Otherwise I'll put any further feedback on the patch in a separate
mail..

Brian

[1] Callchain of the offending read:

@ext3_read_bio[
    submit_bio+1
    submit_bh_wbc+365
    ext4_read_bh+72
    ext4_get_branch+201
    ext4_ind_map_blocks+382
    ext4_map_blocks+295
    _ext4_get_block+170
    __block_write_begin_int+328
    ext4_write_begin+541
    generic_perform_write+213
    ext4_buffered_write_iter+167
    new_sync_write+345
    vfs_write+438
    __x64_sys_pwrite64+140
    do_syscall_64+51
    entry_SYSCALL_64_after_hwframe+68
, 5793, 12]: 3

> Thanks,
> Boyang
> 
> 
> On Sun, Apr 18, 2021 at 8:43 PM Eryu Guan <guan@eryu.me> wrote:
> >
> > On Thu, Apr 15, 2021 at 02:27:44PM +0800, Boyang Xue wrote:
> > > From: Boyang Xue <bxue@redhat.com>
> > >
> > > On ext2/ext3, there're small reads when writing to file in the same cgroup.
> > > Since this sub-test tests that if read/write from 2nd cgroup is both 0 after
> > > writing in 1st cgroup, these small reads from 1st cgroup should not fail the
> > > test. This patch fixes the sub-test in order to tolerate small reads in 1st
> > > cgroup.
> > >
> > > Signed-off-by: Boyang Xue <bxue@redhat.com>
> > > ---
> > > Hi,
> > >
> > > I found generic/563 fails on ext2/ext3 on the latest kernel:
> >
> > I'm not sure if the read bytes should be ignored in this test, or it
> > just uncovers ext2/3 bug. Does it fail with previous kernels?
> >
> > Thanks,
> > Eryu
> >
> > >
> > > [root@kvm109 repo_xfstests]# ./check generic/563
> > > FSTYP         -- ext3
> > > PLATFORM      -- Linux/x86_64 kvm109 5.12.0-0.rc3.170.xx.x86_64 #1 SMP Tue Mar
> > > 16 12:02:55 EDT 2021
> > > MKFS_OPTIONS  -- -b 4096 /dev/vda3
> > > MOUNT_OPTIONS -- -o rw,relatime,seclabel -o context=system_u:object_r:root_t:s0
> > > /dev/vda3 /scratch
> > >
> > > generic/563 4s ... - output mismatch (see
> > > /tmp/tmp.hMWbgkavD4/repo_xfstests/results//generic/563.out.bad)
> > >     --- tests/generic/563.out   2021-04-01 02:07:16.303329895 -0400
> > >     +++ /tmp/tmp.hMWbgkavD4/repo_xfstests/results//generic/563.out.bad
> > > 2021-04-01 03:06:19.240329895 -0400
> > >     @@ -3,7 +3,8 @@
> > >      read is in range
> > >      write is in range
> > >      write -> read/write
> > >     -read is in range
> > >     +read has value of 12288
> > >     +read is NOT in range 0 .. 0
> > >      write is in range
> > >     ...
> > >     (Run 'diff -u /tmp/tmp.hMWbgkavD4/repo_xfstests/tests/generic/563.out
> > > /tmp/tmp.hMWbgkavD4/repo_xfstests/results//generic/563.out.bad'  to see the
> > > entire diff)
> > > Ran: generic/563
> > > Failures: generic/563
> > > Failed 1 of 1 tests
> > > ```
> > >
> > > generic/563 code
> > > ```
> > > ...
> > > # Write from one cgroup then read and write from a second. Writes are charged to
> > > # the first group and nothing to the second.
> > > echo "write -> read/write"
> > > reset  <== I have injected commands here for check, it turns out it indeed
> > > resets rbytes and wbytes both to 0.
> > > switch_cg $cgdir/$seq-cg
> > > $XFS_IO_PROG -c "pwrite 0 $iosize" $SCRATCH_MNT/file >> $seqres.full 2>&1
> > > switch_cg $cgdir/$seq-cg-2
> > > $XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" $SCRATCH_MNT/file \
> > >       >> $seqres.full 2>&1
> > > switch_cg $cgdir
> > > $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
> > > check_cg $cgdir/$seq-cg 0 $iosize  <== problem here, expected read bytes = 0,
> > > but it's 12288
> > > check_cg $cgdir/$seq-cg-2 0 0
> > > ...
> > > ```
> > >
> > > local.config
> > > ```
> > > FSTYP="ext3"
> > > TEST_DIR="/test"
> > > TEST_DEV="/dev/vda2"
> > > SCRATCH_MNT="/scratch"
> > > SCRATCH_DEV="/dev/vda3"
> > > LOGWRITES_MNT="/logwrites"
> > > LOGWRITES_DEV="/dev/vda6"
> > > MKFS_OPTIONS="-b 4096"
> > > MOUNT_OPTIONS="-o rw,relatime,seclabel"
> > > TEST_FS_MOUNT_OPTS="-o rw,relatime,seclabel"
> > > ```
> > >
> > > I think the "write -> read/write" sub-test should test if the read/write bytes
> > > in 2nd cgroup both are 0, after writing in the 1st cgroup. Given that it writes
> > > 8MB in cgroup, dozens of small reads in service of the write (like read
> > > metadata) is not part of the goal of the sub-test, and should be tolerate,
> > > rather than fail the test.
> > >
> > > Currently, the expected read bytes in the 1st cgroup is strictly 0. This patch
> > > sets a fixed tolerant value, so read bytes in the range of 0-(tolerant value) is
> > > tolerant, doesn't fail the test.
> > >
> > > I have run the original test on ext2/ext3/ext4 with 1k/2k/4k blksize on x86_64,
> > > aarch64, s390x, ppc64le, to determine the tolerant value. It turns out the
> > > maximum read bytes in the tests is 33792. So I think set the tolerant value
> > > to 33800 is adequate.
> > >
> > > Please help review this patch. Thanks.
> > >
> > > -Boyang
> > >
> > >  tests/generic/563 | 16 +++++++++-------
> > >  1 file changed, 9 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/tests/generic/563 b/tests/generic/563
> > > index b113eacf..83146721 100755
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
> > >
> > >  # Write from one cgroup then read and write from a second. Writes are charged to
> > >  # the first group and nothing to the second.
> > > @@ -126,8 +128,8 @@ $XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" $SCRATCH_MNT/file \
> > >       >> $seqres.full 2>&1
> > >  switch_cg $cgdir
> > >  $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
> > > -check_cg $cgdir/$seq-cg 0 $iosize
> > > -check_cg $cgdir/$seq-cg-2 0 0
> > > +check_cg $cgdir/$seq-cg 0 $iosize 33800 5%
> > > +check_cg $cgdir/$seq-cg-2 0 0 5% 5%
> > >
> > >  # Read from one cgroup, read & write from a second. Both reads and writes are
> > >  # charged to the first group and nothing to the second.
> > > @@ -140,8 +142,8 @@ $XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" $SCRATCH_MNT/file \
> > >       >> $seqres.full 2>&1
> > >  switch_cg $cgdir
> > >  $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
> > > -check_cg $cgdir/$seq-cg $iosize $iosize
> > > -check_cg $cgdir/$seq-cg-2 0 0
> > > +check_cg $cgdir/$seq-cg $iosize $iosize 5% 5%
> > > +check_cg $cgdir/$seq-cg-2 0 0 5% 5%
> > >
> > >  echo "-io" > $cgdir/cgroup.subtree_control || _fail "subtree control"
> > >
> > > --
> > > 2.27.0
> >
> 

