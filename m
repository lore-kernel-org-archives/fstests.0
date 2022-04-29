Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684EBC433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 29 Apr 2022 01:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiD2BNv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 28 Apr 2022 21:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiD2BNu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 28 Apr 2022 21:13:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74074167C2
        for <fstests@vger.kernel.org>; Thu, 28 Apr 2022 18:10:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFF7E621C9
        for <fstests@vger.kernel.org>; Fri, 29 Apr 2022 01:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C8EC385A9;
        Fri, 29 Apr 2022 01:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651194633;
        bh=iI0+oK+6Xux+wNprj6pGmgE7EvUsK+bR75/fv9nx9vQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kY9gocoW5FJmpujJD8Pg3hvRXN9Y8sPeOcS574+deliElbjWFCL3t+DdG3PFSUVJD
         CVuhtz7cloLPPCGAe/LeOer8tLb7FYraBb0VMPg84k+2cJL3lynLYoimW3yHf3gqJJ
         f2jC05p/y59Sfom+8wXko0Ypr9c7FYAn1VZ+OqzxDdfiPyC+weAFTbRQfIfrWTvlYX
         xHsUbNpqOpUAMa70ePTQQrfdNjUoBDlca4SMBFtLmsnrdYItVHi8+gBT1+td94d2o7
         QQFTG/UiicLKyoG4ozFpLEs/1iYvaQq/sYf/HLmdU0BPjv532uJyxBu2a+K1ogIGGJ
         h/F/xx19DxbNA==
Date:   Thu, 28 Apr 2022 18:10:32 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] ext4/054,ext4/055: don't run when using DAX
Message-ID: <20220429011032.GP17014@magnolia>
References: <20220427005209.4188220-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427005209.4188220-1-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Apr 26, 2022 at 08:52:09PM -0400, Theodore Ts'o wrote:
> The ext4/054 and ext4/055 tests create a scratch file system with a 1k
> block size.  This is not compatible with mounting with the DAX option,
> which requires a block size equal to the page size (which is 4k on
> x86).

Following up on a point I made during this morning's ext4 concall --
I avoided these problems by adding a cli option to mkfs.xfs to set the
DAX flag on the root directory (since it's advisory and propagates to
all new children) and then updated my fstests config to use that.  No
more mount failures due to blocksize != pagesize! :)

--D

> Also, the ext4/054 test doesn't use the test device, so remove the
> _require_test declaration.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  tests/ext4/054 | 2 +-
>  tests/ext4/055 | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/ext4/054 b/tests/ext4/054
> index 9a11719f..6c722f32 100755
> --- a/tests/ext4/054
> +++ b/tests/ext4/054
> @@ -19,8 +19,8 @@ _begin_fstest auto quick dangerous_fuzzers
>  
>  # real QA test starts here
>  _supported_fs ext4
> -_require_test
>  _require_scratch_nocheck
> +_exclude_scratch_mount_option dax
>  _require_xfs_io_command "falloc"
>  _require_xfs_io_command "pwrite"
>  _require_xfs_io_command "fsync"
> diff --git a/tests/ext4/055 b/tests/ext4/055
> index 8f466f1b..1ae42b89 100755
> --- a/tests/ext4/055
> +++ b/tests/ext4/055
> @@ -17,8 +17,9 @@
>  _begin_fstest auto quota
>  
>  # real QA test starts here
> -_require_scratch_nocheck
>  _supported_fs ext4
> +_require_scratch_nocheck
> +_exclude_scratch_mount_option dax
>  _require_user fsgqa
>  _require_user fsgqa2
>  _require_command "$DEBUGFS_PROG" debugfs
> -- 
> 2.31.0
> 
