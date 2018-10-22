Received: from mail-wr1-f67.google.com ([209.85.221.67]:41181 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbeJVLkA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 22 Oct 2018 07:40:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id q7-v6so15351717wrr.8
        for <fstests@vger.kernel.org>; Sun, 21 Oct 2018 20:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <CA+EzBbDZ5QZPqbgicY6Ar=uroM9a0-7b8PyUBdwYGMwXgBEanw@mail.gmail.com>
 <20181021104525.GS17817@desktop> <CA+EzBbCd2zZ9sNW-dgyPyR5FH-HK5LArG6y+bPOCJ3Wqyp5=Ug@mail.gmail.com>
 <20181021222111.GH1617@thunk.org> <CA+EzBbB7GA8PZ1xHag0fTWst5cYMUngTmsjUeWemvKOvJ5B8yQ@mail.gmail.com>
 <20181022020539.GR6311@dastard> <CA+EzBbBBicj8qDAtEsjo-8Vys_K_JAF5HP75D5dOvgSMb-CZDQ@mail.gmail.com>
 <CAOQ4uxj6rZ_efkYXoj4T0E0DDomaEZ-OPTcC0zju4U_QyG-a6Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxj6rZ_efkYXoj4T0E0DDomaEZ-OPTcC0zju4U_QyG-a6Q@mail.gmail.com>
From: Jayashree Mohan <jayashree2912@gmail.com>
Date: Sun, 21 Oct 2018 22:23:06 -0500
Message-ID: <CA+EzBbDdcJpupjPXnQZxcfQxqamwpc9TD0QJrvMOh6SSpy1Fyw@mail.gmail.com>
Subject: Re: Submitting patches to xfstests based on OSDI '18 paper (CrashMonkey)
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>, Theodore Ts'o <tytso@mit.edu>, Eryu Guan <guaneryu@gmail.com>, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Sun, Oct 21, 2018 at 9:49 PM Amir Goldstein <amir73il@gmail.com> wrote:

> Wait, why _scratch_shutdown and not using dm_flakey?
> Fewer filesystems support _scratch_shutdown and _scratch_shutdown
> could be buggy and not simulate crash accurately.

Thanks for this note. I was looking at previous xfstest tests
(something not very old - generic/468 for eg), and it was using
scratch_shutdown. Hence I used that as an example. I'll use
flakey_drop_and_remount while writing up future patches.

Doesn't this mean the current tests in xfstest suite might miss bugs
in current/future kernel versions, because some file systems don't
support it? There are many crash-consistency tests in xfstest suite
that still use _scratch_shutdown. In fact generic/468 is one of the
test cases that could not run on btrfs because it does not support
_shutdown. But then this is the exact test case required to reveal a
bug in btrfs - where you lose allocated blocks beyond the eof on
fallocate. Just wanted to bring this up, in case you did not notice it
:)

Thanks,
Jayashree
