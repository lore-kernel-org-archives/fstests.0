Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238A2C433EF
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Dec 2021 00:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354245AbhLGAdt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 6 Dec 2021 19:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354228AbhLGAdt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 6 Dec 2021 19:33:49 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4651C061746
        for <fstests@vger.kernel.org>; Mon,  6 Dec 2021 16:30:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 22051CE13D5
        for <fstests@vger.kernel.org>; Tue,  7 Dec 2021 00:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2BFC004DD;
        Tue,  7 Dec 2021 00:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638837016;
        bh=lZ3RYVtloXDfgecCHp9w0yJI7oI9vCKldyaZJgXlCrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fc9W/L7UMCLFaBz5Kt8/2bxr9Wm8ZAck6qwXnsiza+nnfyNRw0bN0qaNjO0a+X6x4
         zXNHHyz6+v+j6ejPpKM1wKL4j5rnoDzB16HHsLJQPXNrcFKqvSeVKycUqNzsr+J38Y
         bBunCssfELJixQ16Im9WTB2FNWuHMFa/59nUnzTfxFyY5FRbVhwskVAR1dOdSOpS6e
         1bfvKpAze4aftSJg/zpBhtWc/IaUArK5UNQv2enz03rTh/my9VAj5vvGeFijTzXV2R
         njltvYjrdy2+yOgAGYpQfBEWkmA9TLDm8dK2xg/Mls0O4EEH9UNY6WKRKE0WBOqX+u
         +NJdlsk63buaA==
Date:   Mon, 6 Dec 2021 16:30:15 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 15/16] generic: add race test that mmap write to
 source of reflink
Message-ID: <20211207003015.GD8442@magnolia>
References: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
 <20211125074752.274176-16-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125074752.274176-16-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Nov 25, 2021 at 03:47:51PM +0800, Shiyang Ruan wrote:
> Test for races or FS corruption when mmap writing to a file that's also
> the source of a reflink operation. (MMAP version of generic/167,166)
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  tests/generic/914     | 64 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/914.out |  4 +++
>  2 files changed, 68 insertions(+)
>  create mode 100755 tests/generic/914
>  create mode 100644 tests/generic/914.out
> 
> diff --git a/tests/generic/914 b/tests/generic/914
> new file mode 100755
> index 00000000..c51c44c7
> --- /dev/null
> +++ b/tests/generic/914
> @@ -0,0 +1,64 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 914
> +#
> +# Test for races or FS corruption when mmap writing to a file that's also
> +# the source of a reflink operation. (MMAP version of generic/167,166)
> +#
> +. ./common/preamble
> +_begin_fstest auto clone
> +
> +_register_cleanup "_cleanup" BUS
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/reflink
> +
> +# real QA test starts here
> +_require_scratch_reflink
> +_require_cp_reflink
> +
> +echo "Format and mount"
> +_scratch_mkfs > $seqres.full 2>&1
> +_scratch_mount >> $seqres.full 2>&1
> +
> +testdir=$SCRATCH_MNT/test-$seq
> +finished_file=/tmp/finished
> +rm -rf $finished_file
> +mkdir $testdir
> +
> +loops=1024
> +nr_loops=$((loops - 1))
> +blksz=65536
> +
> +echo "Initialize file"
> +echo >> $seqres.full
> +_pwrite_byte 0x61 0 $((loops * blksz)) $testdir/file1 >> $seqres.full
> +_scratch_cycle_mount
> +
> +# Snapshot creator...
> +snappy() {
> +	n=0
> +	while [ ! -e $finished_file ]; do
> +		out="$(_cp_reflink $testdir/file1 $testdir/snap_$n 2>&1)"

Just out of curiosity, did you notice any of the slow-writes effects
that caused Dave to add throttling to generic/166?  I'm kinda assuming
no since he only changed the directio write tester, but <shrug> now
you're the expert in this area. ;)

In any case, looks correct to me, so
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> +		res=$?
> +		echo "$out" | grep -q "No space left" && break
> +		test -n "$out" && echo "$out"
> +		test $res -ne 0 && break
> +		n=$((n + 1))
> +	done
> +}
> +
> +echo "Snapshot a file undergoing mmap rewrite"
> +snappy &
> +seq $nr_loops -1 0 | while read i; do
> +	$XFS_IO_PROG -f -c "mmap -rw $((i * blksz)) $blksz" \
> +		-c "mwrite -S 0x63 $((i * blksz)) $blksz" $testdir/file1 >> $seqres.full
> +done
> +touch $finished_file
> +wait
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/914.out b/tests/generic/914.out
> new file mode 100644
> index 00000000..1472055f
> --- /dev/null
> +++ b/tests/generic/914.out
> @@ -0,0 +1,4 @@
> +QA output created by 914
> +Format and mount
> +Initialize file
> +Snapshot a file undergoing mmap rewrite
> -- 
> 2.34.0
> 
> 
> 
