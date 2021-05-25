Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79ABC2B9F8
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 16:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8D0B6141C
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 16:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhEYQMU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 May 2021 12:12:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230150AbhEYQMT (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 25 May 2021 12:12:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4B9061378;
        Tue, 25 May 2021 16:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621959049;
        bh=Z8Xi8z0araNqBYdP8tZbhMNbbMpX2YzFN59+4xmSk+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VblbuXGCmPd4g3/w3TXus56mimhk7iH//DuEEe3qSG6gGT6lMPE5EfFCbUWA7Xq6M
         rRgfe220KERcv+vHATT/7NUwYBcyK8mKaH6bO01obqOBYzC0VSVvSCSgA6aUm1qdjw
         TWhgNT0dKQSN07qWLs0GdzLI2fOm5pPodYhtqAJFFVzRUEzet8mHAFokE0VCVsrzQe
         UOG7TOvPYbn8mz98unQMSiEzx3bKA3VlmorQCWWwPkMfnuuffQgAMI8zFUoIrz6osS
         NqajVtVrj/2EfzIHGpM32rDHBYqexQsyvi4pgmvJbCYe7LNUazw62vhtB8B9KacWto
         a6N9fcm//HKCQ==
Date:   Tue, 25 May 2021 09:10:49 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     fstests@vger.kernel.org, linux-afs@lists.infradead.org
Subject: Re: [PATCH 3/9] generic/314, afs: Allow for a filesystem that
 doesn't honour SGID inheritance
Message-ID: <20210525161049.GD202095@locust>
References: <162194962878.4011860.5561077785368723619.stgit@warthog.procyon.org.uk>
 <162194964929.4011860.17079665160292202971.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162194964929.4011860.17079665160292202971.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 25, 2021 at 02:34:09PM +0100, David Howells wrote:
> The AFS filesystem doesn't do any special handling for the SUID, SGID and
> SVTX bits and doesn't perform any sort of propagation.  Further, only a
> user with cell admin rights can set non-0777 bits.
> 
> Handle this by adding a "_require_sgid_inheritance" clause and labelling
> the test with it, thereby skipping for filesystems that don't support it.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

Looks ok,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> cc: linux-afs@lists.infradead.org
> ---
> 
>  common/rc                    |    9 +++++++++
>  doc/requirement-checking.txt |    7 +++++++
>  tests/generic/314            |    1 +
>  3 files changed, 17 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 4ffec9a2..4d4b0280 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4613,6 +4613,15 @@ _has_mknod()
>  	esac
>  }
>  
> +_require_sgid_inheritance()
> +{
> +	case $FSTYP in
> +	afs)
> +		_notrun "SGID-based group ID inheritance is not supported on $FSTYP"
> +		;;
> +	esac
> +}
> +
>  init_rc
>  
>  ################################################################################
> diff --git a/doc/requirement-checking.txt b/doc/requirement-checking.txt
> index d31ba3fb..6efc8dc8 100644
> --- a/doc/requirement-checking.txt
> +++ b/doc/requirement-checking.txt
> @@ -18,6 +18,7 @@ they have.  This is done with _require_<xxx> macros, which may take parameters.
>  	_require_exportfs
>  	_require_mknod
>  	_has_mknod
> +	_require_sgid_inheritance
>  
>   (3) System call requirements.
>  
> @@ -106,6 +107,12 @@ _has_mknod
>       _require_mknod will cause the test to be skipped; _has_mknod returns 0 if
>       mknod is supported and 1 otherwise.
>  
> +_require_sgid_inheritance
> +
> +     The test required that the $TEST_DEV filesystem supports the inheritance
> +     of the SGID bit and the GID from a marked directory.  The test will be
> +     skipped if not supported.
> +
>  
>  ========================
>  SYSTEM CALL REQUIREMENTS
> diff --git a/tests/generic/314 b/tests/generic/314
> index 540f0feb..8ed08542 100755
> --- a/tests/generic/314
> +++ b/tests/generic/314
> @@ -30,6 +30,7 @@ _supported_fs generic
>  _require_test
>  _require_user
>  _require_chown
> +_require_sgid_inheritance
>  
>  rm -rf $TEST_DIR/$seq-dir
>  
> 
> 
