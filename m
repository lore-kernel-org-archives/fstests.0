Received: from mx1.redhat.com ([209.132.183.28]:56927 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751975AbcGTHBD (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 20 Jul 2016 03:01:03 -0400
Date: Wed, 20 Jul 2016 15:01:00 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] fstests: btrfs: Test send on heavily deduped file
Message-ID: <20160720070100.GU27776@eguan.usersys.redhat.com>
References: <20160719024402.19324-1-quwenruo@cn.fujitsu.com>
 <20160719043524.GL27776@eguan.usersys.redhat.com>
 <fb7acb1e-3835-1511-d66e-7d186c94e35e@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb7acb1e-3835-1511-d66e-7d186c94e35e@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jul 19, 2016 at 01:42:03PM +0800, Qu Wenruo wrote:
> > 
> > This test uses $LOAD_FACTOR, so it should be in 'stress' group. And it
> > hangs the latest kernel, stop other tests from running, I think we can
> > add it to 'dangerous' group as well.
> > 
> 
> Thanks for this info.
> I'm completely OK to add this group to 'stress' and 'dangerous'.
> 
> 
> However I'm a little curious about the meaning/standard of these groups.
> 
> Does 'dangerous' conflicts with 'auto'?
> Since under most case, tester would just execute './check -g auto' and the
> system hangs at the test case.
> So I'm a little confused with the 'auto' group.

I quote my previous email here to explain the 'auto' group
http://www.spinics.net/lists/fstests/msg03262.html

"
I searched for Dave's explainations on 'auto' group in his reviews, and
got the following definitions:

- it should be a valid & reliable test (it's finished and have
  deterministic output) [1]
- it passes on current upstream kernels, if it fails, it's likely to be
  resolved in forseeable future [2]
- it should take no longer than 5 minutes to finish [3]
"

And "The only difference between quick and auto group criteria is the
test runtime." Usually 'quick' tests finish within 30s.

For the 'dangerous' group, it was added in commit 3f28d55c3954 ("add
freeze and dangerous groups"), and seems that it didn't have a very
clear definition[*]. But I think any test that could hang/crash recent
kernels is considered as dangerous.

* http://oss.sgi.com/archives/xfs/2012-03/msg00073.html

For this test, it triggers soft lockup on latest 4.7-rc7 kernel and
prevents further tests from running, so it's part of dangerous. And this
bug will be fixed in forseeable future, right? So it's OK to add 'auto'
group. And we can always remove 'dangerous' group from tests when we
find they're only crashing old kernels, e.g. commit 8c94797 ext4: move
30[1234] from the dangerous to the auto group

For running tests, "./check -g auto -x dangerous" might fit your need.

Thanks,
Eryu
