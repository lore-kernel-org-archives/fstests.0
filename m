Received: from mail-pg0-f65.google.com ([74.125.83.65]:36760 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753951AbcLOAbl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 14 Dec 2016 19:31:41 -0500
Received: by mail-pg0-f65.google.com with SMTP id x23so4023436pgx.3
        for <fstests@vger.kernel.org>; Wed, 14 Dec 2016 16:31:41 -0800 (PST)
Date: Wed, 14 Dec 2016 16:31:38 -0800
From: Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [PATCH v3 0/6] Add filesystem-level encryption tests
Message-ID: <20161215003138.GB18462@gmail.com>
References: <1480965669-39714-1-git-send-email-ebiggers@google.com>
 <20161213061255.GP29149@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161213061255.GP29149@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Eric Biggers <ebiggers@google.com>, fstests@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Richard Weinberger <richard@nod.at>, David Gstir <david@sigma-star.at>, Michael Halcrow <mhalcrow@google.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Dec 13, 2016 at 02:12:55PM +0800, Eryu Guan wrote:
> On Mon, Dec 05, 2016 at 11:21:03AM -0800, Eric Biggers wrote:
> > This is the third version of the patch series to add some xfstests for
> > filesystem-level encryption.  The new tests are designed to run on any
> > filesystem that implements the "fscrypt" API, currently ext4 and f2fs.
> > (fscrypt support for ubifs is also under development, but it looks like
> > xfstests doesn't have ubifs support yet.)
> > 
> > The new tests are designed to complement, not replace, doing a full
> > xfstests run with encryption enabled, which for ext4 can currently be
> > done by using the test_dummy_encryption mount option.
> 
> These tests look good to me now overall, from fstests perspective of
> view. I tested them with 4.9 kernel with ext4 encryption enabled, latest
> e2fsprogs and latest xfsprogs plus the set|get_policy patch. All tests
> passed on ext4. Comments go to individual patch.
> 
> But I'm not so familiar with this new encryption API, it would be good
> to have some reviews on the tests from other fscrypt developers too.
> 

Hi Eryu, thanks for the review.  I'm planning to send a v4 of the patchset to
address your comments.

I've let people with more involvement in filesystem encryption know that this
needs to be reviewed.  (And some are Cc'ed here; Ted and Jaegeuk are the
official fscrypto maintainers.)

Thanks,

Eric
