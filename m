Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:40131 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750739AbaGJBwT (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 9 Jul 2014 21:52:19 -0400
Message-ID: <53BDF1D2.6000204@sandeen.net>
Date: Wed, 09 Jul 2014 20:52:18 -0500
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] xfstests: Check fs consistency on TEST_DEV only when
 needed
References: <1403617014-17870-1-git-send-email-lczerner@redhat.com>	<1403617014-17870-2-git-send-email-lczerner@redhat.com> <20140710010711.GJ4453@dastard>
In-Reply-To: <20140710010711.GJ4453@dastard>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>, Lukas Czerner <lczerner@redhat.com>
Cc: fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On 7/9/14, 8:07 PM, Dave Chinner wrote:
> Reducing runtime of the test harness is a good idea, but we should
> not do that if the cost is that it reduces the reliability of error
> detection.

Still, this could have a really big impact, especially on filesystems
with slow fsck.

It'd be great to find a way to make this reliable.

It's kind of a historical accident that "test" is always mounted, but
"scratch" must be _required.  What if we added _require_test if we're 
going to write to test, and doing so triggers the check?

I'm sure there are other ways around it.  Spending tons of time in fsck
for a filesystem we didn't touch isn't time well spent, IMHO.

-Eric
