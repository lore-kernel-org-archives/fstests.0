Received: from mx1.redhat.com ([209.132.183.28]:44672 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752012AbcBJJPS (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 10 Feb 2016 04:15:18 -0500
Date: Wed, 10 Feb 2016 17:15:13 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 04/12] generic: add _require_odirect to three more tests
Message-ID: <20160210091513.GX11419@eguan.usersys.redhat.com>
References: <1455069001-17846-1-git-send-email-tytso@mit.edu>
 <1455069001-17846-5-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1455069001-17846-5-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, hughd@google.com
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 09, 2016 at 08:49:53PM -0500, Theodore Ts'o wrote:
> From: Hugh Dickins <hughd@google.com>
> 
> generic/113, generic/125, generic/214 each use O_DIRECT at some
> stage in their tests, so check O_DIRECT support before running them.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  tests/generic/113 | 1 +
>  tests/generic/125 | 1 +
>  tests/generic/214 | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/tests/generic/113 b/tests/generic/113
> index 7208fa2..54d6191 100755
> --- a/tests/generic/113
> +++ b/tests/generic/113
> @@ -77,6 +77,7 @@ _do_test()
>  _supported_fs generic
>  _supported_os Linux
>  _require_test
> +_require_odirect
>  
>  [ -x $here/ltp/aio-stress ] || _notrun "aio-stress not built for this platform"
>  
> diff --git a/tests/generic/125 b/tests/generic/125
> index bcf9b3e..67eb63f 100755
> --- a/tests/generic/125
> +++ b/tests/generic/125
> @@ -41,6 +41,7 @@ _supported_os Linux
>  
>  _require_test
>  _require_user
> +_require_odirect

generic/125 only runs "./src/ftrunc" and I don't see where O_DIRECT is
being used, did I miss anything?

Thanks,
Eryu

>  
>  TESTDIR=$TEST_DIR/ftrunc
>  TESTFILE=$TESTDIR/ftrunc.tmp
> diff --git a/tests/generic/214 b/tests/generic/214
> index dff267e..7838047 100755
> --- a/tests/generic/214
> +++ b/tests/generic/214
> @@ -55,6 +55,7 @@ rm -f $seqres.full
>  rm -f $TEST_DIR/ouch*
>  
>  _require_xfs_io_command "falloc"
> +_require_odirect
>  
>  # Ok, off we go.
>  
> -- 
> 2.5.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
