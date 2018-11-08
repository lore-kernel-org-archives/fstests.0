Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:63420 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726133AbeKHTPa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 8 Nov 2018 14:15:30 -0500
Date: Thu, 8 Nov 2018 20:40:45 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] fstest: CrashMonkey tests ported to xfstest
Message-ID: <20181108094045.GB6311@dastard>
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
To: Jayashree Mohan <jayashree2912@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Eryu Guan <guaneryu@gmail.com>, fstests <fstests@vger.kernel.org>, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>, Amir Goldstein <amir73il@gmail.com>, Filipe Manana <fdmanana@gmail.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Nov 07, 2018 at 01:09:22PM +1100, Dave Chinner wrote:
> To put it in other words, developers need tests focussed on finding
> bugs quickly, not regression tests that provide the core
> requirements of integration and release testing. The development
> testing phase is all about finding fast and effciently.

To emphasis my point of having tests and tools capable of finding
new bugs, I noticed yesterday that fstress and fsx didn't support
copy_file_range, and fsx doesn't support clone/dedupe_file_range
either. Darrick added them overnight.

fsx as run by generic/263 takes *32* operations to find a data
corruption with copy_file_range on XFS. Even changing it to do
buffered IO instead of direct IO, it only takes ~600 operations to
fail with a different data corruption.

That's *at least* two previously unknown bugs exposed in under a
second of runtime.

That's the sort of tooling we need - we don't need hundreds of tests
that are scripted reproducers of fixed problems, we need tools that
exercise boundary conditions and corner cases in ways that are
likely to expose incorrect behaviour. Tools that do these things
quickly and in a reproducable manner are worth their weight in
gold...

IMO, Quality Engineering is not just about writing regression tests
to keep out known bugs - it's most important function is developing
and refining new testing tools to find bugs that have escaped
detection with existing testing methods and tools. If test engineers
can find new bugs, software engineers can fix them. That's really
the ultimate goal here - to find bugs and fix them before users are
exposed to them...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
