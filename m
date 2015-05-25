Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:42344 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750859AbbEYWa4 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 25 May 2015 18:30:56 -0400
Date: Tue, 26 May 2015 08:30:50 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 3/3] common/rc: support gfs2 in _scratch_mkfs_sized
Message-ID: <20150525223050.GV4316@dastard>
References: <1431697004-3032-1-git-send-email-anprice@redhat.com>
 <1431697004-3032-3-git-send-email-anprice@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1431697004-3032-3-git-send-email-anprice@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Andrew Price <anprice@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, May 15, 2015 at 02:36:44PM +0100, Andrew Price wrote:
> This enables tests which use _scratch_mkfs_sized when $FSTYP == gfs2.
> Where tests use a fs size too small to contain a gfs2 fs created with
> default options, specify a smaller journal size to make it fit.
> 
> Signed-off-by: Andrew Price <anprice@redhat.com>
....
> diff --git a/tests/generic/015 b/tests/generic/015
> index 8d3fd5f..d1805a7 100755
> --- a/tests/generic/015
> +++ b/tests/generic/015
> @@ -53,6 +53,9 @@ _supported_os IRIX Linux
>  _require_scratch
>  _require_no_large_scratch_dev
>  
> +# GFS2 needs a smaller journal size to fit in 50M
> +[ $FSTYP = "gfs2" ] && MKFS_OPTIONS="$MKFS_OPTIONS -J16"

This belongs in scratch_mkfs_sized(), as gfs2 specific code. You
have the size of the fs to be made there, so set the limit
appropriately there.

As it is, it's worth considering that this is exposing a mkfs.gfs2
bug in that it doesn't handle small filesystem sizes correctly by
default....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
