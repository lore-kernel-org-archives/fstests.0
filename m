Return-Path: <SRS0=5Vws=Y5=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF1EC5DF60
	for <linux-fstests@archiver.kernel.org>; Tue,  5 Nov 2019 18:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C319217F5
	for <linux-fstests@archiver.kernel.org>; Tue,  5 Nov 2019 18:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390664AbfKESt0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 5 Nov 2019 13:49:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42343 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389861AbfKESt0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 5 Nov 2019 13:49:26 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iS3tB-00023q-Cj; Tue, 05 Nov 2019 19:49:13 +0100
Date:   Tue, 5 Nov 2019 19:49:12 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Catalin Marinas <catalin.marinas@arm.com>
cc:     Amir Goldstein <amir73il@gmail.com>, Theodore Tso <tytso@mit.edu>,
        fstests <fstests@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>, Qian Cai <cai@lca.pw>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 5.4-rc1 boot regression with kmemleak enabled
In-Reply-To: <20191105182212.GF22987@arrakis.emea.arm.com>
Message-ID: <alpine.DEB.2.21.1911051948350.1869@nanos.tec.linutronix.de>
References: <CAOQ4uxgy6THDG2NsNSQ+=FP+iSZKeCkNEM9PbxQSB5p5nHvoCA@mail.gmail.com> <20191105115431.GD26580@mbp> <CAOQ4uxjm=tWsQpfLkY9O_3qWK86X=kCD19P8zJAQjs5ms_RfZw@mail.gmail.com> <20191105153055.GC22987@arrakis.emea.arm.com>
 <CAOQ4uxjDnu-1eUwAkYW+dRPYAeQsc07on1kk+_emBhZBvj+bAg@mail.gmail.com> <20191105182212.GF22987@arrakis.emea.arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, 5 Nov 2019, Catalin Marinas wrote:
> On Tue, Nov 05, 2019 at 08:17:11PM +0200, Amir Goldstein wrote:
> > [    0.027836] RIP: 0010:get_stack_info+0xa7/0x146
> 
> Ah, it looks very similar to this report:
> 
> http://lkml.kernel.org/r/20191019114421.GK9698@uranus.lan
> 
> Thomas had a patch here:
> 
> https://lore.kernel.org/linux-mm/alpine.DEB.2.21.1910231950590.1852@nanos.tec.linutronix.de/
> 
> but not sure whether it has hit mainline yet.

It's queued in tip. Will hit Linus tree during the week.

Thanks,

	tglx
