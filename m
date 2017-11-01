Received: from ipmail03.adl2.internode.on.net ([150.101.137.141]:8321 "EHLO
        ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753990AbdKABQt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 31 Oct 2017 21:16:49 -0400
Date: Wed, 1 Nov 2017 12:16:47 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] ext4/030: Ext4 online resize tests.
Message-ID: <20171101011647.GC4094@dastard>
References: <20171101001159.88570-1-harshads@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171101001159.88570-1-harshads@google.com>
Sender: fstests-owner@vger.kernel.org
To: harshads <harshads@google.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Oct 31, 2017 at 05:11:59PM -0700, harshads wrote:
> Add tests for Ext4 online resize feature. Once online resizing with
> bigalloc support is merged into Ext4, these tests can be used to
> sanitize the working of that feature. In order to test online resizing
> with bigalloc, set MKFS_OPTIONS="-O bigalloc -C <cluster_size>" and
> run the test.
> 
> Signed-off-by: Harshad Shirwadkar <harshads@google.com>

You should do this on a loop device, that way you can test
much bigger sizes and all the critical numbers around 32 bit
overflows in the storage stack (2T, 4T, 8T, 16T, etc). e.g.
see xfs/078.

Also, you should add a test that does grow at ENOSPC will exercising
the fs with fstress. See xfs/104.

Perhaps some of the XFS specific tests in the growfs group could be
turned into generic tests with the right infrastructure, so you get
more coverage on ext4 without a whole lot of extra work...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
