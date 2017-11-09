Received: from mx1.redhat.com ([209.132.183.28]:52476 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752256AbdKIGTF (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 9 Nov 2017 01:19:05 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 806CA7E427
        for <fstests@vger.kernel.org>; Thu,  9 Nov 2017 06:19:04 +0000 (UTC)
Received: from localhost (unknown [10.66.12.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0AFC85EE17
        for <fstests@vger.kernel.org>; Thu,  9 Nov 2017 06:19:03 +0000 (UTC)
Date: Thu, 9 Nov 2017 14:19:02 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/204: do not call _scratch_mkfs_sized in a pipe
Message-ID: <20171109061902.GT17339@eguan.usersys.redhat.com>
References: <20171105081110.26373-1-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171105081110.26373-1-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Nov 05, 2017 at 04:11:10PM +0800, Eryu Guan wrote:
> _scratch_mkfs_sized will create a filesystem of the given size, and
> call _notrun and exit if current $FSTYP doesn't support sized mkfs.
> But when it's called in a pipe, the exit in _notrun only exits from
> the subshell created by the pipe not the test itself, and test
> continues to run unnecessarily.
> 
> Fix it by not calling _scratch_mkfs_sized in a pipe, but dumping the
> output to a tmp file, which will be fed to _filter_mkfs later.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---
> 
> This is uncovered by Darrick's patch "generic/204: use available blocks
> to determine the number of files to create", with this patch applied
> test will 'hang' when testing on a large NFS export, because the number
> of files to be created was based on the size of available space.
> 
> Note that I've dropped that patch because it also caused failure in 512B
> block size XFS test.

Ping on this patch, v3 fix of generic/204 from Darrick has been reviewed &
queued for next release, it'd be great to have this patch in too.

Thanks,
Eryu

> 
>  tests/generic/204 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/204 b/tests/generic/204
> index 4c203a213f5b..ebc9c0fa001b 100755
> --- a/tests/generic/204
> +++ b/tests/generic/204
> @@ -58,8 +58,8 @@ _scratch_mkfs 2> /dev/null | _filter_mkfs 2> $tmp.mkfs > /dev/null
>  [ $FSTYP = "xfs" ] && MKFS_OPTIONS="$MKFS_OPTIONS -l size=16m -i maxpct=50"
>  
>  SIZE=`expr 115 \* 1024 \* 1024`
> -_scratch_mkfs_sized $SIZE $dbsize 2> /dev/null \
> -		| _filter_mkfs 2> $tmp.mkfs > /dev/null
> +_scratch_mkfs_sized $SIZE $dbsize 2> /dev/null > $tmp.mkfs.raw
> +cat $tmp.mkfs.raw | _filter_mkfs 2> $tmp.mkfs > /dev/null
>  _scratch_mount
>  
>  # Source $tmp.mkfs to get geometry
> -- 
> 2.13.6
> 
