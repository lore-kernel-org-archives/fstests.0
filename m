Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:17890 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752568AbcGTXaD (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 20 Jul 2016 19:30:03 -0400
Date: Thu, 21 Jul 2016 09:30:00 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] fstests: btrfs: Test send on heavily deduped file
Message-ID: <20160720233000.GY12670@dastard>
References: <20160719024402.19324-1-quwenruo@cn.fujitsu.com>
 <20160719043524.GL27776@eguan.usersys.redhat.com>
 <fb7acb1e-3835-1511-d66e-7d186c94e35e@cn.fujitsu.com>
 <20160720070100.GU27776@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160720070100.GU27776@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Qu Wenruo <quwenruo@cn.fujitsu.com>, linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jul 20, 2016 at 03:01:00PM +0800, Eryu Guan wrote:
> For running tests, "./check -g auto -x dangerous" might fit your need.

Yes, that's precisely the way the dangerous group is intended to be
used: as a exclusion filter that gets applied to other test group
definitions.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
