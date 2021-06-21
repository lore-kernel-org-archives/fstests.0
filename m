Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E663BC4743C
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Jun 2021 17:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9ABE6102A
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Jun 2021 17:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbhFURCz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 21 Jun 2021 13:02:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231286AbhFURC1 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 21 Jun 2021 13:02:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A09A260C3F;
        Mon, 21 Jun 2021 17:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624294812;
        bh=gBspFvDa1uOj9tPnhhsdyjrWYRu+lezJ3F3lD4/Vkk8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AdIOrX2HEnEQrlFPkpGwwH4gKO0YCIklUKbuad2WQHRd8Exwq2HHU17lI+kZhiN2m
         I5STX49zA/q/e4cw5QO+uZyzWskpCEtf4mrzI1i6YUaN2rI0/zZUgv6cQvGkePbr6H
         0x+scH0T2G+scCWGUaSINEkXwPsNu630nImBJ7upJftOMd7Af8jUD3qXyxRmyvDcUA
         C0p45oIa2ry7go7FRro1kHzE93XyTNKKMpYRYr/B3KbYWlbHKhtKvquBHTYksjNtBn
         u4atWoTzdeXhHwBxLQ2jvjWbL1RNrCcY8qxolrq4DseHpvzuA31Qlz0a/GKe7VB/YG
         kJnSFiEeb9xNA==
Date:   Mon, 21 Jun 2021 10:00:12 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/556: add a check to make sure ext4 supports
 encrypted casefolding
Message-ID: <20210621170012.GF158186@locust>
References: <20210621164901.1809010-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621164901.1809010-1-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jun 21, 2021 at 12:49:01PM -0400, Theodore Ts'o wrote:
> Some older kernels support ext4 file systems with encryption enabled,
> and with casefold enabled, but not file systems have both encryption
> *and* casefolding enabled.  On those kernels, generic/556 will fail.
> Fortunately, we can test if ext4 supports encrypted casefold via the
> presence of /sys/fs/ext4/features/encrypted_casefold.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  common/casefold   | 17 +++++++++++++++++
>  tests/generic/556 |  1 +
>  2 files changed, 18 insertions(+)
> 
> diff --git a/common/casefold b/common/casefold
> index 9172d818..7b76b986 100644
> --- a/common/casefold
> +++ b/common/casefold
> @@ -43,6 +43,23 @@ _require_scratch_casefold()
>  	_require_command "$LSATTR_PROG" lsattr
>  }
>  
> +_require_encrypted_casefold ()
> +{
> +    case $FSTYP in
> +	ext4)
> +	    if test ! -f /sys/fs/ext4/features/casefold ; then
> +		_notrun "casefolding not supported"
> +	    fi
> +	    if test ! -f /sys/fs/ext4/features/encryption ; then
> +		_notrun "file system encryption not supported"
> +	    fi
> +	    if test ! -f /sys/fs/ext4/features/encrypted_casefold ; then
> +		_notrun "encrypted casefolding not supported"

Dumb question: Are there kernels that support encrypted casefold but not
those two components separately?

--D

> +	    fi
> +	    ;;
> +	esac
> +}
> +
>  _scratch_mkfs_casefold()
>  {
>  	case $FSTYP in
> diff --git a/tests/generic/556 b/tests/generic/556
> index 3145188c..7916a08e 100755
> --- a/tests/generic/556
> +++ b/tests/generic/556
> @@ -16,6 +16,7 @@ status=1 # failure is thea default
>  . ./common/attr
>  
>  _supported_fs generic
> +_require_encrypted_casefold
>  _require_scratch_nocheck
>  _require_scratch_casefold
>  _require_symlinks
> -- 
> 2.31.0
> 
