Received: from mga02.intel.com ([134.134.136.20]:60934 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932162AbcCODqf (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 14 Mar 2016 23:46:35 -0400
Date: Mon, 14 Mar 2016 21:46:10 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH] defrag: ext4 defrag not supported with DAX
Message-ID: <20160315034610.GD19926@linux.intel.com>
References: <1456957552-25326-1-git-send-email-ross.zwisler@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1456957552-25326-1-git-send-email-ross.zwisler@linux.intel.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org
Cc: Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 02, 2016 at 03:25:52PM -0700, Ross Zwisler wrote:
> As of this kernel commit:
> 
> commit 73f34a5e2ced ("ext4: online defrag not supported with DAX")
> 
> online defrag operations for ext4 are disallowed when the filesystem is
> mounted with the DAX option.
> 
> This causes several xfstests to fail because they expect the defrag
> operation to change the file layout:
> 
> ext4/308	 [failed, exit status 1] - output mismatch (see /root/xfstests/results//ext4/308.out.bad)
>     --- tests/ext4/308.out	2015-10-02 10:19:36.791795792 -0600
>     +++ /root/xfstests/results//ext4/308.out.bad	2016-02-17 16:20:52.330454602 -0700
>     @@ -23,659 +23,5 @@
>      50f924a5dc9b03609a4577f9f961414b  SCRATCH_MNT/test.10
>      Perform compacting
>      50f924a5dc9b03609a4577f9f961414b  SCRATCH_MNT/test.10
>     -Perform compacting, second pass
>     -50f924a5dc9b03609a4577f9f961414b  SCRATCH_MNT/test.10
>     -Create file with 20 * 2 fragments
>     -wrote 1234/1234 bytes at offset 0
>     ...
>     (Run 'diff -u tests/ext4/308.out /root/xfstests/results//ext4/308.out.bad'  to see the entire diff)
> generic/018 1s ... [failed, exit status 1] - output mismatch (see /root/xfstests/results//generic/018.out.bad)
>     --- tests/generic/018.out	2016-02-17 16:02:40.103656140 -0700
>     +++ /root/xfstests/results//generic/018.out.bad	2016-02-17 16:20:53.117459173 -0700
>     @@ -10,10 +10,6 @@
>      After: 1
>      Write backwards sync, but contiguous - should defrag to 1 extent
>      Before: in_range(5, 10)
>     -After: 1
>     -Write backwards sync leaving holes - defrag should do nothing
>     -Before: 16
>     -After: 16
>     ...
>     (Run 'diff -u tests/generic/018.out /root/xfstests/results//generic/018.out.bad'  to see the entire diff)
> 
> Avoid this by skipping over defrag tests if we are using ext4 + DAX.
> 
> Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> ---
>  common/defrag | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/common/defrag b/common/defrag
> index d2b137e..1c970e2 100644
> --- a/common/defrag
> +++ b/common/defrag
> @@ -27,7 +27,12 @@ _require_defrag()
>          DEFRAG_PROG="$XFS_FSR_PROG"
>  	;;
>      ext4|ext4dev)
> -        DEFRAG_PROG="$E4DEFRAG_PROG"
> +        echo $MOUNT_OPTIONS | grep -q dax
> +        if [ $? -eq 0 ]; then
> +            _notrun "defragmentation not supported with DAX"
> +        else
> +            DEFRAG_PROG="$E4DEFRAG_PROG"
> +        fi
>  	;;
>      btrfs)
>  	DEFRAG_PROG="$BTRFS_UTIL_PROG filesystem defragment"
> -- 
> 2.5.0

ping?
