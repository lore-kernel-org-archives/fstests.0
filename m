Received: from mx2.suse.de ([195.135.220.15]:53698 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758851AbeD0RAK (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 27 Apr 2018 13:00:10 -0400
Date: Fri, 27 Apr 2018 17:00:09 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH] check: annotate good and expunged tests in results
Message-ID: <20180427170009.GT27853@wotan.suse.de>
References: <20180412213838.28929-1-jeffm@suse.com>
 <20180424093646.GA11384@desktop>
 <fde6f93d-5c12-dcc8-9194-c91f96773bc6@suse.com>
 <20180427112356.GP11384@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427112356.GP11384@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: Jeff Mahoney <jeffm@suse.com>, fstests@vger.kernel.org, nborisov@suse.com, fdmanana@suse.com
List-ID: <fstests@vger.kernel.org>

On Fri, Apr 27, 2018 at 07:23:56PM +0800, Eryu Guan wrote:
> 
> But the test run & pass info is already available from the check output
> and the test result summary at the end of check. Is that sufficient for
> you? Also, we already have mechanism to generate a test report in xunit
> format, i.e. ./check -R xunit -g auto, which includes results for passed
> & failed & notrun tests.

Do we have a way to parse the results *after* a run? For instance,
if you forgot -R xunit ?

  Luis
