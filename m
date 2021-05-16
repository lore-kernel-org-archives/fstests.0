Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D57C433B4
	for <linux-fstests@archiver.kernel.org>; Sun, 16 May 2021 14:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD85B61183
	for <linux-fstests@archiver.kernel.org>; Sun, 16 May 2021 14:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhEPOBl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 16 May 2021 10:01:41 -0400
Received: from out20-62.mail.aliyun.com ([115.124.20.62]:39733 "EHLO
        out20-62.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhEPOBl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 16 May 2021 10:01:41 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07591908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.154454-0.0167311-0.828814;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047208;MF=guan@eryu.me;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.KEDSIOD_1621173623;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.KEDSIOD_1621173623)
          by smtp.aliyun-inc.com(10.147.42.135);
          Sun, 16 May 2021 22:00:24 +0800
Date:   Sun, 16 May 2021 22:00:23 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Sun Ke <sunke32@huawei.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/rc: make _mkfs_dev return mkfs_status
Message-ID: <YKEldxvQTa5FMmpo@desktop>
References: <20210515112820.447767-1-sunke32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210515112820.447767-1-sunke32@huawei.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, May 15, 2021 at 07:28:20AM -0400, Sun Ke wrote:
> If _mkfs_dev fialed，the test should notrun. _mkfs_dev may need to
> return mkfs_status as _scratch_mkfs_ext4 and _scratch_mkfs_xfs do.
> 
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---
> I run generic/test/042 on f2fs, it failed, because the device size is too small：

I think we should require a minimal device size in generic/042 for f2fs,
or write a larger fs image file if possible so that f2fs could run.

Thanks,
Eryu

> 
> F2FS-tools: mkfs.f2fs Ver: 1.9.0 (2017-09-21)
> 
> Info: Disable heap-based policy
> Info: Debug level = 0 
> Info: Label = 
> Info: Trim is enabled
> Info: Segments per section = 1 
> Info: Sections per zone = 1 
> Info: sector size = 512 
> Info: total sectors = 51200 (25 MB) 
> Info: zone aligned segment0 blkaddr: 512 
>     Error: Device size is not sufficient for F2FS volume
>     Error: Failed to prepare a super block!!!
>     Error: Could not format the device!!!
> 
> Change the device size to 40M, it can pass. But I am not sure if it will change 
> the test's intention. 
> 
> [root@localhost xfstests]# ./check tests/generic/042
> FSTYP         -- f2fs
> PLATFORM      -- Linux/x86_64 localhost 5.12.0-rc5-next-20210330 #2 SMP Thu Apr 15 00:58:54 EDT 2021
> MKFS_OPTIONS  -- /dev/sdb
> MOUNT_OPTIONS -- -o acl,user_xattr /dev/sdb /mnt/scratch
> 
> generic/042 3s ...  4s
> Ran: generic/042
> Passed all 1 tests
> 
> Other tests also use _mkfs_dev(), if making _mkfs_dev return 
> mkfs_status is ok, I will modify them in V2.
> 
> [root@localhost xfstests]# ./check tests/generic/042
> FSTYP         -- f2fs
> PLATFORM      -- Linux/x86_64 localhost 5.12.0-rc5-next-20210330 #3 SMP
> Wed Apr 21 22:29:25 EDT 2021
> MKFS_OPTIONS  -- /dev/sdb
> MOUNT_OPTIONS -- -o acl,user_xattr /dev/sdb /mnt/scratch
> 
> generic/042 2s ... [not run] mkfs failed!
> Ran: generic/042
> Not run: generic/042
> Passed all 1 tests
> 
> 
>  common/rc         | 14 ++++++++------
>  tests/generic/042 |  2 +-
>  2 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 0ce3cb0d..4254806a 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -642,6 +642,8 @@ _test_mkfs()
>  _mkfs_dev()
>  {
>      local tmp=`mktemp -u`
> +    local mkfs_status
> +
>      case $FSTYP in
>      nfs*)
>  	# do nothing for nfs
> @@ -677,15 +679,15 @@ _mkfs_dev()
>  		2>$tmp.mkfserr 1>$tmp.mkfsstd
>  	;;
>      esac
> +    mkfs_status=$?
>  
> -    if [ $? -ne 0 ]; then
> -	# output stored mkfs output
> -	cat $tmp.mkfserr >&2
> -	cat $tmp.mkfsstd
> -	status=1
> -	exit 1
> +    if [ $mkfs_status -ne 0 ]; then
> +        # output stored mkfs output
> +        cat $tmp.mkfserr >&2
> +        cat $tmp.mkfsstd
>      fi
>      rm -f $tmp.mkfserr $tmp.mkfsstd
> +    return $mkfs_status
>  }
>  
>  # remove all files in $SCRATCH_MNT, useful when testing on NFS/CIFS
> diff --git a/tests/generic/042 b/tests/generic/042
> index 35727bcb..68bc15ca 100755
> --- a/tests/generic/042
> +++ b/tests/generic/042
> @@ -46,7 +46,7 @@ _crashtest()
>  	# the image to detect stale data exposure.
>  	$XFS_IO_PROG -f -c "truncate 0" -c "pwrite -S 0xCD 0 25M" $img \
>  		>> $seqres.full 2>&1
> -	_mkfs_dev $img >> $seqres.full 2>&1
> +	_mkfs_dev $img >> $seqres.full 2>&1 || _notrun "mkfs failed!"
>  
>  	mkdir -p $mnt
>  	_mount $img $mnt
> -- 
> 2.13.6
