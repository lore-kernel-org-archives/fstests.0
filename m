Received: from mail-qt0-f175.google.com ([209.85.216.175]:34765 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751857AbeBAOVn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 1 Feb 2018 09:21:43 -0500
Received: by mail-qt0-f175.google.com with SMTP id a27so26623579qtd.1
        for <fstests@vger.kernel.org>; Thu, 01 Feb 2018 06:21:42 -0800 (PST)
Date: Thu, 1 Feb 2018 09:21:40 -0500
From: Josef Bacik <josef@toxicpanda.com>
Subject: Re: [LSF/MM TOPIC] Filesystem performance regression tests
Message-ID: <20180201142139.5a53brni5rnjciyp@destiny>
References: <CAOQ4uxi+L6Bhs_=aTvNemC9wBXHw0_bwwPixNzFcJoc8e79XsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi+L6Bhs_=aTvNemC9wBXHw0_bwwPixNzFcJoc8e79XsQ@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: lsf-pc@lists.linux-foundation.org, Josef Bacik <jbacik@fb.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, fstests <fstests@vger.kernel.org>, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Feb 01, 2018 at 08:50:21AM +0200, Amir Goldstein wrote:
> Hi Josef and all,
> 
> I would like to be rude and solicit a talk from Josef on automated
> performance regression testing (if he is planning to attend).
> We know the guys at facebook are running some performance
> regression tests for a while and Josef has just upstreamed
> a nice taste on this infrastructure to xfstests:
> https://marc.info/?l=fstests&m=150765617921864&w=2
> 
> But this is only the beginning... for community performance
> regression tests to be useful there need to be not only people
> running the tests, but also people running the tests on well known
> machines and/or well known hardware configurations and maintain
> long lived performance results db for those machines.
> 
> How can we utilize community resources to achieve that?
> Can running performance regressions of gce-xfstests provide
> anything close to stable results?
> 
> If performance regressions are integrated into 0-day kernel test
> robot, that could be extremely beneficial to the community, but can
> the robot guaranty to run the tests on dedicated machines or
> VMs with dedicated resources?
> 
> Do we know of good examples to follow from automated regression
> tests done for specific filesystem (Dave Chinner has referred to his
> regression tests in one or two occasions)? for other kernel subsystems?
> 
> Putting up a regression test server for overlayfs is on my TODO list.
> In the mean while, I have little to contribute from my experience, but
> would love to sit in that talk.
> 

I'm happy to talk about this stuff and how it could be improved.  I think
integrating it into continuous testing is tricky.  With all of our performance
stuff it's always A/B testing, because shit changes constantly.  I hate doing
perf stuff in VM's because it's captive to whatever else the host is doing.
xfstests is a good place for this stuff since we all have our own personal rigs
that we control.  Could we extend xfstests to log our results publicly?  That
would be cool, I would be fine with that.  My test box rarely changes, so if its
just a matter of uploading some magic ID associated with my box, and then
uploading results paired with that ID to be world viewed then that would be
cool.  I'm sure we could find somebody willing to host such a thing for us.
Thanks,

Josef
