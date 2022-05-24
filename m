Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240F6C4332F
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 07:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbiEXHeS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 03:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235275AbiEXHeQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 03:34:16 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F08696A405
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 00:34:14 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 314C9534410
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 17:34:13 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ntP3V-00FkV8-Bz
        for fstests@vger.kernel.org; Tue, 24 May 2022 17:34:13 +1000
Received: from dave by discord.disaster.area with local (Exim 4.95)
        (envelope-from <david@fromorbit.com>)
        id 1ntP3V-008A5k-AH
        for fstests@vger.kernel.org;
        Tue, 24 May 2022 17:34:13 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [RFC PATCH 0/8] fstests: _cleanup() overrides are a mess
Date:   Tue, 24 May 2022 17:34:03 +1000
Message-Id: <20220524073411.1943480-1-david@fromorbit.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=628c8a76
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=oZkIemNP1mAA:10 a=_lJsNqLO5D6gHzSyid4A:9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi folks,

I pulled on a string a couple of days ago, and it got out of
control. It all started when I went to kill a test with ctrl-c and
it, once again, left background processes running that I had to hunt
down and kill manually.

I then started looking a why this keeps happening, and realised that
the way we clean up on test completion is messy, inconsistent and
frequently buggy. So I started cleaning it all up, starting with the
tests/xfs directory because I saw a lot of low hanging fruit there.

Essentially, we use _cleanup() functions as a way of overriding the
default trap handler we install in _begin_fstest(). Rather than
register a new handler, we just redefine the common cleanup function
and re-implement it (poorly) in every test that does an override.
Often these overrides are completely unnecessary - I think I reduced
the total number of overrides in tests/xfs by ~30% (~190 -> ~125),
and I reudced the number of *unique overrides by a lot more than
that.

The method for overriding changes to be "stacked cleanups" rather
than "duplicated cleanups". That is, tests no longer open code:

	cd /
	rm -rf $tmp.*

THis is what common/preamble::_cleanup() does. We should call that
function to do this. Hence if we have a local cleanup that we need
to do, it becomes:

local_cleanup()
{
	rm -f $testfile
	_cleanup
}
_register_cleanup local_cleanup

While this looks more verbose, it means we can actually reuse the
same cleanup function across lots of tests. 

A large number of xfsdump tests were all using the same override
cleanup function to call _cleanup_dump. These are all changed to:

. ./common/dump
_register_cleanup _cleanup_dump

and _cleanup_dump stacks like this:

_cleanup_dump()
{
	#do xfsdump cleanup stuff

	_cleanup
}

and we don't need to do anything else. There is one xfsdump test
that needs it's own cleanup. It stacks like this:

local_cleanup()
{
	rm -f $testfile
	_cleanup_dump
}
_register_cleanup local_cleanup

All the tests that run fsstress in the background now have a common
cleanup function that kills fsstress processes defined in
common/preamble. They just do:

_register_cleanup _cleanup_fsstress

And now every test that puts fsstress in the background behaves
correctly and kills all the background fsstree processes when
interrupted.

The conversion is by no means complete. I've named the local cleanup
functions by what they do so we can go back and derive commonality
between them. The number of different variations on tearing down
loops devices is crazy, and half of them are buggy. I haven't worked
through these yet, so you'll see lots of tests with:

_loop_cleanup()
{
	......
	_cleanup
}
_register_cleanup _loop_cleanup

That have similar but different ways of cleaning up loop devices.

I also added a _no_cleanup() function, as there are a large number
of xfs fuzzer tests that want to leave a warm corpse behind so that
debugging what just happened is easy.

I also added BUS to the default signal trap set - well over a 100
tests in tests/xfs had a line like:

_register_cleanup "_cleanup" BUS

just to add BUS signals to the set that would cause the cleanup
function to run. Just make it the default!

Overall, this significantly reduces the amount of boiler plate in
tests, and sets us down the path of common cleanup functions that
tests may not even need to define. e.g. just including
./common/dmflakey registers the _cleanup_dmflakey() trap that will
do all the necessary cleanup when the test exists. This makes the
tests simpler, more robust and reduces the maintenance burden of
over 1700 individual tests....

I won't put the full diffstat in this mail, but the benefits should
be clean from the summary:

360 files changed, 420 insertions(+), 1781 deletions(-)

I've lost count of the number of test bugs I killed in removing
all this code, and that's largely just in the tests/xfs directory.
So before I go spend another couple of days on converting the rest
of fstests, I figured I better make sure everyone is OK with these
changes.

Thoughts, comments?

-Dave.

