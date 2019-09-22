Received: from mail-pg1-f176.google.com ([209.85.215.176]:46373 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbfIVHwa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 22 Sep 2019 03:52:30 -0400
Received: by mail-pg1-f176.google.com with SMTP id a3so6108003pgm.13
        for <fstests@vger.kernel.org>; Sun, 22 Sep 2019 00:52:30 -0700 (PDT)
Date: Sun, 22 Sep 2019 15:52:24 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH 00/13] Fix locktest and add lease testing to it
Message-ID: <20190922075224.GQ2622@desktop>
References: <20190918041558.2621-1-ira.weiny@intel.com>
 <20190921162048.GP2622@desktop>
 <2807E5FD2F6FDA4886F6618EAC48510E8991612A@CRSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2807E5FD2F6FDA4886F6618EAC48510E8991612A@CRSMSX101.amr.corp.intel.com>
Sender: fstests-owner@vger.kernel.org
To: "Weiny, Ira" <ira.weiny@intel.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>, "john.hubbard@gmail.com" <john.hubbard@gmail.com>, Dave Chinner <david@fromorbit.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>, "Williams, Dan J" <dan.j.williams@intel.com>, Jeff Layton <jlayton@kernel.org>
List-ID: <fstests@vger.kernel.org>

On Sun, Sep 22, 2019 at 02:01:49AM +0000, Weiny, Ira wrote:
> > On Tue, Sep 17, 2019 at 09:15:45PM -0700, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > >
> > > Rather than have a separate lease test, combine the previously
> > > proposed lease tests[1] directly to locktest because they share so much
> > code.
> > 
> > Firstly, thanks for the revised version!
> > 
> > Then, I'm so sorry if I didn't explain clearly in previous review, we do need a
> > separate lease test, e.g. a new generic/568 test, and don't want locktest.c to
> > test both lock and lease in the same generic/131 case.
> > But reuse & extend the src/locktest.c to test lease as well, and call
> > src/locktest in the new generic/568 case.
> 
> I can do that.  IMO, this work was needed regardless.
> 
> > 
> > e.g. introduce two test arrays, one for lock test and one for lease test, and
> > add new commandline switch to src/locktest.c and use the correct test array
> > according to the given commandline option.
> 
> Sure I can do that without too much trouble.
> 
> Just to be clear are you ok with overloading the fields such that the test array format is the same?  That will be easiest.

Yeah, I'm fine with that. Thanks!

Eryu
