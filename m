Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE13BC433B4
	for <linux-fstests@archiver.kernel.org>; Thu, 20 May 2021 16:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C88F6101E
	for <linux-fstests@archiver.kernel.org>; Thu, 20 May 2021 16:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhETQfr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 20 May 2021 12:35:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231724AbhETQfr (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 20 May 2021 12:35:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7106C61019;
        Thu, 20 May 2021 16:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621528465;
        bh=Iu62Qa2M23sZ2ne+PbPsaQsrgGrdt/39FAvxxijgZF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IK98cv97f++Cw1zYgY0A3CWNydYqz5Jp6KpKr4pjU2u2hsBtzqKru86BXNnwhEStC
         mR9DDTwibYob9tgBmDcRr0Pk9OsS1Locl+34gsndO2UaptG96/EIX/pDFwrwOOzWye
         PLKVXt66qJdJg3VqYaViRbzM871FFUWEO+32QqhWKR1o9oYaW6MggSLIQyKS8N8rZG
         MqW+049gYyuKGhjuLd8twikVqVx/Zzq9H9Rn0ekzPEQEsCZGqDNp3gxfGm26IdzFHB
         gr7ZPII884PH6i8O3YzH2O0XqMQvtZft7m2F5itSEsItcQfM8RPFFl/awq4hQ0mD9+
         jEKnTjiriUlQw==
Date:   Thu, 20 May 2021 09:34:25 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Chenlong (H)" <chenlongcl.chen@huawei.com>
Cc:     fstests@vger.kernel.org, guaneryu@gmail.com, tytso@mit.edu
Subject: Re: [PATCH] ext4/048: Add new regression test
Message-ID: <20210520163425.GG9648@magnolia>
References: <20210519031015.14005-1-chenlongcl.chen@huawei.com>
 <20210519232435.GE9648@magnolia>
 <7a77fe95-2a4d-9092-9fdf-0a4a4fadd418@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a77fe95-2a4d-9092-9fdf-0a4a4fadd418@huawei.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, May 20, 2021 at 11:41:52AM +0800, Chenlong (H) wrote:
> 
> 
> On 2021/5/20 7:24:35, Darrick J. Wong wrote:
> > On Wed, May 19, 2021 at 11:10:15AM +0800, chenlong wrote:
> > > Check the block group zero and prevent initializing reserved inodes.
> > > But in some special cases, the reserved inode may not all belong to
> > > the group zero, it may exist into the second group if we format
> > > filesystem below.
> > > mkfs.ext4 -b 4096 -g 8192 -N 1024 -I 4096 /dev/sda
> > > So, it will end up triggering a false positive report of a corrupted
> > > file system
> > > 
> > > It's a regression test for commit a149d2a5cabb.
> > > 
> > > Signed-off-by: Chen Long <chenlongcl.chen@huawei.com>
> > > ---
> > >   tests/ext4/048     | 50 ++++++++++++++++++++++++++++++++++++++++++++++
> > >   tests/ext4/048.out |  5 +++++
> > >   tests/ext4/group   |  1 +
> > >   3 files changed, 56 insertions(+)
> > >   create mode 100755 tests/ext4/048
> > >   create mode 100644 tests/ext4/048.out
> > > 
> > > diff --git a/tests/ext4/048 b/tests/ext4/048
> > > new file mode 100755
> > > index 00000000..56801579
> > > --- /dev/null
> > > +++ b/tests/ext4/048
> > > @@ -0,0 +1,50 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2021 Huawei.  All Rights Reserved.
> > > +#
> > > +# FS QA Test 048
> > > +#
> > > +# Regression test for commit:
> > > +# a149d2a5cabb(ext4: fix check to prevent false positive report of incorrect
> > > +# used inodes)
> > > +#
> > > +seq=`basename $0`
> > > +seqres=$RESULT_DIR/$seq
> > > +echo "QA output created by $seq"
> > > +
> > > +here=`pwd`
> > > +tmp=/tmp/$$
> > > +status=1	# failure is the default!
> > > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > > +
> > > +_cleanup()
> > > +{
> > > +    cd /
> > > +    rm -f $tmp.*
> > > +}
> > > +
> > > +# get standard environment, filters and checks
> > > +. ./common/rc
> > > +. ./common/filter
> > > +
> > > +# remove previous $seqres.full before test
> > > +rm -f $seqres.full
> > > +
> > > +# real QA test starts here
> > > +_supported_fs ext4
> > > +_require_scratch
> > > +
> > > +echo "+ create scratch fs"
> > > +_scratch_mkfs_ext4 -b 4096 -g 8192 -N 1024 -I 4096 >> $seqres.full 2>&1
> > > +
> > > +echo "+ mount fs"
> > > +_scratch_mount -o errors=remount-ro
> > > +sleep 5
> > 
> > Why do we need to sleep here?  Won't _scratch_mount return nonzero if
> > the (buggy) kernel thought the fs was corrupt?
> > 
> > Also, won't the grep below catch that the fs didn't mount?
> > 
> 
> The default maximum wake-up delay of the lazy init thread of ext4 is
> EXT4_DEF_LI_MAX_START_DELAY (5s).
> 
> After mounting the file system, the lazy init thread will be awakened to
> perform group initialization at 0~5s
> 
> after the current time. If an error is detected during the initialization
> process, it will be set to read-only,
> 
> so the test case needs to delay a little while waiting for the init thread
> to execute.

Oh, that's why there's a delay.  Could you paste this explanation into
the test case as a comment right before the 'sleep 5', please?

Also, if the delay is configurable you might want to set it to a known
value at the start of this test.

--D

> in this testcase,  _scratch_mount will be return zero, after a short period
> of time, the file system will be remounted as read-only.
> 
> In an environment with this bug,  such as:
> 
> [root@testvm ~]# mkfs.ext4 -b 4096 -g 8192 -N 1024 -I 4096 /dev/sda
> 
> [root@testvm ~]# mount -o errors=remount-ro /dev/sda /mnt
> 
> [root@testvm ~]# mount | grep /dev/sda
> 
> /dev/sda on /mnt type ext4 (rw,relatime,errors=remount-ro)
> 
> After the file system is mounted，file system status is rw，but a moment
> later, status will be change to ro.
> 
> [root@testvm ~]# mount | grep /dev/sda
> 
> /dev/sda on /mnt type ext4 (ro,relatime,errors=remount-ro)
> 
> > > +
> > > +echo "+ check mountpoint status"
> > > +cat /proc/self/mounts | grep ${SCRATCH_MNT} | \
> > 
> > Careful here, if someone sets SCRATCH_MNT=/u, this will match another
> > mount for /usr.  At the bare minimum you want 'grep -w' here, I think.
> > 
> > --D
> > 
> 
> There is a risk here and needs to be fixed.
> 
> > > +    $AWK_PROG '{print $4}' | grep -oE '^rw,' | tee -a $seqres.full
> > > +
> > > +# success, all done
> > > +status=0
> > > +exit
> > > diff --git a/tests/ext4/048.out b/tests/ext4/048.out
> > > new file mode 100644
> > > index 00000000..16e50e86
> > > --- /dev/null
> > > +++ b/tests/ext4/048.out
> > > @@ -0,0 +1,5 @@
> > > +QA output created by 048
> > > ++ create scratch fs
> > > ++ mount fs
> > > ++ check mountpoint status
> > > +rw,
> > > diff --git a/tests/ext4/group b/tests/ext4/group
> > > index ceda2ba6..82b77efb 100644
> > > --- a/tests/ext4/group
> > > +++ b/tests/ext4/group
> > > @@ -50,6 +50,7 @@
> > >   045 auto dir
> > >   046 auto prealloc quick
> > >   047 auto quick dax
> > > +048 auto quick
> > >   271 auto rw quick
> > >   301 aio auto ioctl rw stress defrag
> > >   302 aio auto ioctl rw stress defrag
> > > -- 
> > > 2.18.0.huawei.25
> > > 
> > .
> > 
