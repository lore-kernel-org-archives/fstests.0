Return-Path: <SRS0=/sVf=2C=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DED3C43603
	for <linux-fstests@archiver.kernel.org>; Thu, 12 Dec 2019 10:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2805224654
	for <linux-fstests@archiver.kernel.org>; Thu, 12 Dec 2019 10:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbfLLKAL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 Dec 2019 05:00:11 -0500
Received: from snd00013.auone-net.jp ([111.86.247.13]:26723 "EHLO
        dmta0006.auone-net.jp" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726382AbfLLKAL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 Dec 2019 05:00:11 -0500
Received: from ppp.dion.ne.jp by dmta0006.auone-net.jp with ESMTP
          id <20191212100009818.MNNO.12766.ppp.dion.ne.jp@dmta0006.auone-net.jp>;
          Thu, 12 Dec 2019 19:00:09 +0900
Date:   Thu, 12 Dec 2019 19:00:09 +0900
From:   Kusanagi Kouichi <slash@ac.auone-net.jp>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Eryu Guan <guaneryu@gmail.com>,
        Naohiro Aota <naohiro.aota@wdc.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] common/filter: prepend 0 to treat offset as octal
References: <20191212031152.1906287-1-naohiro.aota@wdc.com>
 <20191212060437.GA99869@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212060437.GA99869@magnolia>
User-Agent: Mutt/1.12.2 (2019-09-21)
Message-Id: <20191212100009818.MNNO.12766.ppp.dion.ne.jp@dmta0006.auone-net.jp>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2019-12-11 22:04:37 -0800, Darrick J. Wong wrote:
> On Thu, Dec 12, 2019 at 12:11:52PM +0900, Naohiro Aota wrote:
> > The offsets printed by "od" are octal numbers. So, we need to add "0" at
> > the head of the $offset to parse it as an octal number.
> > 
> > Fixes: 37520a314bd4 ("fstests: Don't use gawk's strtonum")
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> 
> <grumble> Did the original patch author run all the tests that use
> _filter_od to make sure there weren't any regressions.  This fixes
> xfs/139 for me, so...

I'm sorry. I didn't test well. Eryu, can you revert commit 37520a314bd4?
