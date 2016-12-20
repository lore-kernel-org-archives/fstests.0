Received: from mga05.intel.com ([192.55.52.43]:37186 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750927AbcLTRzf (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 20 Dec 2016 12:55:35 -0500
Date: Tue, 20 Dec 2016 10:55:34 -0700
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH] xfstests: fix build warnings and notify_others() bug
Message-ID: <20161220175534.GA26994@linux.intel.com>
References: <1481083441-4809-1-git-send-email-ross.zwisler@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1481083441-4809-1-git-send-email-ross.zwisler@linux.intel.com>
Sender: fstests-owner@vger.kernel.org
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: fstests@vger.kernel.org, Dave Chinner <david@fromorbit.com>, Lukas Czerner <lczerner@redhat.com>, Allison Henderson <achender@vnet.ibm.com>, Christoph Hellwig <hch@lst.de>, Nathan Scott <nathans@sgi.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Dec 06, 2016 at 09:04:01PM -0700, Ross Zwisler wrote:
> This patch addresses the following build warnings:
> 
> fsx.c: In function 'do_punch_hole':
> fsx.c:940:3: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
>    if (!quiet && testcalls > simulatedopcount)
>    ^~
> fsx.c:942:4: note: ...this statement, but the latter is misleadingly indented as if it is guarded by the 'if'
> log4(OP_PUNCH_HOLE, offset, length, FL_SKIPPED);
> ^~~~
> fsx.c:947:3: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
>    if (!quiet && testcalls > simulatedopcount)
>    ^~
> fsx.c:949:4: note: ...this statement, but the latter is misleadingly indented as if it is guarded by the 'if'
> log4(OP_PUNCH_HOLE, offset, length, FL_SKIPPED);
> ^~~~
> fsx.c: In function 'do_zero_range':
> fsx.c:995:3: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
>    if (!quiet && testcalls > simulatedopcount)
>    ^~
> fsx.c:997:4: note: ...this statement, but the latter is misleadingly indented as if it is guarded by the 'if'
> log4(OP_ZERO_RANGE, offset, length, FL_SKIPPED |
> ^~~~
> [CC]    growfiles
> growfiles.c: In function 'notify_others':
> growfiles.c:1458:6: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
>   if ( Forker_pids[ind] != Pid )
>   ^~
> growfiles.c:1462:10: note: ...this statement, but the latter is misleadingly indented as if it is guarded by the 'if'
>   kill(Forker_pids[ind], SIGUSR2);
>   ^~~~
> 
> The warnings in fsx.c were just spacing issues of the form:
> 
> 	if (length == 0) {
> 		if (!quiet && testcalls > simulatedopcount)
> 			prt("skipping zero length punch hole\n");
> 			log4(OP_PUNCH_HOLE, offset, length, FL_SKIPPED);
> 		return;
> 	}
> 
> Where the log4() call just needs to be unindented.  log4() calls elsewhere
> in that same file are not protected with any sort of 'quiet' check, and
> commonly follow prt() calls which are.  See doread(), domapread(), etc.
> 
> The warning from growfiles.c was actually a bug.  notify_others() is
> looping through the Forker_pids[] array and sending SIGUSR2 to all other
> processes.  However, with the current logic it only *logs* the kill for
> other processes, and kills all other processes plus the Forker_pids[] entry
> that matches 'Pid'.
> 
> Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Lukas Czerner <lczerner@redhat.com>
> Cc: Allison Henderson <achender@vnet.ibm.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Nathan Scott <nathans@sgi.com>

Ping on this patch.
