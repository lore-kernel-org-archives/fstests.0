Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:9706 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752328AbeF0IVL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Jun 2018 04:21:11 -0400
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fY5hK-00083D-VP
        for fstests@vger.kernel.org; Wed, 27 Jun 2018 18:21:07 +1000
Received: from dave by discord.disaster.area with local (Exim 4.91)
        (envelope-from <david@fromorbit.com>)
        id 1fY5hK-0002io-Tu
        for fstests@vger.kernel.org; Wed, 27 Jun 2018 18:21:06 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 0/6] fstests: start factoring test setup boilerplate
Date: Wed, 27 Jun 2018 18:20:55 +1000
Message-Id: <20180627082103.9662-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi folks,

These patches start the long process of factoring out most of the
test setup boilerplate in each test. The first patch introduces the
generic test setup include file, and the patches that follow start
the process of converting tests over to use it.

Making infrastructure changes to fstests is hard because of the
sheer number of tests. Abstracting out things like test setup will
make it much easier in future to improve the test setup
infrstructure as we won't need to modify every test to make the
change. We only have to do the hard work once.

There is still some boiler plate in the preamble, but it is reduced
significantly and only contains things that individual tests should
be allowed to influence. i.e. the full output file and a cleanup
function that is called on exit.

I've also replaced the test success suffix - instead of this boiler
plate at the end of each test:

# success, all done
status=0
exit

This has been replaced with a single call to _success, which does
all the things necessary for the test harness to know the test has
exited successfully.

As an initial pass I've convert all the test directories with a
small number of tests, and converted the first handful of tests in
each of the major test directories. This is a slow process because
it's mostly manual as every second test has some unique variation
that makes automated replacement somewhat difficult.

As such, I've really only scratched the surface - this patchset
changes over about 60 tests, and there are about 1200 more tests to
convert. As such, my focus is going to be converting the generic
tests first - this is the biggest chunk of the work that
needs to be done.

Given there is still a large amount of conversion work to do, I
would appreciate it if people regularly contributing to the other
large test dirs (mainly overlay, btrfs, ext4 and xfs) would consider
devoting an hour or two to converting some of those tests to the new
setup preamble. The more people who do a bit, the faster the
conversion will go and the better it will be for everyone.

Comments, thoughts?

-Dave.


