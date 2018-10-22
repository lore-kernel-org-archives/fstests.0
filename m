Received: from imap.thunk.org ([74.207.234.97]:43582 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727546AbeJVPbz (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 22 Oct 2018 11:31:55 -0400
Date: Mon, 22 Oct 2018 03:14:31 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: Submitting patches to xfstests based on OSDI '18 paper
 (CrashMonkey)
Message-ID: <20181022071431.GL1617@thunk.org>
References: <CA+EzBbDZ5QZPqbgicY6Ar=uroM9a0-7b8PyUBdwYGMwXgBEanw@mail.gmail.com>
 <20181021104525.GS17817@desktop>
 <CA+EzBbCd2zZ9sNW-dgyPyR5FH-HK5LArG6y+bPOCJ3Wqyp5=Ug@mail.gmail.com>
 <20181021222111.GH1617@thunk.org>
 <CA+EzBbB7GA8PZ1xHag0fTWst5cYMUngTmsjUeWemvKOvJ5B8yQ@mail.gmail.com>
 <20181022020539.GR6311@dastard>
 <CA+EzBbBBicj8qDAtEsjo-8Vys_K_JAF5HP75D5dOvgSMb-CZDQ@mail.gmail.com>
 <CAOQ4uxj6rZ_efkYXoj4T0E0DDomaEZ-OPTcC0zju4U_QyG-a6Q@mail.gmail.com>
 <CA+EzBbDdcJpupjPXnQZxcfQxqamwpc9TD0QJrvMOh6SSpy1Fyw@mail.gmail.com>
 <20181022040231.GN18822@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022040231.GN18822@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Jayashree Mohan <jayashree2912@gmail.com>, Amir Goldstein <amir73il@gmail.com>, Eryu Guan <guaneryu@gmail.com>, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Mon, Oct 22, 2018 at 03:02:31PM +1100, Dave Chinner wrote:
> scratch_shutdown is testing shutdown behaviour, whatever the cause.
> Not all filesystems have a shutdown mechanism - it's a specific set
> of operations that the filesystem performs in response to failure
> triggers. Some filesystems just go read-only or have other response
> mechanisms, which aren't compatible with expectetd shutdown
> behaviour.

What Dave said.

I'll note that at the moment ext4 passes dm_flakey power cut tests
reliably, which is *different* from the tests which use the
FS_IOC_SHUTDOWN ioctl.  At the moment ext4, fails FS_IOC_SHUTDOWN
tests around 3% -- 5% of the time --- which is why generic/388, which
repeatedly mounts and call FS_IOC_SHUTDOWN 30 times, is a flaky
(sorry) test for ext4.

So for the crashmonkey tests, if you are specifically trying to test
what happens on a power cut, you need to be using dm_flakey, and not
FS_IOC_SHUTDOWN.  Testing what happens on FS_IOC_SHUTDOWN would also
be useful, but it's a different thing.  (And at least for ext4, I know
what the problems are with ext4's FS_IOC_SHUTDOWN support; the
challenge is how to fix it without imposing a performance regression,
and since FS_IOC_SHUTDOWN is rarely used in production[1], it's been
low priority for me to fix.)

						- Ted

[1] Actually, Google does use FS_IOC_SHUTDOWN in production, but only
for scratch iSCSI volumes which have already disappeared and so we
don't care if the underlying file system might get corrupted, since
the whole point is to forcibly detach the failed iSCSI device while
keeping the iSCSI client system running.  (And since it's a scratch
volume, it's mounted with the journal disabled, which means on
shutdown, even we cared about the state of the scratch volume after
shutdown, by in no journal mode there are no guarantees about file
system consistency after a shutdown or power cut anyway.)
