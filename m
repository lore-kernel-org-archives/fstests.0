Received: from mx2.suse.de ([195.135.220.15]:33030 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388029AbeKFXJp (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 6 Nov 2018 18:09:45 -0500
Date: Tue, 6 Nov 2018 14:44:11 +0100
From: David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH 7/7] btrfs: test balance and resize with an active swap
 file
Message-ID: <20181106134411.GB24115@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1541193856.git.osandov@fb.com>
 <e6656ec218c973d548803ed50a45c8d3f81fe388.1541193856.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6656ec218c973d548803ed50a45c8d3f81fe388.1541193856.git.osandov@fb.com>
Sender: fstests-owner@vger.kernel.org
To: Omar Sandoval <osandov@osandov.com>
Cc: fstests@vger.kernel.org, kernel-team@fb.com, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Nov 02, 2018 at 02:29:42PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Make sure we don't shrink the device past an active swap file, but allow
> shrinking otherwise, as well as growing and balance.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  tests/btrfs/177     | 64 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/177.out |  6 +++++
>  tests/btrfs/group   |  1 +
>  3 files changed, 71 insertions(+)
>  create mode 100755 tests/btrfs/177
>  create mode 100644 tests/btrfs/177.out
> 
> diff --git a/tests/btrfs/177 b/tests/btrfs/177
> new file mode 100755
> index 00000000..12dad8fc
> --- /dev/null
> +++ b/tests/btrfs/177
> @@ -0,0 +1,64 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2018 Facebook.  All Rights Reserved.
> +#
> +# FS QA Test 177
> +#
> +# Test relocation (balance and resize) with an active swap file.
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +. ./common/rc
> +. ./common/filter
> +. ./common/btrfs
> +
> +rm -f $seqres.full
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch_swapfile
> +
> +swapfile="$SCRATCH_MNT/swap"
> +
> +# First, create a 1GB filesystem and fill it up.
> +_scratch_mkfs_sized $((1024 * 1024 * 1024)) >> $seqres.full 2>&1
> +_scratch_mount
> +dd if=/dev/zero of="$SCRATCH_MNT/fill" bs=1024k >> $seqres.full 2>&1

Can this be replaced by fallocate? Though it's just a 1GiB of data, it
still takes some seconds on rotational storage.
