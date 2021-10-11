Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC45C433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Oct 2021 08:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7634860EE3
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Oct 2021 08:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbhJKIer (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 11 Oct 2021 04:34:47 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:57247 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234932AbhJKIeq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 11 Oct 2021 04:34:46 -0400
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 3978C861C98;
        Mon, 11 Oct 2021 19:32:46 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mZqjl-004wf3-LQ; Mon, 11 Oct 2021 19:32:45 +1100
Date:   Mon, 11 Oct 2021 19:32:45 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 2/4] generic/594: Fix test failure for xfs on older
 quota-tools
Message-ID: <20211011083245.GB1164794@dread.disaster.area>
References: <20211011075552.196688-1-anju@linux.vnet.ibm.com>
 <20211011075552.196688-3-anju@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011075552.196688-3-anju@linux.vnet.ibm.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=epq8cqlX c=1 sm=1 tr=0 ts=6163f6ae
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=kj9zAlcOel0A:10 a=8gfv0ekSlNoA:10 a=VnNF1IyMAAAA:8 a=7-415B0cAAAA:8
        a=A-phtYmI31mcW5BZwhIA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Oct 11, 2021 at 01:25:50PM +0530, Anju T Sudhakar wrote:
> For xfs we need the quota-tools containing commit fdd774bf08e568
> ("quota-tools: pass quota type to QCMD for Q_XFS_GETQSTAT")to run this
> test. Otherwise this test will fail on xfs, as the grace time is not set
> correctly. So check for the quota-tool with the required commit before
> running this test on xfs.
> 
> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> ---
>  tests/generic/594 | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tests/generic/594 b/tests/generic/594
> index 88f9a0dc..668c1fae 100755
> --- a/tests/generic/594
> +++ b/tests/generic/594
> @@ -6,6 +6,8 @@
>  #
>  # Test per-type(user, group and project) filesystem quota timers, make sure
>  # each of grace time can be set/get properly.
> +# For xfs, you need a quota-tools containing commit fdd774bf08e568 for this
> +# test to run properly- v4.06 should do.
>  #
>  . ./common/preamble
>  _begin_fstest auto quick quota
> @@ -18,9 +20,13 @@ _begin_fstest auto quick quota
>  _supported_fs generic
>  _require_scratch
>  _require_setquota_project
> +version=$(setquota -V | head -n1 | cut -d" " -f4)
>  # V4 XFS doesn't support to mount project and group quota together
>  if [ "$FSTYP" = "xfs" ];then
>  	_require_scratch_xfs_crc
> +	if [ "$version" \< "4.06" ];then
> +		_notrun "This test requires quota-tools 4.06 or greater"
> +	fi

We don't test for version numbers, because feature and bug fix back
ports make testing version numbers unreliable. What needs to be done
here is to test whether the feature is available of not via a
_require_setquota_xfs_getqstat() rule that encapsulates the feature
test and _notrun call if the feature is not supported.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
