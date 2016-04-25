Received: from userp1040.oracle.com ([156.151.31.81]:44975 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964889AbcDYUxF (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 25 Apr 2016 16:53:05 -0400
Date: Mon, 25 Apr 2016 13:50:36 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] common/populate: remove unnecessary devices directory
 creation
Message-ID: <20160425205036.GB19708@birch.djwong.org>
References: <1460942807-19296-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1460942807-19296-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Apr 18, 2016 at 09:26:47AM +0800, Xiaoguang Wang wrote:
> _scratch_ext4_populate and _scratch_xfs_populate try to create
> devices directory in xfstests/, so if we run xfs/083 or ext4/006
> twice, it'll fail, fix this issue.

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> 
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> ---
>  common/populate | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/common/populate b/common/populate
> index d166c24..aa6ed79 100644
> --- a/common/populate
> +++ b/common/populate
> @@ -141,7 +141,6 @@ _scratch_xfs_populate() {
>  
>  	# Char & block
>  	echo "+ special"
> -	mkdir devices
>  	mknod "${SCRATCH_MNT}/S_IFCHR" c 1 1
>  	mknod "${SCRATCH_MNT}/S_IFBLK" c 1 1
>  
> @@ -241,7 +240,6 @@ _scratch_ext4_populate() {
>  
>  	# Char & block
>  	echo "+ special"
> -	mkdir devices
>  	mknod "${SCRATCH_MNT}/S_IFCHR" c 1 1
>  	mknod "${SCRATCH_MNT}/S_IFBLK" c 1 1
>  
> -- 
> 1.8.3.1
> 
> 
> 
