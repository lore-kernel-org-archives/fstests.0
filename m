Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35414 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750853AbaGaMmK (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 31 Jul 2014 08:42:10 -0400
Date: Thu, 31 Jul 2014 20:42:03 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 1/2] xfs: new case to test inode allocations in
 post-growfs disk space
Message-ID: <20140731124203.GH7382@dhcp-13-216.nay.redhat.com>
References: <1405529554-31225-1-git-send-email-eguan@redhat.com>
 <20140721134638.GA45794@bfoster.bfoster>
 <20140724103658.GB6210@dhcp-13-216.nay.redhat.com>
 <20140724130646.GA37832@bfoster.bfoster>
 <20140731033238.GY7382@dhcp-13-216.nay.redhat.com>
 <20140731114537.GA43383@bfoster.bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140731114537.GA43383@bfoster.bfoster>
Sender: fstests-owner@vger.kernel.org
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>, Eric Sandeen <esandeen@redhat.com>, Boris Ranto <branto@redhat.com>, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 31, 2014 at 07:45:37AM -0400, Brian Foster wrote:
> On Thu, Jul 31, 2014 at 11:32:38AM +0800, Eryu Guan wrote:
> > On Thu, Jul 24, 2014 at 09:06:47AM -0400, Brian Foster wrote:
> > > On Thu, Jul 24, 2014 at 06:36:58PM +0800, Eryu Guan wrote:
> > > > On Mon, Jul 21, 2014 at 09:46:38AM -0400, Brian Foster wrote:
> > > > > On Thu, Jul 17, 2014 at 12:52:33AM +0800, Eryu Guan wrote:
[snip]
> > > > Hi Brian,
> > > > 
> > > > Thanks for the review, and sorry for the late response..
> > > > 
> > > > > You could probably even make this smaller and make the test quicker.
> > > > > E.g., I can create an fs down to 20M or so without any problems.  Also,
> > > > > setting imaxpct=0 might be a good idea so you don't hit that artificial
> > > > > limit.
> > > > 
> > > > Yes, a smaller fs could make the test much more quicker. I tested with
> > > > 16M fs and the test time reduced from 70s to ~10s on my test host.
> > > > 
> > > 
> > > That sounds great.
> > > 
> > > > But setting imaxpct=0 could increase the total available inode number
> > > > which could make test run longer. So I tend to use default mkfs
> > > > options here.
> > > >
> > > 
> > > True... I don't really want to make a big deal out of imaxpct. I think
> > > the consensus now is that it's a useless relic and will probably be
> > > removed. That does mean this test will eventually use the full fs space
> > > by default and we should make sure it runs in a reasonable amount of
> > > time. FWIW, it seems to in my tests, running in under 2 minutes on a
> > > single spindle.
> > > 
> > > The other issue is that if I set imaxpct=1 in my mkfs options, the test
> > > passes. Should it? Is it actually testing what it should be in that
> > > scenario? ;) Note that when imaxpct is set, the 'df -i' information will
> > > be based on the cap that imaxpct sets. E.g., it will show 100% usage
> > > even though we've only used a few MB for inodes.
> > 
> > Yes, I can pass the test too with imaxpct=1 set. But I'm not really
> > sure about imaxpct impact on the test result.
> > 
> > Eric, do you have any suggestions here? Because I saw you send out the
> > kernel patch to fix this problem :)
> > 
> 
> (I think Eric might be away.)
> 
> To be clear, I'm just suggesting we verify whether the test is as
> focused as possible. Put another way, have we verified whether this test
> detects the problem with this potential configuration? E.g., run a
> kernel without Eric's growfs fix, run the test and verify it fails.
> Repeat with '-i imaxpct=1' in MKFS_OPTIONS and verify the test still
> fails. If it does, then it's probably fine. If it passes, that's a hole
> in the test case we should close up.
> 
> Brian

Thanks Brian, I'll look into it and try to work it out.

(Note that with my v2 patch, the maxpct number in question is 5 instead of 1)

Thanks,
Eryu
