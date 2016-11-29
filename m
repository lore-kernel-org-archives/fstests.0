Received: from b.ns.miles-group.at ([95.130.255.144]:44724 "EHLO radon.swed.at"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755563AbcK2UwO (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 29 Nov 2016 15:52:14 -0500
Subject: Re: [PATCH v2 4/5] generic: test encrypted file access
References: <1480371402-12204-1-git-send-email-ebiggers@google.com>
 <1480371402-12204-5-git-send-email-ebiggers@google.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <efa324fb-6d0b-aad0-1916-cdf12f0072c0@nod.at>
Date: Tue, 29 Nov 2016 21:52:10 +0100
MIME-Version: 1.0
In-Reply-To: <1480371402-12204-5-git-send-email-ebiggers@google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers@google.com>, fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, David Gstir <david@sigma-star.at>, Michael Halcrow <mhalcrow@google.com>, linux-api@vger.kernel.org, Michael Kerrisk <mtk.manpages@gmail.com>
List-ID: <fstests@vger.kernel.org>

Eric,

On 28.11.2016 23:16, Eric Biggers wrote:
> +# Also, there are some inconsistencies in which error codes are returned on
> +# different kernel versions and filesystems when trying to create a file or
> +# subdirectory without access to the parent directory's encryption key.  For now
> +# we just accept multiple error codes.

This is something I wanted to ask about some time ago but forgot.
Can we please agree on a clear set of fscrypt related error codes
and document them in the Linux man pages?

Thanks,
//richard
