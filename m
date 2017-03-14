Received: from mx1.redhat.com ([209.132.183.28]:53754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750703AbdCNFHl (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 14 Mar 2017 01:07:41 -0400
Date: Tue, 14 Mar 2017 13:07:39 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] common/rc: Use -v option with findmnt
Message-ID: <20170314050739.GY14226@eguan.usersys.redhat.com>
References: <20170313180726.1967-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170313180726.1967-1-rgoldwyn@suse.de>
Sender: fstests-owner@vger.kernel.org
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: fstests@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Mar 13, 2017 at 01:07:26PM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Since btrfs puts in the subvol name in the device, we should
> use -v option to not print the bind mounts or btrfs volumes.
> 
> Fixes: 5e6892d ("common/rc: use findmnt to check mounted device")
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Hmm, I mounted a btrfs snapshot of TEST_DEV to another dir and ran
check, check reported:

TEST_DEV=/dev/sdc1 is mounted but not on TEST_DIR=/mnt - aborting
Already mounted result:
/dev/sdc1[/snap] /mnt/scratch

which seems fine and clear to me. Did you hit any particular failures
without this fix?

Thanks,
Eryu

> ---
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index d53f679..d7a5321 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1463,7 +1463,7 @@ _check_mounted_on()
>  	local type=$5
>  
>  	# find $dev as the source, and print result in "$dev $mnt" format
> -	local mount_rec=`findmnt -rnc -S $dev -o SOURCE,TARGET`
> +	local mount_rec=`findmnt -rncv -S $dev -o SOURCE,TARGET`
>  	[ -n "$mount_rec" ] || return 1 # 1 = not mounted
>  
>  	# if it's mounted, make sure its on $mnt
> -- 
> 2.10.2
> 
