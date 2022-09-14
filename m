Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57370C6FA82
	for <linux-fstests@archiver.kernel.org>; Wed, 14 Sep 2022 17:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiINR7v (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 14 Sep 2022 13:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiINR7s (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 14 Sep 2022 13:59:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0105DDEE3
        for <fstests@vger.kernel.org>; Wed, 14 Sep 2022 10:59:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61A8761E2B
        for <fstests@vger.kernel.org>; Wed, 14 Sep 2022 17:59:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD58DC43145;
        Wed, 14 Sep 2022 17:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663178380;
        bh=Yz6D+c+IzBaJ8vpsNTnAGWB3nypH4KkLd8UD+jhwhqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PNd8ipTHADdoBlQHA8AYSL6vXZoOsTjXOFLW72qRx3lqG37vDHWvr/TOE0xR+/iEX
         JmdUBdhOAkc/urevI7J27pAeRWtfDQVtFHcYXg3Kv6IkXkOE5KY0kyxju4LUCaDJhf
         D1o2kjxAYG9EkTGCsXhEAZq2Paz2HepdQH2zTNWIqrI7nC/giKJdT+PcxJMS9oRb5/
         XCpWJm8DldoMDSGjlLVjMuAkDaC/NKeSNXvgfdbiqtUiE4BJPfqRU5OApX8Wv3E70m
         pctG9G0WrlMkpQA/OnbKa1F2G4CDQfnPk32HTFicDE7/6+0aJ33dcoSnzKQy/6+KzN
         KdzmY7mJi/xjg==
Date:   Wed, 14 Sep 2022 10:59:40 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 1/1] generic: test i_blocks for truncated large files
Message-ID: <YyIWjArO7bvCJQLM@magnolia>
References: <20220913125801.56366-1-preichl@redhat.com>
 <20220913125801.56366-2-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913125801.56366-2-preichl@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Sep 13, 2022 at 02:58:01PM +0200, Pavel Reichl wrote:
> This is a regression test for an incorrect computation of i_blocks for
> truncated files larger than 4 GiB. Bug was filed for exFAT.
> 
> Test is based on reproducer provied by Christophe Vu-Brugier as part
> of kernel patch-fix submission.
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>
> ---
>  tests/generic/698     | 48 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/698.out |  2 ++
>  2 files changed, 50 insertions(+)
>  create mode 100755 tests/generic/698
>  create mode 100644 tests/generic/698.out
> 
> diff --git a/tests/generic/698 b/tests/generic/698
> new file mode 100755
> index 00000000..337df6c5
> --- /dev/null
> +++ b/tests/generic/698
> @@ -0,0 +1,48 @@
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
> +$XFS_IO_PROG -f -c "pwrite -W 0 5G" $junk_file > /dev/null

I wonder, how long will this test take to write 5GB of data?  Can we
speed it up by using fallocate, at least for the filesystems that
support it?

(Aside from that, the rest looks fine to me...)

--D

> +
> +truncate -s $((4 * 1024 * 1024 * 1024)) $junk_file
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
