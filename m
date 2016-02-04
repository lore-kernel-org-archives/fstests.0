Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:28075 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752862AbcBDVHk (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 4 Feb 2016 16:07:40 -0500
Received: from dave by dastard with local (Exim 4.80)
	(envelope-from <david@fromorbit.com>)
	id 1aRR6a-0008Q4-Qm
	for fstests@vger.kernel.org; Fri, 05 Feb 2016 08:06:20 +1100
Date: Fri, 5 Feb 2016 08:06:20 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 0/3] fstests: improved config section support
Message-ID: <20160204210620.GD31407@dastard>
References: <1453340593-10236-1-git-send-email-david@fromorbit.com>
 <20160202033446.GA31407@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160202033446.GA31407@dastard>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 02, 2016 at 02:34:46PM +1100, Dave Chinner wrote:
> On Thu, Jan 21, 2016 at 12:43:10PM +1100, Dave Chinner wrote:
> > Hi folks,
> > 
> > This small series adds more functionality to the config file section
> > support that I've been using locally. It adds support for external
> > devices to the config section parsing, so we can configure external
> > log and realtime devices for XFS tests, updates the "setup"
> > diagnostic command to understand config sections, and adds the
> > ability to exclude sections from the set that check will pull from
> > the config file.
> 
> ping?

Folks, getting reviews for my own changes is holding up the next
release. Please review.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
