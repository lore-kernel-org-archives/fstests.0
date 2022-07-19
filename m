Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEA2C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 19 Jul 2022 14:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbiGSOrT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 19 Jul 2022 10:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239061AbiGSOrS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 19 Jul 2022 10:47:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0A826F0
        for <fstests@vger.kernel.org>; Tue, 19 Jul 2022 07:47:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F9DA61847
        for <fstests@vger.kernel.org>; Tue, 19 Jul 2022 14:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510F2C341C6;
        Tue, 19 Jul 2022 14:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658242036;
        bh=vLsjEIORD+ZcS/k5O2f64AML5AFZqIBQKuv0toxAkiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m37WHB1jlonc1f3cNu5uJ3I1ndYi+Ub0AvBjjQAK8NTELTTQikMOJ3pG1z8XMf/97
         iM+mi5U5TBp9M5PGA7gn8lTPkIuT5gkRH9hJ1Oq8kWPkRq0zQXgq+KdBah91mHqR7r
         M1gDf6LAnbtfXPxInYzxS61FKZlUtOklce+s9EjRcXrMYNQ49DAuHv83j3aapfMJBf
         9pj4bqRpwTS/PJ7bDq7tsXKKAc8ggejuEWqzyUEXfaaAXBpp47ma9vrcwSVM9ir7jz
         b/635lyRV9O1byZWfSCD0JRFApEw+9zlJzH4TpbbFkjMPmaGRZEiOLDQ/cfF46ORVG
         lGvglFiLtx2Pg==
Date:   Tue, 19 Jul 2022 07:47:15 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v3 2/2] xfs/533: test xfs_db whether still can get
 corrupted field value
Message-ID: <YtbD870z0G6sQ/Dp@magnolia>
References: <20220719051310.mptogjydytz233n4@zlang-mailbox>
 <1658219473-2310-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1658219473-2310-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658219473-2310-2-git-send-email-xuyang2018.jy@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jul 19, 2022 at 04:31:13PM +0800, Yang Xu wrote:
> This is a regression test that xfs_db code doesn't clean up the
> LIBXFS_READBUF_SALVAGE call sites in set_cur so that we can't use the
> return value directly and scraping it out later.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  tests/xfs/533     | 34 ++++++++++++++++++++++++++++++++++
>  tests/xfs/533.out |  5 +++++
>  2 files changed, 39 insertions(+)
>  create mode 100755 tests/xfs/533
>  create mode 100644 tests/xfs/533.out
> 
> diff --git a/tests/xfs/533 b/tests/xfs/533
> new file mode 100755
> index 00000000..c0a4c0d2
> --- /dev/null
> +++ b/tests/xfs/533
> @@ -0,0 +1,34 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
> +#
> +# FS QA Test 533
> +#
> +# Regression test for xfsprogs commit
> +# f4afdcb0ad11 ("xfs_db: clean up the salvage read callsites in set_cur()")
> +#
> +# This case test xfs_db whether can get the new magicnum field value even we
> +# just have corrupted this field value.
> +#
> +
> +. ./common/preamble
> +_begin_fstest auto quick db
> +
> +# real QA test starts here
> +_supported_fs xfs
> +_fixed_by_git_commit xfsprogs f4afdcb0ad11 \
> +	"xfs_db: clean up the salvage read callsites in set_cur()"
> +#skip fs check because invalid superblock 1
> +_require_scratch_nocheck
> +
> +_scratch_mkfs_xfs >>$seqres.full 2>&1
> +
> +# write the bad magicnum field value(0) to the superblock 1
> +_scratch_xfs_set_metadata_field "magicnum" "0" "sb 1"
> +
> +#Even magicnum filed has been corrupted, we still can read this filed value

"field"?

With that fixed, this looks good to me...
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D


> +_scratch_xfs_get_metadata_field "magicnum" "sb 1"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/533.out b/tests/xfs/533.out
> new file mode 100644
> index 00000000..7deb78a3
> --- /dev/null
> +++ b/tests/xfs/533.out
> @@ -0,0 +1,5 @@
> +QA output created by 533
> +Allowing write of corrupted data with good CRC
> +magicnum = 0
> +bad magic number
> +0
> -- 
> 2.23.0
> 
