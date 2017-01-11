Received: from sandeen.net ([63.231.237.45]:35680 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936903AbdAKNZd (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 11 Jan 2017 08:25:33 -0500
Subject: Re: [PATCH] common: use xfs_io to obtain the xfsprogs version
References: <20170111104820.7367-1-ddiss@suse.de>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <390c9142-7984-c246-5941-3a88a8759626@sandeen.net>
Date: Wed, 11 Jan 2017 07:25:31 -0600
MIME-Version: 1.0
In-Reply-To: <20170111104820.7367-1-ddiss@suse.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: David Disseldorp <ddiss@suse.de>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 1/11/17 4:48 AM, David Disseldorp wrote:
> xfs_db is currently used for this, but is otherwise only used for XFS
> specific tests. This change allows for the generic tests to be run on a
> system without the xfs_db binary.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>

Reviewed-by: Eric Sandeen <sandeen@redhat.com>

> ---
>  common/config | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/common/config b/common/config
> index 6cce7ce..1604aa9 100644
> --- a/common/config
> +++ b/common/config
> @@ -226,11 +226,11 @@ export UDEV_SETTLE_PROG
>  # Generate a comparable xfsprogs version number in the form of
>  # major * 10000 + minor * 100 + release
>  #
> -# $ xfs_db -V
> -# xfs_db version 2.9.7
> +# $ xfs_io -V
> +# xfs_io version 2.9.7
>  #
>  # so, 2.9.7 = 20907
> -_version=`$XFS_DB_PROG -V | $AWK_PROG '
> +_version=`$XFS_IO_PROG -V | $AWK_PROG '
>  	/version/ {
>  		if (split($3,ver,".") == 3)
>  			print (ver[1] * 10000) + (ver[2] * 100) + ver[3];
> 
