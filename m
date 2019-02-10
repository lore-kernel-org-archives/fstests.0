Received: from mail-pl1-f196.google.com ([209.85.214.196]:33847 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfBJLLu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 10 Feb 2019 06:11:50 -0500
Received: by mail-pl1-f196.google.com with SMTP id w4so3923636plz.1
        for <fstests@vger.kernel.org>; Sun, 10 Feb 2019 03:11:50 -0800 (PST)
Date: Sun, 10 Feb 2019 19:11:42 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] generic: detect preallocation support for fsx tests 075
 and 112
Message-ID: <20190210111142.GU2713@desktop>
References: <20190205184713.20266-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205184713.20266-1-hch@lst.de>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 05, 2019 at 07:47:13PM +0100, Christoph Hellwig wrote:
> Currently generic/075 and generic/112 have two extra fsx passes each that
> exercise fsx with preallocation, which are only enabled for XFS.
> 
> These tests can also be run with other file systems, given that the XFS
> prealloc ioctls are implemented in generic code since the addition of
> the fallocate system call.  This also means a version of XFS that does
> not support preallocation (e.g. because it always writes out of place)
> can skip the prealloc tests while still completing the normal fsx tests
> just fine.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/generic/075 | 16 +++++++++++-----
>  tests/generic/112 | 20 +++++++++++++-------
>  2 files changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/tests/generic/075 b/tests/generic/075
> index 2b957891..8981c560 100755
> --- a/tests/generic/075
> +++ b/tests/generic/075
> @@ -48,11 +48,12 @@ _do_test()
>      echo "fsx.$_n : $_filter_param"
>      echo "-----------------------------------------------"
>  
> -    if [ "$FSTYP" != "xfs" ]
> -    then
> -	if [ "$_n" = "1" -o "$_n" = "3" ]
> -	then
> -	    # HACK: only xfs handles preallocation (-x) so just skip this test
> +    if [ "$_n" = "1" -o "$_n" = "3" ]; then
> +        if echo $testio | grep -q "Operation not supported"; then

Hmm, I don't think checking ENOSUPP message is sufficient, old distros
may ship xfs_io without falloc support or there's no generic prealloc
ioctl support, these cases are rare but possible.

How about adding a new XFS_IOC_RESVSP ioctl check in src/feature.c and
skip the fsx's "-x" option if feature reports that the ioctl is not
supported by the fs?

Thanks,
Eryu

> +	    #
> +	    # Skip the prealloc runs if the file system does not support
> +	    # preallocation
> +	    #
>  	    return
>  	fi
>      fi
> @@ -128,6 +129,11 @@ echo "brevity is wit..."
>  
>  _check_test_fs
>  
> +# check if preallocation is supported
> +testfile=$TEST_DIR/$$.xfs_io
> +testio=`$XFS_IO_PROG -F -f -c "falloc 0 1m" $testfile 2>&1`
> +rm -f $testfile 2>&1 > /dev/null
> +
>  # Options:
>  # -d: debug output for all operations
>  # -l flen: the upper bound on file size (default 262144)
> diff --git a/tests/generic/112 b/tests/generic/112
> index 1879e7b5..a6f8fc14 100755
> --- a/tests/generic/112
> +++ b/tests/generic/112
> @@ -48,13 +48,14 @@ _do_test()
>      echo "fsx.$_n : $_filter_param"
>      echo "-----------------------------------------------"
>  
> -    if [ "$FSTYP" != "xfs" ]
> -    then
> -        if [ "$_n" = "1" -o "$_n" = "3" ]
> -        then
> -            # HACK: only xfs handles preallocation (-x) so just skip this test
> -            return
> -        fi
> +    if [ "$_n" = "1" -o "$_n" = "3" ]; then
> +        if echo $testio | grep -q "Operation not supported"; then
> +	    #
> +	    # Skip the prealloc runs if the file system does not support
> +	    # preallocation
> +	    #
> +	    return
> +	fi
>      fi
>  
>      # This cd and use of -P gets full debug on $here (not TEST_DEV)
> @@ -128,6 +129,11 @@ echo "brevity is wit..."
>  
>  _check_test_fs
>  
> +# check if preallocation is supported
> +testfile=$TEST_DIR/$$.xfs_io
> +testio=`$XFS_IO_PROG -F -f -c "falloc 0 1m" $testfile 2>&1`
> +rm -f $testfile 2>&1 > /dev/null
> +
>  # Options:
>  # -d: debug output for all operations
>  # -l flen: the upper bound on file size (default 262144)
> -- 
> 2.20.1
> 
