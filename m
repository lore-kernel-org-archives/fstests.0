Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:42422 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750759AbaKSXIe (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 19 Nov 2014 18:08:34 -0500
Date: Thu, 20 Nov 2014 10:06:28 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 1/7] Create environment setup files
Message-ID: <20141119230628.GA27262@dastard>
References: <1415971667-16873-1-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1415971667-16873-1-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Jan =?utf-8?B?xaR1bMOhaw==?= <jtulak@redhat.com>
Cc: fstests@vger.kernel.org, lczerner@redhat.com
List-ID: <fstests@vger.kernel.org>

On Fri, Nov 14, 2014 at 02:27:41PM +0100, Jan Ťulák wrote:
> First from a batch of patches for adding an environment support.  This
> description is rather long, as it describes the goal of all set, so a
> TLDR version at first:
> 
> - Allows to separate preparation of the environment (full fs,
>   damaged fs, ...) from a test itself. So multiple tests can use
>   exactly the same conditions.
> - A single test can be run in multiple environments.
> - Disabled by default for backward compatibility (it changes output).
> - I expect it will cause some debate. It is my first bigger patch
>   at all. :-)

I've had a bit of a look at the patchset. Very interesting but will
need a bit of work.

Seeing as this is your first major patchset, a few hints on how to
structure a large patchset to make it easier for reviewers to read:

	- this overall description belongs in a "patch 0" header

	- put simple, obvious fixes and refactoring patches first

	- don't add things before they are used (e.g. the dummy
	  files in the first patch) because reviewers can't see how
	  they fit into the overall picture until they've applied
	  later patches.

	- it's better to have actual functionality rather than dummy
	  place holders and templates. The code will change
	  significantly as you start to make actual use of it and
	  you solve all the problems a dummy or template don't
	  expose.

	- separate out new chunks of functionality into new files
	  e.g. all the list manipulation functions might be better
	  located in common/list where they can be shared rather
	  than in check.

Couple of things about the code:

	- please try to stick to 80 columns if possible.

	- some of the code uses 4 space tabs. When adding code into
	  such functions, please use 4 space tabs. New code should
	  use 8 space tabs, but only if it's not surrounded by code
	  that is using 4 space tabs.

	- really verbose variable names make the code hard to read.
	  e.g. $THIS_ENVIRONMENT is a long name, but I simply can't
	  tell what it's for from either it's name or it's usage.
	  $TEST_ENV is just as good, really...

	- using "_" prefixes in config files to change the behaviour
	  of the referenced test is pretty nasty. If there are
	  different behaviours needed, then the config file needs
	  to use explicit keywords for those behaviours. The only
	  use of the "_" prefix in xfstests is for prefixing
	  functions defined in the common/ code...

	- "2>&1 echo <foo>". What could echo possibly be sending to
	  stderr?



> Long version:
> 
> The goal of this set is to allow a single test to be run in different
> sitations, for example on empty filesystem, full fs, or damaged fs.
> It provides an interface for scripts that can prepare the requested
> environments and takes care of starting the test for each one.
> 
> Currently, this functionality needs to be enabled explicitely by a
> flag -e. It changes output slightly, so I saw this as neccessity.  The
> output change is because one test can be run multiple times in
> different environments, to note the combination. So when enabled,
> [env-name] is added: "xfs/001 [some-environment] 123s ... 456s"

Scope creep?

i.e. this isn't really what we discussed originally - we don't need
"environments" for the existing regression tests, and even if we do
this is not the way to go about grouping them. e.g. xfs/557, xfs/558
and xfs/559 might require the same setup, but as regression tests
they should not take more than a couple of minutes to run. Hence
the right way to do this is a generic setup function and, if
necessary, use the TEST_DIR to maintain a persistent environment
across tests.

> If the test is not aware of this new functionality, nothing changes
> for it, the test will run as usuall.
> 
> This is a part of my work on performance tests (they needs this sort
> of functionality), but is independent on them, so I'm proposing it
> now.
> 
> Of the seven patches, first three creates new files. Patches four to
> six modifies ./check script, but keeps the changes out of existing
> code as much as possible (patch four is only exception).  Patch seven
> is integrating it all together and is enabling the functionality.
> 
> To sum how it works:
> New file "environment", similar to "group" file, is created in each
> test category. It uses similar syntax, but it ortogonal to groups. In
> this file, each test can have specified one or more environments. When
> environments are enabled (./check -e ), list of tests is compiled as
> before (so -g, -x and other arguments works as usually) and for the
> enabled tests, environments are found.
> 
> If one test has multiple environments (and the selection is not
> limited for only some env.), the test is duplicated for each specified
> environment. Each run is then reported independently, as a combination
> of the test and the environment. When the test is not found in the
> file, it is added implicitly with "none" environment. The none
> environment do nothing and can be stated explicitly in the file also.

Hmm - yes, it is very different to what I thought we talked about.
I'll try to explain the way I see persistent performance test
environments fit into the existing infrastructure so you can see
the direction I was thinking of.

All we really require is a way of setting up a filesystem for
multiple performance tests, where setting up the test context might
take significantly longer than running the tests. I can see what you
are trying to do with the environment code, I'm just thinking that
it's a little over-engineered and trying to do too much.

Lets start with how a test would define the initial filesystem setup
it requires, and how it would trigger it to build and when we should
start our timing for measurement of the workload being benchmarked.
e.g.

....
. ./common/rc
. ./common/fsmark

FSMARK_FILES=10000
FSMARK_FILESIZE=4096
FSMARK_DIRS=100
FSMARK_THREADS=10
_scratch_build_fsmark_env

# real test starts now
_start_timing
.....

And _build_fsmark_env() does all the work of checking the
SCRATCH_MNT for existing test environment. e.g. the root directory
of the $SCRATCH_MNT contains a file created by the
_scratch_build_fsmark_env() function that contains the config used
to build it. It sources the config file, see if it matches the
config passed in by the test, and if it doesn't then we need to
rebuild the scratch device and the test environment according to the
current specification.

Indeed, we can turn the above into a create performance test via:

....
FSMARK_FILES=10000
FSMARK_FILESIZE=4096
FSMARK_DIRS=100
FSMARK_THREADS=10
FORCE_ENV_BUILD=true

# real test starts now
_start_timing
_scratch_build_fsmark_env
_stop_timing

status=0
exit

This doesn't require lots of new infrastructure and is way more
flexible than defining how tests are run/prepared in an external
file.  e.g. as you build tests it's trivial to simply group tests
that use the same environment together manually. Tests can still be
run randomly; it's just that they will need to create the
environment accordingly and so take longer to run.

In the longer term, I think it's better to change the common
infrastructure to support test names that aren't numbers and then
grouping of tests that use the same environment can all use the same
name prefix. e.g.

	peformance/fsmark-small-files-001
	peformance/fsmark-small-files-002
	peformance/fsmark-small-files-003
	peformance/fsmark-large-files-001
	peformance/fsmark-large-files-002
	peformance/fsmark-1m-empty-files-001
	peformance/fsmark-10m-empty-files-001
	peformance/fsmark-100m-empty-files-001
	peformance/fsmark-100m-empty-files-002
	.....

This makes sorting tests that use the same environment a very simple
thing whilst also providing other wishlist functionality we have for
the regression test side of fstests.  If we need common test setups
for regressions tests, then we can simply add the new regression
tests in exactly the same way.

As a result of this, we still use the existing group infrastructure
to control what performance tests are run. Hence there's no need for
explicit environments, CLI parameters to run them, cross-product
matrices of tests running in differnet environments, etc. i.e.

performance/group:
fsmark-small-files-001		fsmark small_files rw sequential
fsmark-small-files-002		fsmark small_files rw random
fsmark-small-files-003		fsmark small_files traverse
fsmark-small-files-004		fsmark small_files unlink
fsmark-large-files-001		fsmark large_files rw
fsmark-large-files-002		fsmark large_files unlink
fsmark-1m-empty-files-001	fsmark metadata scale create
fsmark-10m-empty-files-001	fsmark metadata scale create
fsmark-100m-empty-files-001	fsmark metadata scale create
fsmark-100m-empty-files-002	fsmark metadata scale traverse
fsmark-100m-empty-files-003	fsmark metadata scale unlink
.....

Hence:

# ./check -g fsmark

will run all those fsmark tests.

# ./check -g small_files

will run just the small file tests

# ./check -g fsmark -x scale

will run all the fsmark tests that aren't scalability tests.

That's how I've been thinking we should integrate persistent
filesystem state for performance tests, as well as the test script
interface and management should work. It is not as generic as your
environment concept, but I think it's simpler, more flexible and
easier to manage them a new set of wrappers around the outside of
the existing test infrastructure. I'm interested to see what you
think, Jan...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
