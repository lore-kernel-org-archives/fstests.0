Received: from mail.kernel.org ([198.145.29.99]:55012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfIEKLL (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 5 Sep 2019 06:11:11 -0400
Message-ID: <28a504d5628b1b2ad17086dea79acce13ee85429.camel@kernel.org>
Subject: Re: [RFC PATCH 0/2] Add lease testing
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 05 Sep 2019 06:11:08 -0400
In-Reply-To: <20190903222233.GA31319@iweiny-DESK2.sc.intel.com>
References: <20190903210537.29142-1-ira.weiny@intel.com>
         <20190903214255.GK7777@dread.disaster.area>
         <20190903222233.GA31319@iweiny-DESK2.sc.intel.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Ira Weiny <ira.weiny@intel.com>, Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, john.hubbard@gmail.com, Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Eryu Guan <guaneryu@gmail.com>
List-ID: <fstests@vger.kernel.org>

On Tue, 2019-09-03 at 15:22 -0700, Ira Weiny wrote:
> On Wed, Sep 04, 2019 at 07:42:55AM +1000, Dave Chinner wrote:
> > On Tue, Sep 03, 2019 at 02:05:35PM -0700, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > To get to a point of developing and testing the new Lease semantics for long
> > > term file pins[1], add a simple lease test.
> > 
> > Hi Ira,
> > 
> > Can you co-ordinate with Jeff on this? He just posted a patch
> > to add F_SETLEASE testing with a new binary a few days
> > ago...
> > 
> > https://marc.info/?l=fstests&m=156690934513424&w=2
> 
> Sure.
> 
> Jeff,
> 
> Looking at your submission revealed I was missing 2 tests (shown in the diff
> below).
> 
> Would it be sufficient to add these to this submission and go with my series?
> Or would you prefer using fork vs the socket harness?
> 
> I think we may need a fork in the server side of my tests to work on duplicated
> FD's but right now I have more tests than you.
> 
> Let me know, Thanks,
> Ira
> 
> commit 849633871b7c0b00a6ee2bb751c09cd6365da386 (lease-test-b0-v3)
> Author: Ira Weiny <ira.weiny@intel.com>
> Date:   Tue Sep 3 15:17:52 2019 -0700
> 
>     src/leasetest: Add tests to match competing test
>     
>     A competing patch to test leases was submitted in parallel.[1]
>     
>     This adds tests which were covered in that patch set.
>     
>     [1] https://marc.info/?l=fstests&m=156690934513424&w=2
>     
>     Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> diff --git a/src/leasetest.c b/src/leasetest.c
> index b30a4d05d039..729aca851493 100644
> --- a/src/leasetest.c
> +++ b/src/leasetest.c
> @@ -137,6 +137,8 @@ char *descriptions[] = {
>      /*  4 */"Fail Read Lease if opened with write permissions",
>      /*  5 */"Read lease gets SIGIO on write open",
>      /*  6 */"Write lease gets SIGIO on read open",
> +    /*  7 */"No SIGIO is sent with read lock on read open",
> +    /*  8 */"Read lease gets SIGIO on write open",
>  };
>  
>  static int64_t tests[][5] =
> @@ -195,6 +197,26 @@ static int64_t tests[][5] =
>                 {6,     CMD_CLOSE,      0,              PASS,           SERVER  },
>                 {6,     CMD_CLOSE,      0,              PASS,           CLIENT  },
>  
> +       /* Don't get SIGIO when read lease is taken by read */
> +               {7,     CMD_OPEN,       O_RDONLY,       PASS,           CLIENT  },
> +               {7,     CMD_SETLEASE,   F_RDLCK,        PASS,           CLIENT  },
> +               {7,     CMD_GETLEASE,   F_RDLCK,        PASS,           CLIENT  },
> +               {7,     CMD_SIGIO,      0,              PASS,           CLIENT  },
> +               {7,     CMD_OPEN,       O_RDONLY,       PASS,           SERVER  },
> +               {7,     CMD_WAIT_SIGIO, 5,              FAIL,           CLIENT  },
> +               {7,     CMD_CLOSE,      0,              PASS,           SERVER  },
> +               {7,     CMD_CLOSE,      0,              PASS,           CLIENT  },
> +
> +       /* Get SIGIO when Read lease is broken by Write */
> +               {8,     CMD_OPEN,       O_RDONLY,       PASS,           CLIENT  },
> +               {8,     CMD_SETLEASE,   F_RDLCK,        PASS,           CLIENT  },
> +               {8,     CMD_GETLEASE,   F_RDLCK,        PASS,           CLIENT  },
> +               {8,     CMD_SIGIO,      0,              PASS,           CLIENT  },
> +               {8,     CMD_OPEN,       O_RDWR,         PASS,           SERVER  },
> +               {8,     CMD_WAIT_SIGIO, 5,              PASS,           CLIENT  },
> +               {8,     CMD_CLOSE,      0,              PASS,           SERVER  },
> +               {8,     CMD_CLOSE,      0,              PASS,           CLIENT  },
> +
>         /* indicate end of array */
>         /* Must have an end for the SERVER and one for the CLIENT */
>                 {0,0,0,0,SERVER},

Hi Ira,

Let's go with your testcase, including the patch above. It's more
comprehensive than the one I proposed, and should be easier to extend in
the future.

Acked-by: Jeff Layton <jlayton@kernel.org>
