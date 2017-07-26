Received: from mx1.redhat.com ([209.132.183.28]:47244 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750907AbdGZIzC (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 26 Jul 2017 04:55:02 -0400
Date: Wed, 26 Jul 2017 16:55:00 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] ext4: add a test for ea_inode feature
Message-ID: <20170726085500.GX9167@eguan.usersys.redhat.com>
References: <20170725180528.7829-1-tahsin@google.com>
 <20170725180615.8091-1-tahsin@google.com>
 <CAAeU0aMAPWVv00bmU2wy89cF_zpxo9PFL+tjaacoHVtORXj1Tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeU0aMAPWVv00bmU2wy89cF_zpxo9PFL+tjaacoHVtORXj1Tg@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Tahsin Erdogan <tahsin@google.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jul 25, 2017 at 11:20:38AM -0700, Tahsin Erdogan wrote:
> Eryu, thanks for the feedback!

Thanks for the new test! :)

> 
> >> +# FS QA Test 026
> >> +#
> >> +# Test ea_inode feature.
> >
> > Better to have more information about ea_inode feature and what this
> > case tests here too.
> 
> Done.
> 
> >> +_scratch_mkfs_ext4 -O ea_inode -I 256 -b 4096 >/dev/null 2>&1
> >
> > Is 4k block size a hard requirement? If not, then we lose test coverage
> > for 1k/2k block size ext4, if so, some comments on it would be better.
> > (and the 256 inode size too).
> 
> The actual block size is not that important for the purposes of this
> test. However, knowing the block size helps simplifying the test
> because we can hardcode xattr value sizes in the rest of the script.
> I've set block size to 4k in case ext4 default changes in the future.

In this case, what we generally do is filtering the output and make it
consistent across different block size ext4 filesystems, instead of
hardcoding the block size in test, so we have better test coverage.

But I modified the test a bit to remove the block size specification and
tried with 1k and 2k block size, test still passed. Seems there's no
problem running the test with non-4k block size ext4.

And as you said in v2 comments, 256 inode size is required to store some
xattr in inode body, I think we can check the actual inode size after
_scratch_mkfs and _notrun if it's smaller than 256. So we don't restrict
the test to a certain test config.

But again, I tried with 128B inode size and test passed too, even though
it didn't test what we want exactly in this case. But that doesn't
matter to me, adding some comments to explain the behavior when inode
size is 128 would be OK.

So I think a bare "_scratch_mkfs >/dev/null 2>&1" would be good for this
test, we just need more comments to clarify the behaviors.

Thanks,
Eryu
