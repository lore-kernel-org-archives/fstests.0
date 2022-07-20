Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54378C43334
	for <linux-fstests@archiver.kernel.org>; Wed, 20 Jul 2022 17:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239125AbiGTRVX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 20 Jul 2022 13:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiGTRVX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 20 Jul 2022 13:21:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFBD52DDF
        for <fstests@vger.kernel.org>; Wed, 20 Jul 2022 10:21:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 148AC60BDC
        for <fstests@vger.kernel.org>; Wed, 20 Jul 2022 17:21:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66FB4C3411E;
        Wed, 20 Jul 2022 17:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658337680;
        bh=bTSeloc4aa6RkIFWh9fJqFs3wa6/953RA/hbrMKEtYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R83mbjIUWJjm0EJVQ44Ih4BGs9hXG4Bie3Jn2NqpjCbtibWXNQVZE2JPlwxVIX64Q
         rkOU7YjhHSiY1IWI3QqOOUIlGpFmQIPgOp81Rqpbal9EDcLeMJq3rHxTxF7L3c1b/t
         cRrvjBLYC3QotAmv/FHMKLN+exrmyYfyrMqXHnlL2TC+gTpOJ2Oy7B+Ei4c0W8xjQk
         CTaTZMrzXd1q6QB/FN+Z1tz9/onVSYqboxafLAewjEM4r2zc4LQDOTewBCcro1rG/L
         cAJrpe/1JBUDE1cUGtJfZvR0M64VSyZ/ZPOaEFpjsb4Uv9+GyXW/uyRcWwVR7hZhlH
         jUlBcRUMGc8Jw==
Date:   Wed, 20 Jul 2022 10:21:19 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/549: test mkfs.xfs whether terminate getsubopt
 arrays properly
Message-ID: <Ytg5j+So+WP0PXNP@magnolia>
References: <1658295937-2169-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658295937-2169-1-git-send-email-xuyang2018.jy@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 20, 2022 at 01:45:37PM +0800, Yang Xu wrote:
> When I run xfs/144 manually, the step as below:
> mkfs.xfs -f -d agcount=3200,size=6366g -d file,n
> 
> I accidentally pressed the Enter key, it triggers Segmentation fault.
> Then I found Darrick has fixed this one weeks ago. So add this test.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  tests/xfs/549     | 33 +++++++++++++++++++++++++++++++++
>  tests/xfs/549.out |  2 ++
>  2 files changed, 35 insertions(+)
>  create mode 100755 tests/xfs/549
>  create mode 100644 tests/xfs/549.out
> 
> diff --git a/tests/xfs/549 b/tests/xfs/549
> new file mode 100755
> index 00000000..31ead3c7
> --- /dev/null
> +++ b/tests/xfs/549
> @@ -0,0 +1,33 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
> +#
> +# FS QA Test 549
> +#
> +# Regression test for xfsprogs commit
> +# 50dba8189b1f ("mkfs: terminate getsubopt arrays properly")
> +#
> +# This case test mkfs.xfs whether can terminate getsubopt arrays properly.
> +# If not, it will trigger segmentation fault.
> +#
> +
> +. ./common/preamble
> +_begin_fstest auto quick mkfs
> +
> +# real QA test starts here
> +_supported_fs xfs
> +_fixed_by_git_commit xfsprogs 50dba8189b1f \
> +	"mkfs: terminate getsubopt arrays properly"
> +_require_test
> +
> +testfile=$TEST_DIR/a
> +rm -rf $testfile
> +
> +$MKFS_XFS_PROG -f -d agcount=4 -d file,name=$testfile,nrext64=0 \
> +	>> $seqres.full  2>&1

Heh, you don't even need $testfile --

"$MKFS_XFS_PROG -d agcount=3 -d garbagegarbagegarbage=0"

is enough to cause the crash.  But this works just as well, so

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/549.out b/tests/xfs/549.out
> new file mode 100644
> index 00000000..4e3acd3f
> --- /dev/null
> +++ b/tests/xfs/549.out
> @@ -0,0 +1,2 @@
> +QA output created by 549
> +Silence is golden
> -- 
> 2.23.0
> 
