Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABADCC54EE9
	for <linux-fstests@archiver.kernel.org>; Wed,  7 Sep 2022 15:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiIGP05 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 7 Sep 2022 11:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiIGP05 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 7 Sep 2022 11:26:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B971F2EF3E
        for <fstests@vger.kernel.org>; Wed,  7 Sep 2022 08:26:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55BEA61927
        for <fstests@vger.kernel.org>; Wed,  7 Sep 2022 15:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAAFC433D6;
        Wed,  7 Sep 2022 15:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662564415;
        bh=TWqXO0h3w7MklfAMK2A/9JWNB7J9ncfi1XOIZ/6+kKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rin3wov0FsD+2SOoG7ot/F2x8SJwPK8gJhHy6XeJL2kJqYwTTD2y24XuwtjFnjZ6I
         LRHkwlAZrUlubZAxbF5W7K/5bBFyMbdmR5zXaTO1aVh630JcBxguGbBYUT2BFkIgsS
         bi1f+vul20glo65QeAtiacM9Qgp34bumQ9A6Mya1Ob5UHShh9CVdhEwLugaS0W7Uw8
         29waRZMhKBt+Hwv2sTOXZup3IJuBr+bccO1rqntfcH1GH3QVrOEb0zTqvJ/mgXddGo
         haxHgFHx8Fh2zrduC9/LrXJXlCkWBwGEBYESbF+1mY+HB8LrPpB/i74wUoVQ7dOjzr
         AMKfh7WPMCxmg==
Date:   Wed, 7 Sep 2022 08:26:55 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic: test i_blocks for truncated large files
Message-ID: <Yxi4PwiigCspU7qD@magnolia>
References: <20220906155320.952636-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906155320.952636-1-preichl@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Sep 06, 2022 at 05:53:20PM +0200, Pavel Reichl wrote:
> This is a regression test for an incorrect computation of i_blocks for
> truncated files larger than 4 GiB. Bug was filed for exFAT.
> 
> Test is based on reproducer provied by Christophe Vu-Brugier as part
> of kernel patch-fix submission.
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>
> ---
>  tests/generic/698     | 47 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/698.out |  2 ++
>  2 files changed, 49 insertions(+)
>  create mode 100755 tests/generic/698
>  create mode 100644 tests/generic/698.out
> 
> diff --git a/tests/generic/698 b/tests/generic/698
> new file mode 100755
> index 00000000..217641e6
> --- /dev/null
> +++ b/tests/generic/698
> @@ -0,0 +1,47 @@
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
> +_require_test
> +_require_fs_space $TEST_DIR $((5 * 1024 * 1024)) #kB
> +
> +echo "Silence is golden"
> +
> +junk_dir=$TEST_DIR/$seq
> +junk_file=$junk_dir/junk
> +mkdir -p $junk_dir
> +
> +$XFS_IO_PROG -f -c "pwrite -W 0 5G" $junk_file > /dev/null
> +
> +
> +truncate -s $((4 * 1024 * 1024 * 1024)) $junk_file
> +
> +iblocks_after_truncate=`stat -c '%b' $junk_file`
> +iblocks_expected=$((4 * 1024 * 1024 * 2))

What happens if the filesystem allocates a substantial number of blocks
to store block mappings (e.g. ext2)?  Those are accounted to i_blocks.

> +
> +if [ "$iblocks_expected" != "$iblocks_after_truncate" ]; then
> +	echo "Number of blocks needs to be same: $iblocks_expected, $iblocks_after_truncate"

_within_range?

--D

> +fi
> +
> +status=0
> +
> +exit
> diff --git a/tests/generic/698.out b/tests/generic/698.out
> new file mode 100644
> index 00000000..222db0de
> --- /dev/null
> +++ b/tests/generic/698.out
> @@ -0,0 +1,2 @@
> +QA output created by 698
> +Silence is golden
> -- 
> 2.37.3
> 
