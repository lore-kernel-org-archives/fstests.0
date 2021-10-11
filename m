Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0954C433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Oct 2021 08:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2EB460EFE
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Oct 2021 08:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbhJKIim (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 11 Oct 2021 04:38:42 -0400
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:53945 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235010AbhJKIil (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 11 Oct 2021 04:38:41 -0400
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id E8B0E1BFF49;
        Mon, 11 Oct 2021 19:36:39 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mZqnX-004whv-DD; Mon, 11 Oct 2021 19:36:39 +1100
Date:   Mon, 11 Oct 2021 19:36:39 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 4/4] generic/219: Fix test failure on 64k block size
Message-ID: <20211011083639.GC1164794@dread.disaster.area>
References: <20211011075552.196688-1-anju@linux.vnet.ibm.com>
 <20211011075552.196688-5-anju@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011075552.196688-5-anju@linux.vnet.ibm.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=epq8cqlX c=1 sm=1 tr=0 ts=6163f798
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=kj9zAlcOel0A:10 a=8gfv0ekSlNoA:10 a=VnNF1IyMAAAA:8 a=7-415B0cAAAA:8
        a=HwEe6-5x0QUykn-W2n4A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Oct 11, 2021 at 01:25:52PM +0530, Anju T Sudhakar wrote:
> Skip this test on 64k, as 4k as taken as the default block size.
> 
> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> ---
> But I have a Query:
> This test fails on ext4&xfs with 64k block size. Do we need to
> rephrase this test to incorporate the 64k bs scenario as well?
> If not we can skip this test.

Right, we should fix the test to use multiples of block size rather
than fixed byte sizes as we do for all the other tests that need to
work across different block sizes. e.g. probe the block size after
mkfs and then convert the "48k" numbers to "$((12 * $bs))".

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
