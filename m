Received: from mail-io0-f194.google.com ([209.85.223.194]:34174 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753878AbcLSVb0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 19 Dec 2016 16:31:26 -0500
Received: by mail-io0-f194.google.com with SMTP id y124so20533498iof.1
        for <fstests@vger.kernel.org>; Mon, 19 Dec 2016 13:31:26 -0800 (PST)
Date: Mon, 19 Dec 2016 13:31:22 -0800
From: Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [RFC][PATCH 0/2] xfstests on ubifs
Message-ID: <20161219213122.GD37112@gmail.com>
References: <1482173132-100690-1-git-send-email-ebiggers3@gmail.com>
 <16b0ba94-bdef-00c5-acd9-d19200f81ecd@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16b0ba94-bdef-00c5-acd9-d19200f81ecd@nod.at>
Sender: fstests-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: fstests@vger.kernel.org, linux-mtd@lists.infradead.org, David Gstir <david@sigma-star.at>, "Theodore Y . Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

Hi Richard,

On Mon, Dec 19, 2016 at 08:12:07PM +0100, Richard Weinberger wrote:
> Eric,
> 
> On 19.12.2016 19:45, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Hello,
> > 
> > Since ubifs encryption has been merged into the 4.10 kernel, I wanted to run my
> > new encryption tests on ubifs to make sure it's compatible with ext4 and f2fs.
> > xfstests doesn't support ubifs yet but I was able to hack something together.
> > I'm sending my patches for anyone who may be interested.
> 
> Thanks for doing this. This was already on my TODO but you were faster.
> 
> > The first patch adds ubifs support to xfstests itself.  This is a fairly small
> > patch that just deals with a couple quirks of ubifs, e.g. requiring a char
> > device rather than a block device.
> > 
> > The second patch updates xfstests-bld (a separate project maintained by Theodore
> > Ts'o) to support ubifs with kvm-xfstests and gce-xfstests.  It uses block2mtd to
> > emulate MTD devices using standard block devices, then layers UBI volumes on top
> > of these.  Of course, actually running the tests is dependent on the xfstests
> > patch.
> > 
> > Note: I'm *not* an ubifs developer, and so far I haven't done much else besides
> > run the encryption tests.  There seemed to be a lot of failures when I tried
> > running some of the other generic xfstests, and also a strange failure in the
> > encryption test generic/402 that I wasn't able to fix; so if I haven't obviously
> > screwed something up, I strongly suggest the ubifs developers look into this.
> 
> /me looks.
> 

Also, in case you weren't aware of this already, I should mention that with ext4
we have a way to do a full xfstests run with encryption enabled, to find bugs
that wouldn't be found in dedicated tests.  Basically you run xfstests with the
"test_dummy_encryption" mount option (or with the "ext4/encrypt" config for
xfstests-bld), and it makes ext4 encrypt all new files and directories without
userspace having to set up encryption policies.  It may be useful to look into
implementing this for ubifs and/or f2fs too.

(I'd actually like to get rid of test_dummy_encryption and just use the ioctls,
but currently it's not really possible because it would require some ugly hooks
in xfstests, and also the root directory cannot be encrypted because e2fsck
requires that lost+found exist and be unencrypted.  An "inherit-only" encryption
policy settable by a mkfs flag is also an option, but it seems like overkill
just for testing.  So I think we'll be stuck with test_dummy_encryption for a
while longer.  At least I've written kernel and xfstests-bld patches that make
it a little less ugly kernel-side...)

Eric
