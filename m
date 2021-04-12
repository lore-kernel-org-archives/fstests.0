Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2677FC433ED
	for <linux-fstests@archiver.kernel.org>; Mon, 12 Apr 2021 22:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0254761244
	for <linux-fstests@archiver.kernel.org>; Mon, 12 Apr 2021 22:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239338AbhDLWlx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 12 Apr 2021 18:41:53 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60424 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238901AbhDLWlx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 12 Apr 2021 18:41:53 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13CMfKRT028603
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 18:41:21 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1D03915C3B1E; Mon, 12 Apr 2021 18:41:20 -0400 (EDT)
Date:   Mon, 12 Apr 2021 18:41:20 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Eryu Guan <guan@eryu.me>, Christian Brauner <brauner@kernel.org>,
        fstests@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v12 2/6] generic/632: add fstests for idmapped mounts
Message-ID: <YHTMkBcVTFAGqyks@mit.edu>
References: <20210328223400.1800301-1-brauner@kernel.org>
 <20210328223400.1800301-3-brauner@kernel.org>
 <YHMH/JRmzg3ETcED@desktop>
 <20210411151249.6y34x7yatqtpcvi6@wittgenstein>
 <20210411151857.wd6gd46u53vlh2xv@wittgenstein>
 <YHMUAL/oD4fB3+R7@desktop>
 <20210411153223.vhcegiklrwoczy55@wittgenstein>
 <YHOW7DN51YuYgLPM@mit.edu>
 <20210412115426.a4bzsx4cp7jhx2ou@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412115426.a4bzsx4cp7jhx2ou@wittgenstein>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 12, 2021 at 01:54:26PM +0200, Christian Brauner wrote:
>So we can detect it pretty reliably at runtime by trying whether we can
>create an idmapped mount on the given filesystem. That is enough for the
>idmapped mount tests here but of course has at least two drawbacks:
>1. there might be scenarios where we get false negatives
>   (e.g. open_tree() could fail for a lack of permissions or sm else,
>   kernel might be compiled without userns support etc. pp)

In the ideal world, if the kernel wasn't compiled with the necessary
CONFIG options enabled, it's desirable of the test can detect that
fact and skip running the test instead failing and forcing the person
running the test to try to figure out whether this is a legitmate file
system bug or a just a test setup bug.

This is one of the other functions of /sys/fs/ext4/features/...  for
example:

#ifdef CONFIG_UNICODE
EXT4_ATTR_FEATURE(casefold);
#endif

That way, if a particular kernel CONFIG is not compiled in, we can
prevent the feature from being advertised, without having to rely on
/proc/config.gz be present.

>2. it's heavy in so far as we have to do the whole exercise of creating
>   a detached mount

Yeah, there are times when I've added a new feature flag file in
/sys/fs/ext4/features because it was simpler than being able to doing
some kind of heavyweight test.

> So having a reliable way to detect whether or not the underlying fs
> supports it could be worth it (My hope was for the fsinfo() API to grow
> this "feature check" ability but oh well.).
> 
> One possibility might be to extend fstatfs() and steal one u32 from the
> padding that is currently in there?

That would require mounting a file system in order to do the check,
which is not necesarily always convenient, but that would certainly
work.  (See below for an example of where it was much easier for
mke2fs to be able to test for a file system "capability" without
needing to mount a test file system.)

> > If you can't do this by checking to see if the file system will
> > support a particular mount option, or some other run-time test, for
> > ext4 we can signal this by checking for the existence of a file in
> > /sys/fs/ext4/features, such as /sys/fs/ext4/features/fast_commit.
> > (Grep for EXT4_ATTR_FEATURE and ATTR_LIST in fs/ext4/sysfs.c; it
> > requires adding two lines to advertise a new ext4 feature.)
> 
> I wonder if this wouldn't be nice to have independent of whether or not
> there is another way to detect it?
> I'm would think that people like to see all new ext4 features listed in
> there. Even if this is technically a generic vfs feature.

My apologies for the confusion.  There's a bit of overloading in terms
of the word "features" as used above.  In some cases, there is a
direct correspondance between bits that show up in the compat,
ro_compat, and incompat fields in the ext4 superblock.  In other cases
it might describe a file system behaviour (e.g., lazy_itable_init) and
this acts as a hint to e2fsprogs about what kind of defaults it should
use when creating a file system --- or to warn the user about whether
a particular file system can be mounted using the current kernel.

For example, currently we give the following warning if you create a
file system with a 64k block size:

% mke2fs -t ext4 -b 65536 /tmp/foo.img 8M
Warning: blocksize 65536 not usable on most systems.
mke2fs 1.46.2 (28-Feb-2021)
Creating regular file /tmp/foo.img
mke2fs: 65536-byte blocks too big for system (max 4096)
Proceed anyway? (y,N)

However, suppose at some point, thanks to advances in the MM layer, it
becomes possible to support file systems where the block size is
greater than the page size.  We might then advertise that via the
existing of a file such as /sys/fs/ext4/feature/big_blocks (for
example), and then newer versions of mke2fs would check for that file
and suppress the warning on a kernel which would actually allow file
systems with 64k blocks to be mounted on an x86_64 system.  This is
also why I designed it via using a file in /sys/fs/ext4/features, so
that I don't have to do a test mount and use a system call fstatfs(2)
to check for the existenace of an ext4 feature/capability (all of the
obvious terms are already overloaded, sigh).

I agree that having some kind of fs-independent way for querying
whether some feature/capability is present for a particular kernel
would be convenient.  This wouldn't necessarily need to be implemented
in the VFS, though, especially if the convention that gets adopted is
via a file in /sys/fs/<fstype>/features/<capability>.

						- Ted
