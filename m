Return-Path: <SRS0=WWQL=ZY=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5D9C432C0
	for <linux-fstests@archiver.kernel.org>; Mon,  2 Dec 2019 09:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 630D120833
	for <linux-fstests@archiver.kernel.org>; Mon,  2 Dec 2019 09:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfLBJem (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 2 Dec 2019 04:34:42 -0500
Received: from snd00006.auone-net.jp ([111.86.247.6]:53409 "EHLO
        dmta0009.auone-net.jp" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726115AbfLBJem (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 2 Dec 2019 04:34:42 -0500
Received: from ppp.dion.ne.jp by dmta0009.auone-net.jp with ESMTP
          id <20191202093440460.XCIV.12796.ppp.dion.ne.jp@dmta0009.auone-net.jp>;
          Mon, 2 Dec 2019 18:34:40 +0900
Date:   Mon, 2 Dec 2019 18:34:40 +0900
From:   Kusanagi Kouichi <slash@ac.auone-net.jp>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/filter: Don't use strtonum
References: <20191129072108857.YEGH.25002.ppp.dion.ne.jp@dmta0003.auone-net.jp>
 <20191201154747.GJ8664@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191201154747.GJ8664@desktop>
User-Agent: Mutt/1.12.2 (2019-09-21)
Message-Id: <20191202093440460.XCIV.12796.ppp.dion.ne.jp@dmta0009.auone-net.jp>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2019-12-01 23:47:47 +0800, Eryu Guan wrote:
> On Fri, Nov 29, 2019 at 04:21:08PM +0900, Kusanagi Kouichi wrote:
> > It's a gawk extension and not needed. Make tests pass with non-gawk.
> > 
> > Signed-off-by: Kusanagi Kouichi <slash@ac.auone-net.jp>
> 
> I noticed that you sent another two patches that fix similar issue in
> another test. I think we could fold them into one patch that fixes all
> the strtonum problem.
> 
> Thanks,
> Eryu

I'll fold them into this patch and resend.
