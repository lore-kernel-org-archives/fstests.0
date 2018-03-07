Received: from mail-io0-f194.google.com ([209.85.223.194]:33561 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751067AbeCGHHy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 7 Mar 2018 02:07:54 -0500
Date: Wed, 7 Mar 2018 15:07:47 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] fstests: btrfs/004: increase the buffer size of
 logical-resolve to the maximum value 64K
Message-ID: <20180307070747.GG30836@localhost.localdomain>
References: <20180306070231.16880-1-lufq.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306070231.16880-1-lufq.fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Mar 06, 2018 at 03:02:31PM +0800, Lu Fengqi wrote:
> Because of commit e76e13ce8c0b ("fsstress: implement the
> clonerange/deduperange ioctls"), dedupe makes the number of references to
> the same extent item increase so much that the default 4K buffer of
> logical-resolve is no longer sufficient.
> 
> Signed-off-by: Lu Fengqi <lufq.fnst@cn.fujitsu.com>

This looks fine to me. But I'd like an explicit ack from btrfs
developers.

Thanks,
Eryu

> ---
>  tests/btrfs/004 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/004 b/tests/btrfs/004
> index de583cc355d4..0d2efb91dba7 100755
> --- a/tests/btrfs/004
> +++ b/tests/btrfs/004
> @@ -103,7 +103,7 @@ _btrfs_inspect_addr()
>  	expect_addr=$3
>  	expect_inum=$4
>  	file=$5
> -	cmd="$BTRFS_UTIL_PROG inspect-internal logical-resolve -P $addr $mp"
> +	cmd="$BTRFS_UTIL_PROG inspect-internal logical-resolve -s 65536 -P $addr $mp"
>  	echo "# $cmd" >> $seqres.full
>  	out=`$cmd`
>  	echo "$out" >> $seqres.full
> -- 
> 2.16.2
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
