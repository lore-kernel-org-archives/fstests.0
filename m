Received: from mail-pl0-f68.google.com ([209.85.160.68]:43777 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750808AbeDMEnm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 13 Apr 2018 00:43:42 -0400
Date: Fri, 13 Apr 2018 12:43:35 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v3] fstests: btrfs/159 superblock corruption test case
Message-ID: <20180413044335.GG2932@desktop>
References: <20180329102848.12669-1-anand.jain@oracle.com>
 <20180409052830.4772-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409052830.4772-1-anand.jain@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Apr 09, 2018 at 01:28:30PM +0800, Anand Jain wrote:
> Verify if the superblock corruption is handled correctly.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2->v3:
>  Provide the disk to be corrupted as an arg, instead of swapping the devices,
>   so drop mount_opt_minus_args().
>  159.out slightly changed.
> v1->v2:
>  $subject slightly changed
>  Added more info about the test-case
>  Keep the stuff from the ./new btrfs
>  Add mount_opt_minus_args() to get the options (if) set at the config file
>  Move DEV_GOOD & DEV_BAD to where it starts to use
>  To help debugging added run_check where possible
>  Remove {} in the out file
>  Use _filter_error_mount for mount fail cases other than -EINVAL
> 
>  tests/btrfs/159     | 149 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/159.out |  21 ++++++++
>  tests/btrfs/group   |   1 +
>  3 files changed, 171 insertions(+)
>  create mode 100755 tests/btrfs/159
>  create mode 100644 tests/btrfs/159.out
> 
> diff --git a/tests/btrfs/159 b/tests/btrfs/159
> new file mode 100755
> index 000000000000..c3a50b58b0b9
> --- /dev/null
> +++ b/tests/btrfs/159
> @@ -0,0 +1,149 @@
> +#! /bin/bash
> +# FS QA Test 159
> +#
> +# Test if the superblock corruption is handled correctly:
> +# 	- Test fsid miss-match (csum ok) between primary and copy superblock
> +#	Fixed by the ML patch:
> +#	btrfs: check if the fsid in the primary sb and copy sb are same
> +# 	- Test if the mount fails if the primary superblock csum is
> +#		corrupted on any disk
> +# 	- Test if the mount does not fail if the copy1 sb csum is corrupted
> +#	Fixed by the ML patches:
> +#	btrfs: verify superblock checksum during scan
> +#	btrfs: verify checksum for all devices in mount context

Do you have a tree that I can pull from? I want to make sure the test
does pass on patched kernel, but the patchset doesn't apply on v4.16
kernel.

Thanks,
Eryu
