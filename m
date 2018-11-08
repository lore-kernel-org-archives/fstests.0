Received: from ipmail03.adl6.internode.on.net ([150.101.137.143]:55915 "EHLO
        ipmail03.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726145AbeKHSpA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 8 Nov 2018 13:45:00 -0500
Date: Thu, 8 Nov 2018 20:10:25 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] fstest: CrashMonkey tests ported to xfstest
Message-ID: <20181108091025.GA6311@dastard>
References: <20181104163826.GH12788@desktop>
 <1B22AFA2-FAF3-45AA-9910-CDBE4AEBFB09@gmail.com>
 <20181105052217.GT6311@dastard>
 <46630C6B-77FA-4D15-92E7-43B89AD889A0@gmail.com>
 <20181106231536.GB8691@thunk.org>
 <20181106233956.GX6311@dastard>
 <CA+EzBbDwdi26MCswz0iQ8hUTcGixATUXayxMOmEw5gekYvmMuw@mail.gmail.com>
 <20181107020922.GY6311@dastard>
 <20181107040429.GA13539@thunk.org>
 <CA+EzBbDp4UrcYLgDpHjtSuQb0a-Ny_94vJzXaMu0sskD1K3skg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EzBbDp4UrcYLgDpHjtSuQb0a-Ny_94vJzXaMu0sskD1K3skg@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Jayashree Mohan <jayashree2912@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Eryu Guan <guaneryu@gmail.com>, fstests <fstests@vger.kernel.org>, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>, Amir Goldstein <amir73il@gmail.com>, Filipe Manana <fdmanana@gmail.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Nov 07, 2018 at 07:41:50PM -0600, Jayashree Mohan wrote:
> Hi all,
> 
> We understand the concern about testing times. To choose a middle
> ground, Ted's suggestion of using _scratch_mkfs_sized works best for
> CrashMonkey specific tests. These tests involve very few files and it
> suffices to have a 100MB file system. I tested the patch on ext4, xfs,
> btrfs and f2fs on a partition of this size. The overhead due to
> _check_scratch_fs  after each sub test is in the range of 3-5 seconds

3-5 second per invocation of _check_scratch_fs?

> for all  these file systems. If this is tolerable, we can force a

Not if your numbers that means 300 x 3-5 seconds. That's 15-25
minutes of extra runtime.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
