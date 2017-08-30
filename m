Received: from mx1.redhat.com ([209.132.183.28]:46116 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750758AbdH3HAu (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 30 Aug 2017 03:00:50 -0400
Date: Wed, 30 Aug 2017 15:00:47 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [RFC][PATCH 3/8] fsx: fixes to random seed
Message-ID: <20170830070047.GA27835@eguan.usersys.redhat.com>
References: <1503503357-26234-1-git-send-email-amir73il@gmail.com>
 <1503503357-26234-4-git-send-email-amir73il@gmail.com>
 <CAOQ4uxid_pV=J4c3GwTKownM=Yk_HMPYoEsE3++wjOYRhB7oTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxid_pV=J4c3GwTKownM=Yk_HMPYoEsE3++wjOYRhB7oTg@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Aug 25, 2017 at 12:19:07PM +0300, Amir Goldstein wrote:
> On Wed, Aug 23, 2017 at 6:49 PM, Amir Goldstein <amir73il@gmail.com> wrote:
> > Not sure why, but with initstate()/setstate(), sfx generates
> > same events regadless of the input seed argument.
> >
> > Change to use srandom() to fix the problem.
> >
> > Add pid to auto random seed, so parallel fsx executions with auto
> > seed will use different seed values.
> >
> > At this time there are 6 tests that use sfx, out of which:
> > 2 use -S 0 as seed (gettime()) - generic/{075,112}
> > 2 do not specify seed (default = 1) - generic/{091,263}
> > 1 uses explicit constant seed - generic/127
> > 1 uses explicit $RANDOM seed - generic/231
> >
> > This change affects all those tests.
> > The tests that intended to randomize the seed will now really
> > randomize the seed.
> > The tests that intended to use a constant seed will still use
> > a constant seed, but resulting event sequence will be different
> > than before this change.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> 
> Eryu,
> 
> While the rest of the series make take longer time to land,
> I think you should consider applying this patch, or at least test
> how it affects test results on your test systems.

Sorry I got to this so late.. and thanks a lot for all the work you've
done for this log-write test!

> 
> Please let me know if you observe the same behavior as I do
> (you  can use fsx -d to output all events to stdout)

Yes, I saw the same symptom as you've observed, the operation sequences
are always the same no matter what seed I fed to fsx, I'm testing on
both RHEL6 and RHEL7 hosts. It's so weird that seed doesn't have any
effect on initstate and setstate, I'm not sure why either.. But your
patch does change fsx to random mode.

> 
> I wonder what is your opinion of randomized seed vs. constant
> seed in xfstest... anyway, the tests 075,112,231 seem to have
> been using effectively constant seed up to now, not as author
> intended.

I agree with Josef here, be as random as possible and print out the seed
for debug purpose. So I think this patch is fine. I tested the affected
tests a few times and they went on well.

Thanks!

Eryu
