Received: from mx1.redhat.com ([209.132.183.28]:59482 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751501AbdF0FZd (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 27 Jun 2017 01:25:33 -0400
Date: Tue, 27 Jun 2017 13:25:29 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 2/2] common/rc: handle xfs_io copy_range when
 copy_file_range syscall isn't available
Message-ID: <20170627052529.GX23360@eguan.usersys.redhat.com>
References: <20170626164053.7634-1-lhenriques@suse.com>
 <20170626164053.7634-2-lhenriques@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170626164053.7634-2-lhenriques@suse.com>
Sender: fstests-owner@vger.kernel.org
To: Luis Henriques <lhenriques@suse.com>
Cc: fstests@vger.kernel.org, Anna Schumaker <Anna.Schumaker@Netapp.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Jun 26, 2017 at 05:40:53PM +0100, Luis Henriques wrote:
> _require_xfs_io_command() isn't handling the case where the copy_file_range
> syscall isn't available.  Unfortunately, old versions of xfs_io don't
> handle it correctly either and the test will succeed with an empty file.

If copy_file_range syscall isn't available on the system, xfs_io should
have no "copy_range" built either, or if you're using a pre-built xfs_io
binary shipped by a distro, it should have no copy_range either to match
the kernel space. Anyway, I don't think it would cause any problem if
there's no copy_file_range syscall support. I'm curious what's your
environment setup.

> 
> To fix this function, we need to add two checks:
> 
> 1) for old xfs_io versions, fail if the test seems to succeed (no output)
>    but the file created is empty,
> 2) for newer versions, use the error returned.
> 
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
>  common/rc | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 2972f89e9527..aad065cb2ade 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2146,6 +2146,10 @@ _require_xfs_io_command()
>  		$XFS_IO_PROG -F -f -c "pwrite 0 4k" $testfile > /dev/null 2>&1
>  		testio=`$XFS_IO_PROG -F -f -c "copy_range $testfile" $testcopy 2>&1`
>  		rm -f $testcopy > /dev/null 2>&1

$testcopy is removed here...

> +		[ -z "$testio" -a ! -s "$testcopy" ] && \

then on hosts with copy_file_range support, this check always returns
true, and test _notrun when it should run.

Thanks,
Eryu

> +			_notrun "xfs_io $command support is missing"
> +		echo $testio | egrep -q "Function not implemented" && \
> +			_notrun "xfs_io $command support is missing"
>  		;;
>  	"falloc" )
>  		testio=`$XFS_IO_PROG -F -f -c "falloc $param 0 1m" $testfile 2>&1`
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
