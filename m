Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1F8ECAAD8
	for <linux-fstests@archiver.kernel.org>; Thu, 22 Sep 2022 00:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiIVA3E (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 21 Sep 2022 20:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiIVA3D (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 21 Sep 2022 20:29:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FFCA9272
        for <fstests@vger.kernel.org>; Wed, 21 Sep 2022 17:29:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A27EC629B8
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 00:29:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A70FC433C1;
        Thu, 22 Sep 2022 00:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663806542;
        bh=Wn4f6lnAjAuVCIPDUFCClgKczEsL3PXQg+n8dALkqb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YWkuJlhr0iMr2pWMwMz2twgAjYuBlBPI2XY+T8MzY5kV6pzXKub3mLjyzdbbFiuKf
         rQ/wnL84i2PyFuyp5tEwxuPmDis+BfNYvA9yKo1YeomDVgEXMPt9qi6LYQh4KFujBr
         gf1Y7u0vTdVn+WOaouDqu81YEQIDeZ7RobY1U6dzPy7LAtfS81FcOWxXt87lePpGpS
         DHCXXl8s5xLOJqQdH9Vxi8otLeuZKkC/iwizhQMUo5AUa+i7HekPpeZCE46/wyx5ho
         kjQzoYRW59tutJ541Z1hEiEvIqepAtHaUNbc7GEsw6r9fM3yWSfiwvgHv8zXvoUZW7
         jJ/J7v0Wn0u5A==
Date:   Wed, 21 Sep 2022 17:29:01 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v4 2/2] generic: test i_blocks for truncated large files
Message-ID: <YyusTfJI514VVHwp@magnolia>
References: <20220921141025.920599-1-preichl@redhat.com>
 <20220921141025.920599-3-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921141025.920599-3-preichl@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Sep 21, 2022 at 04:10:25PM +0200, Pavel Reichl wrote:
> This is a regression test for an incorrect computation of i_blocks for
> truncated files larger than 4 GiB. Bug was filed for exFAT.
> 
> Test is based on reproducer provied by Christophe Vu-Brugier as part
> of kernel patch-fix submission.
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>
> ---
>  tests/generic/698     | 51 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/698.out |  2 ++
>  2 files changed, 53 insertions(+)
>  create mode 100755 tests/generic/698
>  create mode 100644 tests/generic/698.out
> 
> diff --git a/tests/generic/698 b/tests/generic/698
> new file mode 100755
> index 00000000..97ac1474
> --- /dev/null
> +++ b/tests/generic/698
> @@ -0,0 +1,51 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022  Red Hat Inc. All Rights Reserved.
> +#
> +# FS QA Test 698
> +#
> +# Verify that i_blocks for truncated files larger than 4 GiB have correct
> +# values.
> +#
> +# This test verifies the problem fixed in kernel with commit
> +# 92fba084b79e exfat: fix i_blocks for files truncated over 4 GiB
> +#
> +. ./common/preamble
> +. ./common/filter
> +
> +_begin_fstest auto
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	cd /
> +	rm -r -f $tmp.* $junk_dir
> +}
> +
> +_supported_fs generic
> +_fixed_by_kernel_commit 92fba084b79e \
> +	"exfat: fix i_blocks for files truncated over 4 GiB"
> +
> +_require_test
> +_require_fs_space $TEST_DIR $((5 * 1024 * 1024)) #kB
> +
> +junk_dir=$TEST_DIR/$seq
> +junk_file=$junk_dir/junk
> +mkdir -p $junk_dir
> +
> +_create_file_sized 5G $junk_file
> +if [ $? -ne 0 ]; then
> +        echo "_create_file_sized failed"

Nit: Perhaps "could not create 5G test file" should be the message?

/me shrugs, that's a stylistic nit, so:
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> +fi
> +
> +truncate -s 4G $junk_file
> +
> +block_size=`stat -c '%B' $junk_file`
> +iblocks_after_truncate=`stat -c '%b' $junk_file`
> +iblocks_expected=$((4 * 1024 * 1024 * 1024 / $block_size))
> +
> +_within_tolerance "Number of allocated blocks after truncate" $iblocks_after_truncate $iblocks_expected 1% -v
> +
> +status=0
> +
> +exit
> diff --git a/tests/generic/698.out b/tests/generic/698.out
> new file mode 100644
> index 00000000..cbb02d37
> --- /dev/null
> +++ b/tests/generic/698.out
> @@ -0,0 +1,2 @@
> +QA output created by 698
> +Number of allocated blocks after truncate is in range
> -- 
> 2.37.3
> 
