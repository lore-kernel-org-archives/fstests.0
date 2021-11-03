Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D8FC433F5
	for <linux-fstests@archiver.kernel.org>; Wed,  3 Nov 2021 16:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3DAE60F58
	for <linux-fstests@archiver.kernel.org>; Wed,  3 Nov 2021 16:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbhKCQ1N (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 3 Nov 2021 12:27:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232101AbhKCQ1L (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 3 Nov 2021 12:27:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21B2D600EF;
        Wed,  3 Nov 2021 16:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635956675;
        bh=LcB2SndItcDO0aH6iv9UcMDp2nHIiKr5r9y8xEwNo7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GdleTHju8tRjy3LYhqNcqRIbS+Myss7WeQF9NGIg9fuU6ao6IJ3lYQ5x7yCKeWa/E
         sF+fUIUgIHZcJVztFsgCH4+p8WN72samY7d9eQLaYRmxxUMktXP3ljbhy0zYuNeB3f
         +3DAvcKxg9n6b1evN+j4hwnvpTyjX+eceMNzUiUfNp0CVUQNNm/G5Fmwpjk+cLgO5G
         fsOdVSAX27IDMjF+l+ple7qU85Y1laGMMcg8+yKWKj2/XiBrlKhO/STuS7Bi81lYfg
         bTN687oVdvek0vJHss17JpqnuJiX+PXJyUpDxryZFvJGqOY6MR0ErSIL2F0+iAc2qQ
         DOInOsw1uXavw==
Date:   Wed, 3 Nov 2021 09:24:34 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     fstests@vger.kernel.org, fdmanana@gmail.com,
        Anthony Iliopoulos <ailiopoulos@suse.de>
Subject: Re: [PATCH] fsstress: improve error message on check_cwd() error
Message-ID: <20211103162434.GX24282@magnolia>
References: <20211101155559.3988492-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101155559.3988492-1-mcgrof@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Nov 01, 2021 at 08:55:59AM -0700, Luis Chamberlain wrote:
> I ran into an error with generic/083 with xfs due to check_cwd() but
> why it failed is not clear because there are two types of
> failures:
> 
>   o stat64() failed (likely -ENOMEM is my guess)
>   o the inode actually changed
> 
> Throw a bone out to developers so that in case en error does happen
> they know which rabbit hole to go down on.

<cough> word choice on those last three words...

> 
> Cc: Anthony Iliopoulos <ailiopoulos@suse.de>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  ltp/fsstress.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> index 90ae432e..a576afea 100644
> --- a/ltp/fsstress.c
> +++ b/ltp/fsstress.c
> @@ -9,6 +9,7 @@
>  #include <sys/uio.h>
>  #include <stddef.h>
>  #include <stdbool.h>
> +#include <string.h>
>  #include "global.h"
>  
>  #ifdef HAVE_BTRFSUTIL_H
> @@ -943,9 +944,21 @@ check_cwd(void)
>  {
>  #ifdef DEBUG
>  	struct stat64	statbuf;
> +	int ret;
> +
> +	ret = stat64(".", &statbuf);
> +	if (ret !=0) {

Nit: space between '!=' and '0'.

> +		fprintf(stderr, "fsstress: check_cwd stat64 failed with: %d (%s)\n",
> +			ret, strerror(ret));

ret is set to -1 on error, according to the manpage; to get the real
error you'd have to call strerror(errno) as the last arg, or be lazy
and:

		perror("fsstress check_cwd stat64");

> +		goto out;
> +	}
>  
> -	if (stat64(".", &statbuf) == 0 && statbuf.st_ino == top_ino)
> +	if (statbuf.st_ino == top_ino)
>  		return;
> +
> +	fprintf(stderr, "fsstress: check_cwd statbuf.st_ino (%lu) != top_ino (%lu)\n",
> +		statbuf.st_ino, top_ino);

This might want some explicit casting, since this can be defined as
anything between unsigned long to uint64_t, at least according to the
glibc headers on my system.

--D

> +out:
>  	assert(chdir(homedir) == 0);
>  	fprintf(stderr, "fsstress: check_cwd failure\n");
>  	abort();
> -- 
> 2.33.0
> 
