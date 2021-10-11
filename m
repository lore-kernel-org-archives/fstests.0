Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C404C433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Oct 2021 08:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E1DF60ED4
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Oct 2021 08:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbhJKI3i (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 11 Oct 2021 04:29:38 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:60497 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234913AbhJKI3h (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 11 Oct 2021 04:29:37 -0400
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 44F0C1055DFC;
        Mon, 11 Oct 2021 19:27:35 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mZqek-004wXc-Nd; Mon, 11 Oct 2021 19:27:34 +1100
Date:   Mon, 11 Oct 2021 19:27:34 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/4] xfs/432: Skip this test for dax config and pagesize
 not equal to the specified block size
Message-ID: <20211011082734.GA1164794@dread.disaster.area>
References: <20211011075552.196688-1-anju@linux.vnet.ibm.com>
 <20211011075552.196688-2-anju@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011075552.196688-2-anju@linux.vnet.ibm.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=6163f578
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=SJWVYF9499ZM1-fS:21 a=kj9zAlcOel0A:10 a=8gfv0ekSlNoA:10 a=VnNF1IyMAAAA:8
        a=7-415B0cAAAA:8 a=X4udckkwtu4qVBzGAcEA:9 a=CjuIK1q_8ugA:10
        a=2Sk4fGd22p-XXAMx-c-o:22 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Oct 11, 2021 at 01:25:49PM +0530, Anju T Sudhakar wrote:
> This test case passes 1k as the block size(to keep that as minimum),
> and hence it fails to mount with "-o dax" option on platforms where
> pageszie not equal to the specified block size. This leads to test
> case reported as "failed" with dax config.
> 
> So skip this test when dax is enabled.
> 
> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> ---
>  tests/xfs/432 | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/xfs/432 b/tests/xfs/432
> index 40cb2474..9022af69 100755
> --- a/tests/xfs/432
> +++ b/tests/xfs/432
> @@ -32,6 +32,10 @@ _require_scratch
>  
>  rm -f "$seqres.full"
>  
> +# Skip this test, if pagesize !=1k and dax is enabled.
> +if [[ $(get_page_size) -ne 1024 ]]; then
> +	_exclude_scratch_mount_option dax
> +fi

Page size will never be 1kB so there's no point even checking the
page size here.

The problem here is that exclusing the dax mount option is
completely wrong when "-o dax=never" is used - it means that even
though the storage hardware is DAX capable, don't use dax at all,
and so tests that use 1kB block sizes will actaully work.

IOWs, this test should run if dax=never or dax=inode is set, but not
if dax=always or just plain "dax" is set...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
