Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD093C433B4
	for <linux-fstests@archiver.kernel.org>; Sat, 15 May 2021 15:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82E59613CE
	for <linux-fstests@archiver.kernel.org>; Sat, 15 May 2021 15:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhEOPun (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 15 May 2021 11:50:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230204AbhEOPum (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 15 May 2021 11:50:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C61F66127A;
        Sat, 15 May 2021 15:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621093769;
        bh=XnavjjPH35F/R8OE/3W1Ws0H4fCLdhM99fXkiJqDHfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LAR0jOar2n3+2UTSAh+XvhQZfrYe8jGSZ8PI5yFFIKyvOoZnxuBaCFVtWEZo29kYk
         ImKtHoKlXQr582kbZzCkucdzNby/RrPGYACEAGW3F2gVC7w6Q3yTtXBoyvBMplUJTy
         GpW4Jb3Fxx7wpDsUruEs+m6qj4SEbAJ7XdHxB9GlxF21kp7QuVNcIHyWYFzTTNlel1
         yVd0xM0MaL2Sp0qXQmvvfLNqbTFxofEn9Im+YTOTP4hMzobfZ7Di8c9E0isFC1u9XI
         im1ZyftdXCXxYG0QyaEx6BAJaJ9qsEvAs8bV7163MEuUN8mCNVlLBrvMlrEiawfO5b
         5LCkTH4RgCeVg==
Date:   Sat, 15 May 2021 08:49:29 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Sun Ke <sunke32@huawei.com>
Cc:     fstests@vger.kernel.org, guan@eryu.me
Subject: Re: [PATCH] common/rc: make _mkfs_dev return mkfs_status
Message-ID: <20210515154929.GA9648@magnolia>
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

Hmm, this changes _mkfs_dev behavior such that it no longer exits the
test, which implies that the callers could be broken.  How about
renaming the above to _try_mkfs_dev and then add a _mkfs_dev to:

_mkfs_dev() {
	_try_mkfs_dev "$@"
	if [ $? -ne 0 ]; then
		status=1
		exit 1
	fi
}

I think then the only difference is that _mkfs_dev now cleans up the
$tmp.mkfs* files.

--D

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
> 
