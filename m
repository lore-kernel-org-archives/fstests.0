Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:47647 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755514AbbIUATX (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 20 Sep 2015 20:19:23 -0400
Date: Mon, 21 Sep 2015 10:19:20 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic/027: enlarge fs size for btrfs in bigger
 page-size machine
Message-ID: <20150921001920.GI26895@dastard>
References: <1441971691-26427-1-git-send-email-xuw2015@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1441971691-26427-1-git-send-email-xuw2015@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: xuw2015@gmail.com
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Sep 11, 2015 at 07:41:31PM +0800, xuw2015@gmail.com wrote:
> From: George Wang <xuw2015@gmail.com>
> 
> btrfs on bigger page-size machine(such as ppc64/ppc64le), the min fs
> size shoule be more than 480MB. Otherwise, the mount will fail.
> So we shoud adjust the fs size to 512MB for btrfs to run this test
> correctly. And we also provide a double check: if mount fails, we should
> never run this test.
> 
> Signed-off-by: George Wang <xuw2015@gmail.com>
> ---
>  tests/generic/027 | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/tests/generic/027 b/tests/generic/027
> index d2e59d6..c42b9a6 100755
> --- a/tests/generic/027
> +++ b/tests/generic/027
> @@ -65,8 +65,17 @@ _require_scratch
>  rm -f $seqres.full
>  echo "Silence is golden"
>  
> -_scratch_mkfs_sized $((256 * 1024 * 1024)) >>$seqres.full 2>&1
> -_scratch_mount
> +loop=100
> +fs_size=$((256 * 1024 * 1024)) 
> +# btrfs takes much longer time, reduce the loop count
> +# btrfs takes much more space when first mount on bigger page-size machine
> +if [ "$FSTYP" == "btrfs" ]; then
> +	loop=10
> +	fs_size=$((512 * 1024 * 1024))
> +fi

No. Please don't sprinkle fs magic numbers like this through tests.
This is the second "btrfs breaks with small filesystems on 64k page
size machines so change the test" patch in recent times.

If btrfs has some special behaviour that it needs to support here
(e.g. minimum fs size because of machine page size) then please
modify the minimum size inside _scratch_mkfs_sized() via a callout
to a new _mkfs_btrfs_sized() function.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
