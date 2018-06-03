Received: from mail-pg0-f68.google.com ([74.125.83.68]:44551 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbeFCNvN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 3 Jun 2018 09:51:13 -0400
Received: by mail-pg0-f68.google.com with SMTP id p21-v6so13264863pgd.11
        for <fstests@vger.kernel.org>; Sun, 03 Jun 2018 06:51:13 -0700 (PDT)
Date: Sun, 3 Jun 2018 21:51:07 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [RFC PATCH 0/2] fstests: boiler plate reductions
Message-ID: <20180603135107.GK6581@desktop>
References: <20180529004752.8243-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529004752.8243-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, May 29, 2018 at 10:47:50AM +1000, Dave Chinner wrote:
> Hi folks,
> 
> To reduce boilerplate text in each test, I'm proposing the following
> two sets of modifications:
> 
> 	1. set tests up using a common include file; and
> 	2. switch tests over to using SPDX license tags
> 
> The first patch is simply moving all the common per-test setup code
> the test harness requires into a common file that all tests then
> include. This is code that nobody should ever need to change for any
> given test and pulling it out of the tests themselves removes the
> temptation for anyone to "optimise" the test setup code. There are a
> large number of tests where the setup code has been "optimised" and,
> as such, the common code that relies on the per-test setup may be
> compromised.
> 
> The other advantage of doing this is that tree-wide test setup
> changes now become much simpler to do, as it will not require
> touching every test in the tree. This will substanitally reduce the
> burden of improving the test infrastructure.
> 
> This patch modifies a couple of tests to demonstrate how the tests
> themselves will end up looking - they still have a cleanup()
> function called on test exit, and the status variable is still
> treated the same way. However, tests now only need to clean up stuff
> created within the test, so it much cleaner.
> 
> The second patch touches licensing, so please consider this one
> carefully. It introduces SPDX license tags to the xfstests codebase,
> and defines the tags and licenses they refer to in the LICENSES/
> directory. At present, I have only created a GPL-2.0 license tag,
> and replaced all the GPL v2.0 license texts in the root
> and common/ directories with SPDX tags. I also converted the same
> two tests I touched in the first patch to convert them, so you can
> see exactly what tests will look like after this.
> 
> I'll go throw how I've converted these files, so people can comment
> on the process and the decisions I've made.
> 
> 	1. Baseline assumption: unless otherwise specifically
> 	mentioned, the code is licensed under a GPL v2.0 license
> 
> 	2. If the file has a GPL license blurb, replace it with
> 	a "SPDX-License-Identifier: GPL-2.0" tag.
> 
> 	3. If the file has no GPL license blurb, add a new
> 	"SPDX-License-Identifier: GPL-2.0" tag.
> 
> 	3. If the file has a "Copyright ..." line, preserve it after
> 	the SPDX tag.
> 
> 	4. Remove author and other lines in the header with email
> 	addresses in them - we have the author history in the git
> 	repository. Git blame can tell us exactly who wrote what
> 	code and hence we don't need it in the code itself.

I'm not a license expert, but this process looks sane to me, thanks a
lot for doing this!

> 
> Most (possibly all?) of the code under tests/ has GPL license blurbs
> - they'll all get converted by this same process. It's a bit murkier
> when it comes to src/ and ltp/, as this code has varied history. For
> these directories, the first pass I make will for code that has
> explicit GPL licenses. Every other file will need to be looked at
> on a case by case basis and done as time permits...
> 
> Please note that I'm not trying to change the license on any of the
> code, just change the way it is documented to reduce boilerplate
> code. If I've made any changes that modify the license of any
> specific code, then I've made a mistake and I need to fix that.
> Please point out anywhere you think my actions have not been clear
> and obvious.
> 
> Once we have some consensus on how we want to proceed, I'll do the
> grunt work and co-ordinate with Eryu on minimising the number of
> times I have to rebase a patchset that is going to touch around 1500
> files...

How would you like to proceed with a minimum number of rebasing times? I
think that most rebase work would come from new tests that being added
during the whole process, I think I could do

1) simply suspend adding new tests until the whole work is done, or
2) convert new tests myself if there're just a few of them

Thanks,
Eryu
