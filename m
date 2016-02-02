Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:39795 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751705AbcBBDkD (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 1 Feb 2016 22:40:03 -0500
Received: from dave by dastard with local (Exim 4.80)
	(envelope-from <david@fromorbit.com>)
	id 1aQRjq-0008Bn-5C
	for fstests@vger.kernel.org; Tue, 02 Feb 2016 14:34:46 +1100
Date: Tue, 2 Feb 2016 14:34:46 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 0/3] fstests: improved config section support
Message-ID: <20160202033446.GA31407@dastard>
References: <1453340593-10236-1-git-send-email-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1453340593-10236-1-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jan 21, 2016 at 12:43:10PM +1100, Dave Chinner wrote:
> Hi folks,
> 
> This small series adds more functionality to the config file section
> support that I've been using locally. It adds support for external
> devices to the config section parsing, so we can configure external
> log and realtime devices for XFS tests, updates the "setup"
> diagnostic command to understand config sections, and adds the
> ability to exclude sections from the set that check will pull from
> the config file.

ping?


-- 
Dave Chinner
david@fromorbit.com
