Received: from mx1.redhat.com ([209.132.183.28]:42000 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751723AbcHYE1m (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 25 Aug 2016 00:27:42 -0400
Date: Thu, 25 Aug 2016 12:09:44 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/337: add checks for listxattr call fails.
Message-ID: <20160825040944.GV27776@eguan.usersys.redhat.com>
References: <1472039753-29982-1-git-send-email-asavkov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1472039753-29982-1-git-send-email-asavkov@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Artem Savkov <asavkov@redhat.com>
Cc: fstests@vger.kernel.org, Filipe Manana <fdmanana@suse.com>, Dave Chinner <david@fromorbit.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Aug 24, 2016 at 01:55:53PM +0200, Artem Savkov wrote:
> Add simple checks for failed calls to listxattr syscall. So far ERANGE, ENOENT
> and EFAULT are checked.
> 
> Test is based on llistxattr02 test from LTP.

Any reason porting this from LTP? I think LTP is the right place for
such syscall level tests, this test should stay there, or extend
llistxattr02 test if you want to test new errnos.

> 
> Signed-off-by: Artem Savkov <asavkov@redhat.com>
> ---
>  .gitignore            |  1 +
>  src/Makefile          |  2 +-
>  src/listxattr_fails.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/337     |  4 ++++
>  tests/generic/337.out |  3 +++
>  5 files changed, 60 insertions(+), 1 deletion(-)
>  create mode 100644 src/listxattr_fails.c
> 
> diff --git a/.gitignore b/.gitignore
> index d84f385..613d245 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -66,6 +66,7 @@
>  /src/holes
>  /src/holetest
>  /src/itrash
> +/src/listxattr_fails
>  /src/locktest
>  /src/loggen
>  /src/looptest
> diff --git a/src/Makefile b/src/Makefile
> index 57b0df1..0fee55f 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -21,7 +21,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	stale_handle pwrite_mmap_blocked t_dir_offset2 seek_sanity_test \
>  	seek_copy_test t_readdir_1 t_readdir_2 fsync-tester nsexec cloner \
>  	renameat2 t_getcwd e4compact test-nextquota punch-alternating \
> -	attr-list-by-handle-cursor-test
> +	attr-list-by-handle-cursor-test listxattr_fails
>  
>  SUBDIRS =
[snip]
> diff --git a/tests/generic/337 b/tests/generic/337
> index 1758871..88b1e33 100755
> --- a/tests/generic/337
> +++ b/tests/generic/337
> @@ -68,5 +68,9 @@ $SETFATTR_PROG -n user.ping -v pong $SCRATCH_MNT/testfile
>  # It should list all the xattrs we have set before.
>  $GETFATTR_PROG --absolute-names --dump $SCRATCH_MNT/testfile | _filter_scratch
>  
> +# Call listattr_fails to check if we get expected errors on errorneus listxattr
> +# calls.
> +$here/src/listxattr_fails $SCRATCH_MNT/testfile
> +

And usually we don't add new test to existing cases, so if the new test
fails we know it's not a regression.

Thanks,
Eryu

>  status=0
>  exit
> diff --git a/tests/generic/337.out b/tests/generic/337.out
> index 1cd92ff..8ff8374 100644
> --- a/tests/generic/337.out
> +++ b/tests/generic/337.out
> @@ -6,3 +6,6 @@ user.foobar="123"
>  user.ping="pong"
>  user.something="pizza"
>  
> +expected error: ERANGE
> +expected error: ENOENT
> +expected error: EFAULT
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
