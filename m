Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39819 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727025AbfGCDej (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 2 Jul 2019 23:34:39 -0400
Date: Tue, 2 Jul 2019 23:34:29 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] generic/042: add sleep before shutdown
Message-ID: <20190703033429.GA19593@mit.edu>
References: <1562117471-2376-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562117471-2376-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jul 03, 2019 at 09:31:11AM +0800, Yang Xu wrote:
> On some server machines, the memory was so big that we
> don't have enough time to submit file.  After umoumt,
> hexdump will report no such file or directory on ext4.

Um, so this is passing for me using ext4.  The file system is getting
shutdown via "./src/godown -f $mnt".  The -f causes the shutdown file
system to be called with the LOGFLUSH flag set.  This causes a forced
journal commit before the file system is shut down, so how much memory
the system might have should be irrelvant.

The only thing I can think of is if the journal was not enabled, but
generic/042 calls _require_metadata_journalling, and so the test will
be skipped if the file system was created without a journal or if the
noload mount option is passed as part of the test config.

Can you say a little bit more about your test configuration and test
environment?  This test really shouldn't be needing your patch;
sleeping for ten seconds should *not* be making a difference as to
whether or not the file exists for hexdump to test.  And to the extent
that the test is trying to find race conditions, adding a sleep 10
defeats the purpose of the test.

				- Ted
