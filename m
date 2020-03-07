Return-Path: <SRS0=YIgP=4Y=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424E3C10F00
	for <linux-fstests@archiver.kernel.org>; Sat,  7 Mar 2020 10:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3B12073D
	for <linux-fstests@archiver.kernel.org>; Sat,  7 Mar 2020 10:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgCGKvn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 7 Mar 2020 05:51:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:42844 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbgCGKvn (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 7 Mar 2020 05:51:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F1CB3B387;
        Sat,  7 Mar 2020 10:51:41 +0000 (UTC)
Date:   Sat, 7 Mar 2020 11:51:41 +0100
From:   Anthony Iliopoulos <ailiopoulos@suse.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/513: fix allocsize on archs with pagesize larger
 than blocksize
Message-ID: <20200307105141.GM11781@technoir>
References: <20200307004407.17116-1-ailiopoulos@suse.com>
 <20200307071512.GB14282@dhcp-12-102.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307071512.GB14282@dhcp-12-102.nay.redhat.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Mar 07, 2020 at 03:15:12PM +0800, Zorro Lang wrote:
> On Sat, Mar 07, 2020 at 01:44:07AM +0100, Anthony Iliopoulos wrote:
> > The minimum accepted allocsize mount option value is page size, which
> > causes the particular test to fail in architectures where page size >
> > block size. Fix it by basing the value on the platform page size rather
> > than the block size as obtained from mkfs. In addition add a filter so
> > that different values can be used without breaking the golden output.
> > 
> > Signed-off-by: Anthony Iliopoulos <ailiopoulos@suse.com>
> > ---
> 
> Hi,
> 
> Thanks for this patch, I've forgotten that I tried to fix it:
> https://marc.info/?l=fstests&m=158250811523489&w=2
> 
> And looks like Eryu prefer filtering the PAGESIZE, he might like to merge
> this one:)

I missed that, but assumed that the intention of the test was to cover
the minimum allowable value on the allocsize range and not just the
parsing, so I made it variable. Either way it's fine as long as the test
covers the intended purpose.

> The patch looks good to me, only one slight thing. The filter_pagesz() is
> not used to filter "$pagesize" itself, it filters "allocsize=$pagesize"
> actually. So how about name it as filter_xfs_options (or something like that),
> then we might add more lines(filter) in it later?

Thanks for the review, yes this makes sense, so I'll send a v2 shortly
with the changes.
