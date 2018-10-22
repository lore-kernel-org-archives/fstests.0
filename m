Received: from ipmail03.adl2.internode.on.net ([150.101.137.141]:14846 "EHLO
        ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726182AbeJVMXW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 22 Oct 2018 08:23:22 -0400
Date: Mon, 22 Oct 2018 15:02:31 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: Submitting patches to xfstests based on OSDI '18 paper
 (CrashMonkey)
Message-ID: <20181022040231.GN18822@dastard>
References: <CA+EzBbDZ5QZPqbgicY6Ar=uroM9a0-7b8PyUBdwYGMwXgBEanw@mail.gmail.com>
 <20181021104525.GS17817@desktop>
 <CA+EzBbCd2zZ9sNW-dgyPyR5FH-HK5LArG6y+bPOCJ3Wqyp5=Ug@mail.gmail.com>
 <20181021222111.GH1617@thunk.org>
 <CA+EzBbB7GA8PZ1xHag0fTWst5cYMUngTmsjUeWemvKOvJ5B8yQ@mail.gmail.com>
 <20181022020539.GR6311@dastard>
 <CA+EzBbBBicj8qDAtEsjo-8Vys_K_JAF5HP75D5dOvgSMb-CZDQ@mail.gmail.com>
 <CAOQ4uxj6rZ_efkYXoj4T0E0DDomaEZ-OPTcC0zju4U_QyG-a6Q@mail.gmail.com>
 <CA+EzBbDdcJpupjPXnQZxcfQxqamwpc9TD0QJrvMOh6SSpy1Fyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EzBbDdcJpupjPXnQZxcfQxqamwpc9TD0QJrvMOh6SSpy1Fyw@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Jayashree Mohan <jayashree2912@gmail.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Theodore Ts'o <tytso@mit.edu>, Eryu Guan <guaneryu@gmail.com>, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Sun, Oct 21, 2018 at 10:23:06PM -0500, Jayashree Mohan wrote:
> On Sun, Oct 21, 2018 at 9:49 PM Amir Goldstein <amir73il@gmail.com> wrote:
> 
> > Wait, why _scratch_shutdown and not using dm_flakey?
> > Fewer filesystems support _scratch_shutdown and _scratch_shutdown
> > could be buggy and not simulate crash accurately.
> 
> Thanks for this note. I was looking at previous xfstest tests
> (something not very old - generic/468 for eg), and it was using
> scratch_shutdown. Hence I used that as an example. I'll use
> flakey_drop_and_remount while writing up future patches.
> 
> Doesn't this mean the current tests in xfstest suite might miss bugs
> in current/future kernel versions, because some file systems don't
> support it?

scratch_shutdown is testing shutdown behaviour, whatever the cause.
Not all filesystems have a shutdown mechanism - it's a specific set
of operations that the filesystem performs in response to failure
triggers. Some filesystems just go read-only or have other response
mechanisms, which aren't compatible with expected shutdown
behaviour.

And because shutdowns can be caused by things other than IO errors
(which dm-flakey triggers) and so need to be tested /in addition/ to
other types of failures.

> There are many crash-consistency tests in xfstest suite
> that still use _scratch_shutdown.

Yes, because shutdowns can /simulate/ such failures.

> In fact generic/468 is one of the
> test cases that could not run on btrfs because it does not support
> _shutdown.

Yes, but that doesn't stop us from having the test. If btrfs were to
implement a shutdown mechanism, then they'd gain coverage from these
tests too.

> But then this is the exact test case required to reveal a
> bug in btrfs - where you lose allocated blocks beyond the eof on
> fallocate. Just wanted to bring this up, in case you did not notice it

Then add support for shutdowns to btrfs, and it will get test
coverage from these tests. That's not a problem with the test -
that's a filesystem functionality deficiency. i.e. fix the
filesystem, don't change the test.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
