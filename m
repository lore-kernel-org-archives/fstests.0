Received: from mx2.suse.de ([195.135.220.15]:56926 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726034AbfC1Rto (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 28 Mar 2019 13:49:44 -0400
Date: Thu, 28 Mar 2019 18:50:47 +0100
From: David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] fstests: btrfs try use forget to unregister device
Message-ID: <20190328175047.GR29086@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <1552988980-25710-1-git-send-email-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552988980-25710-1-git-send-email-anand.jain@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Mar 19, 2019 at 05:49:40PM +0800, Anand Jain wrote:
> btrfs module reload was introduced to unregister devices in the btrfs
> kernel module.
> 
> The problem with the module reload approach is that you can't run btrfs
> test cases 124, 125, 154 and 164 on the system with btrfs as root fs.
> 
> Patches [1] introduced btrfs forget feature which lets to cleanup the
> kernel device list without kernel module reload.
> 
>  [1]
>  btrfs-progs: add cli to forget one or all scanned devices

The subject lines was changed to "btrfs-progs: device scan: add new
option to forget one or all scanned devices"

>  btrfs: introduce new ioctl to unregister a btrfs device

> So this patch uses forget feature instead of kernel module reload, if
> the forget feature is available.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  common/btrfs    | 20 ++++++++++++++++++++
>  tests/btrfs/124 |  6 +++---
>  tests/btrfs/125 |  6 +++---
>  tests/btrfs/154 |  6 +++---
>  tests/btrfs/164 |  4 ++--
>  5 files changed, 31 insertions(+), 11 deletions(-)
> 
> diff --git a/common/btrfs b/common/btrfs
> index f6513c06f95f..e94e011db04e 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -382,3 +382,23 @@ _scratch_btrfs_sectorsize()
>  	$BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV |\
>  		grep sectorsize | awk '{print $2}'
>  }
> +
> +_btrfs_supports_forget()
> +{
> +	$BTRFS_UTIL_PROG device scan --help | grep -wq forget && \
> +		$BTRFS_UTIL_PROG device scan --forget > /dev/null 2>&1

The second part actually unregisters all devices, is there some more
lightweight way to detect the support? Like providing a valid block
device but without btrfs. If the ioctl is supported, then it returns
-ENOENT and if not supported then -EOPNOTSUPP.

> +}
> +
> +_require_btrfs_forget_if_not_fs_loadable()

_require_btrfs_forget_or_module_loadable

We don't want to load the filesystem but the kernel module.

> +{
> +	_btrfs_supports_forget && return

Why is the 'return' here? If the first command succeeds, then &&
proceeds to return that does implicitli returns 0. So it's redundant, or
I'm missing something subtle here.

> +
> +	_require_loadable_fs_module "btrfs"
> +}
> +
> +_btrfs_forget_if_not_fs_reload()

Same naming

> +{
> +	_btrfs_supports_forget && return
> +
> +	_reload_fs_module "btrfs"
> +}
