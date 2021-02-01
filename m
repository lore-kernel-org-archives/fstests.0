Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A4AC433DB
	for <linux-fstests@archiver.kernel.org>; Mon,  1 Feb 2021 09:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8F0364E04
	for <linux-fstests@archiver.kernel.org>; Mon,  1 Feb 2021 09:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbhBAJ5x (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 1 Feb 2021 04:57:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21415 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232443AbhBAJ5w (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 1 Feb 2021 04:57:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612173385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rkcuV0zAcG2f9yr9vcs4HyaD/eM/2iNCChJJyMhP80k=;
        b=ZtvMJWcmzuLcTP8xggakqB8aCsvRva2S8i0VT5PRjjulCJr3pywSJMc17i1dJ4+XtGt0pJ
        C1yeC+Gug87WoecgUMpaNGeqCLIOIIHe1RvOIn2u9R/eotBLXxUf1NQvR+bpOUjd5H3QiQ
        I7Mz0c9b9wAoPkWOzewGPw1iQ3iyXzc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-m94dkZ-5PCWSUCZoiEM-uQ-1; Mon, 01 Feb 2021 04:56:23 -0500
X-MC-Unique: m94dkZ-5PCWSUCZoiEM-uQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 828C1C7400;
        Mon,  1 Feb 2021 09:56:22 +0000 (UTC)
Received: from localhost (unknown [10.66.61.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 03CD71975E;
        Mon,  1 Feb 2021 09:56:21 +0000 (UTC)
Date:   Mon, 1 Feb 2021 18:13:25 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Sun Ke <sunke32@huawei.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [v2] ext4: Add a test for rename with RENAME_WHITEOUT
Message-ID: <20210201101325.GA14354@localhost.localdomain>
Mail-Followup-To: Sun Ke <sunke32@huawei.com>, fstests@vger.kernel.org
References: <20210128061202.210074-1-sunke32@huawei.com>
 <20210130111229.GW14354@localhost.localdomain>
 <79e620e9-1543-bcbf-23b1-a397975734ae@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79e620e9-1543-bcbf-23b1-a397975734ae@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Feb 01, 2021 at 02:12:46PM +0800, Sun Ke wrote:
> hi, Zorro
> 
> 在 2021/1/30 19:12, Zorro Lang 写道:
> > On Thu, Jan 28, 2021 at 02:12:02PM +0800, Sun Ke wrote:
> > > Fill the disk space, try to create some files and rename a file, mount
> > > again, list directory contents and triggers some errors. It is a
> > > regression test for kernel commit 6b4b8e6b4ad8 ("ext4: ext4: fix bug for
> > > rename with RENAME_WHITEOUT")
> > > 
> > > Signed-off-by: Sun Ke <sunke32@huawei.com>
> > > ---
> > > v1 -> v3:
> > > Use the original in src and modify 048.out
> > > ---
> > > ---
> > >   tests/ext4/048     | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >   tests/ext4/048.out |  2 ++
> > >   tests/ext4/group   |  1 +
> > >   3 files changed, 79 insertions(+)
> > >   create mode 100755 tests/ext4/048
> > >   create mode 100644 tests/ext4/048.out
> > > 
> > > diff --git a/tests/ext4/048 b/tests/ext4/048
> > > new file mode 100755
> > > index 00000000..0311d1a2
> > > --- /dev/null
> > > +++ b/tests/ext4/048
> > > @@ -0,0 +1,76 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2021 HUAWEI.  All Rights Reserved.
> > > +#
> > > +# FS QA Test 048
> > > +#
> > > +# This is a regression test for kernel patch:
> > > +# commit 6b4b8e6b4ad8 ("ext4: ext4: fix bug for rename with RENAME_WHITEOUT")
> > > +
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
> > > +	cd /
> > > +	rm -f $tmp.*
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
> > > +
> > > +# Modify as appropriate.
> > > +_supported_fs ext4
> > > +_supported_fs generic
> > ext4 or generic? Tell the truth, according to below testing steps, I think it
> > can be a generic test case, not only for ext4.
> 
> When reproducing the bug, demsg show :
> 
>     EXT4-fs error (device loop0): ext4_lookup:1440: inode #2049: comm ls:
> deleted inode referenced: 139
> 
> It was printed in fs/ext4/super.c in funcation __ext4_error_inode. I search
> "deleted inode referenced" in linux kernel
> 
> and find 4 places:
> 
>     fs/ext2/namei.c: "deleted inode referenced: %lu",
>     fs/ext4/namei.c: "deleted inode referenced: %u",
>     fs/minix/inode.c:               printk("MINIX-fs: deleted inode
> referenced: %lu\n",
>     fs/minix/inode.c:               printk("MINIX-fs: deleted inode
> referenced: %lu\n",
> 
> If it is generic, I am not very sure how to distinguish success from
> failure.

Except this dmesg check, all other steps aren't extN related. So I'd like to
recommand:
1) Checking if we have a better way to avoid checking this ext4 only dmesg
output? Likes if that "ls -l test/dir/file1" can find this bug? Does it have
different output with/without the bug fix?

2) If we can't do the 1), and must check the ext4-only dmesg, we can use a
judgement to check it for extN only:

if [[ $FSTYP =~ ext ]];then
	check that dmesg
fi

then let other filesystems do dmesg checking by default.

But the 1) is still the best way I think.

Thanks,
Zorro

> 
> 
> > > +_require_scratch
> > > +_require_xfs_io_command "falloc"
> > > +
> > > +dmesg -c > /dev/null
> > > +
> > > +_scratch_mkfs > $seqres.full 2>&1
> > > +_scratch_mount >> $seqres.full 2>&1
> > > +
> > > +testdir=$SCRATCH_MNT
> > > +cd ${testdir}
> > > +
> > > +mkdir test
> > > +$XFS_IO_PROG -f -c "falloc 0 128M" img >> $seqres.full
> > > +$MKFS_EXT4_PROG  img > /dev/null 2>&1
> > > +$MOUNT_PROG img test
> > Can we reproduce this bug by $SCRATCH_DEV directly, not through a loopdev.
> > Likes:
> > 
> > _scratch_mkfs_sized 128M (maybe bigger ?)
> > _scratch_mount
> > 
> > > +
> > > +# fill the disk space
> > > +dd if=/dev/zero of=test/foo bs=1M count=128 > /dev/null 2>&1
> > Can _fill_fs() helper help you that?
> > 
> > > +
> > > +# create 1000 files, not all the files will be created successfully
> > > +mkdir test/dir
> > > +cd test/dir
> > > +for ((i = 0; i < 1000; i++))
> > > +do
> > > +	touch file$i > /dev/null 2>&1
> > > +done
> > I don't know if it can be 100% sure there's at least 1 file will be created at
> > here, after you tried to fill the fs.
> > 
> > So I think maybe you can create a file with known name, then use _fill_fs()
> > to fill the whole fs. Then try to rename the file you know its name. Can that
> > reproduce the bug?
> OK, I am not sure, let me have a try.
> > 
> > > +
> > > +# try to rename, but now no space left on device
> > > +$here/src/renameat2 -w $testdir/test/dir/file1 $testdir/test/dir/dst_file
> > > +
> > > +cd $testdir
> > > +$UMOUNT_PROG test
> > > +$MOUNT_PROG img test
> > > +ls -l test/dir/file1 > /dev/null 2>&1
> > > +$UMOUNT_PROG test
> > > +
> > > +dmesg -c | grep "deleted inode referenced"
> > Can _check_dmesg_for() help you?
> > 
> > > +# success, all done
> > > +status=0
> > > +exit
> > > diff --git a/tests/ext4/048.out b/tests/ext4/048.out
> > > new file mode 100644
> > > index 00000000..5b3990da
> > > --- /dev/null
> > > +++ b/tests/ext4/048.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 048
> > > +No space left on device
> > > diff --git a/tests/ext4/group b/tests/ext4/group
> > > index ceda2ba6..6140dd7e 100644
> > > --- a/tests/ext4/group
> > > +++ b/tests/ext4/group
> > > @@ -50,6 +50,7 @@
> > >   045 auto dir
> > >   046 auto prealloc quick
> > >   047 auto quick dax
> > > +048 other
> > I think your test case is a general test case, "auto"and "rename" groups
> > are good to it, if it's quick enough, add "quick" group.
> 
> Thanks for your suggestion.
> 
> 
> Thanks,
> 
> Sun Ke
> 
> > 
> > >   271 auto rw quick
> > >   301 aio auto ioctl rw stress defrag
> > >   302 aio auto ioctl rw stress defrag
> > > -- 
> > > 2.13.6
> > > 
> > .
> 

