Received: from ipmail03.adl6.internode.on.net ([150.101.137.143]:18119 "EHLO
        ipmail03.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752385AbeF0HmW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Jun 2018 03:42:22 -0400
Date: Wed, 27 Jun 2018 17:42:19 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfstests: fix install target using sudo
Message-ID: <20180627074219.GK13748@dastard>
References: <20180626210834.24220-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626210834.24220-1-mcgrof@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jun 26, 2018 at 02:08:34PM -0700, Luis R. Rodriguez wrote:
> If you install with:
> 
> 	sudo make install
> 
> Depending on the system, you may see /var/lib/xfstests/tests/ is empty.
> This is because $(PWD) can expand to be empty on certain systems and so the
> wildcard finds nothing.

When and why?

I'm guessing it's because the environment variable PWD is not
exported by the shell that make is being run in?  /bin/sh, /bin/bash
and /bin/dash should always set PWD in the environment, so maybe
you're using a different shell that doesn't set PWD correctly?

> PWD is only used on one target, the tests/*/ dir install target.
> 
> We can fix this by using $(CURDIR) however that does not suffice as we
> are also using the $(wildcard) and that needs its own careful expansion.

$(CURDIR) is documented as an being the current absolute path, so
AFAICT there's nothing to be careful about in terms of expansion.
What are you trying to avoid here?

> This issue is observed on both Fedora and OpenSUSE, but not on Debian.

This really smells more of a shell/environment issue, not a distro
issue.

> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> ---
>  tests/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/Makefile b/tests/Makefile
> index 2611b3b845f5..084135da0487 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -5,7 +5,8 @@
>  TOPDIR = ..
>  include $(TOPDIR)/include/builddefs
>  
> -TESTS_SUBDIRS = $(sort $(dir $(wildcard $(PWD)/$(TESTS_DIR)/[a-z]*/)))
> +TEST_DIR = $(dir $(CURDIR)/$(TESTS_DIR))

I think this is wrong - you're creating an invalid path:

curdir/tests_dir is /home/dave/src/xfstests-dev/tests/tests
dir curdir/tests_dir is /home/dave/src/xfstests-dev/tests/

then using $(dir <path>) command to truncate away the invalid
path segment, resulting in the original path $(CURDIR) gave you.

In fact, $(CURDIR) is basically what the current code intends - I
didn't know this existed because it's not obviously searchable (i.e.
not a CWD or PWD variant) so I hacked around it with environment
variables.

So AFAICT, the change the needs to be made here is:

-TESTS_SUBDIRS = $(sort $(dir $(wildcard $(PWD)/$(TESTS_DIR)/[a-z]*/)))
+TESTS_SUBDIRS = $(sort $(dir $(wildcard $(CURDIR)/[a-z]*/)))

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
