Received: from b.ns.miles-group.at ([95.130.255.144]:44723 "EHLO radon.swed.at"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755992AbcLSTs4 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 19 Dec 2016 14:48:56 -0500
Subject: Re: [RFC][PATCH 0/2] xfstests on ubifs
References: <1482173132-100690-1-git-send-email-ebiggers3@gmail.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <74d2781e-e1db-7aa9-26d0-f1b3d473e064@nod.at>
Date: Mon, 19 Dec 2016 20:48:52 +0100
MIME-Version: 1.0
In-Reply-To: <1482173132-100690-1-git-send-email-ebiggers3@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>, fstests@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, David Gstir <david@sigma-star.at>, "Theodore Y . Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On 19.12.2016 19:45, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Hello,
> 
> Since ubifs encryption has been merged into the 4.10 kernel, I wanted to run my
> new encryption tests on ubifs to make sure it's compatible with ext4 and f2fs.
> xfstests doesn't support ubifs yet but I was able to hack something together.
> I'm sending my patches for anyone who may be interested.
> 
> The first patch adds ubifs support to xfstests itself.  This is a fairly small
> patch that just deals with a couple quirks of ubifs, e.g. requiring a char
> device rather than a block device.
> 
> The second patch updates xfstests-bld (a separate project maintained by Theodore
> Ts'o) to support ubifs with kvm-xfstests and gce-xfstests.  It uses block2mtd to
> emulate MTD devices using standard block devices, then layers UBI volumes on top
> of these.  Of course, actually running the tests is dependent on the xfstests
> patch.
> 
> Note: I'm *not* an ubifs developer, and so far I haven't done much else besides
> run the encryption tests.  There seemed to be a lot of failures when I tried
> running some of the other generic xfstests, and also a strange failure in the
> encryption test generic/402 that I wasn't able to fix; so if I haven't obviously
> screwed something up, I strongly suggest the ubifs developers look into this.

BTW: Do you have a xfstests git tree with all your fscrypt related patches?

Thanks,
//richard
