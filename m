Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7599CC433E6
	for <linux-fstests@archiver.kernel.org>; Tue,  9 Feb 2021 16:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BA0D64EC4
	for <linux-fstests@archiver.kernel.org>; Tue,  9 Feb 2021 16:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbhBIQdF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 9 Feb 2021 11:33:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:42354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232845AbhBIQdF (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 9 Feb 2021 11:33:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6DC0264D9D;
        Tue,  9 Feb 2021 16:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612888345;
        bh=l+qkCfMO1expC6asD1LIP6Y6wBNff0Ivk7+ZR7OYLZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mhUhlfh0Z9pPkRqk9OTJ8q81S8iiTshUSNtikRWkJpGwSUjCoj3MxKhNFvD7/R1sx
         uHEJ9shW6uSQ6v4phHKC7d/0lg/fJJXoa9L184DqkcmE9elp/v5PAHLKkbcAuWS2gp
         kKpQyZQAg2ahm3Xsln0goen+4UDdkAneg5yxmwKZ+zm3gU49L3kf7lF9ju8sYWh3Fm
         cdpyL+khulVYGKdI6OwQvv/bv5a5Tv8Fttzt8okmax0rjZudDiJ9OGTwm9mUD24n4A
         0ZLfRNAcJOyO8urojkikn7MimMKRT4Pia2hvS8mSJYc0drqFsCxT4l8Cyy/NdlJTf3
         6u47PSa9UPB+w==
Date:   Tue, 9 Feb 2021 08:32:25 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     David Sterba <dsterba@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] src/splice-test.c: use memalign instead of aligned_alloc
Message-ID: <20210209163225.GC7190@magnolia>
References: <20210209155715.28804-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209155715.28804-1-dsterba@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Feb 09, 2021 at 04:57:15PM +0100, David Sterba wrote:
> The build fails on SLE11 as the function aligned_alloc is not available
> there. Replace it by memalign that has the same semantics and is
> commonly used in fstests code base. aligned_alloc has additional
> requirements on the alignment and buffer size but that is ok as the
> buffer is defined in multiples of the alignment.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Looks reasonable to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  src/splice-test.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/src/splice-test.c b/src/splice-test.c
> index 11fb11fa8cc3..2f1ba2baaff0 100644
> --- a/src/splice-test.c
> +++ b/src/splice-test.c
> @@ -17,6 +17,7 @@
>  #include <stdbool.h>
>  #include <string.h>
>  #include <errno.h>
> +#include <malloc.h>
>  
>  #define SECTOR_SIZE 512
>  #define BUFFER_SIZE (150 * SECTOR_SIZE)
> @@ -143,9 +144,9 @@ int main(int argc, char *argv[])
>  		   do_splice == do_splice1 ? "sequential" : "concurrent",
>  		   (open_flags & O_DIRECT) ? "with" : "without");
>  
> -	buffer = aligned_alloc(SECTOR_SIZE, BUFFER_SIZE);
> +	buffer = memalign(SECTOR_SIZE, BUFFER_SIZE);
>  	if (buffer == NULL)
> -		err(1, "aligned_alloc");
> +		err(1, "memalign");
>  
>  	fd = open(filename, open_flags, 0666);
>  	if (fd == -1)
> -- 
> 2.29.2
> 
