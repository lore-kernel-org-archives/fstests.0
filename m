Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91FBC4332F
	for <linux-fstests@archiver.kernel.org>; Tue,  8 Nov 2022 15:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbiKHPI2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 8 Nov 2022 10:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbiKHPIZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 8 Nov 2022 10:08:25 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604971E3
        for <fstests@vger.kernel.org>; Tue,  8 Nov 2022 07:08:21 -0800 (PST)
Received: from letrec.thunk.org ([12.139.153.3])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2A8F83f4024022
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Nov 2022 10:08:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1667920086; bh=5HBDIXF0YXjVBAL0n6t6ZTzluBfXw9hmf/5jNXC86Cg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Tu2pmqlXQEvWn7mM4vNLsfKVr9MF4uyksarAg8KD+nlrgBkXB7c9ot/jJEdpqI09A
         rLbDCLWklr1pmxexUKwQ12LyB1fe7Rt57FXz/fNoNvEi9XJffXjuqo+2mNMth6j/I4
         nOoTjTwmwIDU6xzPM45/kqw3AuQ1JaWYDGo34ajddRZ3oF3lmq2QvFcLajJ8yxmiG/
         oziros0pdgAiQNKePmPSim1rTWklx1r7gAGmtyaPiHBPHRDB2nXsoCXSnl1UEzh2U9
         hMUCfa1VEW1r/thf+o3BS8WtS7VAsMudpGekCc31K54lQ7u0V/6thxgbT/FhJBXduu
         2lPMGxA+V+3Wg==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 2ADBD8C0272; Tue,  8 Nov 2022 10:08:03 -0500 (EST)
Date:   Tue, 8 Nov 2022 10:08:03 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zorro Lang <zlang@redhat.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
        Eric Whitney <enwlinux@gmail.com>
Subject: Re: [PATCH] generic: add missing $FSX_AVOID to fsx invocations
Message-ID: <Y2pw08wrQbAfAtT5@mit.edu>
References: <20221105182918.24099-1-tytso@mit.edu>
 <20221106121031.ywrlqu6w54kgnn2i@zlang-mailbox>
 <Y2gqpYhf5n8Y43eZ@mit.edu>
 <20221107020236.gdlmb5hxsaxxislo@zlang-mailbox>
 <Y2kzxKnYf8CLj49v@mit.edu>
 <Y2lmFoNQ2ByXzCW0@magnolia>
 <20221108024455.6lhdrbfoqq53wj4p@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108024455.6lhdrbfoqq53wj4p@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Nov 08, 2022 at 10:44:55AM +0800, Zorro Lang wrote:
> > If it's collapse/insert range you're specifically worried about, perhaps
> > its time to implement _get_file_block_size for ext4 so that
> > _test_congruent_file_oplen can exclude those tests that will get the
> > alignment wrong?
> 
> Thanks Darrick, I'm thinking about this helper you wrote recently :)
> (The real name is _require_congruent_file_oplen in common/rc.)
> 
> Hi Ted, is this helpful if you write a _ext4_get_file_block_size (refer to
> _xfs_get_file_block_size in common/xfs), then call it in _get_file_block_size
> to help _require_congruent_file_oplen to get the correct length which is an
> integer multiple of the file's allocation unit size ?

Well, it's a bit more complicated than that, since there's a
distinction between the cluster size and block size.  The cluster size
is the allocation unit.  However, other things are done in units of
the block size, including how we report fiemap results, etc.

For example, take a look at generic/206.  It will try to create a file
system where the file system block size is the one fourth of the page
size --- so for x86, 1k.  However, for ext4, the default cluster size
for 16 times the block size, so for this file system the allocation
unit size is 16k.  If we make _get_file_block_size return 64k for all
files, then generic/206 will fail:

    pagesz=$(getconf PAGE_SIZE)
    blksz=$((pagesz / 4))
    ...
    _scratch_mkfs_blocksized $blksz > $seqres.full 2>&1
    ...
    real_blksz=$(_get_file_block_size $testdir)
    test $real_blksz != $blksz && _notrun "Failed to format with small blocksize."

I assume this works for xfs because only files in the real-time block
size will have a larger allocation unit size, but the root directory
has a allocation unit size of the "real" block size?

I suppose I could make a hypothetical _ext4_get_file_block_size lie
and return the "real" block size when it's called on the mount point,
but that seems kinda of gross, and it's also a lie, since the
allocation unit size for the root directory actually is the cluster
size, not the block size.

If I were going to be doing things from scratch, I'd make a
distinction between _get_file_allocation_size and
_get_file_system_block_size, which would be a lot *clearer* about what
is going on.  Even then, I could imagine some tests getting confused
with how, say, fiemap behaves with an ext4 file system with a 4k block
size and a 64k allocation unit size, so I'm not sure it's a complete
solution.  And doing this now would require quite a bit of code churn
in xfstests.

> If this's helpful for your first concern [1], please tell me. Then we can talk
> about your second concern [2], if it's still your main concern now :)
> 
> "This might *[1]* either be because the test didn't know about ext4
>  bigalloc's cluster alignment requirements, *[2]* or because a particular
>  operation might just be *buggy* and being able to run tests as if a
>  particular command wasn't supported was useful."

So [1] is a real concern, and at the moment, we just suppress all of
the tests that try to use collapse/insert range.  For example, from
the ext4/bigalloc config file:

    # Until we can teach xfstests the difference between cluster size and
    # block size, avoid collapse_range and insert_range since these will
    # fail due the fact that these operations require cluster-aligned
    # ranges.
    export FSX_AVOID="-C -I"
    export FSSTRESS_AVOID="-f collapse=0 -f insert=0"
    export XFS_IO_AVOID="fcollapse finsert"
    TEST_SET_EXCLUDE="-x collapse,insert"

That's not ideal, and it's been on my todo list to try to fix it, when
I could get one of those round tuit's.  However, I had assumed that we
would split _get_file_block_size somehow, given the observation I've
made above.  So this was always been something that has put me off,
because it looked like a much larger project than say, "gee, I have an
hour or two on a weekend, let me see if I can fix this".

[2] is practically not _really_ a concern any more.  It used to be
that one of the ways that I would root cause a failing test was to
suppress one of the advanced fallocate modes, whether it be
collapse/insert range, or going even further back, punch hole.  If
test then passed, then I could say, "ah, hah; the problem can probably
be localized to a certain part of the fs code."

However, that's mainly tests that are using fsstress and fsx, and we
have solutions for that.  And for other tests, I can examine the test
and see whether or not it's using collapse/insert range by inspection,
so it's really not that big of a deal.  I could imagine other file
systems who might find this useful in the future, if they were trying
to growing support for the more advanced fallocate modes --- but that
wouldn't *my* concern, and arguably those file systems could solve
problems alternate ways, such as having mount options that suppress
those fallocate modes entirely which could be used when running
xfstests.

						- Ted

P.S.  I have noticed some tests that use collapse/insert range but
don't declare that they are in the collapse or insert groups.
Fortunately, all of these tests are also in the clone group, and so
they don't apply to ext4, so _I_ don't care.  :-)
