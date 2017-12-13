Received: from mx1.redhat.com ([209.132.183.28]:38276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751529AbdLMLFa (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 13 Dec 2017 06:05:30 -0500
Date: Wed, 13 Dec 2017 19:05:27 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v4 1/3] Check pwrite parameters
Message-ID: <20171213110527.GB2749@eguan.usersys.redhat.com>
References: <20171207160044.8913-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171207160044.8913-1-rgoldwyn@suse.de>
Sender: fstests-owner@vger.kernel.org
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: fstests@vger.kernel.org, darrick.wong@oracle.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Dec 07, 2017 at 10:00:42AM -0600, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> There are some parameters added with xfs_io. Check if the pwrite
> parameters are available. For some cases, xfs_io now returns "command
> -%c not supported", so added "not supported" to count as error.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Changes since v3:
>  - pwrite -N check to add -V parameters to check on pwritev2()
> 
> ---
>  common/rc | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 4c053a53..4f4b9e10 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2035,6 +2035,7 @@ _require_xfs_io_command()
>  	shift
>  	local param="$*"
>  	local param_checked=0
> +	local opts=""
>  
>  	testfile=$TEST_DIR/$$.xfs_io
>  	case $command in
> @@ -2079,6 +2080,17 @@ _require_xfs_io_command()
>  		echo $testio | grep -q "invalid option" && \
>  			_notrun "xfs_io $command support is missing"
>  		;;
> +	"pwrite")
> +		# -N (RWF_NOWAIT) only works with direct I/O writes
> +		local pwrite_opts=" "
> +		if [ "$param" == "-N" ]; then
> +			opts+=" -d"
> +			pwrite_opts+="-V 1 -b 4k"
> +		fi
> +		testio=`$XFS_IO_PROG -f $opts -c \
> +		        "pwrite $pwrite_opts $param 0 4k" $testfile 2>&1`
> +		param_checked=1

I think I found why xfs_io returned EOPNOTSUPP but strace showed EAGAIN
for me. It's pwritev2 glibc wrapper that modifies the errno before
return, please see glibc commit 852d63120783 ("posix: Set p{read,write}v2
to return ENOTSUP (BZ#21780)").

diff --git a/sysdeps/unix/sysv/linux/pwritev2.c b/sysdeps/unix/sysv/linux/pwritev2.c
index 72f0471f969a..8e5032fe2fed 100644
--- a/sysdeps/unix/sysv/linux/pwritev2.c
+++ b/sysdeps/unix/sysv/linux/pwritev2.c
@@ -28,7 +28,7 @@ pwritev2 (int fd, const struct iovec *vector, int count, off_t offset,
 # ifdef __NR_pwritev2
   ssize_t result = SYSCALL_CANCEL (pwritev2, fd, vector, count,
                                   LO_HI_LONG (offset), flags);
-  if (result >= 0 || errno != ENOSYS)
+  if (result >= 0)
     return result;
 # endif
   /* Trying to emulate the pwritev2 syscall flags is troublesome:
@@ -42,7 +42,7 @@ pwritev2 (int fd, const struct iovec *vector, int count, off_t offset,
 
   if (flags != 0)
     {
-      __set_errno (EOPNOTSUPP);
+      __set_errno (ENOTSUP);
       return -1;
     }
   return pwritev (fd, vector, count, offset);

So originally, pritev2 wrapper returned any error except ENOSYS, but now
it translates all errors to ENOTSUP (EOPNOTSUPP). That's why kernel
returned EAGAIN and strace captured EAGAIN but perror() in xfs_io still
printed EOPNOTSUPP. It looks like a glibc bug to me.

Apparently, my Fedora rawhide system is new enough to have this glibc
version. And I did see generic/470 pass with 4.15-rc2 kernel with that
glibc patch reverted.

Anyway, with this additional "-V 1" in pwrite test, generic/470 would
_notrun on buggy system.

I'll queue this patchset for next release if there's no more comments
from other reivewers.

Thanks
Eryu


> +		;;
>  	"scrub"|"repair")
>  		testio=`$XFS_IO_PROG -x -c "$command probe 0" $TEST_DIR 2>&1`
>  		echo $testio | grep -q "Inappropriate ioctl" && \
> @@ -2109,7 +2121,9 @@ _require_xfs_io_command()
>  		$XFS_IO_PROG -c "help $command" | grep -q "^ $param --" || \
>  			_notrun "xfs_io $command doesn't support $param"
>  	else
> -		echo $testio | grep -q "invalid option" && \
> +		# xfs_io could result in "command %c not supported" if it was
> +		# built on kernels not supporting pwritev2() calls
> +		echo $testio | grep -q "\(invalid option\|not supported\)" && \
>  			_notrun "xfs_io $command doesn't support $param"
>  	fi
>  }
> -- 
> 2.14.2
> 
