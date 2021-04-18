Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF5EC433B4
	for <linux-fstests@archiver.kernel.org>; Sun, 18 Apr 2021 12:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D875861207
	for <linux-fstests@archiver.kernel.org>; Sun, 18 Apr 2021 12:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhDRMn7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 18 Apr 2021 08:43:59 -0400
Received: from out20-63.mail.aliyun.com ([115.124.20.63]:59275 "EHLO
        out20-63.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhDRMn6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 18 Apr 2021 08:43:58 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07437384|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0825127-0.00118576-0.916301;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=guan@eryu.me;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.K.puFFI_1618749809;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.K.puFFI_1618749809)
          by smtp.aliyun-inc.com(10.147.43.230);
          Sun, 18 Apr 2021 20:43:29 +0800
Date:   Sun, 18 Apr 2021 20:43:28 +0800
From:   Eryu Guan <guan@eryu.me>
To:     bxue@redhat.com
Cc:     fstests@vger.kernel.org, bfoster@redhat.com, minlei@redhat.com,
        lczerner@redhat.com
Subject: Re: [PATCH v1] generic/563: tolerate small reads in "write ->
 read/write" sub-test
Message-ID: <YHwpcP6nBL9n/AAT@desktop>
References: <20210415062744.826644-1-bxue@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415062744.826644-1-bxue@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Apr 15, 2021 at 02:27:44PM +0800, Boyang Xue wrote:
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

I'm not sure if the read bytes should be ignored in this test, or it
just uncovers ext2/3 bug. Does it fail with previous kernels?

Thanks,
Eryu

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
> +check_cg $cgdir/$seq-cg-2 0 0 5% 5%
>  
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
