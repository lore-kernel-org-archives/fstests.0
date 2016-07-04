Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:14170 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932249AbcGDBkp (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 3 Jul 2016 21:40:45 -0400
Date: Mon, 4 Jul 2016 11:40:40 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 1/2] xfstests: Fix installation for extended names
Message-ID: <20160704014040.GA27480@dastard>
References: <1467389347-2055-1-git-send-email-jtulak@redhat.com>
 <1467389347-2055-2-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1467389347-2055-2-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

On Fri, Jul 01, 2016 at 06:09:06PM +0200, Jan Tulak wrote:
> xfstests supports extended test names like 314-foo-bar, but installation of
> these tests was skipped (not matching a regexp). So this patch fixes the
> makefiles in tests/*/
> 
> Signed-off-by: Jan Tulak <jtulak@redhat.com>
> ---
> UPDATE:
> Rewritten, now it doesn't fail without the extended name, and doesn't
> suppress anything. Thanks Dave.
> ---
>  tests/btrfs/Makefile   | 21 +++++++++++++++++----
>  tests/cifs/Makefile    | 21 +++++++++++++++++----
>  tests/ext4/Makefile    | 21 +++++++++++++++++----
>  tests/f2fs/Makefile    | 24 ++++++++++++++++++------
>  tests/generic/Makefile | 21 +++++++++++++++++----
>  tests/overlay/Makefile | 23 ++++++++++++++++++-----
>  tests/shared/Makefile  | 21 +++++++++++++++++----
>  tests/udf/Makefile     | 21 +++++++++++++++++----
>  tests/xfs/Makefile     | 21 +++++++++++++++++----
>  9 files changed, 155 insertions(+), 39 deletions(-)
> 
> diff --git a/tests/btrfs/Makefile b/tests/btrfs/Makefile
> index e1a5be1..0301d78 100644
> --- a/tests/btrfs/Makefile
> +++ b/tests/btrfs/Makefile
> @@ -5,16 +5,29 @@
>  TOPDIR = ../..
>  include $(TOPDIR)/include/builddefs
>  
> -BTRFS_DIR = btrfs
> -TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(BTRFS_DIR)
> +GROUP_DIR = btrfs
> +TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(GROUP_DIR)

What's this change for?

Please don't make random undocumented changes when updating a
patchset. It is best not to change anything unrelated to the problem
being solved.


>  include $(BUILDRULES)
>  
> +# note: the second TESTS wildcard gets also .out files, but these will be
> +# overwritten with correct permissions a moment later, as they are also in
> +# OUTPUTS. Regexps here are really limited, so I didn't find a better
> +# solution...
> +TESTS = $(wildcard [0-9][0-9][0-9])
> +TESTS += $(wildcard [0-9][0-9][0-9]-*)

Ugh. The hacks need to be constrained to the makefile and not do
nasty things with installed files. 

What I think should be done here is to turn the selection around the
other way because we can select the output files directly and
correctly. We can then use that to build the test list via stripping
and filtering as all tests must have an output file associated with
them.

So:

# Start with all test related files:
ALLFILES = $(wildcard [0-9]??*)

# Now build a list of known output files.  Unfortunately, the
# multiple output test files are poorly handled as makefiles don't
# handle wildcarded multi-suffix matching. Hence we separate the
# processing of these right now.
EXTENDED_OUTFILES = $(wildcard [0-9]??*.out.*)
BASIC_OUTFILES = $(wildcard [0-9]??*.out)
OUTFILES = $(EXTENDED_OUTFILES) $(BASIC_OUTFILES)

# Strip suffix to get matching tests. We want to strip from the
# first "." to the end, but makefiles don't have a built in
# operative for that. So:
#
# Hack: strip the multiple segments after .out with repeated basename calls.
EXTFILTER1 = $(basename $(EXTENDED_OUTFILES))
EXTFILTER2 = $(basename $(EXTFILTER1))
EXTFILTER3 = $(basename $(EXTFILTER2))
EXTFILTER4 = $(basename $(EXTFILTER3))

# final filter list
FILTER = $(basename $(EXTFILTER4) $(BASIC_OUTFILES)) 

# finally, select the test files by filtering against against the
# stripped output files and sort them to remove duplicates.
TESTS = $(sort $(filter $(ALLFILES), $(FILTER)))

That will give you two lists - "OUTFILES" which are all the output
files that need to be installed, and "TESTS" which are all the tests
that should be installed. There will be no overlap between these two
lists.

I'd also suggest that this can probably be put in the BUILDRULES
file, as it will be common to all makefiles and doesn't need to be
repeated in every makefile.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
