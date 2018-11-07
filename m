Received: from imap.thunk.org ([74.207.234.97]:47112 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbeKGNdJ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 7 Nov 2018 08:33:09 -0500
Date: Tue, 6 Nov 2018 23:04:29 -0500
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] fstest: CrashMonkey tests ported to xfstest
Message-ID: <20181107040429.GA13539@thunk.org>
References: <CA+EzBbB5t5bSZ0hB6Y1jkxTgOLOv809Jbbcx7w5eK_XS_FPG7w@mail.gmail.com>
 <20181104163826.GH12788@desktop>
 <1B22AFA2-FAF3-45AA-9910-CDBE4AEBFB09@gmail.com>
 <20181105052217.GT6311@dastard>
 <46630C6B-77FA-4D15-92E7-43B89AD889A0@gmail.com>
 <20181106231536.GB8691@thunk.org>
 <20181106233956.GX6311@dastard>
 <CA+EzBbDwdi26MCswz0iQ8hUTcGixATUXayxMOmEw5gekYvmMuw@mail.gmail.com>
 <20181107020922.GY6311@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107020922.GY6311@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Jayashree Mohan <jayashree2912@gmail.com>, Eryu Guan <guaneryu@gmail.com>, fstests <fstests@vger.kernel.org>, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>, Amir Goldstein <amir73il@gmail.com>, Filipe Manana <fdmanana@gmail.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Nov 07, 2018 at 01:09:22PM +1100, Dave Chinner wrote:
> > Running on a 200MB partition, addition of this check added only around 3-4
> > seconds of delay in total for this patch consisting of 37 tests. Currently
> > this patch takes about 12-15 seconds to run to completion on my 200MB
> > partition.
> 
> What filesystem, and what about 20GB scratch partitions (which are
> common)?  i.e. Checking cost is different on different filesystems,
> different capacity devices and even different userspace versions of
> the same filesystem utilities. It is most definitely not free, and
> in some cases can be prohibitively expensive.

For the CrashMonkey tests, one solution might be to force the use of a
small file system on the scratch disk.  (e.g., using _scratch_mkfs_sized).

> I suspect we've lost sight of the fact that fstests was /primarily/h
> a filesystem developer test suite, not a distro regression test
> suite. If the test suite becomes too cumbersome and slow for
> developers to use effectively, then it will get used less during
> development and that's a *really, really bad outcome*.

I agree with your concern.

> It even takes half an hour to run the quick group on my fast
> machine, which really isn't very quick anymore because of the sheer
> number of tests in the quick group.  Half an hour is too slow for
> effective change feed back - feedback within 5 minutes is
> necessary, otherwise the developer will context switch to somethingt
> else while waiting and lose all focus on what they were doing. This
> leads to highly inefficient developers.

At Google we were willing to live with a 10 minute "fssmoke" subset,
but admittedly, that's grown to 15-20 minutes in recent years.  So
trying to create a "smoke" group that is only 5 minutes SGTM.

> The only tests that I've seen discover new bugs recently are those
> that run fsx, fstress or some other semi-randomised workloads that
> are combined with some other operation. These tests find the bugs
> that fine-grained, targetted regression tests will never uncover,
> and so in many cases running most of these integration/regression
> tests doesn't provide any value to the developer.

Yeah, what I used to do is assume that if the test run survives past
generic/013 (which uses fsstress), I'd assume that it would pass the
rest of the tests, and I would move on to reviewing the next commit.
Unfortuantely we've added so many ext4 specific tests (which run in
front of generic) that this trick no longer works.  I haven't gotten
annoyed enough to hack in some way to reorder the tests that get run
so the highest value tests run first, and then sending a "90+% chance
the commit is good, running the rest of the tests" message, but it has
occurred to me....

> Perhaps we need to recategorise the tests into new groups.

Agreed.  Either we need to change what tests we leave in "quick", or
we need to create a new group "smoke" where quick is an attribute of
the group as a whole, not an attribute of each test in the "quick"
group.

> Perhaps we need to scale the fstests infrastructure to support
> thousands of tests efficiently.

On my "when I find the round tuit, or when I can get a GSOC or intern
to work on it, whichever comes first" list is to enhance gce-xfstests
so it can shard the tests for a particular fs configuration so they
use a group of a VMs, instead of just using a separate VM for each
config scenario (e.g., dax, blocksize < page size, bigalloc, ext3
compat, etc.)

It might mean using ~100 VM's instead of the current 10 that I use,
but if it means the tests complete in a tenth of the time, the total
cost for doing a full integration test won't change by that much.  The
bigger problem is that people might have to ask permission to increase
the GCE quotas from the defaults used on new accounts.

For those people who are trying to run xfstests on bare metal, I'm not
sure there's that much that can be done to improve things; did you
have some ideas?  Or were you assuming that step one would require
buying many more physical test machines in your test cluster?

(Maybe IBM will be willing to give you a much bigger test machine
budget?  :-)

							- Ted
