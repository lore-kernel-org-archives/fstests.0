Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:17207 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755848AbeE2AsA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 28 May 2018 20:48:00 -0400
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fNSns-0007pb-RB
        for fstests@vger.kernel.org; Tue, 29 May 2018 10:47:56 +1000
Received: from dave by discord.disaster.area with local (Exim 4.91)
        (envelope-from <david@fromorbit.com>)
        id 1fNSns-0002Uu-QE
        for fstests@vger.kernel.org; Tue, 29 May 2018 10:47:56 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [RFC PATCH 0/2] fstests: boiler plate reductions
Date: Tue, 29 May 2018 10:47:50 +1000
Message-Id: <20180529004752.8243-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi folks,

To reduce boilerplate text in each test, I'm proposing the following
two sets of modifications:

	1. set tests up using a common include file; and
	2. switch tests over to using SPDX license tags

The first patch is simply moving all the common per-test setup code
the test harness requires into a common file that all tests then
include. This is code that nobody should ever need to change for any
given test and pulling it out of the tests themselves removes the
temptation for anyone to "optimise" the test setup code. There are a
large number of tests where the setup code has been "optimised" and,
as such, the common code that relies on the per-test setup may be
compromised.

The other advantage of doing this is that tree-wide test setup
changes now become much simpler to do, as it will not require
touching every test in the tree. This will substanitally reduce the
burden of improving the test infrastructure.

This patch modifies a couple of tests to demonstrate how the tests
themselves will end up looking - they still have a cleanup()
function called on test exit, and the status variable is still
treated the same way. However, tests now only need to clean up stuff
created within the test, so it much cleaner.

The second patch touches licensing, so please consider this one
carefully. It introduces SPDX license tags to the xfstests codebase,
and defines the tags and licenses they refer to in the LICENSES/
directory. At present, I have only created a GPL-2.0 license tag,
and replaced all the GPL v2.0 license texts in the root
and common/ directories with SPDX tags. I also converted the same
two tests I touched in the first patch to convert them, so you can
see exactly what tests will look like after this.

I'll go throw how I've converted these files, so people can comment
on the process and the decisions I've made.

	1. Baseline assumption: unless otherwise specifically
	mentioned, the code is licensed under a GPL v2.0 license

	2. If the file has a GPL license blurb, replace it with
	a "SPDX-License-Identifier: GPL-2.0" tag.

	3. If the file has no GPL license blurb, add a new
	"SPDX-License-Identifier: GPL-2.0" tag.

	3. If the file has a "Copyright ..." line, preserve it after
	the SPDX tag.

	4. Remove author and other lines in the header with email
	addresses in them - we have the author history in the git
	repository. Git blame can tell us exactly who wrote what
	code and hence we don't need it in the code itself.

Most (possibly all?) of the code under tests/ has GPL license blurbs
- they'll all get converted by this same process. It's a bit murkier
when it comes to src/ and ltp/, as this code has varied history. For
these directories, the first pass I make will for code that has
explicit GPL licenses. Every other file will need to be looked at
on a case by case basis and done as time permits...

Please note that I'm not trying to change the license on any of the
code, just change the way it is documented to reduce boilerplate
code. If I've made any changes that modify the license of any
specific code, then I've made a mistake and I need to fix that.
Please point out anywhere you think my actions have not been clear
and obvious.

Once we have some consensus on how we want to proceed, I'll do the
grunt work and co-ordinate with Eryu on minimising the number of
times I have to rebase a patchset that is going to touch around 1500
files...

Cheers,

Dave.

