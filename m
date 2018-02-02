Received: from ipmail03.adl6.internode.on.net ([150.101.137.143]:1181 "EHLO
        ipmail03.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751472AbeBBAST (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 1 Feb 2018 19:18:19 -0500
Date: Fri, 2 Feb 2018 11:19:11 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [LSF/MM TOPIC] Filesystem performance regression tests
Message-ID: <20180202001911.nrcwpg7xmtsrdduf@destitution>
References: <CAOQ4uxi+L6Bhs_=aTvNemC9wBXHw0_bwwPixNzFcJoc8e79XsQ@mail.gmail.com>
 <20180201142139.5a53brni5rnjciyp@destiny>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201142139.5a53brni5rnjciyp@destiny>
Sender: fstests-owner@vger.kernel.org
To: Josef Bacik <josef@toxicpanda.com>
Cc: Amir Goldstein <amir73il@gmail.com>, lsf-pc@lists.linux-foundation.org, Josef Bacik <jbacik@fb.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, fstests <fstests@vger.kernel.org>, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Feb 01, 2018 at 09:21:40AM -0500, Josef Bacik wrote:
> On Thu, Feb 01, 2018 at 08:50:21AM +0200, Amir Goldstein wrote:
> > Hi Josef and all,
> > 
> > I would like to be rude and solicit a talk from Josef on automated
> > performance regression testing (if he is planning to attend).
> > We know the guys at facebook are running some performance
> > regression tests for a while and Josef has just upstreamed
> > a nice taste on this infrastructure to xfstests:
> > https://marc.info/?l=fstests&m=150765617921864&w=2
> > 
> > But this is only the beginning... for community performance
> > regression tests to be useful there need to be not only people
> > running the tests, but also people running the tests on well known
> > machines and/or well known hardware configurations and maintain
> > long lived performance results db for those machines.
> > 
> > How can we utilize community resources to achieve that?
> > Can running performance regressions of gce-xfstests provide
> > anything close to stable results?
> > 
> > If performance regressions are integrated into 0-day kernel test
> > robot, that could be extremely beneficial to the community, but can
> > the robot guaranty to run the tests on dedicated machines or
> > VMs with dedicated resources?
> > 
> > Do we know of good examples to follow from automated regression
> > tests done for specific filesystem (Dave Chinner has referred to his
> > regression tests in one or two occasions)? for other kernel subsystems?
> > 
> > Putting up a regression test server for overlayfs is on my TODO list.
> > In the mean while, I have little to contribute from my experience, but
> > would love to sit in that talk.
> > 
> 
> I'm happy to talk about this stuff and how it could be improved.  I think
> integrating it into continuous testing is tricky.  With all of our performance
> stuff it's always A/B testing, because shit changes constantly.  I hate doing
> perf stuff in VM's because it's captive to whatever else the host is doing.
> xfstests is a good place for this stuff since we all have our own personal rigs
> that we control.  Could we extend xfstests to log our results publicly?  That
> would be cool, I would be fine with that.

I recently wrote a script that produces html comparison tables from
multiple test result runs for easy viewing of long term failure
trends.  I could probably adapt it to whatever the perf test results
output, too. The main problem is where to put them online - perhaps
a git repo somewhere we can all commit to that auto updates to a web
server?

> My test box rarely changes, so if its
> just a matter of uploading some magic ID associated with my box, and then
> uploading results paired with that ID to be world viewed then that would be
> cool.  I'm sure we could find somebody willing to host such a thing for us.

Write the script and they will come? :P

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
