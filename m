Return-Path: <SRS0=+7JN=7R=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEECDC433E0
	for <linux-fstests@archiver.kernel.org>; Thu,  4 Jun 2020 10:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4837207D5
	for <linux-fstests@archiver.kernel.org>; Thu,  4 Jun 2020 10:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgFDKtb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 4 Jun 2020 06:49:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:45204 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgFDKtb (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 4 Jun 2020 06:49:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A86A8ABE2;
        Thu,  4 Jun 2020 10:49:33 +0000 (UTC)
Date:   Thu, 4 Jun 2020 12:49:28 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Yong Sun <sunyong0511@gmail.com>,
        Eric Sandeen <sandeen@redhat.com>, fstests@vger.kernel.org,
        Yong Sun <yosun@suse.com>, Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] fstests: modify user name beginning with non-digit
Message-ID: <20200604104928.GC26706@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200603102035.552-1-yosun@suse.com>
 <20200604083023.GA26629@dell5510>
 <20200604093628.GJ1938@dhcp-12-102.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604093628.GJ1938@dhcp-12-102.nay.redhat.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Zorro,

> > Also test tests/generic/381 still uses 123456-fsgqa. Shouldn't be replaced as
> > well?

> I don't know why this case need user '123456-fsgqa', but the generic/381 need
> the 123456-fsgqa necessarily. It cover a bug about how xfs_quota deal with
> user name begin with digits.
Thanks for a quick clarification, sorry for overlooking the test description.

Kind regards,
Petr
