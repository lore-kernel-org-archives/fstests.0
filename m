Received: from mx1.redhat.com ([209.132.183.28]:39754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932188AbcLMGM6 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 13 Dec 2016 01:12:58 -0500
Date: Tue, 13 Dec 2016 14:12:55 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v3 0/6] Add filesystem-level encryption tests
Message-ID: <20161213061255.GP29149@eguan.usersys.redhat.com>
References: <1480965669-39714-1-git-send-email-ebiggers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1480965669-39714-1-git-send-email-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers@google.com>
Cc: fstests@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Richard Weinberger <richard@nod.at>, David Gstir <david@sigma-star.at>, Michael Halcrow <mhalcrow@google.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Dec 05, 2016 at 11:21:03AM -0800, Eric Biggers wrote:
> This is the third version of the patch series to add some xfstests for
> filesystem-level encryption.  The new tests are designed to run on any
> filesystem that implements the "fscrypt" API, currently ext4 and f2fs.
> (fscrypt support for ubifs is also under development, but it looks like
> xfstests doesn't have ubifs support yet.)
> 
> The new tests are designed to complement, not replace, doing a full
> xfstests run with encryption enabled, which for ext4 can currently be
> done by using the test_dummy_encryption mount option.

These tests look good to me now overall, from fstests perspective of
view. I tested them with 4.9 kernel with ext4 encryption enabled, latest
e2fsprogs and latest xfsprogs plus the set|get_policy patch. All tests
passed on ext4. Comments go to individual patch.

But I'm not so familiar with this new encryption API, it would be good
to have some reviews on the tests from other fscrypt developers too.

Thanks,
Eryu
