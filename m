Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F75C433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 20 May 2022 04:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245673AbiETEmu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 20 May 2022 00:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241873AbiETEms (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 20 May 2022 00:42:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD71812FEE5
        for <fstests@vger.kernel.org>; Thu, 19 May 2022 21:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653021766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jv6p3VfNPEWr6LTsJ9aQUdZuWrZOAU8R09yJ825hi9Y=;
        b=alDxKg+ClTjrNZOxbtd+YU6jUnQagIu6O7xpTR5GFWLZMd23/eAcF6YsT7VpNRfa7ilgPg
        fl5Pm/9h/Ew9EytkU3FKJBgmcLy4LGWE9L2rt4axxO2Suz9+tQhJjPNP2SAtj8XRho9slW
        SmHJeK80Bui5dXYKm9zhM8106uNXjuU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-koHC9pCIOKGAuH0PGqw2AA-1; Fri, 20 May 2022 00:42:44 -0400
X-MC-Unique: koHC9pCIOKGAuH0PGqw2AA-1
Received: by mail-qt1-f197.google.com with SMTP id q13-20020a05622a04cd00b002f3c0e197afso5931175qtx.0
        for <fstests@vger.kernel.org>; Thu, 19 May 2022 21:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jv6p3VfNPEWr6LTsJ9aQUdZuWrZOAU8R09yJ825hi9Y=;
        b=oBhNzyiBLU0lNnhZNXMQ5kbbsiI+VS5beYGKF531Y5Z3p7Aq9kg+QDOiN8cKhkqDV5
         +QBUtZRJhm6eFC1XaQfUPDEZxfqhUPZVJiCChqG997NqNrXdwhMsuV98+N5YGQpebz11
         GNkt9DXKjzvzfBcKtRqlV25dF0QrmLByjgQeQPlfBZonvruhLx1jbC3sROBLI2XurehL
         BIXrDYMJQncVRxr2ZikIinC5arMWGEp8VwWSvmVf71MV1EGmvJeMwXOqJVRZUfJGo/Bp
         Teoa8FUPEWD+ucALQ4DDyKTu2twpAOYZIh4fSRri2/AxJE2DLFwNG/wXtn19bfbFKUYG
         xSng==
X-Gm-Message-State: AOAM532vaTVrSmg80TfOMbStUME4ybwa6/LvRW+5YUwc0w4+LFEPjnqO
        tx7vnizBDyJ/HERHHbNWK0Gcjs77yEYiqzwiRj1j8gj4jWW7Cjeav579n4Lb67LUMnAoJV4ZPO8
        PTYqGk4O82tNC/7tBbw==
X-Received: by 2002:ac8:4e91:0:b0:2f3:cbc2:eb0c with SMTP id 17-20020ac84e91000000b002f3cbc2eb0cmr6314000qtp.459.1653021763745;
        Thu, 19 May 2022 21:42:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLcmTJwH9+111QOtsP6bY/+2KtkQopqY2yQC+Jefw+BjIXaoDlTOD+mUPgJuQG9r+YjpzaSg==
X-Received: by 2002:ac8:4e91:0:b0:2f3:cbc2:eb0c with SMTP id 17-20020ac84e91000000b002f3cbc2eb0cmr6313997qtp.459.1653021763473;
        Thu, 19 May 2022 21:42:43 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k67-20020a37ba46000000b0069fc13ce1e9sm2460667qkf.26.2022.05.19.21.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 21:42:43 -0700 (PDT)
Date:   Fri, 20 May 2022 12:42:36 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] common/rc: fix test init performance regression on
 XFS
Message-ID: <20220520044236.qwyg3gsx357bqdh2@zlang-mailbox>
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
> ---

Nice catch! I just checked all cases use XFS_COPY_PROG, they all contains
_require_xfs_copy at beginning, so I think this change is good. I'll give
it more test before pushing.

That remind me better to check the common code which runs before each case
real starting. And carefully review patches might add more operations at
each case beginning. Anyway, thanks for this performance improvement.

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

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

