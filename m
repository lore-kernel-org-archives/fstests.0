Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D096C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Mar 2022 05:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236759AbiCVFh0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 22 Mar 2022 01:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236704AbiCVFh0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Mar 2022 01:37:26 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FF5524BF8
        for <fstests@vger.kernel.org>; Mon, 21 Mar 2022 22:35:59 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-150-27.pa.vic.optusnet.com.au [49.186.150.27])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id F1F8A533906;
        Tue, 22 Mar 2022 16:35:56 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nWXBT-008Onk-JD; Tue, 22 Mar 2022 16:35:55 +1100
Date:   Tue, 22 Mar 2022 16:35:55 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH 2/2] fstests: test dirty pipe vulnerability issue of
 CVE-2022-0847
Message-ID: <20220322053555.GD1609613@dread.disaster.area>
References: <20220321110341.1323882-1-zlang@redhat.com>
 <20220321110341.1323882-3-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321110341.1323882-3-zlang@redhat.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=6239603d
        a=sPqof0Mm7fxWrhYUF33ZaQ==:117 a=sPqof0Mm7fxWrhYUF33ZaQ==:17
        a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=7-415B0cAAAA:8
        a=kwEDHUuWiqPUqh4M1vMA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Mar 21, 2022 at 07:03:41PM +0800, Zorro Lang wrote:
> diff --git a/tests/generic/999 b/tests/generic/999
> new file mode 100755
> index 00000000..2488e455
> --- /dev/null
> +++ b/tests/generic/999
> @@ -0,0 +1,54 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Red Hat, Inc.  All Rights Reserved.
> +#
> +# FS QA Test No. 999
> +#
> +# Test for the Dirty Pipe vulnerability (CVE-2022-0847) caused by an
> +# uninitialized  "pipe_buffer.flags" variable, which fixed by:
> +#   9d2231c5d74e ("lib/iov_iter: initialize "flags" in new pipe_buffer")
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +	rm -f $TEST_DIR/testfile.$seq
> +}

Just leave the test file lying around so this can use the default
cleanup method. The test device is supposed to gather random
cruft as tests run....

> +
> +# real QA test starts here
> +_supported_fs generic
> +_require_test
> +_require_user
> +_require_chmod
> +_require_test_program "splice2pipe"
> +
> +localfile=$TEST_DIR/testfile.$seq

.... and remove the file here as part of test setup with:

rm -f $localfile

Otherwise looks fine.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
