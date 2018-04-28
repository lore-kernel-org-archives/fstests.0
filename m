Received: from mail-pg0-f47.google.com ([74.125.83.47]:43057 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759215AbeD1Cpt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 27 Apr 2018 22:45:49 -0400
Received: by mail-pg0-f47.google.com with SMTP id k11-v6so1684683pgo.10
        for <fstests@vger.kernel.org>; Fri, 27 Apr 2018 19:45:49 -0700 (PDT)
Date: Sat, 28 Apr 2018 10:45:45 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] check: annotate good and expunged tests in results
Message-ID: <20180428024545.GR11384@desktop>
References: <20180412213838.28929-1-jeffm@suse.com>
 <20180424093646.GA11384@desktop>
 <fde6f93d-5c12-dcc8-9194-c91f96773bc6@suse.com>
 <20180427112356.GP11384@desktop>
 <20180427170009.GT27853@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427170009.GT27853@wotan.suse.de>
Sender: fstests-owner@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Jeff Mahoney <jeffm@suse.com>, fstests@vger.kernel.org, nborisov@suse.com, fdmanana@suse.com
List-ID: <fstests@vger.kernel.org>

On Fri, Apr 27, 2018 at 05:00:09PM +0000, Luis R. Rodriguez wrote:
> On Fri, Apr 27, 2018 at 07:23:56PM +0800, Eryu Guan wrote:
> > 
> > But the test run & pass info is already available from the check output
> > and the test result summary at the end of check. Is that sufficient for
> > you? Also, we already have mechanism to generate a test report in xunit
> > format, i.e. ./check -R xunit -g auto, which includes results for passed
> > & failed & notrun tests.
> 
> Do we have a way to parse the results *after* a run? For instance,
> if you forgot -R xunit ?

There's a tools/compare-failures script that takes the outputs of check
as inputs and compares the results. But, TBH, I never run it after
reviewing it.. Perhaps it could be enhanced somehow.

Thanks,
Eryu
