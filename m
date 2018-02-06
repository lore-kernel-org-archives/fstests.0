Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:53575 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751774AbeBFGM1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 6 Feb 2018 01:12:27 -0500
Date: Tue, 6 Feb 2018 17:13:20 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: xfstests failures
Message-ID: <20180206061320.zlma3t55ymtmhyeo@destitution>
References: <94286394-157a-421b-7f73-52f10529f23f@intel.com>
 <20180206035443.GN18267@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206035443.GN18267@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Dave Jiang <dave.jiang@intel.com>, fstests@vger.kernel.org, "Zwisler, Ross" <ross.zwisler@intel.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 06, 2018 at 11:54:43AM +0800, Eryu Guan wrote:
> On Mon, Feb 05, 2018 at 02:40:40PM -0700, Dave Jiang wrote:
> > xfs/191-input-validation
> 
> This tests mkfs.xfs behavior and AFAIK it fails after Dave's mkfs
> refactor patchset, the test itself requires some fixes.

It failed before it, too. I'd just mark this test as broken and
remove it for the auto group, because it isn't doing what I
originally intended it to be used for.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
