Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0C8C433EF
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Nov 2021 16:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9157761245
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Nov 2021 16:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbhKEQwm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 5 Nov 2021 12:52:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234043AbhKEQwm (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 5 Nov 2021 12:52:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D03D61037;
        Fri,  5 Nov 2021 16:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636131002;
        bh=tJ2wahvQcjofNAYH8EwWv9wUAgrOFo92qU0q6vMQIb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lcTEw+xAYHgdX2G0QBR8EOdiXKMaz/xMA9CXdmr1B+9vezWc3IQrouo+Z5N26Iipi
         qYun91ggu7Ew+S9NB1zXU8nWObY9ne/R6pORTKkygAgHopwcbivxBtCJ5nymDiRMbm
         vgaAc6hlnsG7JWqZbSK5RtEI3h1/eIWIVK0WEuo8CkMaGd6NhCVjvkf1RDdzuZp0uw
         3ImePgqg8tLgfw0twrgsF/UZXvY6jLG8BIrf2BqWp/vGxfgrPu1q6p7unipE4eg1S6
         PrufgppmdW1Gwttz8FEyMKefah3U3d5v/ukcGoGzTSgTISSoh9cLBGqGyXNIxOiy2S
         YoIg8Gx9TTYtQ==
Date:   Fri, 5 Nov 2021 09:50:02 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     fstests@vger.kernel.org, fdmanana@gmail.com,
        Anthony Iliopoulos <ailiopoulos@suse.de>
Subject: Re: [PATCH v3] fsstress: improve error message on check_cwd() error
Message-ID: <20211105165002.GH24282@magnolia>
References: <20211105164432.2860572-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105164432.2860572-1-mcgrof@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Nov 05, 2021 at 09:44:32AM -0700, Luis Chamberlain wrote:
> I ran into an error with generic/083 with xfs due to check_cwd() but
> why it failed is not clear because there are two types of
> failures:
> 
>   o stat64() failed (likely -ENOMEM is my guess)
>   o the inode actually changed
> 
> Throw a bone out to developers so that in case en error does happen
> they know which rabbit hole to go into.
> 
> Cc: Anthony Iliopoulos <ailiopoulos@suse.de>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

LGTM,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
> 
> Changes on this v3:
> 
>  o Minor nitpick on spaces
>  o Changed rabbit hole language
>  o enhanced stat64() error message to include errno as well
>  o cast things as suggested
> 
>  ltp/fsstress.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> index 90ae432e..aab64f33 100644
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
> @@ -943,9 +944,22 @@ check_cwd(void)
>  {
>  #ifdef DEBUG
>  	struct stat64	statbuf;
> +	int ret;
> +
> +	ret = stat64(".", &statbuf);
> +	if (ret != 0) {
> +		fprintf(stderr, "fsstress: check_cwd stat64() returned %d with errno: %d (%s)\n",
> +			ret, errno, strerror(errno));
> +		goto out;
> +	}
>  
> -	if (stat64(".", &statbuf) == 0 && statbuf.st_ino == top_ino)
> +	if (statbuf.st_ino == top_ino)
>  		return;
> +
> +	fprintf(stderr, "fsstress: check_cwd statbuf.st_ino (%llu) != top_ino (%llu)\n",
> +		(unsigned long long) statbuf.st_ino,
> +		(unsigned long long) top_ino);
> +out:
>  	assert(chdir(homedir) == 0);
>  	fprintf(stderr, "fsstress: check_cwd failure\n");
>  	abort();
> -- 
> 2.33.0
> 
