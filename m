Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45FEC433EF
	for <linux-fstests@archiver.kernel.org>; Thu,  2 Jun 2022 16:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237152AbiFBQku (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 2 Jun 2022 12:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236745AbiFBQku (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 2 Jun 2022 12:40:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF6313C1F2
        for <fstests@vger.kernel.org>; Thu,  2 Jun 2022 09:40:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0CD7B82043
        for <fstests@vger.kernel.org>; Thu,  2 Jun 2022 16:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69562C385A5;
        Thu,  2 Jun 2022 16:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654188046;
        bh=peHSUYHuY1Ndlq4oTT0nzAL08RPm70QQztR2XYp4Ljk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qWIOA4iNYrjP/P769J7tWGHzRYFO6sl/139VEVaJCu1sAJrg2xt8BfpkdT3PVy3w/
         D5uQc4jhlmQVFqAOEjnamZg7wVOSEcqJ4Ceaz6HxPZKcmtO6tUyZ79B+HejxtU4AJv
         wMFSpPSjB9K+XIPFA+98kH07Vsag9aJfx9I4wr4h132ZtsBlb6GTJe6PzrkQD8inMg
         2IOV+SPnRbsmTHC1epqW5ZZFyS9jCdmNXLOJKwuc05jtQAajErO7n40MowfR4tFRAi
         qyoJ/DT1wFM5rsrYzDYT0F3IyczWcvFfK6dsunjAd1831EIRZxOtpco7dgu0Oy3z3f
         0C13e5JniwkuA==
Date:   Thu, 2 Jun 2022 09:40:45 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v3] generic/139: require 512 bytes to be the minimum dio
 size
Message-ID: <YpjoDZ9Gi1ouhcMe@magnolia>
References: <YpeixjeZ8kdVw/+7@magnolia>
 <20220602051716.2050004-1-zlang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602051716.2050004-1-zlang@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jun 02, 2022 at 01:17:16PM +0800, Zorro Lang wrote:
> Due to generic/139 tests base on 512 bytes aligned, so skip this test
> if the minimum dio write size >512. This patch also change the
> common/rc::_require_dio helper, supports a minimum aligned size
> argument.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
> 
> Thanks the review from Darrick on v2, this v3 remove some duplicate code
> which I forgot.
> 
> Thanks,
> Zorro
> 
>  common/rc         | 13 ++++++++++---
>  tests/generic/139 |  2 +-
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 2f31ca46..9823e3a1 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2721,9 +2721,12 @@ _require_xfs_io_command()
>  	fi
>  }
>  
> -# check that kernel and filesystem support direct I/O
> +# check that kernel and filesystem support direct I/O, and check if "$1" size
> +# aligned (optional) is supported
>  _require_odirect()
>  {
> +	local alignment=${1:+"-b $1"}

This might be a nit, but you might want to do this instead:

	local blocksize=$1
	local align_args=${1:+"-b $1"}

So that there's only one "$1" to change if the arguments ever get
rearranged.  But that might never happen, and this feels nearly like
pointless navelgazing.

If you're happy with things the way they are, the logic looks ok so:
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> +
>  	if [ $FSTYP = "ext4" ] || [ $FSTYP = "f2fs" ] ; then
>  		if echo "$MOUNT_OPTIONS" | grep -q "test_dummy_encryption"; then
>  			_notrun "$FSTYP encryption doesn't support O_DIRECT"
> @@ -2735,9 +2738,13 @@ _require_odirect()
>  		fi
>  	fi
>  	local testfile=$TEST_DIR/$$.direct
> -	$XFS_IO_PROG -F -f -d -c "pwrite 0 20k" $testfile > /dev/null 2>&1
> +	$XFS_IO_PROG -F -f -d -c "pwrite $alignment 0 20k" $testfile > /dev/null 2>&1
>  	if [ $? -ne 0 ]; then
> -		_notrun "O_DIRECT is not supported"
> +		if [ -n "$alignment" ]; then
> +			_notrun "O_DIRECT aligned to $1 bytes is not supported"
> +		else
> +			_notrun "O_DIRECT is not supported"
> +		fi
>  	fi
>  	rm -f $testfile 2>&1 > /dev/null
>  }
> diff --git a/tests/generic/139 b/tests/generic/139
> index 0bbc222c..3eb1519d 100755
> --- a/tests/generic/139
> +++ b/tests/generic/139
> @@ -26,7 +26,7 @@ _cleanup()
>  # real QA test starts here
>  _require_test_reflink
>  _require_cp_reflink
> -_require_odirect
> +_require_odirect 512
>  
>  testdir=$TEST_DIR/test-$seq
>  rm -rf $testdir
> -- 
> 2.31.1
> 
