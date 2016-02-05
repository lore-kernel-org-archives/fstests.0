Received: from mx1.redhat.com ([209.132.183.28]:60648 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721AbcBED5R (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 4 Feb 2016 22:57:17 -0500
Date: Fri, 5 Feb 2016 11:57:13 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 1/2] dm-thinp helpers in common/dmthin
Message-ID: <20160205035713.GR11419@eguan.usersys.redhat.com>
References: <5627FA00.70003@redhat.com>
 <5627FB43.9050804@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5627FB43.9050804@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Eric Sandeen <sandeen@redhat.com>, fstests <fstests@vger.kernel.org>, Mike Snitzer <snitzer@redhat.com>, xzhou@redhat.com
List-ID: <fstests@vger.kernel.org>

On Wed, Oct 21, 2015 at 03:53:23PM -0500, Eric Sandeen wrote:
> Basic dm-thinp helpers to set up, tear down, grow, check,
> and set no-space behavior for a single thin dm volume built
> on $SCRATCH_DEV.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Looks good to me. We're planning to add more thinp tests using this
framework, and we can always improve the dmthin framework. For now

Reviewed-by: Eryu Guan <eguan@redhat.com>
