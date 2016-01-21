Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:49356 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756216AbcAUF6G (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 21 Jan 2016 00:58:06 -0500
Date: Thu, 21 Jan 2016 16:58:03 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [RFC PATCH] fstests: add known issue support
Message-ID: <20160121055803.GG20456@dastard>
References: <1453350570-25862-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1453350570-25862-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jan 21, 2016 at 12:29:30PM +0800, Eryu Guan wrote:
> Add known issue support so it's easier to know if a failure is a known
> issue or a new one (and potential regression), and mark the whole test
> as failure (check returns non-zero) only when there're unknown failures.
> 
> A new $KNOWNISSUE_DIR dir is introduced (default to `pwd`/knownissue),
> and common known issues across filesystems/arches/configs can be listed
> in $KNOWNISSUE_DIR/generic and $KNOWNISSUE_DIR/$FSTYP, they are the
> default known issue files.
> 
> When testing with section in config, an additional section-specific
> known issue file is processed, $KNOWNISSUE_DIR/$section_name, all known
> failures for this specific config can be listed here.
> 
> A new "-k" option to check is added, it's used to specify user-provided
> known issue file rather than the default files. When "-k" is used, only
> the known issues in this file are processed, $KNOWNISSUE_DIR/{generic,
> $FSTYP, $section_name} are ignored.
> 
> The format of the known issue file is:
>  # comments are starting with '#'
>  # first column is test name
>  # second column indicates if the test should be skipped, yes to skip
>  # the third column is the note about this failure
>  # test name	skip?	comments
>  generic/001	no	triggers WARNING ...
>  generic/002	yes	crash kernel, skip, patch xxx should fix it
>  ...
> 
> After test, test summary is printed, e.g.
> 
> 	Ran: ext4/005 generic/001 generic/018
> 	Failures: ext4/005 generic/018
> 	Failed 2 of 3 tests
> 	Known failures: ext4/005
> 	1 of 2 failed tests are known failures
> 	Unknown failures: generic/018
> 	1 of 2 failed tests are unknown failures
> 
> Examples:
>  # run specific section with user provided known issue file
>  ./check -g auto -s ext4_1k_data_journal -k /path/to/known_issue_file

As I've just said to Ted in a separate thread on the ext4 list: if
you need to exclude tests for a given test environment because you
already know they fail then custom expunge files will provide that
functionality.

Known issues are not a property of a test or even a config section;
they are a result of the environment xfstests is being run in.
Things like the hardware (memory, number of CPUs, disk space
available, etc) impact on various tests just as much as mkfs and
mount options or utility program support.

IOWs, these "known issue files" need to be maintained and managed by
the external environment, not the xfstests harness.  The only thing
the environment actually needs from the xfstests harness is control
of whether a test should be run or not, and the expunge files
already provide that. Really, check is not the place to do determine
if a failure is expected or not.

That said, it would be good to have tools in xfstests capable of
archiving and parsing historic results directories to extract
regular failures and correlate them across different machines and
environments, but this functionality would not be part of the main
harness itself.

i.e. The "known/unknown failure" parsing of the result output does
not need to be done by check in xfstests; it should be done by a
post-processing script that walks over the latest results file in
$RESULTDIR, which also need to be archived so that determination of
whether a test failure is common, random, only shows up in certain
configurations, etc can be done to feed back into the environments
known issue files.

The intent of having a configurable results directory was to enable
this sort of reporting/post-processing infrastructure to be easily
layered on top of xfstests.

So, rather than trying to overload the check output harder to parse
for some users, think about what scripts need to be added to the
tools/ directory to make each ./check execution record into a
different results directory, how we might be able to summarise those
results into a concise archive (potentially on a remote machine) and
what post-processing we can do on such archives to provide
meaningful information.

For example:

	- "ext4/005 is a new failure"
	- "ext4/005 passed, was a long term failure, maybe fixed?"
	- "ext4/005 only fails when "-b size=1024" is set"
	- "ext4/005 only fails on machine test324.lab03.foo."

With such a database of information, we don't need to manually
create and track known issues in a bunch of files somewhere;
the information is queriable, and can be used to generate
exclude files during post porcessing for specific environments that
we can then pass to ./check on their next run..

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
