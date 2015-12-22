Received: from sandeen.net ([63.231.237.45]:50885 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933305AbbLVVsn (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 22 Dec 2015 16:48:43 -0500
Subject: Re: [PATCH 6/6] fsx: Add mechanism to replay failed operations
References: <1450817636-11416-1-git-send-email-agruenba@redhat.com>
 <1450817636-11416-7-git-send-email-agruenba@redhat.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <5679C53A.4010905@sandeen.net>
Date: Tue, 22 Dec 2015 15:48:42 -0600
MIME-Version: 1.0
In-Reply-To: <1450817636-11416-7-git-send-email-agruenba@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Andreas Gruenbacher <agruenba@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 12/22/15 2:53 PM, Andreas Gruenbacher wrote:
> Create a $name.fsxops file next to $test.fsxlog.  When a test fails,
> dump the operations in the log into that file in a simple, parseable
> format like:
> 
>   fallocate 0x2e0f2 0xf04a 0x0 keep_size
>   truncate 0x0 0x11e00 0x0 *
>   write 0x73400 0x6c00 0x11e00
>   skip punch_hole 0x71539913 0xdf76 0x7a000 close_open
>   mapread 0x56000 0x16d08 0x7a000
> 
> Here, each operation is on a separate line. When the first word is
> "skip", the operation will be skipped.  The next parameters are offset,
> length, and the current file size, followed by optional flags like
> keep_size and clode_open.  A trailing asterisk indicates that the
> operation overlaps with the operation that has failed.
> 
> Add a --replay-ops option that allows to replay the operations recorded
> in such a $name.fsxops file.  (The log can be modified to easily narrow
> down which operations are causing the failure.)

fsx already accepts a seed parameter; with the seed can't we simply replay
the operations by specifying the same seed with -S?  And for narrowing down,
there's -D startingop and -N numops; doesn't that suffice?

And we already get an fsxlog like:

skipping zero size read
skipping insert range behind EOF
3 mapwrite	0x2e836 thru	0x3cba1	(0xe36c bytes)
4 insert	from 0x12000 to 0x15000, (0x3000 bytes)
5 punch	from 0xfb60 to 0x16c20, (0x70c0 bytes)
6 falloc	from 0x31645 to 0x38d1d (0x76d8 bytes)
7 punch	from 0x207c8 to 0x2224e, (0x1a86 bytes)
8 mapwrite	0xbcf1 thru	0x171ab	(0xb4bb bytes)
9 collapse	from 0x8000 to 0x13000, (0xb000 bytes)
...

from i.e. generic/075, but the cleanup function:

_cleanup()
{
    cd /
    rm -rf $TEST_DIR/fsx.* $tmp.*
}

removes it (even on a failure, I think, but I'm not certain).

Can't we just leverage what fsx already provides?  I'm not sure what this
patch adds on top of that, am I missing something?

Thanks,
-Eric
