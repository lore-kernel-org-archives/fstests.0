Received: from userp1040.oracle.com ([156.151.31.81]:41950 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752291AbcITFzw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 20 Sep 2016 01:55:52 -0400
Date: Mon, 19 Sep 2016 22:55:42 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v3] common/rc: fix fsmap check
Message-ID: <20160920055542.GF10172@birch.djwong.org>
References: <20160920044809.GB3059@birch.djwong.org>
 <1474348992-27909-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1474348992-27909-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: eguan@redhat.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Sep 20, 2016 at 01:23:12PM +0800, Xiao Yang wrote:
> We don't need -T to detect GETFSMAP and the flag doesn't exist
> on really old versions of xfs_io, so just get rid of it.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  common/rc | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 13afc6a..52a75c5 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2049,8 +2049,7 @@ _require_xfs_io_command()
>  			_notrun "xfs_io $command support is missing"
>  		;;
>  	"fsmap" )
> -		testio=`$XFS_IO_PROG -T -F -c "fsmap" \
> -			$TEST_DIR 2>&1`
> +		testio=`$XFS_IO_PROG -f -c "fsmap" $testfile 2>&1`

Seems fine to me,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

>  		echo $testio | egrep -q "Inappropriate ioctl" && \
>  			_notrun "xfs_io $command support is missing"
>  		;;
> -- 
> 1.8.3.1
> 
> 
> 
