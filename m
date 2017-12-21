Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:62338 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757284AbdLUBjM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 20 Dec 2017 20:39:12 -0500
Date: Thu, 21 Dec 2017 12:38:02 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] common/encrypt: Create an encrypted equivalent of
 _scratch_mkfs_sized
Message-ID: <20171221013802.GP5858@dastard>
References: <1513792000-25462-1-git-send-email-ari@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1513792000-25462-1-git-send-email-ari@tuxera.com>
Sender: fstests-owner@vger.kernel.org
To: Ari Sundholm <ari@tuxera.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Dec 20, 2017 at 07:46:40PM +0200, Ari Sundholm wrote:
> Test case generic/399 hardcodes "-O encrypt" in MKFS_OPTIONS when
> calling _scratch_mkfs_sized, which only works with the mkfs of certain
> filesystems. Create a new helper, _scratch_mkfs_sized_encrypted, for
> handling the differences between the mkfs tools of different
> filesystems. It also allows those filesystems whose mkfs doesn't accept
> "-O encrypt" to skip the test gracefully until proper support is added
> for them in the helper.
> 
> Signed-off-by: Ari Sundholm <ari@tuxera.com>
> ---
>  common/encrypt    | 12 ++++++++++++
>  tests/generic/399 |  3 +--
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/common/encrypt b/common/encrypt
> index a6fd89d..189c59e 100644
> --- a/common/encrypt
> +++ b/common/encrypt
> @@ -81,6 +81,18 @@ _scratch_mkfs_encrypted()
>  	esac
>  }
>  
> +_scratch_mkfs_sized_encrypted()
> +{
> +	case $FSTYP in
> +	ext4|f2fs)
> +		MKFS_OPTIONS="$MKFS_OPTIONS -O encrypt" _scratch_mkfs_sized $*
> +		;;

This does not need to screw around with MKFS_OPTIONS. This:

		_scratch_mkfs_sized -O encrypt $*

Will do just fine.

Also, _scratch_mkfs_encrypted() supports UBIFS, and this new
function doesn't. Seems like it should to me...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
