Received: from mx1.redhat.com ([209.132.183.28]:53287 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753076AbcEWGlk (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 23 May 2016 02:41:40 -0400
Date: Mon, 23 May 2016 14:41:38 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [RFD] fstests needs a new maintainer
Message-ID: <20160523064138.GA5051@zlang.usersys.redhat.com>
References: <20160523045350.GF26977@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160523045350.GF26977@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, May 23, 2016 at 02:53:50PM +1000, Dave Chinner wrote:
> Hi folks,
> 
> For some time now I've been somewhat neglecting xfstests. I've been
> slow to review changes, slow to test and commit changes, and
> generally been dragging my heels on getting general maintainer stuff
> done.
> 
> My problem has several different aspects. The main issue I have is
> that that I don't context switch between tasks at all well. I work
> best when I have a problem I can focus on in depth until it is
> solved. Getting interrupted by something means I start thrash
> between different contexts and then don't get stuff done. I then get
> frustrated because I'm not making progress on anything, and then I
> turn into a nasty, evil, beligerant nay-sayer.
> 
> I don't like wearing cranky-pants all the time, but it's been
> building for some time. To reduce the negative effect of context
> switching, I've been ignoring things I need to pay regular attention
> to (e.g. fstests patches). Then the backlog builds up and when I
> finally get around to doing the merging work, I get annoyed by the
> amount of patch futzing I have to do because of conflicts caused by
> ignoring it for so long.
> 
> And so my care factor while doing this work has decreased, and I
> miss things I should notice, and when I do see things I have
> entirely the wrong attitude to be constructive.  Recently I've even
> found myself getting unreasonably annoyed by little things in this
> process (like git am breaking in an unresolvable way on a patch) and
> have ended up just walking away....
> 
> Rather than go on like this and let it continue into a downward
> spiral that ends in a crash and an alcohol fueled rage-quitting burn
> out, I think it's time to hand fstests on to someone else. I'd much
> prefer to do a clean handover of fstests to someone who is keen and
> eager to do the job. Then I will have less things I need to care
> about and context switch over, and so will make me happier and more
> productive. IMO, that will benefit fstests more than me trying to
> hold on and just thrash harder.
> 
> So, now you know why I want to hand over fstests to someone else,
> it's worth noting why I'm struggling to keep up - that's a better
> story to focus on right now.  In the past 2 and half years since I
> became maintainer (in Nov 2013), there have been:
> 
> 	- 70+ contributors
> 	- 800+ commits, which make up ~1/3rd of the total commits to
> 	  xfstests since 2001
> 	- more than 450 new tests have been added (more than
> 	  doubled!)
> 	- added support for CIFS, f2fs, overlay, tmpfs, and reiser4
> 
> IOWs, fstests development speed has increased signficantly while
> I've been maintainer and the size of the project has more than
> doubled. It's this growth and increase in community and development
> pace that I can't keep up with - fstests is a healthy, growing
> project.  Hence I see this as a positive step for fstests - it has
> grown to the point where it now needs a dedicated maintainer rather
> than one who splits their time across multiple projects.
> 
> I am definitely not saying "I'm leaving, you're on your own!". I
> don't plan on going anywhere - fstests is still going to be a
> primary workflow tool for me. I'm expecting that there will be some
> period of handover - I'll the spend the time to ensure the new
> maintainer knows all they need to know to keep the tree in good
> shape, and then I'll step back and let them ride the roller
> coaster in their own way...
> 
> So it now comes down to finding a new maintainer. Rather than repeat
> past mistakes of others when it comes to selecting a new maintainer,
> I'm simply going to open the floor to discussion, nominations, etc.
> The maintainer is your choice as fstests users and developers, not
> mine as the outgoing maintainer. I have opinions (as always!) but
> I'm going to remain quiet and let the discussion take it's course.
> Which, I should note, is exactly how I became maintainer in the
> first place. :P

Hi Dave,

Excuse me for my abrupt reply.

Thanks for what you did for us. I'm just thinking maybe you can
separate fstests maintenance jobs to several different maintainers?
Due to fstests project become bigger and bigger, it maybe hard for
someone review & merge & verify all kinds of patches.

As I know LTP have "not only one" maintainers. I think we still
need someone like you can make important decision for fstests.
But for some daily jobs, you can distribute them to others.

Thanks,
Zorro

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com


