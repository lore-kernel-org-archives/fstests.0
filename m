Return-Path: <SRS0=8raW=DZ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0641BC433E7
	for <linux-fstests@archiver.kernel.org>; Sun, 18 Oct 2020 10:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB64F21582
	for <linux-fstests@archiver.kernel.org>; Sun, 18 Oct 2020 10:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgJRKLC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 18 Oct 2020 06:11:02 -0400
Received: from out20-1.mail.aliyun.com ([115.124.20.1]:52254 "EHLO
        out20-1.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgJRKLB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 18 Oct 2020 06:11:01 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.125953|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0089484-0.00110466-0.989947;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=guan@eryu.me;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.IkzVkC3_1603015858;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.IkzVkC3_1603015858)
          by smtp.aliyun-inc.com(10.147.41.231);
          Sun, 18 Oct 2020 18:10:58 +0800
Date:   Sun, 18 Oct 2020 18:10:58 +0800
From:   Eryu Guan <guan@eryu.me>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>, guaneryu@gmail.com,
        fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] generic/402: use _try_scratch_mount instead of
 _scratch_mount
Message-ID: <20201018101058.GY3853@desktop>
References: <1602840684-25524-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1602840684-25524-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20201016153321.GB9830@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016153321.GB9830@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Oct 16, 2020 at 08:33:21AM -0700, Darrick J. Wong wrote:
> On Fri, Oct 16, 2020 at 05:31:24PM +0800, Yang Xu wrote:
> > Here will check the return code of mount option. So update it
> > to use _try_scratch_mount
> > 
> > Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> > ---
> >  tests/generic/402 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tests/generic/402 b/tests/generic/402
> > index 7fc81864..4c940ac4 100755
> > --- a/tests/generic/402
> > +++ b/tests/generic/402
> > @@ -102,7 +102,7 @@ run_test()
> >  }
> >  
> >  _scratch_mkfs &>> $seqres.full 2>&1 || _fail "mkfs failed"
> > -_scratch_mount || _fail "scratch mount failed"
> > +_try_scratch_mount || _fail "scratch mount failed"
> 
> Why not just drop the "|| _fail" part?  The message isn't much
> more specific than the fail message that _scratch_mount emits.

Agreed, using _scratch_mount is fine here.

Thanks,
Eryu
