Received: from aserp2130.oracle.com ([141.146.126.79]:47174 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728564AbfBYWsO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 25 Feb 2019 17:48:14 -0500
Date: Mon, 25 Feb 2019 14:47:44 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] src/t_attr_corruption: use security.capability instead
 of security.evm
Message-ID: <20190225224744.GY6503@magnolia>
References: <20190225191052.15342-1-jeffm@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225191052.15342-1-jeffm@suse.com>
Sender: fstests-owner@vger.kernel.org
To: jeffm@suse.com
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Feb 25, 2019 at 02:10:52PM -0500, jeffm@suse.com wrote:
> From: Jeff Mahoney <jeffm@suse.com>
> 
> src/t_attr_corruption uses the security.evm extended attribute because
> it sorts before security.posix_acl_access.  The security.evm attribute
> is a formatted structure and when passed an uninitialized buffer, it
> will fail with EPERM.
> 
> We see test failures like:
>     --- tests/generic/529.out2019-02-21 13:22:47.583406922 -0500
>     +++ /opt/xfstests/results//generic/529.out.bad 2019-02-21 13:57:31.967406922 -0500
>     @@ -1,2 +1,2 @@
>      QA output created by 529
>     -list attr: Numerical result out of range
>     +set evm: Operation not permitted
> 
> This patch uses security.capability which also sorts where it needs to
> do for the test and also accepts an unformatted buffer.
> 
> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
> ---
>  src/t_attr_corruption.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/t_attr_corruption.c b/src/t_attr_corruption.c
> index f26611f9..0c229dbc 100644
> --- a/src/t_attr_corruption.c
> +++ b/src/t_attr_corruption.c
> @@ -76,7 +76,7 @@ int main(int argc, char *argv[])
>  	if (ret)
>  		die("set posix acl");
>  
> -	ret = fsetxattr(fd, "security.evm", buf, 1, 1);
> +	ret = fsetxattr(fd, "security.capability", buf, 1, 1);

This fails for me both with and without EVM configured into my kernel:

fsetxattr(3, "security.capability", "\3", 1, XATTR_CREATE) = -1 EINVAL (Invalid argument)

Judging from fs/xattr.c it looks as though security.capability also has
a defined format that's parsed by security/commoncap.c...

--D

>  	if (ret)
>  		die("set evm");
>  
> -- 
> 2.16.4
> 
