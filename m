Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A15BC433E0
	for <linux-fstests@archiver.kernel.org>; Sun, 31 Jan 2021 15:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DDA464E28
	for <linux-fstests@archiver.kernel.org>; Sun, 31 Jan 2021 15:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbhAaP0G (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 31 Jan 2021 10:26:06 -0500
Received: from out20-62.mail.aliyun.com ([115.124.20.62]:40366 "EHLO
        out20-62.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbhAaPZv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 31 Jan 2021 10:25:51 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.11928|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0881639-0.000197543-0.911639;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.JT3j6Nj_1612106692;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.JT3j6Nj_1612106692)
          by smtp.aliyun-inc.com(10.147.40.2);
          Sun, 31 Jan 2021 23:24:53 +0800
Date:   Sun, 31 Jan 2021 23:24:52 +0800
From:   Eryu Guan <guan@eryu.me>
To:     zlang@redhat.com
Cc:     "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/233,270: unlimit the max locked memory size for
 io_uring
Message-ID: <20210131152452.GF2350@desktop>
References: <20210127072143.247849-1-zlang@redhat.com>
 <20210127234340.GD7695@magnolia>
 <20210128030209.GO14354@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128030209.GO14354@localhost.localdomain>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jan 28, 2021 at 11:02:09AM +0800, Zorro Lang wrote:
> On Wed, Jan 27, 2021 at 03:43:40PM -0800, Darrick J. Wong wrote:
> > On Wed, Jan 27, 2021 at 03:21:43PM +0800, Zorro Lang wrote:
> > > The ltp/fsstress always fails on io_uring_queue_init() by returnning
> > > ENOMEM. Due to io_uring accounts memory it needs under the rlimit
> > > memlocked option, which can be quite low on some setups, especially
> > > on 64K pagesize machine. root isn't under this restriction, but
> > > regular users are. So only g/233 and g/270 which use $qa_user to run
> > > fsstress are failed.
> > > 
> > > To avoid this failure, set max locked memory to unlimited before doing
> > > fsstress, then restore it after test done.
> > > 
> > > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > > ---
> > >  tests/generic/233 | 8 ++++++++
> > >  tests/generic/270 | 8 ++++++++
> > >  2 files changed, 16 insertions(+)
> > > 
> > > diff --git a/tests/generic/233 b/tests/generic/233
> > > index 7eda5774..342690c2 100755
> > > --- a/tests/generic/233
> > > +++ b/tests/generic/233
> > > @@ -43,6 +43,13 @@ _fsstress()
> > >  -f rename=10 -f fsync=2 -f write=15 -f dwrite=15 \
> > >  -n $count -d $out -p 7`
> > >  
> > > +	# io_uring accounts memory it needs under the rlimit memlocked option,
> > > +	# which can be quite low on some setups (especially 64K pagesize). root
> > > +	# isn't under this restriction, but regular users are. To avoid the
> > > +	# io_uring_queue_init fail on ENOMEM, set max locked memory to unlimited
> > > +	# temporarily.
> > > +	lmem=`ulimit -l`
> > > +	ulimit -l unlimited
> > 
> > Should this apply to all the other tests that run fsstress?
> > 
> > $ grep -l FSSTRESS_PROG tests/ | wc -l
> > 94
> 
> The root user isn't under this restriction, only g/233 and g/270 run fsstress
> with non-root user ($qa_user).
> Hmm... is that possible to run xfstests with a non-root user? Or you'd like to

No, fstests is required to be run by root user, there's a check in
'check' script :)

> write a common helper _fsstress() (if run fsx with non-root user, I doubt it's
> needed too)...

Perhaps we should raise the limit in fsstress and fsx while setting up
io_uring_queue_init()? So we don't have to add this ulimit settings to
every test that runs fsstress/fsx with regular user.

Thanks,
Eryu
