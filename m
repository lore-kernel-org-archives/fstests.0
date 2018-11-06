Received: from mail-vs1-f45.google.com ([209.85.217.45]:45313 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387946AbeKGJWO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 7 Nov 2018 04:22:14 -0500
Received: by mail-vs1-f45.google.com with SMTP id 124so8419257vsp.12
        for <fstests@vger.kernel.org>; Tue, 06 Nov 2018 15:54:28 -0800 (PST)
MIME-Version: 1.0
References: <CA+EzBbB5t5bSZ0hB6Y1jkxTgOLOv809Jbbcx7w5eK_XS_FPG7w@mail.gmail.com>
 <20181104163826.GH12788@desktop> <1B22AFA2-FAF3-45AA-9910-CDBE4AEBFB09@gmail.com>
 <20181105052217.GT6311@dastard> <46630C6B-77FA-4D15-92E7-43B89AD889A0@gmail.com>
 <20181106231536.GB8691@thunk.org> <20181106233956.GX6311@dastard>
 <CA+EzBbDwdi26MCswz0iQ8hUTcGixATUXayxMOmEw5gekYvmMuw@mail.gmail.com>
 CA+EzBbDwdi26MCswz0iQ8hUTcGixATUXayxMOmEw5gekYvmMuw@mail.gmail.com <5be228d2.1c69fb81.3ad08.5e76.GMR@mx.google.com>
In-Reply-To: <5be228d2.1c69fb81.3ad08.5e76.GMR@mx.google.com>
From: Jayashree Mohan <jayashree2912@gmail.com>
Date: Tue, 6 Nov 2018 17:54:15 -0600
Message-ID: <CA+EzBbCSTom4JPPvMi_MdMpr13CNh1f+cRuHGH7hqXLv3cVG9g@mail.gmail.com>
Subject: Re: Delivery Status Notification (Failure)
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Eryu Guan <guaneryu@gmail.com>, fstests <fstests@vger.kernel.org>, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>, Amir Goldstein <amir73il@gmail.com>, Filipe Manana <fdmanana@gmail.com>
List-ID: <fstests@vger.kernel.org>

> > Can you try adding _check_scratch_fs after each test case?  Yes, it
>
> _check_scratch_fs now runs xfs_scrub on XFS as well as xfs_repair,
> so it's actually quite expensive.
>
> The whole point of aggregating all these tests into one fstest is to
> avoid the overhead of running _check_scratch_fs after every single
> test that are /extremely unlikely/ to fail on existing filesystems.


Filipe and Eryu suggest that we run _check_scratch_fs after each
subtest. Quoting Filipe,


>
> For this type of tests, I think it's a good idea to let fsck run.
>
> Even if all of the links are persisted, the log/journal replay might
> have caused metadata inconsistencies in the fs for example - this was
> true for many cases I fixed over the years in btrfs.
> Even if fsck doesn't report any problem now, it's still good to run
> it, to help prevent future regressions.
>
> Plus this test creates a very small fs, it's not like fsck will take a
> significant time to run.
> So for all these reasons I would unmount and fsck after each test.


For this reason, we currently _check_scratch_fs after each subtest in
the _check_consistency method in my patch.
+       _unmount_flakey
+       _check_scratch_fs $FLAKEY_DEV
+       [ $? -ne 0 ] && _fatal "fsck failed"

Running on a 200MB partition, addition of this check added only around
3-4 seconds of delay in total for this patch consisting of 37 tests.
Currently this patch takes about 12-15 seconds to run to completion on
my 200MB partition.
Am I missing something - is this the check you are talking about?

Thanks,
Jayashree Mohan
