Received: from mail-ua1-f68.google.com ([209.85.222.68]:44389 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfCGXUE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Mar 2019 18:20:04 -0500
MIME-Version: 1.0
References: <20190304140622.23997-1-fdmanana@kernel.org> <CAOQ4uxi87QhQHake0L_xVtUYChc3D2kLqho1obq14aG6zCMu6A@mail.gmail.com>
 <20190305005020.GA26298@dastard> <CAOQ4uxgKj8pAKKra9jv+xTb9dOxG-J5fKvJ_6a_iabWR9RbgrQ@mail.gmail.com>
 <20190305223301.GD26298@dastard> <CAOQ4uxggon==2r2hibMvXc4_N4zod+2z0Ycw74eKRn+q1uwYsw@mail.gmail.com>
 <20190306214813.GE26298@dastard> <CAOQ4uxjM0-D8c3KR0ooXYhhUa5+19j_=3XUaXf6vGMbsNhShJw@mail.gmail.com>
In-Reply-To: <CAOQ4uxjM0-D8c3KR0ooXYhhUa5+19j_=3XUaXf6vGMbsNhShJw@mail.gmail.com>
From: Jayashree Mohan <jayashree2912@gmail.com>
Date: Thu, 7 Mar 2019 17:19:51 -0600
Message-ID: <CA+EzBbCuQJen9hSHf8-JSRGG3VPxo9X4ugscMdKuw_A6isHDUQ@mail.gmail.com>
Subject: Re: [PATCH] generic: add test for fsync after shrinking truncate and rename
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>, Filipe Manana <fdmanana@kernel.org>, fstests <fstests@vger.kernel.org>, Linux Btrfs <linux-btrfs@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

Hi Amir,

> I went back to look at similar fsync tests by Filipe:
> generic/{106,107,335,336,341,342,343,348,498,501,502,509,510,512}
>
> I found some alleged subtle mistakes about SOMC assumptions.
>
> generic/336 does:
> touch $SCRATCH_MNT/a/foo
> ln $SCRATCH_MNT/a/foo $SCRATCH_MNT/b/foo_link
> touch $SCRATCH_MNT/b/bar
> sync
> unlink $SCRATCH_MNT/b/foo_link
> mv $SCRATCH_MNT/b/bar $SCRATCH_MNT/c/
> $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/a/foo

This is probably what's happening in this particular test :

SOMC requires:
          fsync(a/foo) must ensure unlink(b/foo_link)  (because they
were linked at some point)

But what happens is:
           fsync(a/foo)          -->  unlink(b/foo_link)
           unlink(b/foo_link)  -->  fsync(b)
           fsync(b)                 -->  rename goes through

SOMC should only require that the unlink persists. The rename
operation persists due to the side-effect of SOMC. So we should be
only testing if the unlink operation went through.

Take a look at this thread that describes the bug which resulted in
this test case (https://patchwork.kernel.org/patch/8293181/).
The file bar was lost during the rename operation and I think this
test simply wanted to verify that file bar was intact in either one of
the directories. Probably the reason this test was written was not to
test SOMC, but to verify that the log replay in btrfs does not delete
the renamed file - luckily it happens to pass on other file systems
because they all persist the rename operation as a side effect of
SOMC. To me, this test currently checks for something more than SOMC.
The check must be modified to only test if b/foo_link is removed, and
that the file bar is *either* in directory b or c.

Test 343 is a similar case where in btrfs log replay ended up
persisting the file in both the source and destination directories
after a rename operation
(https://patchwork.kernel.org/patch/8766401/). The checks must be
updated here as well.

Thanks,
Jayashree
