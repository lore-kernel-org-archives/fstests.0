Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27306C433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 20 May 2022 02:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344597AbiETCAW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 May 2022 22:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344647AbiETCAU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 May 2022 22:00:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F380EC3E1
        for <fstests@vger.kernel.org>; Thu, 19 May 2022 19:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B6F1B827D9
        for <fstests@vger.kernel.org>; Fri, 20 May 2022 02:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E96C385B8;
        Fri, 20 May 2022 02:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653012016;
        bh=Qw7bjOz9I/djc9jXEiA9drUe+CWQhGBfqxjaMSKjXZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kBj3600gMKlAOhF4ypY4DPjzTyDXcoeFDLsQHpjiMCODNPJsXxUglDoeIJdn5hMWJ
         ri6ScqwqSneY01aVW1uU/s6JZPjNWq8I0cqZ/y9CdBKbXAMU9FQXVvFbnu0A2wjKsk
         zeU4+tvYW87q0o+Hi/STq97PT2N99+NgV4elFbWqrnI1f7C0hll+uO8jeslvjwZ8jn
         NeUFfpuR3ljBAhE4v4s0O5FFB9cP/1r/AmrY6G6LzwUfA/C11m6i7aTbEHPXa0PlSq
         wterKM2ierj1JPxA4Xb3Ya78ezQ24a073Vs41tXe16vQq+Thi8UcZu7FapoZHZh4d8
         oGJBU4Y/HXW3Q==
Date:   Thu, 19 May 2022 19:00:16 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] common/rc: fix test init performance regression on
 XFS
Message-ID: <Yob2MFPKUPZZPIys@magnolia>
References: <20220520012336.1542637-1-david@fromorbit.com>
 <20220520012336.1542637-3-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520012336.1542637-3-david@fromorbit.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, May 20, 2022 at 11:23:36AM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> I've been having problems over the past month with tests randomly
> running much slower than they should. The overall effect has been
> that running an auto group iterate has blown out from about 3
> hours to almost 5 hours.
> 
> The problem has been that the root disks have been thrashing.
> Thousands of iops and the backing store getting IO bound so all test
> vms with root drive images hosted on that backing store then also
> go slow.
> 
> I finally got to the bottom of it - it looked for all the world like
> a qemu image format write amplification problem, because I couldn't
> capture anything unusual from inside the guest. I converted all
> the root images to raw format on fast SSD storage, and the problem
> didn't go away - while some tests were faster, other tests were
> still randomly slow.
> 
> Finally I tracked it down with blktrace/blkparse. All the IO was
> coming from processes with the command line like:
> 
>  /sbin/mkfs.xfs -d file name=/tmp/791409.img size=512m
> 
> A quick grep then pointed me at common/rc::init_rc() where there is
> a test for XFS specific on-disk format behaviour that uses that
> exact command line.
> 
> init_rc() is run from _begin_fstest() so it is executed on every
> test start. We run mkfs to create a 512MB filesystem in $tmp on
> every test start. That's ..... not smart. And we do it so we can
> change the setup of $XFS_COPY_PROG, which is only used in a handful
> of tests. That's also .... not smart.
> 
> And then the penny dropped: we recently increased the default log
> size of small filesystems, so this is now zeroing a 64MB log instead
> of a 5-10MB log. And, of course it's on the root drive because of
> the $tmp image prefix, which in this case is ext3, and it's
> fragmenting the crap out of the writes and so it increases runtime
> of the mkfs.xfs execution from nothing to 5-10s.
> 
> Then when one of these mkfs invocations co-incides with journal
> flushing driven writeback, everything just stops until the writeback
> stops thrashing. And so all tests are 5-10s slows, and random tests
> take anywhere between 20-100s longer to start up....
> 
> Fix it by moving the setup of XFS_COPY_PROG to _require_xfs_copy()
> so only the tests that use xfs_copy run this code.
> 
> Numbers don't lie:
> 
> generic/001 11s ...  6s
> generic/002 9s ...  1s
> generic/003 17s ...  10s
> generic/004 12s ...  1s
> generic/005 9s ...  1s
> generic/006 9s ...  2s
> generic/007 11s ...  3s
> generic/008 5s ...  2s
> generic/009 10s ...  2s
> generic/010 5s ...  0s
> generic/011 9s ...  1s
> generic/012 7s ...  2s
> generic/013 10s ...  5s
> generic/014 11s ...  1s
> generic/015 7s ...  1s
> generic/016 7s ...  2s
> .....
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Ah, nice.  I hadn't even realized that was there!
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  common/rc  | 13 -------------
>  common/xfs | 12 ++++++++++++
>  2 files changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index f5ead044..67b4cc77 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4522,19 +4522,6 @@ init_rc()
>  	# it is supported.
>  	$XFS_IO_PROG -i -c quit 2>/dev/null && \
>  		export XFS_IO_PROG="$XFS_IO_PROG -i"
> -
> -	# xfs_copy on v5 filesystems do not require the "-d" option if xfs_db
> -	# can change the UUID on v5 filesystems
> -	if [ "$FSTYP" == "xfs" ]; then
> -		touch /tmp/$$.img
> -		$MKFS_XFS_PROG -d file,name=/tmp/$$.img,size=512m >/dev/null 2>&1
> -		# xfs_db will return 0 even if it can't generate a new uuid, so
> -		# check the output to make sure if it can change UUID of V5 xfs
> -		$XFS_DB_PROG -x -c "uuid generate" /tmp/$$.img \
> -			| grep -q "invalid UUID\|supported on V5 fs" \
> -			&& export XFS_COPY_PROG="$XFS_COPY_PROG -d"
> -		rm -f /tmp/$$.img
> -	fi
>  }
>  
>  # get real device path name by following link
> diff --git a/common/xfs b/common/xfs
> index ac1d021e..2123a4ab 100644
> --- a/common/xfs
> +++ b/common/xfs
> @@ -1160,6 +1160,18 @@ _require_xfs_copy()
>  	[ -n "$XFS_COPY_PROG" ] || _notrun "xfs_copy binary not yet installed"
>  	[ "$USE_EXTERNAL" = yes ] && \
>  		_notrun "Cannot xfs_copy with external devices"
> +
> +	# xfs_copy on v5 filesystems do not require the "-d" option if xfs_db
> +	# can change the UUID on v5 filesystems
> +	touch /tmp/$$.img
> +	$MKFS_XFS_PROG -d file,name=/tmp/$$.img,size=64m >/dev/null 2>&1
> +
> +	# xfs_db will return 0 even if it can't generate a new uuid, so
> +	# check the output to make sure if it can change UUID of V5 xfs
> +	$XFS_DB_PROG -x -c "uuid generate" /tmp/$$.img \
> +		| grep -q "invalid UUID\|supported on V5 fs" \
> +		&& export XFS_COPY_PROG="$XFS_COPY_PROG -d"
> +	rm -f /tmp/$$.img
>  }
>  
>  __xfs_cowgc_interval_knob1="/proc/sys/fs/xfs/speculative_cow_prealloc_lifetime"
> -- 
> 2.35.1
> 
