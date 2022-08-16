Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2728C25B0E
	for <linux-fstests@archiver.kernel.org>; Tue, 16 Aug 2022 16:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbiHPQAF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 16 Aug 2022 12:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbiHPP7m (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 16 Aug 2022 11:59:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A9BDF0B
        for <fstests@vger.kernel.org>; Tue, 16 Aug 2022 08:58:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A25D7B8188C
        for <fstests@vger.kernel.org>; Tue, 16 Aug 2022 15:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE72C433D6;
        Tue, 16 Aug 2022 15:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660665484;
        bh=QTtxTP5aBOVClGyoGYSmE9QvvuN9qSJ/hsgj92R5vq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Etcjs0IW9dChAuL3rlRsg18Striu4xfG0tSWDQoDxMkvvYhDF4aWO6dYX5IbFlrAA
         GPueboDQdzVkmpVt3Byo4gplBbhllYXA7qFIJEm6tN4mB/an7JS4x+WpbXj8W9lySJ
         AH8BkTyfqTWjSDFs2Q/oDWiD1L5NjhPpHsiE9Im52wd59WFb9Jb/5G9uTPdVvzMHh0
         Ini2EtBjG/TTTRnErqyj+o20MRQQylHtfcMW9ZLwXJr71/04k456DUJe4ni5t7uAm0
         RBF2OyvUH9bI89cMb/ZFWsBh9niU1VfcQ3NkDZZVxqZEqYnTYjJLZgkI6aMERVTg0M
         pCk09YoCI0Xlw==
Date:   Tue, 16 Aug 2022 08:58:03 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic: test i_blocks for large files
Message-ID: <Yvu+i1sxTD/KcVjL@magnolia>
References: <20220813054438.ghygw23t6phvuwos@zlang-mailbox>
 <20220816104536.273937-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816104536.273937-1-preichl@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Aug 16, 2022 at 12:45:36PM +0200, Pavel Reichl wrote:
> This is a regression test for an incorrect
> computation of i_blocks for files larger than
> 4 GiB. Bug was filed for exFAT.
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>
> ---
>  common/rc             | 10 ++++++++++
>  tests/generic/693     | 46 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/693.out |  2 ++
>  3 files changed, 58 insertions(+)
>  create mode 100755 tests/generic/693
>  create mode 100644 tests/generic/693.out
> 
> diff --git a/common/rc b/common/rc
> index 197c9415..06cbdee5 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1980,6 +1980,16 @@ _require_test()
>      touch ${RESULT_DIR}/require_test
>  }
>  
> +# require a test dev of a minimum size (in kb)
> +_require_test_size()
> +{
> +	[ $# -eq 1 ] || _fail "_require_test_size: expected size param"
> +
> +	_require_test
> +	local devsize=`_get_device_size $TEST_DEV`
> +	[ $devsize -lt $1 ] && _notrun "test dev too small"
> +}
> +
>  _has_logdev()
>  {
>  	local ret=0
> diff --git a/tests/generic/693 b/tests/generic/693
> new file mode 100755
> index 00000000..a6d1abff
> --- /dev/null
> +++ b/tests/generic/693
> @@ -0,0 +1,46 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022  Red Hat Inc. All Rights Reserved.
> +#
> +# FS QA Test 693
> +#
> +# Verify that i_blocks for files larger than 4 GiB have correct
> +# values.
> +#
> +# This test verifies the problem fixed in kernel with commit
> +# 0c336d6e33f4 exfat: fix incorrect loading of i_blocks for large files
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
> +_require_test_size $((4 * 1024 * 1024)) #kB

What does this new helper do that "_require_fs_space $TEST_DIR 4194304"
wouldn't solve?

--D

> +
> +echo "Silence is golden"
> +
> +junk_dir=$TEST_DIR/$seq
> +junk_file=$junk_dir/junk
> +mkdir -p $junk_dir
> +
> +$XFS_IO_PROG -f -c "pwrite -W 0 4G" $junk_file > /dev/null
> +
> +iblocks=`stat -c '%b' $junk_file`
> +
> +_test_cycle_mount
> +
> +iblocks_after_remount=`stat -c '%b' $junk_file`
> +
> +if [ "$iblocks" != "$iblocks_after_remount" ]; then
> +	echo "Number of blocks needs to be same: $iblocks, $iblocks_after_remount"
> +fi
> +
> +status=0
> +
> +exit
> diff --git a/tests/generic/693.out b/tests/generic/693.out
> new file mode 100644
> index 00000000..01884ea5
> --- /dev/null
> +++ b/tests/generic/693.out
> @@ -0,0 +1,2 @@
> +QA output created by 693
> +Silence is golden
> -- 
> 2.37.2
> 
