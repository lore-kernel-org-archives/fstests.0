Received: from mail.kernel.org ([198.145.29.99]:55042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfITNMO (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 20 Sep 2019 09:12:14 -0400
Message-ID: <ce1e299cee340dcb3f6c6446392f186b95492547.camel@kernel.org>
Subject: Re: [PATCH 00/13] Fix locktest and add lease testing to it
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 20 Sep 2019 09:12:11 -0400
In-Reply-To: <20190918041558.2621-1-ira.weiny@intel.com>
References: <20190918041558.2621-1-ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: ira.weiny@intel.com, fstests@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>
Cc: john.hubbard@gmail.com, Dave Chinner <david@fromorbit.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>, dan.j.williams@intel.com
List-ID: <fstests@vger.kernel.org>

On Tue, 2019-09-17 at 21:15 -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Rather than have a separate lease test, combine the previously proposed lease
> tests[1] directly to locktest because they share so much code.
> 
> To make things cleaner update the lock test code and test script.  This
> includes fixing a rather serious bug.
> 
> Finally update the error output to help identify any steps which fail during
> testing.
> 
> Ira
> 
> [1] https://www.spinics.net/lists/fstests/msg12467.html
> 
> Ira Weiny (13):
>   src/locktest: Remove unnecessary sleep
>   src/locktest: Remove OPEN macro
>   src/locktest: Change command macro names
>   src/locktest: Add get_cmd_str
>   src/locktest.c: Clean up client command passing
>   src/locktest.c: Fix return code if last test fails
>   generic/131: Clean up pid variables
>   generic/131: Save stderr for debugging
>   src/locktest: Add simple lease testing
>   src/locktest: Add lease testing for basic signal reception
>   src/locktest: Add truncate lease tests
>   src/locktest: Clean up error output
>   src/locktest: Audit all debug output
> 
>  src/locktest.c    | 957 ++++++++++++++++++++++++++++++----------------
>  tests/generic/131 |  72 ++--
>  2 files changed, 666 insertions(+), 363 deletions(-)
> 

Nice work, Ira. This all looks like good cleanup (and at least one
important bugfix).

Reviewed-by: Jeff Layton <jlayton@kernel.org>
