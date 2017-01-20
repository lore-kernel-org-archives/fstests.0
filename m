Received: from mx1.redhat.com ([209.132.183.28]:38652 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750735AbdATFXB (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 20 Jan 2017 00:23:01 -0500
Date: Fri, 20 Jan 2017 13:22:58 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v4 2/3] fstests: test btrfs incremental send after moving
 a directory
Message-ID: <20170120052258.GU1859@eguan.usersys.redhat.com>
References: <1484190817-17326-1-git-send-email-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484190817-17326-1-git-send-email-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>, Robbie Ko <robbieko@synology.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Jan 12, 2017 at 03:13:37AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that an incremental send operation works after moving a directory
> into a new parent directory, deleting its previous parent directory and
> creating a new inode that has the same inode number as the old parent.
> 
> This issue is fixed by the following patch for the linux kernel:
> 
>   "Btrfs: incremental send, do not delay rename when parent inode is new"
> 
> Signed-off-by: Robbie Ko <robbieko@synology.com>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

I tested this patchset with/without proposed kernel patches, all tests
worked as expected. Just one tiny update on commit below.

> ---

> +# Remount the filesystem so that the next created inodes will have the numbers
> +# 258 and 259. This is because when a filesystem is mounted, btrfs sets the
> +# subvolume's inode counter to a value corresponding to the highest inode number
> +# in the subvolume plus 1. This inode counter is used to assign a unique number
> +# to each new inode and it's incremented by 1 after very inode creation.
> +# Note: we unmount and then mount instead of doing a mount with "-o remount"
> +# because otherwise the inode counter remains at value 260.
> +_scratch_unmount
> +_scratch_mount

I replaced these with _scratch_cycle_mount.

Thanks,
Eryu
