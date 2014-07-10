Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:40336 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753923AbaGJAw3 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 9 Jul 2014 20:52:29 -0400
Date: Thu, 10 Jul 2014 10:51:19 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs/292: fix format of expected message
Message-ID: <20140710005119.GI4453@dastard>
References: <1403694146-16910-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1403694146-16910-1-git-send-email-gux.fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xing Gu <gux.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 25, 2014 at 07:02:26PM +0800, Xing Gu wrote:
> In mkfs.xfs, it uses left-align and fixed width format when outputting
> device name, so variable length of devicename makes different space's
> number between "meta-data=devicename" and "isize". But in the expected
> output, the space' number between them is fixed. This behavior often
> results in the case failure. So fix the format of expected message.
> 
> Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
> ---
>  tests/xfs/292     | 6 ++++--
>  tests/xfs/292.out | 4 ++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/xfs/292 b/tests/xfs/292
> index 2910118..1762215 100755
> --- a/tests/xfs/292
> +++ b/tests/xfs/292
> @@ -53,9 +53,11 @@ rm -f $fsfile
>  $XFS_IO_PROG -f -c "truncate 256g" $fsfile
>  
>  echo "mkfs.xfs without geometry"
> -mkfs.xfs -f $fsfile 2>&1 | sed -e "s:$fsfile:FILENAME:g" | grep meta-data
> +mkfs.xfs -f $fsfile 2>&1 | grep meta-data | \
> +    sed -e "s:$fsfile:FILENAME:g" -e "s:[ ][ ]*: :g"
>  echo "mkfs.xfs with cmdline geometry"
> -mkfs.xfs -f -d su=16k,sw=5 $fsfile 2>&1 | sed -e "s:$fsfile:FILENAME:g" | grep meta-data
> +mkfs.xfs -f -d su=16k,sw=5 $fsfile 2>&1 | grep meta-data | \
> +    sed -e "s:$fsfile:FILENAME:g" -e "s:[ ][ ]*: :g"
>  
>  rm -f $fsfile

I think this test could be better rewritten to use _filter_mkfs. ie.

mkfs.xfs -f $fsfile | _filter_mkfs 2> $tmp.mkfs > /dev/null
grep ddev $tmp.mkfs

So that it uses the generic mkfs filter and pulls just the info
needed from the variable file that the filter produces. That way we
only have to update one filter whenever the mkfs output format
changes.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
