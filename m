Received: from mail-vs1-f68.google.com ([209.85.217.68]:34112 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbeKIAWn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 8 Nov 2018 19:22:43 -0500
Received: by mail-vs1-f68.google.com with SMTP id y27so9891425vsi.1
        for <fstests@vger.kernel.org>; Thu, 08 Nov 2018 06:46:53 -0800 (PST)
MIME-Version: 1.0
References: <20181104163826.GH12788@desktop> <1B22AFA2-FAF3-45AA-9910-CDBE4AEBFB09@gmail.com>
 <20181105052217.GT6311@dastard> <46630C6B-77FA-4D15-92E7-43B89AD889A0@gmail.com>
 <20181106231536.GB8691@thunk.org> <20181106233956.GX6311@dastard>
 <CA+EzBbDwdi26MCswz0iQ8hUTcGixATUXayxMOmEw5gekYvmMuw@mail.gmail.com>
 <20181107020922.GY6311@dastard> <20181107040429.GA13539@thunk.org>
 <CA+EzBbDp4UrcYLgDpHjtSuQb0a-Ny_94vJzXaMu0sskD1K3skg@mail.gmail.com> <20181108091025.GA6311@dastard>
In-Reply-To: <20181108091025.GA6311@dastard>
From: Jayashree Mohan <jayashree2912@gmail.com>
Date: Thu, 8 Nov 2018 08:46:38 -0600
Message-ID: <CA+EzBbDfZDoWDyZ1o_uFPhUp2r+L+xh_fGrR3E88w5VqzJWStQ@mail.gmail.com>
Subject: Re: [PATCH] fstest: CrashMonkey tests ported to xfstest
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Eryu Guan <guaneryu@gmail.com>, fstests <fstests@vger.kernel.org>, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>, Amir Goldstein <amir73il@gmail.com>, Filipe Manana <fdmanana@gmail.com>
List-ID: <fstests@vger.kernel.org>

> > We understand the concern about testing times. To choose a middle
> > ground, Ted's suggestion of using _scratch_mkfs_sized works best for
> > CrashMonkey specific tests. These tests involve very few files and it
> > suffices to have a 100MB file system. I tested the patch on ext4, xfs,
> > btrfs and f2fs on a partition of this size. The overhead due to
> > _check_scratch_fs  after each sub test is in the range of 3-5 seconds
>
> 3-5 second per invocation of _check_scratch_fs?

No. This is the overall overhead for calling  _check_scratch_fs after
each of the 37 sub tests in my first patch. Without this check, it
took 10 seconds to run. With this addition, it takes about 12-15
seconds to run all the 37 sub tests.


> > for all  these file systems. If this is tolerable, we can force a
>
> Not if your numbers that means 300 x 3-5 seconds. That's 15-25
> minutes of extra runtime.

Going by the above calculation, the extra run time for the invocation
of check after each sub-test should be around 30-40 seconds in total
(for the set of 300 tests).
