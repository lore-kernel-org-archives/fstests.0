Received: from mail-yb1-f174.google.com ([209.85.219.174]:42053 "EHLO
        mail-yb1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbeJVLF4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 22 Oct 2018 07:05:56 -0400
Received: by mail-yb1-f174.google.com with SMTP id o204-v6so1532789yba.9
        for <fstests@vger.kernel.org>; Sun, 21 Oct 2018 19:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <CA+EzBbDZ5QZPqbgicY6Ar=uroM9a0-7b8PyUBdwYGMwXgBEanw@mail.gmail.com>
 <20181021104525.GS17817@desktop> <CA+EzBbCd2zZ9sNW-dgyPyR5FH-HK5LArG6y+bPOCJ3Wqyp5=Ug@mail.gmail.com>
 <20181021222111.GH1617@thunk.org> <CA+EzBbB7GA8PZ1xHag0fTWst5cYMUngTmsjUeWemvKOvJ5B8yQ@mail.gmail.com>
 <20181022020539.GR6311@dastard> <CA+EzBbBBicj8qDAtEsjo-8Vys_K_JAF5HP75D5dOvgSMb-CZDQ@mail.gmail.com>
In-Reply-To: <CA+EzBbBBicj8qDAtEsjo-8Vys_K_JAF5HP75D5dOvgSMb-CZDQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 22 Oct 2018 05:49:10 +0300
Message-ID: <CAOQ4uxj6rZ_efkYXoj4T0E0DDomaEZ-OPTcC0zju4U_QyG-a6Q@mail.gmail.com>
Subject: Re: Submitting patches to xfstests based on OSDI '18 paper (CrashMonkey)
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Jayashree Mohan <jayashree2912@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>, Theodore Tso <tytso@mit.edu>, Eryu Guan <guaneryu@gmail.com>, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Mon, Oct 22, 2018 at 5:45 AM Jayashree Mohan <jayashree2912@gmail.com> wrote:
>
> Hi Dave,
>
> Agreed that there could be other overheads per test, which we'll try
> to minimize by batching.
>
> However, even if we batch similar test cases into one,
> _scratch_shutdown and _scratch_cycle_mount() will be called in each

Wait, why _scratch_shutdown and not using dm_flakey?
Fewer filesystems support _scratch_shutdown and _scratch_shutdown
could be buggy and not simulate crash accurately.

> sub-case within the test. Doesn't this mean you will run fsck after
> each sub-test too?
>

_scratch_cycle_mount does not fsck.

Thanks,
Amir.
