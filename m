Received: from mail-pg1-f195.google.com ([209.85.215.195]:42763 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbfHRPol (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 18 Aug 2019 11:44:41 -0400
Date: Sun, 18 Aug 2019 23:44:28 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] fstests: generic/500 doesn't work for btrfs
Message-ID: <20190818154016.GB2845@desktop>
References: <20190815182659.27875-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815182659.27875-1-josef@toxicpanda.com>
Sender: fstests-owner@vger.kernel.org
To: Josef Bacik <josef@toxicpanda.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, kernel-team@fb.com, "Darrick J. Wong" <darrick.wong@oracle.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Aug 15, 2019 at 02:26:59PM -0400, Josef Bacik wrote:
> Btrfs does COW, so when we unlink the file we need to update metadata
> and write it to a new location, which we can't do because the thinp is
> full.  This results in an EIO during a metadata write, which makes us
> flip read only, thus making it impossible to fstrim the fs.  Just make
> it so we skip this test for btrfs.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  tests/generic/500 | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tests/generic/500 b/tests/generic/500
> index 201d8b9f..5cd7126f 100755
> --- a/tests/generic/500
> +++ b/tests/generic/500
> @@ -49,6 +49,12 @@ _supported_os Linux
>  _require_scratch_nocheck
>  _require_dm_target thin-pool
>  
> +# The unlink below will result in new metadata blocks for btrfs because of CoW,
> +# and since we've filled the thinp device it'll return EIO, which will make
> +# btrfs flip read only, making it fail this test when it just won't work right
> +# for us in the first place.
> +test $FSTYP == "btrfs"  && _notrun "btrfs doesn't work that way lol"

I'm wondering if we could introduce a proper _require rule to cover this
case? e.g. require the fs doesn't allocate new blocks on unlink? or
something like that. But I'm not sure what's the proper fs feature to
require here, any suggestions?

Thanks,
Eryu

> +
>  # Require underlying device support discard
>  _scratch_mkfs >>$seqres.full 2>&1
>  _scratch_mount
> -- 
> 2.21.0
> 
