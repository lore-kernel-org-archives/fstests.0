Return-Path: <SRS0=G1tu=X3=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A78C35280
	for <linux-fstests@archiver.kernel.org>; Wed,  2 Oct 2019 08:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E9821783
	for <linux-fstests@archiver.kernel.org>; Wed,  2 Oct 2019 08:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfJBIYd (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 2 Oct 2019 04:24:33 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:20747 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726000AbfJBIYd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 2 Oct 2019 04:24:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TdyCNj5_1570004669;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0TdyCNj5_1570004669)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 02 Oct 2019 16:24:29 +0800
Date:   Wed, 2 Oct 2019 16:24:29 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     fstests@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>,
        john.hubbard@gmail.com, Dave Chinner <david@fromorbit.com>,
        Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>,
        dan.j.williams@intel.com, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH V2 00/16] Fix locktest and add lease testing to it
Message-ID: <20191002082429.GC67926@e18g06458.et15sqa>
References: <20190923175336.2287-1-ira.weiny@intel.com>
 <20191001215410.GA8840@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001215410.GA8840@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Oct 01, 2019 at 02:54:10PM -0700, Ira Weiny wrote:
> On Mon, Sep 23, 2019 at 10:53:20AM -0700, 'Ira Weiny' wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Add lease tests[1] to locktest because they share so much code.  Make running
> > of lease tests separate as an '-L' option.
> > 
> > To make things cleaner update the lock test code and test script.  This
> > includes fixing a rather serious bug.                                                                                                                 
> > 
> > Finally update the error output to help identify any steps which fail during
> > testing.                                                                                                                                            
> >
> 
> Was there any further feedback on this series?  Did it get mangled too bad to
> apply?

Sorry, I forget to mention in last update announce that I'm on public
holiday this week and have limited internet access. I'll review this v2
when I get back.

> 
> Ira
> 
> > 
> > Changes from V1:
> > 	Create a new option '-L' to run lease testing
> > 	Created 568 test script which shared common code with 131
> > 	Moved 2 patches earlier in the series
> > 		[PATCH V2 09/16] src/locktest: Clean up error output
> > 		[PATCH V2 10/16] src/locktest: Audit all debug output
> > 	Added 3 patches
> > 		[PATCH V2 11/16] src/locktest: Add run() function
> > 		[PATCH V2 15/16] common/locktest: Add common locktest functions
> > 		[PATCH V2 16/16] generic/568: Add lease testing

Thanks for the revision!

Eryu

> > 
> > Ira Weiny (16):
> >   src/locktest: Remove unnecessary sleep
> >   src/locktest: Remove OPEN macro
> >   src/locktest: Change command macro names
> >   src/locktest: Add get_cmd_str
> >   src/locktest.c: Clean up client command passing
> >   src/locktest.c: Fix return code if last test fails
> >   generic/131: Clean up pid variables
> >   generic/131: Save stderr for debugging
> >   src/locktest: Clean up error output
> >   src/locktest: Audit all debug output
> >   src/locktest: Add run() function
> >   src/locktest: Add simple lease testing
> >   src/locktest: Add lease testing for basic signal reception
> >   src/locktest: Add truncate lease tests
> >   common/locktest: Add common locktest functions
> >   generic/568: Add lease testing
> > 
> >  common/locktest       |  95 ++++
> >  src/locktest.c        | 999 +++++++++++++++++++++++++++---------------
> >  tests/generic/131     |  54 +--
> >  tests/generic/568     |  32 ++
> >  tests/generic/568.out |   2 +
> >  tests/generic/group   |   1 +
> >  6 files changed, 786 insertions(+), 397 deletions(-)
> >  create mode 100644 common/locktest
> >  create mode 100755 tests/generic/568
> >  create mode 100644 tests/generic/568.out
> > 
> > -- 
> > 2.20.1
> > 
