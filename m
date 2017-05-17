Received: from mail-pg0-f65.google.com ([74.125.83.65]:33973 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753011AbdEQTVt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 17 May 2017 15:21:49 -0400
Received: by mail-pg0-f65.google.com with SMTP id u187so2961916pgb.1
        for <fstests@vger.kernel.org>; Wed, 17 May 2017 12:21:49 -0700 (PDT)
Date: Wed, 17 May 2017 12:21:46 -0700
From: Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [PATCH 2/2] Accept failing with EPERM in addition to ENOKEY for
 rename without key
Message-ID: <20170517192146.GD91213@gmail.com>
References: <20170517095531.11818-1-david.oberhollenzer@sigma-star.at>
 <20170517095531.11818-3-david.oberhollenzer@sigma-star.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170517095531.11818-3-david.oberhollenzer@sigma-star.at>
Sender: fstests-owner@vger.kernel.org
To: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Cc: fstests@vger.kernel.org, linux-mtd@lists.infradead.org, richard@nod.at
List-ID: <fstests@vger.kernel.org>

Hi David,

On Wed, May 17, 2017 at 11:55:30AM +0200, David Oberhollenzer wrote:
> Some filesystems (e.g. UBIFS) fail with EPERM when trying to move a
> file into an encrypted directory via cross rename, without having
> access to the encryption key.
> 
> Since rename is perfectly allowed to return EPERM, which is also tested
> for, and no precise specification seems to exist that clarifys when to
> expect EPERM and when ENOKEY, this patch modifies the generic/398 test
> to accept both, for the test case where the key is not available.
> 

Specifically, the operation is expected to fail for two logically independent
reasons:
- It shouldn't be possible to link or rename an unencrypted file into an
  encrypted directory, as this violates the "one encryption policy per directory
  tree" constraint (EPERM)
- It shouldn't be possible to link or rename files into an encrypted directory
  without the directory's encryption key (ENOKEY)

Therefore it's not an ideal test, though it seemed worthwhile originally because
it was, in fact, broken in both ways, causing the operation to succeed :)

> Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
> ---
>  tests/generic/398 | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/398 b/tests/generic/398
> index b486b9c5..390c4380 100755
> --- a/tests/generic/398
> +++ b/tests/generic/398
> @@ -43,6 +43,12 @@ _cleanup()
>  	rm -f $tmp.*
>  }
>  
> +_filter_rename()
> +{
> +	# rename without key can also fail with EPERM instead of ENOKEY
> +	sed -e "s/Operation not permitted/Required key not available/g"
> +}
> +

It doesn't matter much, but IMO it would make a little more sense to substitute
ENOKEY with EPERM instead of the other way around, then updating 398.out to
expect "Operation not permitted".  The reason for this is that everything else
in generic/398 is testing for EPERM, because the test script is checking for
situations in which the "one encryption policy per directory tree" constraint
can be violated, and such violations normally result in EPERM.

Eric
