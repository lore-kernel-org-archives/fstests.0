Received: from mx2.suse.de ([195.135.220.15]:51428 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726005AbfDZQem (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 26 Apr 2019 12:34:42 -0400
Date: Fri, 26 Apr 2019 18:35:42 +0200
From: David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH v2] fstests: btrfs: try use forget to unregister device
Message-ID: <20190426163542.GW20156@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <1552988980-25710-1-git-send-email-anand.jain@oracle.com>
 <20190402081946.24838-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402081946.24838-1-anand.jain@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, dsterba@suse.cz, guaneryu@gmail.com
List-ID: <fstests@vger.kernel.org>

On Tue, Apr 02, 2019 at 04:19:46PM +0800, Anand Jain wrote:
> Some btrfs test cases use btrfs module-reload to unregister devices in
> the btrfs kernel. The problem with the module-reload approach is, if test
> system contains btrfs as rootfs, then you can't run these test cases.
> 
> Patches [1] introduced btrfs forget feature which can unregister devices
> without the module-reload approach.
> 
>  [1]
>  btrfs-progs: device scan: add new option to forget one or all scanned devices
>  btrfs: introduce new ioctl to unregister a btrfs device
> 
> And this patch makes relevant changes in the fstests to use this new
> feature, when available.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2:
>  Update change log.
>  Rename _require_btrfs_forget_if_not_fs_loadable() to _require_btrfs_forget_or_module_loadable()
>  Rename _btrfs_forget_if_not_fs_reload() to _btrfs_forget_or_module_reload()

Reviewed-by: David Sterba <dsterba@suse.com>

> +_require_btrfs_forget_or_module_loadable()
> +{
> +	_btrfs_supports_forget && return
> +
> +	_require_loadable_fs_module "btrfs"
> +}
> +
> +_btrfs_forget_or_module_reload()
> +{
> +	_btrfs_supports_forget && return
> +
> +	_reload_fs_module "btrfs"
> +}

The extra return mentioned in v1 is probably just a matter of coding
style so I don't mind as long as it works.
