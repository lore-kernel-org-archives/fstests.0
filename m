Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38486 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750716AbbB0Jpk (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 27 Feb 2015 04:45:40 -0500
Date: Fri, 27 Feb 2015 10:45:09 +0100 (CET)
From: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>
Subject: RE: [PATCH v3 2/2] Fix warning of "Usage: _is_block_dev dev"
In-Reply-To: <00d201d0522f$f4876980$dd963c80$@cn.fujitsu.com>
Message-ID: <alpine.LFD.2.00.1502271043160.2188@localhost.localdomain>
References: <196cc72cb39e1a338339fa09c73f6334af63a2d6.1424946979.git.zhaolei@cn.fujitsu.com> <477b0e94819bea20d920822f0b88099ce19532a8.1424946979.git.zhaolei@cn.fujitsu.com> <alpine.LFD.2.00.1502261223250.25704@localhost.localdomain>
 <00c501d051bf$7a6c84c0$6f458e40$@cn.fujitsu.com> <alpine.LFD.2.00.1502261430120.25704@localhost.localdomain> <00d201d0522f$f4876980$dd963c80$@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: fstests-owner@vger.kernel.org
To: Zhao Lei <zhaolei@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

> > Simply said
> > 
> > _is_block_dev "$TEST_DEV"
> > 
> > will return empty string if $TEST_DEV either does not exist or $TEST_DEV itself
> > is empty string. However if someone calls
> > 
> > _is_block_dev
> > 
> > he'll get an error so he knows that he needs to fix his code.
> > 
> 
> These 2 way have the respective advantages.
> For me, both way is acceptable as long as it can fix titled bug.
> 
> I'll send v4 based on your suggestion, to provide Dave Chinner a selection.

Ok thanks, I think that simply using quotes is better then rewriting
the thing and introducing new helpers. But in the end its Dave's decision
to make.

Thanks!
-Lukas
