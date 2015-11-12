Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:63301 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752403AbbKLAnw (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 11 Nov 2015 19:43:52 -0500
Date: Thu, 12 Nov 2015 11:43:49 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] fstests: Make generic/081 run in old version of lvm
Message-ID: <20151112004349.GP19199@dastard>
References: <0b5bab871522166ec55727e234c56004098dbc77.1447235833.git.zhaolei@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b5bab871522166ec55727e234c56004098dbc77.1447235833.git.zhaolei@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Zhaolei <zhaolei@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Nov 11, 2015 at 05:57:33PM +0800, Zhaolei wrote:
....
> Fix:
>  Add a condition to to check if current lvm support --yes option,
>  Tested in above RHEL 6.3 platform.
> 
> Changelog v1->v2:
>  Use yes pipe, suggested by: Eryu Guan <eguan@redhat.com>
> 
> Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>
> ---
>  tests/generic/081 | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/081 b/tests/generic/081
> index 8334ec9..1970075 100755
> --- a/tests/generic/081
> +++ b/tests/generic/081
> @@ -65,7 +65,11 @@ mkdir -p $mnt
>  # lvm uses some space for metadata
>  _scratch_mkfs_sized $((300 * 1024 * 1024)) >>$seqres.full 2>&1
>  $LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1
> -$LVM_PROG lvcreate --yes -L 256M -n $lvname $vgname >>$seqres.full 2>&1
> +if $LVM_PROG lvcreate --yes --version >>$seqres.full 2>&1; then
> +	$LVM_PROG lvcreate --yes -L 256M -n $lvname $vgname >>$seqres.full 2>&1
> +else
> +	yes | $LVM_PROG lvcreate -L 256M -n $lvname $vgname >>$seqres.full 2>&1
> +fi

If the current version of lvm works with the pipe version, then just
use that unconditionally.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
