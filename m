Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A80FC433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 16 May 2022 08:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbiEPIDH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 16 May 2022 04:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239270AbiEPIDF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 May 2022 04:03:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB102D1F6
        for <fstests@vger.kernel.org>; Mon, 16 May 2022 01:03:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E026061196
        for <fstests@vger.kernel.org>; Mon, 16 May 2022 08:03:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820ECC385AA;
        Mon, 16 May 2022 08:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652688183;
        bh=PxNctA92Cqw+11jD1ST8Y86DOSAnvUxou2ch6tVAlkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZHmvfe5xWCPAodHrNSvQ3umrcQgduDjQtCeTLqnuO6o1pRkPFYZmRJZWEU1AkWjuR
         6l0uZMo8rolOTuUq9kqG6D9Ns6+vB95ttrS/jfUmaJwnpMr3n+hKLoleFvfXO7sLOM
         cLl0oCvCG6NboBRQaq1XRlv9Z0wYDs9TjLCjZamKvBL6sqsr4dWwt0ws5tAy4jglYQ
         /Ist2ATCnjGgN06ua4+z3ohAVvhS9Ygo2iaZf5ViJDOakIkoaAvDE5STs8nnKAshHj
         dGCQaXxlq9qKp+KHloiHH+6XCg+i6Hzd0B1y1Ja60TUCvZv8Bi7FyomdahCkObS6HI
         Wc+/NxfeuVb9g==
Date:   Mon, 16 May 2022 10:02:59 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH v2 00/13] rename & split tests
Message-ID: <20220516080259.lhfbt6qyizbdekbm@wittgenstein>
References: <20220512165250.450989-1-brauner@kernel.org>
 <20220514175943.msaucvar5m3uxskb@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220514175943.msaucvar5m3uxskb@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, May 15, 2022 at 01:59:43AM +0800, Zorro Lang wrote:
> On Thu, May 12, 2022 at 06:52:37PM +0200, Christian Brauner wrote:
> > From: "Christian Brauner (Microsoft)" <brauner@kernel.org>
> > 
> > Hey everyone,
> > 
> > Please note that this patch series contains patches that will be
> > rejected by the fstests mailing list because of the amount of changes
> > they contain. So tools like b4 will not be able to find the whole patch
> > series on a mailing list. In case it's helpful I've added the
> > "fstests.vfstest.for-next" tag which can be pulled. Otherwise it's
> > possible to simply use the patch series as it appears in your inbox.
> 
> Hi Christian,

Hi Zorro,

> 
> After a full round regression test, I just found this patchset cause
> generic/689 fail as [1], so I think it still need below fix [2]. If
> you won't send a fixed version before fstests release this sunday, I
> will fix it by myself, to help this patchset be merged this week. Due
> to it's not worth waiting one more week for this.

Thank you!

> 
> Thanks,
> Zorro
> 
> [1]
> /var/lib/xfstests/tests/generic/689: line 29: /var/lib/xfstests/src/idmapped-mounts/idmapped-mounts: No such file or directory
> 
> [2]
> diff --git a/tests/generic/689 b/tests/generic/689
> index 670f8e5a..10dc58ed 100755
> --- a/tests/generic/689
> +++ b/tests/generic/689
> @@ -11,7 +11,7 @@
>  # 705191b03d50 ("fs: fix acl translation")
>  #
>  . ./common/preamble
> -_begin_fstest auto quick perms
> +_begin_fstest auto quick idmapped perms

Ah, I see. I didn't catch this because I forgot to add the test to the
idmapped group.

Thanks,
Christian

>  
>  # Import common functions.
>  . ./common/filter
> @@ -26,7 +26,7 @@ _require_group fsgqa
>  
>  echo "Silence is golden"
>  
> -$here/src/idmapped-mounts/idmapped-mounts --test-setxattr-fix-705191b03d50 \
> +$here/src/vfs/vfstest --test-setxattr-fix-705191b03d50 \
>         --device "$TEST_DEV" --mount "$TEST_DIR" --fstype "$FSTYP"
>  
>  status=$?
> 
> > 
> > All vfstests pass:
> > 
> > #### btrfs ####
> > ubuntu@imp1-vm:~/src/git/xfstests$ sudo ./check -g idmapped
> > FSTYP         -- btrfs
> > PLATFORM      -- Linux/x86_64 imp1-vm 5.18.0-rc4-fs-mnt-hold-writers-8a2e2350494f #107 SMP PREEMPT_DYNAMIC Mon May 9 12:12:34 UTC 2022
> > MKFS_OPTIONS  -- /dev/sda4
> > MOUNT_OPTIONS -- /dev/sda4 /mnt/scratch
> > 
> > btrfs/245 52s ...  54s
> > generic/633 58s ...  51s
> > generic/644 60s ...  49s
> > generic/645 161s ...  143s
> > generic/656 63s ...  55s
> > Ran: btrfs/245 generic/633 generic/644 generic/645 generic/656
> > Passed all 5 tests
> > 
> > #### ext4 ####
> > ubuntu@imp1-vm:~/src/git/xfstests$ sudo ./check -g idmapped
> > FSTYP         -- ext4
> > PLATFORM      -- Linux/x86_64 imp1-vm 5.18.0-rc4-fs-mnt-hold-writers-8a2e2350494f #107 SMP PREEMPT_DYNAMIC Mon May 9 12:12:34 UTC 2022
> > MKFS_OPTIONS  -- /dev/sda4
> > MOUNT_OPTIONS -- -o acl,user_xattr /dev/sda4 /mnt/scratch
> > 
> > generic/633 47s ...  50s
> > generic/644 46s ...  49s
> > generic/645 135s ...  139s
> > generic/656 53s ...  54s
> > Ran: generic/633 generic/644 generic/645 generic/656
> > Passed all 4 tests
> > 
> > #### xfs ####
> > ubuntu@imp1-vm:~/src/git/xfstests$ sudo ./check -g idmapped
> > FSTYP         -- xfs (debug)
> > PLATFORM      -- Linux/x86_64 imp1-vm 5.18.0-rc4-fs-mnt-hold-writers-8a2e2350494f #107 SMP PREEMPT_DYNAMIC Mon May 9 12:12:34 UTC 2022
> > MKFS_OPTIONS  -- -f /dev/sda4
> > MOUNT_OPTIONS -- /dev/sda4 /mnt/scratch
> > 
> > generic/633 58s ...  58s
> > generic/644 62s ...  60s
> > generic/645 161s ...  161s
> > generic/656 62s ...  63s
> > xfs/152 133s ...  133s
> > xfs/153 94s ...  92s
> > Ran: generic/633 generic/644 generic/645 generic/656 xfs/152 xfs/153
> > Passed all 6 tests
> > 
> > /* v2 */
> > * This rebases the patchset on top the for-next branch.
> > * Last week we merged 858a19c5e9b0 ("idmapped_mounts: Prepare for
> >   support for more features"). The patch switched feature checking from
> >   a boolean to a flag. It failed convert all tests. This adds a patch to
> >   fix this in patch 01/13.
> > * A patch has been added to remove an invalid test. The semantics for a
> >   specific corner-case where we allowed a mount's idmapping to change
> >   while there were active writers will be altered.
> > 
> > /* v1 */
> > As announced multiple times already we need to rename and split the
> > idmapped mount testsuite into separate source files and also give it a
> > better name to reflect the fact that it covers a lot more than just
> > idmapped mounts.
> > 
> > I have decided against compiling different binaries for now. Instead we
> > compile a single vfstest binary that can be called with various command
> > line switches to run the various test suites. This is not different than
> > what we did for the idmapped-mounts binary. Of course, nothing prevents
> > us from using multiple binaries in the future.
> > 
> > Thanks!
> > Christian
> > 
> > Christian Brauner (13):
> >   idmapped-mounts: make all tests set their required feature flags
> >   src: rename idmapped-mounts folder
> >   src/vfs: rename idmapped-mounts.c file
> >   vfstest: rename struct t_idmapped_mounts
> >   utils: add missing global.h include
> >   utils: add struct vfstest_info
> >   utils: move helpers into utils
> >   missing: move sys_execveat() to missing.h
> >   utils: add struct test_suite
> >   vfstests: split idmapped mount tests into separate suite
> >   vfstest: split out btrfs idmapped mounts test
> >   vfstest: split out remaining idmapped mount tests
> >   vfs/idmapped-mounts: remove invalid test
> > 
> >  .gitignore                                    |     4 +-
> >  common/rc                                     |    32 +-
> >  src/Makefile                                  |     2 +-
> >  src/detached_mounts_propagation.c             |     2 +-
> >  src/feature.c                                 |     2 +-
> >  src/idmapped-mounts/idmapped-mounts.c         | 14625 ----------------
> >  src/idmapped-mounts/utils.c                   |   425 -
> >  src/idmapped-mounts/utils.h                   |   130 -
> >  src/{idmapped-mounts => vfs}/Makefile         |    14 +-
> >  src/vfs/btrfs-idmapped-mounts.c               |  3854 ++++
> >  src/vfs/btrfs-idmapped-mounts.h               |    15 +
> >  src/vfs/idmapped-mounts.c                     |  7747 ++++++++
> >  src/vfs/idmapped-mounts.h                     |    18 +
> >  src/{idmapped-mounts => vfs}/missing.h        |    11 +
> >  src/{idmapped-mounts => vfs}/mount-idmapped.c |     0
> >  src/vfs/utils.c                               |  1050 ++
> >  src/vfs/utils.h                               |   373 +
> >  src/vfs/vfstest.c                             |  2073 +++
> >  tests/btrfs/245                               |     2 +-
> >  tests/generic/633                             |     2 +-
> >  tests/generic/644                             |     2 +-
> >  tests/generic/645                             |     2 +-
> >  tests/generic/656                             |     2 +-
> >  tests/xfs/152                                 |     4 +-
> >  tests/xfs/153                                 |     2 +-
> >  25 files changed, 15177 insertions(+), 15216 deletions(-)
> >  delete mode 100644 src/idmapped-mounts/idmapped-mounts.c
> >  delete mode 100644 src/idmapped-mounts/utils.c
> >  delete mode 100644 src/idmapped-mounts/utils.h
> >  rename src/{idmapped-mounts => vfs}/Makefile (59%)
> >  create mode 100644 src/vfs/btrfs-idmapped-mounts.c
> >  create mode 100644 src/vfs/btrfs-idmapped-mounts.h
> >  create mode 100644 src/vfs/idmapped-mounts.c
> >  create mode 100644 src/vfs/idmapped-mounts.h
> >  rename src/{idmapped-mounts => vfs}/missing.h (93%)
> >  rename src/{idmapped-mounts => vfs}/mount-idmapped.c (100%)
> >  create mode 100644 src/vfs/utils.c
> >  create mode 100644 src/vfs/utils.h
> >  create mode 100644 src/vfs/vfstest.c
> > 
> > 
> > base-commit: 87cf32ad3fa234e3d5ec501e0f86516bef91d805
> > -- 
> > 2.34.1
> > 
> 
