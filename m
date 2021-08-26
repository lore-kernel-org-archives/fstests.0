Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67F3C432BE
	for <linux-fstests@archiver.kernel.org>; Thu, 26 Aug 2021 00:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 797E8610C8
	for <linux-fstests@archiver.kernel.org>; Thu, 26 Aug 2021 00:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbhHZAQi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 25 Aug 2021 20:16:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231210AbhHZAQh (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 25 Aug 2021 20:16:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72951610A7;
        Thu, 26 Aug 2021 00:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629936951;
        bh=D4U2lVOBrDajb95XRC9LTLWMRHKzw9VLOLsXcYavj6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DkFi/mFa9cDDVz2umWCg1OAUgDCbFZlqHQfb9PrO1/Tb9jGygVemTiQFylgJBcNXx
         kRWshsYuVqn9T5mjixH6yeV9C5b9zWfWW6X4Ns+2kpAEx/MHTOQBM4kE7AGYy094Vf
         FtYaRPpDQz2oXpopbMcVS4ZQBzA37Fw6Q7WvmHYW+Q++SxkLJIhFnF25CCiEDTD7+2
         +Hf+5WyXEIpwOANscCsQCLnm0Qt6TThhcSS71Qc9UBm97zEf5RxuMt3iqJDsMiWheL
         0Y7gdDyZSUfBWtsvBNjcOIwcGfSszJT2nMWQW6x/DBRfrXeTly+7xsHurPSw0YRMj/
         8u6nWxU4Pnudw==
Date:   Wed, 25 Aug 2021 17:15:50 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Murphy Zhou <xzhou@redhat.com>
Cc:     fstests@vger.kernel.org, Donald Douwsma <ddouwsma@redhat.com>
Subject: Re: [PATCH v3] tests/xfs: check available blocks after log recovery
 on ro mount
Message-ID: <20210826001550.GJ12612@magnolia>
References: <20210806014938.npfn2ykyirfrdlra@xzhoux.usersys.redhat.com>
 <20210806185545.GE3601425@magnolia>
 <20210823070541.mn2y4pn4256dwnhm@xzhoux.usersys.redhat.com>
 <20210823174316.GE12612@magnolia>
 <20210824050436.3l5jodgjhwt7wqzl@xzhoux.usersys.redhat.com>
 <20210824151428.GG12612@magnolia>
 <20210824165341.lvo5lwgosgh4n4ir@fedora>
 <20210825234337.GI12612@magnolia>
 <CALWRkkjTuYSOqv=0NCJhFtVYzO6xyyUd6RwNmv8Nc4vmwi2P7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALWRkkjTuYSOqv=0NCJhFtVYzO6xyyUd6RwNmv8Nc4vmwi2P7A@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Aug 26, 2021 at 08:00:33AM +0800, Murphy Zhou wrote:
> On Thu, Aug 26, 2021 at 7:43 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Wed, Aug 25, 2021 at 12:53:41AM +0800, Zorro Lang wrote:
> > > On Tue, Aug 24, 2021 at 08:14:28AM -0700, Darrick J. Wong wrote:
> > > > On Tue, Aug 24, 2021 at 01:04:36PM +0800, Murphy Zhou wrote:
> > > > > And followed by a rw mount.
> > > > >
> > > > > Suggested-by:  Donald Douwsma <ddouwsma@redhat.com>
> > > > > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > > > > Signed-off-by: Murphy Zhou <xzhou@redhat.com>
> > > > > ---
> > > > >
> > > > > Thanks Darrick very much for reviewing!
> > > > >
> > > > > v2:
> > > > >    Add explaination of the issue
> > > > >    add xfs_force_bdev data $SCRATCH_MNT
> > > > >    use DF_PROG
> > > > >    Re numbered this test
> > > > > v3:
> > > > >    Add _require_scratch_shutdown
> > > > >    Use _get_available_space
> > > > >    Explain why does not use _scratch_mount
> > > > >
> > > > >  tests/xfs/999     | 65 +++++++++++++++++++++++++++++++++++++++++++++++
> > > > >  tests/xfs/999.out |  2 ++
> > > > >  2 files changed, 67 insertions(+)
> > > > >  create mode 100755 tests/xfs/999
> > > > >  create mode 100644 tests/xfs/999.out
> > > > >
> > > > > diff --git a/tests/xfs/999 b/tests/xfs/999
> > > > > new file mode 100755
> > > > > index 00000000..0ce9989b
> > > > > --- /dev/null
> > > > > +++ b/tests/xfs/999
> > > > > @@ -0,0 +1,65 @@
> > > > > +#! /bin/bash
> > > > > +# SPDX-License-Identifier: GPL-2.0
> > > > > +# Copyright (c) 2021 RedHat All Rights Reserved.
> > > > > +#
> > > > > +# FS QA Test 999
> > > > > +#
> > > > > +# Testcase for kernel commit:
> > > > > +#   50d25484bebe xfs: sync lazy sb accounting on quiesce of read-only mounts
> > > > > +#
> > > > > +# After shutdown and readonly mount, a following read-write mount would
> > > > > +# get wrong number of available blocks. This is caused by unmounting the log
> > > > > +# on a readonly filesystem doesn't log the sb counters.
> > > > > +#
> > > > > +. ./common/preamble
> > > > > +_begin_fstest shutdown auto quick
> > > > > +
> > > > > +# real QA test starts here
> > > > > +
> > > > > +_supported_fs xfs
> > > > > +_require_scratch
> > > > > +_require_scratch_shutdown
> > > > > +
> > > > > +_scratch_mkfs > $seqres.full 2>&1
> > > > > +# Don't use _scratch_mount because we need to mount without SELinux context
> > > > > +# to reproduce this issue. If we mount with SELinux context, this testcase
> > > > > +# is not reproducing the original issue.
> > > > > +mount $SCRATCH_DEV $SCRATCH_MNT
> > > >
> > > > This mount will fail if the test runner configured an external log or a
> > > > realtime device, because you didn't specify those devices to the mount
> > > > call.  Either this needs _require_nonexternal or $(_scratch_options
> > > > mount) needs to be injected into the command line.
> > >
> > > I think I know why Xiong said _scratch_mount can't reproduce this bug.
> > >
> > > Before this patch v3, he tried to find the xfs corruption by using $DF_PROG $SCRATCH_MNT
> > > before&after xfs_repair.
> > >
> > > If we use _scratch_mount, new files we create won't contains SELinux label
> > > in xfs inode attrfork. The corruption comes from sb_ifree (free inodes):
> > >   Phase 2 - using internal log
> > >         - zero log...
> > >         - scan filesystem freespace and inode maps...
> > >   sb_ifree 61, counted 60
> >
> > <shrug> Faulty logging of the superblock can result in any of the
> > summary fields being wrong, so I don't see why this is a problem?
> > As long as at least one of the sb fields has to be corrected, we've
> > successfully found a broken kernel, right?
> >
> > > But if we don't use _scratch_mount, the corruption comes from sb_fdblocks(free blocks):
> > >   Phase 2 - using internal log
> > >         - zero log...
> > >         - scan filesystem freespace and inode maps...
> > >   sb_fdblocks 130086290, counted 131007896
> > >
> > > So if he use _scratch_mount, he can't get different available blocks by
> > > $DF_PROG $SCRATCH_MNT, before&after xfs_repair. Due to the corrupted thing
> > > is sb_ifree.
> > >
> > > But I still can't understand one thing, even if do *not* use _scratch_mount, the attr(selinux label)
> > > is local(short) format[1], didn't take more blocks. What takes more blocks, cause later
> > > sb_fdblocks corruption?
> >
> > /me has no idea either, other than to suggest
> >
> > SELINUX_MOUNT_OPTIONS= _scratch_mount
> >
> > if you don't want the selinux labels to be applied?
> 
> In v5 patch, it's not a problem any more. With _scratch_mount we still
> can reproduce the issue.

Heh, ok, I'll go look at that.  Didn't realize there was a v5 already.

--D

> Thanks!
> 
> >
> > --D
> >
> > >
> > > Thanks,
> > > Zorro
> > >
> > > [1]
> > > ...
> > > core.aformat = 1 (local)
> > > ...
> > > u3 = (empty)
> > > a.sfattr.hdr.totsize = 51
> > > a.sfattr.hdr.count = 1
> > > a.sfattr.list[0].namelen = 7
> > > a.sfattr.list[0].valuelen = 37
> > > a.sfattr.list[0].root = 0
> > > a.sfattr.list[0].secure = 1
> > > a.sfattr.list[0].name = "selinux"
> > > a.sfattr.list[0].value = "unconfined_u:object_r:unlabeled_t:s0\000"
> > >
> > >
> > > >
> > > > --D
> > > >
> > > > > +_xfs_force_bdev data $SCRATCH_MNT
> > > > > +
> > > > > +# Write test file
> > > > > +ls > $SCRATCH_MNT/testfile
> > > > > +$DF_PROG $SCRATCH_MNT >> $seqres.full 2>&1
> > > > > +
> > > > > +# Shutdown
> > > > > +$XFS_IO_PROG -x -c "shutdown -f" $SCRATCH_MNT
> > > > > +
> > > > > +# Mount ReadOnly
> > > > > +_scratch_unmount
> > > > > +_scratch_mount -oro
> > > > > +$DF_PROG $SCRATCH_MNT >> $seqres.full 2>&1
> > > > > +# Umount and mount rw
> > > > > +_scratch_unmount
> > > > > +_scratch_mount
> > > > > +
> > > > > +# Get fdblocks before repair
> > > > > +fdb1=$(_get_available_space $SCRATCH_MNT)
> > > > > +_scratch_unmount
> > > > > +
> > > > > +# Repair
> > > > > +_repair_scratch_fs >> $seqres.full 2>&1
> > > > > +
> > > > > +# Re-mount
> > > > > +_scratch_mount
> > > > > +
> > > > > +# Get fdblocks after repair
> > > > > +fdb2=$(_get_available_space $SCRATCH_MNT)
> > > > > +
> > > > > +echo fdb1 $fdb1 fdb2 $fdb2 >> $seqres.full 2>&1
> > > > > +
> > > > > +[ $fdb1 -ne $fdb2 ] && echo Wrong fdblocks: $fdb1 and $fdb2
> > > > > +
> > > > > +# success, all done
> > > > > +echo "Silence is golden"
> > > > > +status=0
> > > > > +exit
> > > > > diff --git a/tests/xfs/999.out b/tests/xfs/999.out
> > > > > new file mode 100644
> > > > > index 00000000..3b276ca8
> > > > > --- /dev/null
> > > > > +++ b/tests/xfs/999.out
> > > > > @@ -0,0 +1,2 @@
> > > > > +QA output created by 999
> > > > > +Silence is golden
> > > > > --
> > > > > 2.20.1
> > > > >
> > > >
> > >
> >
> 
