Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EA4C6FA90
	for <linux-fstests@archiver.kernel.org>; Thu, 22 Sep 2022 16:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbiIVQWy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 22 Sep 2022 12:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbiIVQWx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 22 Sep 2022 12:22:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDAFE720D
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 09:22:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 478E360FD2
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 16:22:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A132BC433C1;
        Thu, 22 Sep 2022 16:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663863766;
        bh=upV3DPkngO6yK95gwsxLt5wzbwcJ7fPWfkHS2CdkxJg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=REQFtYPDhZQqpveJviEAR+gnQmZsDjy35i+UcJC9M/IJKDVaLxkmCQZdRNkHOpyfl
         KlDm/phj+GNjQVGf88X/WXJsrMyLY6x5CNxQ6rJJpZHnk1iedrXJQzfcAQB4g8V7H8
         NdNYFXsAspTng+f9+6T6iYmHlKLRaU/FxApdHPCI+H4hmtMm5AVzDdqdfNH2CcK/9U
         xEsgkWwCC4cK0ZjzBvRJoM0eHYMigknLRNiGz/DWpHhH7HORbBDkXRw5t2/N4vWkfG
         jgSu60R3FeOb0Lng4z/41ImJHuobZ7m6k2/T3xrd0KMCLSElSCODpwTAHuStTwybEt
         ePdzvHgaP2xIw==
Date:   Thu, 22 Sep 2022 09:22:46 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v5 1/2] common: new helper to alloacate fixed size files
Message-ID: <YyyL1mWHw2vd+QSm@magnolia>
References: <20220922063836.974796-1-preichl@redhat.com>
 <20220922063836.974796-2-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922063836.974796-2-preichl@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Sep 22, 2022 at 08:38:35AM +0200, Pavel Reichl wrote:
> Helper that creates files of specified size using falloc if supported,
> otherwise pwrite is used.
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Technically speaking, I only RVB-tagged the second patch, not this first
one...

> ---
>  common/rc         | 23 +++++++++++++++++++++++
>  tests/generic/694 |  8 +++++++-
>  2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index a25cbcd0..228fcb37 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4925,6 +4925,29 @@ hexdump()
>  	_fail "Use _hexdump(), please!"
>  }
>  
> +# Try to create a file with inode->i_blocks >= (length / blocksize).
> +# There may be some small overhead, e.g. ext2 filesystem allocates a
> +# substantial number of blocks to store block mappings. Those are accounted
> +# to i_blocks.
> +_create_file_sized()
> +{
> +	local length=$1
> +	local file=$2
> +	local tmp=`mktemp -u`
> +	local ret=0
> +
> +	$XFS_IO_PROG -ft -c "falloc 0 $length" $file >$tmp.out 2>&1
> +	ret=$?
> +	if (grep -Eq "Operation not supported|command .* not found" $tmp.out);then
> +		# fallocate isn't supported, fallback to general buffer write
> +		$XFS_IO_PROG -ft -c "pwrite 0 $length" $file >$tmp.out 2>&1
> +		ret=$?
> +	fi
> +	[ $ret -ne 0 ] && cat $tmp.out
> +	rm -f $tmp.out
> +	return $ret
> +}
> +
>  init_rc
>  
>  ################################################################################
> diff --git a/tests/generic/694 b/tests/generic/694
> index dfd988df..c96c2154 100755
> --- a/tests/generic/694
> +++ b/tests/generic/694
> @@ -21,6 +21,9 @@ _cleanup()
>  }
>  
>  _supported_fs generic
> +_fixed_by_kernel_commit 0c336d6e33f4 \
> +	"exfat: fix incorrect loading of i_blocks for large file"
> +
>  _require_test
>  _require_fs_space $TEST_DIR $((4 * 1024 * 1024)) #kB
>  
> @@ -30,7 +33,10 @@ junk_dir=$TEST_DIR/$seq
>  junk_file=$junk_dir/junk
>  mkdir -p $junk_dir
>  
> -$XFS_IO_PROG -f -c "pwrite -W 0 4G" $junk_file > /dev/null
> +_create_file_sized 4G $junk_file
> +if [ $? -ne 0 ]; then
> +	echo "Could not create 4G test file"

...but this does look good now.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> +fi
>  
>  iblocks=`stat -c '%b' $junk_file`
>  
> -- 
> 2.37.3
> 
