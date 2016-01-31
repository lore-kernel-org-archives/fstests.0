Received: from aserp1040.oracle.com ([141.146.126.69]:42979 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256AbcAaDFQ (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sat, 30 Jan 2016 22:05:16 -0500
Date: Sat, 30 Jan 2016 19:05:03 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] xfs/083: disable dmesg check
Message-ID: <20160131030503.GB5849@birch.djwong.org>
References: <1454068444-23926-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1454068444-23926-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Jan 29, 2016 at 07:54:04PM +0800, Guangwen Feng wrote:
> This test fuzzes the metadata and accesses the corrupted fs later,
> which always produces error info in dmesg and causes test fail,
> so fix this.
> 
> Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
> ---
>  tests/xfs/083 | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tests/xfs/083 b/tests/xfs/083
> index 8e14e88..558b964 100755
> --- a/tests/xfs/083
> +++ b/tests/xfs/083
> @@ -102,6 +102,11 @@ scratch_repair() {
>  }
>  
>  rm -f $seqres.full
> +
> +# We will access the corrupted fs later, which always produces error
> +# info in dmesg. We do not want the test to fail because of this.
> +_disable_dmesg_check

What kind of message did you hit?  I'd thought that the checksum errors
didn't include any of the magic text that tripped _check_dmesg.

--D

> +
>  echo "See interesting results in $seqres.full" | sed -e "s,$RESULT_DIR,RESULT_DIR,g"
>  SRCDIR=`pwd`
>  test -z "${FUZZ_ARGS}" && FUZZ_ARGS="-3 -n 32"
> -- 
> 1.8.4.2
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
