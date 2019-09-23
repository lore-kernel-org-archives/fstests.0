Received: from mga02.intel.com ([134.134.136.20]:34382 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438062AbfIWR6N (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 23 Sep 2019 13:58:13 -0400
Date: Mon, 23 Sep 2019 10:58:12 -0700
From: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH V2 00/16] Fix locktest and add lease testing to it
Message-ID: <20190923175812.GA32754@iweiny-DESK2.sc.intel.com>
References: <20190923175204.2139-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923175204.2139-1-ira.weiny@intel.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>
Cc: john.hubbard@gmail.com, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>, dan.j.williams@intel.com, Jeff Layton <jlayton@kernel.org>
List-ID: <fstests@vger.kernel.org>

My apologies...  git-send-email seems to be hanging after sending most of
these patches...  :-/

Not sure why.  But it has done it again.  I'm probably going to send the last 2
over.  This series can be ignored....

Very sorry,
Ira

On Mon, Sep 23, 2019 at 10:51:48AM -0700, 'Ira Weiny' wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Add lease tests[1] to locktest because they share so much code.  Make running
> of lease tests separate as an '-L' option.
> 
> To make things cleaner update the lock test code and test script.  This
> includes fixing a rather serious bug.                                                                                                                 
> 
> Finally update the error output to help identify any steps which fail during
> testing.                                                                                                                                              
> 
> Changes from V1:
> 	Create a new option '-L' to run lease testing
> 	Created 568 test script which shared common code with 131
> 	Moved 2 patches earlier in the series
> 		[PATCH V2 09/16] src/locktest: Clean up error output
> 		[PATCH V2 10/16] src/locktest: Audit all debug output
> 	Added 3 patches
> 		[PATCH V2 11/16] src/locktest: Add run() function
> 		[PATCH V2 15/16] common/locktest: Add common locktest functions
> 		[PATCH V2 16/16] generic/568: Add lease testing
> 
> Ira Weiny (16):
>   src/locktest: Remove unnecessary sleep
>   src/locktest: Remove OPEN macro
>   src/locktest: Change command macro names
>   src/locktest: Add get_cmd_str
>   src/locktest.c: Clean up client command passing
>   src/locktest.c: Fix return code if last test fails
>   generic/131: Clean up pid variables
>   generic/131: Save stderr for debugging
>   src/locktest: Clean up error output
>   src/locktest: Audit all debug output
>   src/locktest: Add run() function
>   src/locktest: Add simple lease testing
>   src/locktest: Add lease testing for basic signal reception
>   src/locktest: Add truncate lease tests
>   common/locktest: Add common locktest functions
>   generic/568: Add lease testing
> 
>  common/locktest       |  95 ++++
>  src/locktest.c        | 999 +++++++++++++++++++++++++++---------------
>  tests/generic/131     |  54 +--
>  tests/generic/568     |  32 ++
>  tests/generic/568.out |   2 +
>  tests/generic/group   |   1 +
>  6 files changed, 786 insertions(+), 397 deletions(-)
>  create mode 100644 common/locktest
>  create mode 100755 tests/generic/568
>  create mode 100644 tests/generic/568.out
> 
> -- 
> 2.20.1
> 
