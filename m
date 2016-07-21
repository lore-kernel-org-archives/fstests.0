Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:46728 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753898AbcGUW5Q (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 21 Jul 2016 18:57:16 -0400
Date: Fri, 22 Jul 2016 08:57:12 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] fstests: btrfs: Test send on heavily deduped file
Message-ID: <20160721225712.GE12670@dastard>
References: <20160719024402.19324-1-quwenruo@cn.fujitsu.com>
 <20160719043524.GL27776@eguan.usersys.redhat.com>
 <fb7acb1e-3835-1511-d66e-7d186c94e35e@cn.fujitsu.com>
 <20160720070100.GU27776@eguan.usersys.redhat.com>
 <01fb32c1-4662-ba9e-6bab-5b01790bd1d3@cn.fujitsu.com>
 <20160720233742.GZ12670@dastard>
 <409140dc-6c77-7e20-33ff-c533d0054bf6@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <409140dc-6c77-7e20-33ff-c533d0054bf6@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Cc: Eryu Guan <eguan@redhat.com>, linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 21, 2016 at 10:05:25AM +0800, Qu Wenruo wrote:
> 
> 
> At 07/21/2016 07:37 AM, Dave Chinner wrote:
> >On Wed, Jul 20, 2016 at 03:40:29PM +0800, Qu Wenruo wrote:
> >>At 07/20/2016 03:01 PM, Eryu Guan wrote:
> >>>On Tue, Jul 19, 2016 at 01:42:03PM +0800, Qu Wenruo wrote:
> >>>>>
> >>>>>This test uses $LOAD_FACTOR, so it should be in 'stress' group. And it
> >>>>>hangs the latest kernel, stop other tests from running, I think we can
> >>>>>add it to 'dangerous' group as well.
> >>>>>
> >>>>
> >>>>Thanks for this info.
> >>>>I'm completely OK to add this group to 'stress' and 'dangerous'.
> >>>>
> >>>>
> >>>>However I'm a little curious about the meaning/standard of these groups.
> >>>>
> >>>>Does 'dangerous' conflicts with 'auto'?
> >>>>Since under most case, tester would just execute './check -g auto' and the
> >>>>system hangs at the test case.
> >>>>So I'm a little confused with the 'auto' group.
> >>>
> >>>I quote my previous email here to explain the 'auto' group
> >>>http://www.spinics.net/lists/fstests/msg03262.html
> >>>
> >>>"
> >>>I searched for Dave's explainations on 'auto' group in his reviews, and
> >>>got the following definitions:
> >>>
> >>>- it should be a valid & reliable test (it's finished and have
> >>> deterministic output) [1]
> >>>- it passes on current upstream kernels, if it fails, it's likely to be
> >>> resolved in forseeable future [2]
> >>>- it should take no longer than 5 minutes to finish [3]
> >>>"
> >>>
> >>>And "The only difference between quick and auto group criteria is the
> >>>test runtime." Usually 'quick' tests finish within 30s.
> >>>
> >>>For the 'dangerous' group, it was added in commit 3f28d55c3954 ("add
> >>>freeze and dangerous groups"), and seems that it didn't have a very
> >>>clear definition[*]. But I think any test that could hang/crash recent
> >>>kernels is considered as dangerous.
> >>>
> >>>* http://oss.sgi.com/archives/xfs/2012-03/msg00073.html
> >>
> >>Thanks for all the info, really helps a lot.
> >>
> >>Especially for quick and auto difference.
> >>
> >>Would you mind me applying this standard to current btrfs test cases?
> >
> >It shoul dbe applied to all test cases, regardless of the filesystem
> >type.
> 
> It's straightforward for specific fs test cases.
> 
> But for generic, I'm a little concerned of the quick/auto standard.
> Should we use result of one single fs(and which fs? I assume xfs
> though) or all fs, to determine quick/auto group?

It's up to the person introducing the new test to determine how it
should be classified. If this causes problems for other people, then
they can send patches to reclassify it appropriately based on their
runtime numbers and configuration.

Historicaly speaking, we've tended to ignore btrfs performance
because it's been so randomly terrible. It's so often been a massive
outlier that we've generally considered btrfs performance to be a
bug that needs fixing and not something that requires the test to be
reclassified for everyone else.

> So it makes quick/auto tag quite hard to determine.

It's quite straight forward, really. Send patches with numbers for
the tests you want reclassified, and lots of people will say "yes, i
see that too" or "no, that only takes 2s on my smallest, slowest
test machine, it should remain as a quick test". And that's about
it.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
