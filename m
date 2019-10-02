Return-Path: <SRS0=G1tu=X3=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5550C10F14
	for <linux-fstests@archiver.kernel.org>; Wed,  2 Oct 2019 17:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB9321783
	for <linux-fstests@archiver.kernel.org>; Wed,  2 Oct 2019 17:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbfJBR70 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 2 Oct 2019 13:59:26 -0400
Received: from mga06.intel.com ([134.134.136.31]:1877 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbfJBR70 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 2 Oct 2019 13:59:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2019 10:59:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,249,1566889200"; 
   d="scan'208";a="366779725"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga005.jf.intel.com with ESMTP; 02 Oct 2019 10:59:24 -0700
Date:   Wed, 2 Oct 2019 10:59:24 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Eryu Guan <eguan@linux.alibaba.com>
Cc:     fstests@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>,
        john.hubbard@gmail.com, Dave Chinner <david@fromorbit.com>,
        Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>,
        dan.j.williams@intel.com, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH V2 00/16] Fix locktest and add lease testing to it
Message-ID: <20191002175924.GD32696@iweiny-DESK2.sc.intel.com>
References: <20190923175336.2287-1-ira.weiny@intel.com>
 <20191001215410.GA8840@iweiny-DESK2.sc.intel.com>
 <20191002082429.GC67926@e18g06458.et15sqa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002082429.GC67926@e18g06458.et15sqa>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Oct 02, 2019 at 04:24:29PM +0800, Eryu Guan wrote:
> On Tue, Oct 01, 2019 at 02:54:10PM -0700, Ira Weiny wrote:
> > On Mon, Sep 23, 2019 at 10:53:20AM -0700, 'Ira Weiny' wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > Add lease tests[1] to locktest because they share so much code.  Make running
> > > of lease tests separate as an '-L' option.
> > > 
> > > To make things cleaner update the lock test code and test script.  This
> > > includes fixing a rather serious bug.
> > > 
> > > Finally update the error output to help identify any steps which fail during
> > > testing.
> > >
> > 
> > Was there any further feedback on this series?  Did it get mangled too bad to
> > apply?
> 
> Sorry, I forget to mention in last update announce that I'm on public
> holiday this week and have limited internet access. I'll review this v2
> when I get back.

Awesome!  Have a great time!  :-D

> 
> > 
> > Ira
> > 
> > > 
> > > Changes from V1:
> > > 	Create a new option '-L' to run lease testing
> > > 	Created 568 test script which shared common code with 131
> > > 	Moved 2 patches earlier in the series
> > > 		[PATCH V2 09/16] src/locktest: Clean up error output
> > > 		[PATCH V2 10/16] src/locktest: Audit all debug output
> > > 	Added 3 patches
> > > 		[PATCH V2 11/16] src/locktest: Add run() function
> > > 		[PATCH V2 15/16] common/locktest: Add common locktest functions
> > > 		[PATCH V2 16/16] generic/568: Add lease testing
> 
> Thanks for the revision!

NP, I kind of like the way it turned out.

Ira

