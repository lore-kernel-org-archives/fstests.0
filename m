Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:17269 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756134AbdLUBek (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 20 Dec 2017 20:34:40 -0500
Date: Thu, 21 Dec 2017 12:34:04 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic/399: Use dd instead of xfs_io pwrite to fill
 volume
Message-ID: <20171221013404.GO5858@dastard>
References: <1513790564-24236-1-git-send-email-ari@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1513790564-24236-1-git-send-email-ari@tuxera.com>
Sender: fstests-owner@vger.kernel.org
To: Ari Sundholm <ari@tuxera.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Dec 20, 2017 at 07:22:44PM +0200, Ari Sundholm wrote:
> As recently discussed on the fstests mailing list, the way
> generic/399 checks for the filesystem having become full only
> works on filesystems that behave like ext4, and even on those,
> actually only works by accident.
> 
> The problem is that xfs_io does not give a nonzero exit value
> when the pwrite operation fails due to ENOSPC. However, if the
> filesystem also happens to be unable to create new empty files
> when it is full, the check will do its job because open() fails
> with ENOSPC. Not all filesystems behave like this, however.
> 
> As it seems to be nontrivial to get xfs_io fixed for this case,
> I propose simply replacing the xfs_io pwrite command with dd
> for now. AFAICS, this works with all filesystems, and should also
> preserve the nature of the test case.
> 
> Signed-off-by: Ari Sundholm <ari@tuxera.com>
> ---
>  tests/generic/399 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/399 b/tests/generic/399
> index 8f5fcdc..5056b20 100755
> --- a/tests/generic/399
> +++ b/tests/generic/399
> @@ -101,7 +101,7 @@ total_file_size=0
>  i=1
>  while true; do
>  	file=$SCRATCH_MNT/encrypted_dir/file$i
> -	if ! $XFS_IO_PROG -f $file -c 'pwrite 0 1M' &> $tmp.out; then
> +	if ! dd if=/dev/zero of=$file bs=4k count=256 &> $tmp.out; then
>  		if ! grep -q 'No space left on device' $tmp.out; then
>  			echo "FAIL: unexpected pwrite failure"
>  			cat $tmp.out

NACK.

Please work to get xfs_io fixed - there's been some discussion, a
couple of test patches, and a direction has pretty much been decided
but neither Brian (who is on PTO) or I have had the time to
implement it. If you need it fixed right away then you need to put
the work in rather than wait for other people (who are on holiday
right now) to fit it into their own schedules and priorities.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
