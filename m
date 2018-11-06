Received: from imap.thunk.org ([74.207.234.97]:46364 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbeKGInS (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 7 Nov 2018 03:43:18 -0500
Date: Tue, 6 Nov 2018 18:15:36 -0500
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] fstest: CrashMonkey tests ported to xfstest
Message-ID: <20181106231536.GB8691@thunk.org>
References: <CA+EzBbB5t5bSZ0hB6Y1jkxTgOLOv809Jbbcx7w5eK_XS_FPG7w@mail.gmail.com>
 <20181104163826.GH12788@desktop>
 <1B22AFA2-FAF3-45AA-9910-CDBE4AEBFB09@gmail.com>
 <20181105052217.GT6311@dastard>
 <46630C6B-77FA-4D15-92E7-43B89AD889A0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46630C6B-77FA-4D15-92E7-43B89AD889A0@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Jayashree Mohan <jayashree2912@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>, Eryu Guan <guaneryu@gmail.com>, fstests <fstests@vger.kernel.org>, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>, Amir Goldstein <amir73il@gmail.com>, Filipe Manana <fdmanana@gmail.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Nov 05, 2018 at 02:16:57PM -0600, Jayashree Mohan wrote:
> 
> I believe that to _scratch_mkfs, I must first _cleanup dm_flakey. If I replace the above snippet by 
> _cleanup
> _scratch_mkfs
> _init_flakey
> 
> The time taken for the test goes up by around 10 seconds (due to mkfs maybe). So I thought it was sufficient to remove the working directory.

Can you try adding _check_scratch_fs after each test case?  Yes, it
will increase the test time, but it will make it easier for a
developer to figure out what might be going on.

Also, how big does the file system have to be?  I wonder if we can
speed things up if a ramdisk is used as the backing device for
dm-flakey.

On the flip side, am I remembering correctly that the original
technique used by your research paper used a custom I/O stack so you
could find potential problems even in the operations getting lost
after a power drop, no matter how unlikely, but rather, for anything
that isn't guaranteed by the cache flush command?

One argument for not using a ramdisk to speed things up is that it
would make be much less likely that potential problems would be found.
But I wonder, given that we're not using dm-flakey, how likely that we
would notice regressions in the first place.

For example, given that we know which patches were needed to fix the
various problems found by your research.  Suppose we revert those
patches, or use a kernel that doesn't have those fixes.  Will the
xfstests script you've generated be able to trigger the failures with
an unfixed kernel?

Cheers,

					- Ted
