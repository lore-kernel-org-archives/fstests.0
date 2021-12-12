Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB7AC433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 12 Dec 2021 12:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhLLM7J (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 12 Dec 2021 07:59:09 -0500
Received: from out20-51.mail.aliyun.com ([115.124.20.51]:59561 "EHLO
        out20-51.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhLLM7J (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 12 Dec 2021 07:59:09 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1839591|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.122253-0.00306347-0.874683;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047194;MF=guan@eryu.me;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.MAjk71u_1639313947;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.MAjk71u_1639313947)
          by smtp.aliyun-inc.com(10.147.41.137);
          Sun, 12 Dec 2021 20:59:07 +0800
Date:   Sun, 12 Dec 2021 20:59:07 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/module: fix patient module remover when module is
 not present
Message-ID: <YbXyG4OPA2Yfw9/K@desktop>
References: <20211115232834.4121190-1-mcgrof@kernel.org>
 <YbOwrpa7SoJqErvZ@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbOwrpa7SoJqErvZ@bombadil.infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Dec 10, 2021 at 11:55:26AM -0800, Luis Chamberlain wrote:
> Poke

Sorry, it got lost from my to-review queue, applied now, thanks!

Eryu

> 
> On Mon, Nov 15, 2021 at 03:28:34PM -0800, Luis Chamberlain wrote:
> > When module is not present and the open coded patient module
> > remover is called we'll end up in a loop which never ends.
> > Fix this.
> > 
> > I actually found this issue not in fstests, but when applying this
> > open coded solution to blktests. In fstest we tend to only call
> > module remove when we have a module loaded. blktests is different,
> > and so I immediately spotted the issue there.
> > 
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >  common/module | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/common/module b/common/module
> > index ead0f881..6efab71d 100644
> > --- a/common/module
> > +++ b/common/module
> > @@ -180,6 +180,8 @@ _patient_rmmod()
> >  				continue
> >  			fi
> >  			let max_tries=$max_tries-1
> > +		else
> > +			break
> >  		fi
> >  	done
> >  
> > -- 
> > 2.33.0
> > 
