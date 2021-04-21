Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34F1C433ED
	for <linux-fstests@archiver.kernel.org>; Wed, 21 Apr 2021 15:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C34FE61249
	for <linux-fstests@archiver.kernel.org>; Wed, 21 Apr 2021 15:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244143AbhDUPyG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 21 Apr 2021 11:54:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25360 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243782AbhDUPyE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 21 Apr 2021 11:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619020411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+v2ydm2VifEipra5zlqQrbMSgtEN2/m5jMr5Iz7DS7A=;
        b=ecU5XWMf3TVCSR0w/otmbQ7QzhphxrRucyyYax8Phb82BC+3MC5o6QdhwJJnZfIvptyhiT
        +8Ak5BdLx+gGZycywi7SXZ2yVkMpaOuLPxLpw1dg9WkDFL7Bb5u9AAaoS3BmLZ5XGM/M9L
        RCZwzGLCrdeQDRO1Z1+Tc2pxrHnLXDI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-2wQPF6MZNH2yiOOmdYa1EQ-1; Wed, 21 Apr 2021 11:53:18 -0400
X-MC-Unique: 2wQPF6MZNH2yiOOmdYa1EQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D86484BA40
        for <fstests@vger.kernel.org>; Wed, 21 Apr 2021 15:53:17 +0000 (UTC)
Received: from bfoster (ovpn-112-25.rdu2.redhat.com [10.10.112.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EFAD159443;
        Wed, 21 Apr 2021 15:53:16 +0000 (UTC)
Date:   Wed, 21 Apr 2021 11:53:15 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     bxue@redhat.com
Cc:     fstests@vger.kernel.org, minlei@redhat.com, lczerner@redhat.com
Subject: Re: [PATCH v1] generic/563: tolerate small reads in "write ->
 read/write" sub-test
Message-ID: <YIBKawaUlcyiETie@bfoster>
References: <20210415062744.826644-1-bxue@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415062744.826644-1-bxue@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Apr 15, 2021 at 02:27:44PM +0800, bxue@redhat.com wrote:
> From: Boyang Xue <bxue@redhat.com>
> 
> On ext2/ext3, there're small reads when writing to file in the same cgroup.
> Since this sub-test tests that if read/write from 2nd cgroup is both 0 after
> writing in 1st cgroup, these small reads from 1st cgroup should not fail the
> test. This patch fixes the sub-test in order to tolerate small reads in 1st
> cgroup.
> 
> Signed-off-by: Boyang Xue <bxue@redhat.com>
> ---
> Hi,
> 
> I found generic/563 fails on ext2/ext3 on the latest kernel:
> 
> [root@kvm109 repo_xfstests]# ./check generic/563
> FSTYP         -- ext3
> PLATFORM      -- Linux/x86_64 kvm109 5.12.0-0.rc3.170.xx.x86_64 #1 SMP Tue Mar
> 16 12:02:55 EDT 2021
> MKFS_OPTIONS  -- -b 4096 /dev/vda3
> MOUNT_OPTIONS -- -o rw,relatime,seclabel -o context=system_u:object_r:root_t:s0
> /dev/vda3 /scratch
> 
> generic/563 4s ... - output mismatch (see
> /tmp/tmp.hMWbgkavD4/repo_xfstests/results//generic/563.out.bad)
>     --- tests/generic/563.out   2021-04-01 02:07:16.303329895 -0400
>     +++ /tmp/tmp.hMWbgkavD4/repo_xfstests/results//generic/563.out.bad
> 2021-04-01 03:06:19.240329895 -0400
>     @@ -3,7 +3,8 @@
>      read is in range
>      write is in range
>      write -> read/write
>     -read is in range
>     +read has value of 12288
>     +read is NOT in range 0 .. 0
>      write is in range
>     ...
>     (Run 'diff -u /tmp/tmp.hMWbgkavD4/repo_xfstests/tests/generic/563.out
> /tmp/tmp.hMWbgkavD4/repo_xfstests/results//generic/563.out.bad'  to see the
> entire diff)
> Ran: generic/563
> Failures: generic/563
> Failed 1 of 1 tests
> ```
> 
> generic/563 code
> ```
> ...
> # Write from one cgroup then read and write from a second. Writes are charged to
> # the first group and nothing to the second.
> echo "write -> read/write"
> reset  <== I have injected commands here for check, it turns out it indeed
> resets rbytes and wbytes both to 0.
> switch_cg $cgdir/$seq-cg
> $XFS_IO_PROG -c "pwrite 0 $iosize" $SCRATCH_MNT/file >> $seqres.full 2>&1
> switch_cg $cgdir/$seq-cg-2
> $XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" $SCRATCH_MNT/file \
> 	>> $seqres.full 2>&1
> switch_cg $cgdir
> $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
> check_cg $cgdir/$seq-cg 0 $iosize  <== problem here, expected read bytes = 0,
> but it's 12288
> check_cg $cgdir/$seq-cg-2 0 0
> ...
> ```
> 
> local.config
> ```
> FSTYP="ext3"
> TEST_DIR="/test"
> TEST_DEV="/dev/vda2"
> SCRATCH_MNT="/scratch"
> SCRATCH_DEV="/dev/vda3"
> LOGWRITES_MNT="/logwrites"
> LOGWRITES_DEV="/dev/vda6"
> MKFS_OPTIONS="-b 4096"
> MOUNT_OPTIONS="-o rw,relatime,seclabel"
> TEST_FS_MOUNT_OPTS="-o rw,relatime,seclabel"
> ```
> 
> I think the "write -> read/write" sub-test should test if the read/write bytes
> in 2nd cgroup both are 0, after writing in the 1st cgroup. Given that it writes
> 8MB in cgroup, dozens of small reads in service of the write (like read
> metadata) is not part of the goal of the sub-test, and should be tolerate,
> rather than fail the test.
> 
> Currently, the expected read bytes in the 1st cgroup is strictly 0. This patch
> sets a fixed tolerant value, so read bytes in the range of 0-(tolerant value) is
> tolerant, doesn't fail the test.
> 
> I have run the original test on ext2/ext3/ext4 with 1k/2k/4k blksize on x86_64,
> aarch64, s390x, ppc64le, to determine the tolerant value. It turns out the
> maximum read bytes in the tests is 33792. So I think set the tolerant value
> to 33800 is adequate.
> 
> Please help review this patch. Thanks.
> 
> -Boyang
> 
>  tests/generic/563 | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/generic/563 b/tests/generic/563
> index b113eacf..83146721 100755
> --- a/tests/generic/563
> +++ b/tests/generic/563
> @@ -60,6 +60,8 @@ check_cg()
>  	cgname=$(basename $cgroot)
>  	expectedread=$2
>  	expectedwrite=$3
> +	readtol=$4
> +	writetol=$5
>  	rbytes=0
>  	wbytes=0
>  
> @@ -71,8 +73,8 @@ check_cg()
>  			awk -F = '{ print $2 }'`
>  	fi
>  
> -	_within_tolerance "read" $rbytes $expectedread 5% -v
> -	_within_tolerance "write" $wbytes $expectedwrite 5% -v
> +	_within_tolerance "read" $rbytes $expectedread $readtol -v
> +	_within_tolerance "write" $wbytes $expectedwrite $writetol -v
>  }
>  
>  # Move current process to another cgroup.
> @@ -113,7 +115,7 @@ $XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" -c fsync \
>  	$SCRATCH_MNT/file >> $seqres.full 2>&1
>  switch_cg $cgdir
>  $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
> -check_cg $cgdir/$seq-cg $iosize $iosize
> +check_cg $cgdir/$seq-cg $iosize $iosize 5% 5%
>  
>  # Write from one cgroup then read and write from a second. Writes are charged to
>  # the first group and nothing to the second.
> @@ -126,8 +128,8 @@ $XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" $SCRATCH_MNT/file \
>  	>> $seqres.full 2>&1
>  switch_cg $cgdir
>  $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
> -check_cg $cgdir/$seq-cg 0 $iosize
> -check_cg $cgdir/$seq-cg-2 0 0
> +check_cg $cgdir/$seq-cg 0 $iosize 33800 5%

Any reason for the 33800 value as opposed to an even 32k? Also a brief
comment might be useful:

# Use a fixed value tolerance for the expected value of zero here
# because filesystems might perform a small number of metadata reads to
# complete the write.

> +check_cg $cgdir/$seq-cg-2 0 0 5% 5%
>  

I'm not sure it ever really makes sense to have a percentage tolerance
when the expected values are zero. This is the case with the current
implementation simply because the tolerance is hardcoded in the helper
function. If we're going to pass the tolerances for each test along with
the expected values, it might make a bit more sense to pass along a 0
tolerance where that is expected. Otherwise the rest LGTM. Thanks for
sending the patch..

Brian

>  # Read from one cgroup, read & write from a second. Both reads and writes are
>  # charged to the first group and nothing to the second.
> @@ -140,8 +142,8 @@ $XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" $SCRATCH_MNT/file \
>  	>> $seqres.full 2>&1
>  switch_cg $cgdir
>  $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
> -check_cg $cgdir/$seq-cg $iosize $iosize
> -check_cg $cgdir/$seq-cg-2 0 0
> +check_cg $cgdir/$seq-cg $iosize $iosize 5% 5%
> +check_cg $cgdir/$seq-cg-2 0 0 5% 5%
>  
>  echo "-io" > $cgdir/cgroup.subtree_control || _fail "subtree control"
>  
> -- 
> 2.27.0
> 

