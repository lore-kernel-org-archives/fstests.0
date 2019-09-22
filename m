Received: from mga02.intel.com ([134.134.136.20]:41697 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbfIVCB5 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 21 Sep 2019 22:01:57 -0400
From: "Weiny, Ira" <ira.weiny@intel.com>
Subject: RE: [PATCH 00/13] Fix locktest and add lease testing to it
Date: Sun, 22 Sep 2019 02:01:49 +0000
Message-ID: <2807E5FD2F6FDA4886F6618EAC48510E8991612A@CRSMSX101.amr.corp.intel.com>
References: <20190918041558.2621-1-ira.weiny@intel.com>
 <20190921162048.GP2622@desktop>
In-Reply-To: <20190921162048.GP2622@desktop>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>, "john.hubbard@gmail.com" <john.hubbard@gmail.com>, Dave Chinner <david@fromorbit.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>, "Williams, Dan J" <dan.j.williams@intel.com>, Jeff Layton <jlayton@kernel.org>
List-ID: <fstests@vger.kernel.org>

> On Tue, Sep 17, 2019 at 09:15:45PM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > Rather than have a separate lease test, combine the previously
> > proposed lease tests[1] directly to locktest because they share so much
> code.
> 
> Firstly, thanks for the revised version!
> 
> Then, I'm so sorry if I didn't explain clearly in previous review, we do need a
> separate lease test, e.g. a new generic/568 test, and don't want locktest.c to
> test both lock and lease in the same generic/131 case.
> But reuse & extend the src/locktest.c to test lease as well, and call
> src/locktest in the new generic/568 case.

I can do that.  IMO, this work was needed regardless.

> 
> e.g. introduce two test arrays, one for lock test and one for lease test, and
> add new commandline switch to src/locktest.c and use the correct test array
> according to the given commandline option.

Sure I can do that without too much trouble.

Just to be clear are you ok with overloading the fields such that the test array format is the same?  That will be easiest.

> 
> >
> > To make things cleaner update the lock test code and test script.
> > This includes fixing a rather serious bug.
> >
> > Finally update the error output to help identify any steps which fail
> > during testing.
> >
> > Ira
> >
> > [1] https://www.spinics.net/lists/fstests/msg12467.html
> >
> > Ira Weiny (13):
> >   src/locktest: Remove unnecessary sleep
> >   src/locktest: Remove OPEN macro
> >   src/locktest: Change command macro names
> >   src/locktest: Add get_cmd_str
> >   src/locktest.c: Clean up client command passing
> >   src/locktest.c: Fix return code if last test fails
> >   generic/131: Clean up pid variables
> >   generic/131: Save stderr for debugging
> 
> Looks like above cleanups and bugfixes can be merged independently, but
> I'm not sure if you need to update them as well when introducing new test
> array and new test case, so I leave them unmerged for now.

I don't think I will need to modify these per se.  I'd probably introduce the mechanics as part of the first test below to add the basic testing.  But it does not matter much.  Feel free to merge them if you want.

Ira

> 
> Thanks!
> 
> Eryu
> 
> >   src/locktest: Add simple lease testing
> >   src/locktest: Add lease testing for basic signal reception
> >   src/locktest: Add truncate lease tests
> >   src/locktest: Clean up error output
> >   src/locktest: Audit all debug output
> >
> >  src/locktest.c    | 957 ++++++++++++++++++++++++++++++----------------
> >  tests/generic/131 |  72 ++--
> >  2 files changed, 666 insertions(+), 363 deletions(-)
> >
> > --
> > 2.20.1
> >
