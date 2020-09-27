Return-Path: <SRS0=/6m1=DE=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD46FC4346E
	for <linux-fstests@archiver.kernel.org>; Sun, 27 Sep 2020 09:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FC6023977
	for <linux-fstests@archiver.kernel.org>; Sun, 27 Sep 2020 09:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgI0Jic (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 27 Sep 2020 05:38:32 -0400
Received: from out20-27.mail.aliyun.com ([115.124.20.27]:54964 "EHLO
        out20-27.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgI0Jic (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 27 Sep 2020 05:38:32 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1067294|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0130096-0.000472494-0.986518;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07381;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.IcpOcFf_1601199508;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.IcpOcFf_1601199508)
          by smtp.aliyun-inc.com(10.147.41.231);
          Sun, 27 Sep 2020 17:38:28 +0800
Date:   Sun, 27 Sep 2020 17:38:28 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/611: remove _supported_os line
Message-ID: <20200927093828.GR3853@desktop>
References: <20200921043144.8057-1-zlang@redhat.com>
 <5F69BA9E.7040201@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5F69BA9E.7040201@cn.fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Sep 22, 2020 at 04:49:34PM +0800, Xiao Yang wrote:
> On 2020/9/21 12:31, Zorro Lang wrote:
> > The current xfstests doesn't support _supported_os() function, the
> > generic/611 always hit an error:
> >
> >   xfstests-dev/tests/generic/611: line 39: _supported_os: command not found
> >
> > So remove the "_supported_os Linux" line directly.
> Hi Zorro,
> 
> It seems better to add a fix tag:
> Fixes: a860a167d87a ("common: kill _supported_os")

Actually it was my fault, not the above commit, I applied the new test
first, then applied above commit, which of cource didn't handle
generic/611..

> 
> Other than that it is fine for me. :-)
> Reviewed-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Thanks for the fix and review!

Eryu

> 
> Best Regards,
> Xiao Yang
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > ---
> >  tests/generic/611 | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/tests/generic/611 b/tests/generic/611
> > index 069db6f9..f4158bb3 100755
> > --- a/tests/generic/611
> > +++ b/tests/generic/611
> > @@ -36,7 +36,6 @@ rm -f $seqres.full
> >  # real QA test starts here
> >  
> >  _supported_fs generic
> > -_supported_os Linux
> >  _require_scratch
> >  _require_attrs
> >  
> 
> 
