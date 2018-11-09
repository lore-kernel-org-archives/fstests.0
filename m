Received: from imap.thunk.org ([74.207.234.97]:33560 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727961AbeKJE7E (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 9 Nov 2018 23:59:04 -0500
Date: Fri, 9 Nov 2018 14:17:04 -0500
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] fstest: CrashMonkey tests ported to xfstest
Message-ID: <20181109191704.GE21078@thunk.org>
References: <20181105052217.GT6311@dastard>
 <46630C6B-77FA-4D15-92E7-43B89AD889A0@gmail.com>
 <20181106231536.GB8691@thunk.org>
 <20181106233956.GX6311@dastard>
 <CA+EzBbDwdi26MCswz0iQ8hUTcGixATUXayxMOmEw5gekYvmMuw@mail.gmail.com>
 <20181107020922.GY6311@dastard>
 <20181108094045.GB6311@dastard>
 <CAHWVdUXSCo1UjGG+TL9SBq5KXOMszVP86E2od1RXqKfcwcYXvA@mail.gmail.com>
 <20181109031205.GC6311@dastard>
 <CAHWVdUXUtY+e-yuTzwV-E-2kvkg0YeNqxiK01pEJOuLBnWWtAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHWVdUXUtY+e-yuTzwV-E-2kvkg0YeNqxiK01pEJOuLBnWWtAw@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>
Cc: Dave Chinner <david@fromorbit.com>, Jayashree Mohan <jayashree2912@gmail.com>, Eryu Guan <guaneryu@gmail.com>, fstests <fstests@vger.kernel.org>, Amir Goldstein <amir73il@gmail.com>, Filipe Manana <fdmanana@gmail.com>
List-ID: <fstests@vger.kernel.org>

How about creating a group "regress", and we can move them into
tests/regress for better categorization, for regression tests?

And for tests that attempt find new problems, we already have a group
"fuzzers"; and perhaps there should be a some standard guieline for
how long a single invocation of a fuzz test should run before
quitting.  I'd say something in the 5 to 15 minute range?  People can
always run the fuzz test multiple times, and if the fuzz test can save
test between runs, it should matter that it's broken up into multiple
test invocations.

					- Ted
