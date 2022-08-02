Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A024C00140
	for <linux-fstests@archiver.kernel.org>; Tue,  2 Aug 2022 22:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbiHBWFu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 2 Aug 2022 18:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiHBWFt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 2 Aug 2022 18:05:49 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2FF54EE1F
        for <fstests@vger.kernel.org>; Tue,  2 Aug 2022 15:05:48 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-20-138.pa.nsw.optusnet.com.au [49.195.20.138])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id D2BD910C8BDA;
        Wed,  3 Aug 2022 08:05:39 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oJ01B-008RCe-V1; Wed, 03 Aug 2022 08:05:37 +1000
Date:   Wed, 3 Aug 2022 08:05:37 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Liu Yiding <liuyd.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/688: Skip test if fs doesn't support security
Message-ID: <20220802220537.GC3861211@dread.disaster.area>
References: <1659426760-2-1-git-send-email-liuyd.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1659426760-2-1-git-send-email-liuyd.fnst@fujitsu.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62e99fb3
        a=cxZHBGNDieHvTKNp/pucQQ==:117 a=cxZHBGNDieHvTKNp/pucQQ==:17
        a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=omOdbC7AAAAA:8 a=7-415B0cAAAA:8
        a=9xv59_mZTmjfBaO9PkgA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Aug 02, 2022 at 07:52:40AM +0000, Liu Yiding wrote:
> This test require security attr. Skip test if fs doesn't support
> security attr. E.g. virtiofs
> 
> Signed-off-by: Liu Yiding <liuyd.fnst@fujitsu.com>
> ---
>  tests/generic/688 | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/generic/688 b/tests/generic/688
> index 426286b6..d11b4c21 100755
> --- a/tests/generic/688
> +++ b/tests/generic/688
> @@ -7,6 +7,7 @@
>  # Functional test for dropping capability bits as part of an fallocate.
>  #
>  . ./common/preamble
> +. ./common/attr
>  _begin_fstest auto prealloc quick

Includes don't belong in the test preamble/setup section. They
belong a few lines below in the section titled:

# Include common functions.

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
