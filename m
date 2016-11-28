Received: from mail-pg0-f49.google.com ([74.125.83.49]:36072 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751515AbcK1WZu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 28 Nov 2016 17:25:50 -0500
Received: by mail-pg0-f49.google.com with SMTP id f188so61151572pgc.3
        for <fstests@vger.kernel.org>; Mon, 28 Nov 2016 14:25:50 -0800 (PST)
Date: Mon, 28 Nov 2016 14:25:46 -0800
From: Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v2 0/5] Add filesystem-level encryption tests
Message-ID: <20161128222546.GA145516@google.com>
References: <1480371402-12204-1-git-send-email-ebiggers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1480371402-12204-1-git-send-email-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Richard Weinberger <richard@nod.at>, David Gstir <david@sigma-star.at>, Michael Halcrow <mhalcrow@google.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Nov 28, 2016 at 02:16:37PM -0800, Eric Biggers wrote:
> This is the second version of the patch series to add some xfstests for
> filesystem-level encryption.  The new tests are designed to run on any
> filesystem that implements the "fscrypt" API, currently ext4 and f2fs.  (fscrypt
> support for ubifs is also under development, but it looks like xfstests doesn't
> have ubifs support yet.)
> 
> The new tests are designed to complement, not replace, doing a full xfstests run
> with encryption enabled, which for ext4 can currently be done by using the
> test_dummy_encryption mount option.
> 
> v2 of the series drops the fscrypt_util test program and instead uses new xfs_io
> commands to set and get encryption policies, and uses keyctl to add and remove
> encryption keys.  I'm sending the xfs_io patch separately since xfs_io is part
> of xfsprogs.
> 

Forgot to list a few other changes since v1:

	* Updates to match xfstests coding style
	* Move validation of policy structure into its own test
	* Add test to detect some cryptographic weaknesses
	* Drop ioctl locking test 

Eric
