Received: from imap.thunk.org ([74.207.234.97]:54748 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbeKIBrJ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 8 Nov 2018 20:47:09 -0500
Date: Thu, 8 Nov 2018 11:10:53 -0500
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] fstest: CrashMonkey tests ported to xfstest
Message-ID: <20181108161053.GB1080@thunk.org>
References: <CA+EzBbB5t5bSZ0hB6Y1jkxTgOLOv809Jbbcx7w5eK_XS_FPG7w@mail.gmail.com>
 <20181104163826.GH12788@desktop>
 <1B22AFA2-FAF3-45AA-9910-CDBE4AEBFB09@gmail.com>
 <20181105052217.GT6311@dastard>
 <46630C6B-77FA-4D15-92E7-43B89AD889A0@gmail.com>
 <20181106231536.GB8691@thunk.org>
 <20181106233956.GX6311@dastard>
 <CA+EzBbDwdi26MCswz0iQ8hUTcGixATUXayxMOmEw5gekYvmMuw@mail.gmail.com>
 <20181107020922.GY6311@dastard>
 <20181108094045.GB6311@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108094045.GB6311@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Jayashree Mohan <jayashree2912@gmail.com>, Eryu Guan <guaneryu@gmail.com>, fstests <fstests@vger.kernel.org>, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>, Amir Goldstein <amir73il@gmail.com>, Filipe Manana <fdmanana@gmail.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Nov 08, 2018 at 08:40:45PM +1100, Dave Chinner wrote:
> IMO, Quality Engineering is not just about writing regression tests
> to keep out known bugs - it's most important function is developing
> and refining new testing tools to find bugs that have escaped
> detection with existing testing methods and tools. If test engineers
> can find new bugs, software engineers can fix them. That's really
> the ultimate goal here - to find bugs and fix them before users are
> exposed to them...

How about creating a new group, "regression"?  Regression tests are
not useless, but we might want to reserve them for integration
testing, periodic tests, and distro testing of "golden masters" where
test run is not of essence.

For smoke testing, what we want are general functional tests, and
"moderate" stress tests.  Regression tests are a distant third
priority.  So assigning regression tests to distinct group so we can
filter them out might be another way of controlling the runtime of a
smoke test config.

					- Ted
