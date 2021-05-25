Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D5FC2B9F8
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 16:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 033956140F
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 16:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhEYQU5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 May 2021 12:20:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231839AbhEYQU4 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 25 May 2021 12:20:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64999611C2;
        Tue, 25 May 2021 16:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621959566;
        bh=AMnAvZALXsXC1/C820KLZcCzmr/MZQYIrgzKFgcidaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VStJBRXcfiqWBHBNqPNXQRGbTi9uJuGz4gz1AfJrzDiqlpCyiOMC1ukbTNlYExBOG
         0shgNn42CMX9kKrBWjRk8h14/4x677/g1dlVNtWQZDkSyZK/GqWJQ+DF4zhDe7w0rt
         Ub4jJUld8qzQIhE710q1hvo2P9mHj5Q7qw4b5rN6oT5Hlo2N9ujjCz4BgShzJycpY7
         8Yl1nps6XYqT+u0zPoBV85saxtdZkH571N9wjhklfaeTifsPRkBlY9ZaBLIrLBNKMy
         FG/cwG07G3ISM8ChOlAivnpe5VP/KBFtseVVgWrX395w7ZVsGC+gHqXRVdmWWNXdec
         z+flBH5wf5i3A==
Date:   Tue, 25 May 2021 09:19:26 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     fstests@vger.kernel.org, linux-afs@lists.infradead.org
Subject: Re: [PATCH 5/9] generic/123, generic/128, afs: Allow for an fs that
 does its own perm management
Message-ID: <20210525161926.GF202095@locust>
References: <162194962878.4011860.5561077785368723619.stgit@warthog.procyon.org.uk>
 <162194966265.4011860.229488885734976223.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162194966265.4011860.229488885734976223.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 25, 2021 at 02:34:22PM +0100, David Howells wrote:
> The AFS filesystem has its own distributed permission management system
> that's based on a per-cell user and group database used in conjunction with
> ACLs.  The user is determined by the authentication token acquired from the
> kaserver or Kerberos, not by the local fsuid/fsgid.  For the most part, the
> uid, gid and mask on a file are ignored.
> 
> The generic/123 and generic/128 tests check that the UNIX permission bits do
> what would normally be expected of them - but this fails on AFS.  Using "su"
> to change the user is not effective on AFS.  Instead, "keyctl session" would
> need to be used and an alternative authentication token would need to be
> obtained.
> 
> Provide a "_require_unix_perm_checking" clause so that these tests can be
> suppressed in cases such as AFS.
> 
> Signed

Looks ok,
Reviewed

(I'll send the rest when the remainder of the SoB comes in. :P)

--D

> ---
> 
>  common/rc                    |    9 +++++++++
>  doc/requirement-checking.txt |    8 ++++++++
>  tests/generic/123            |    1 +
>  tests/generic/128            |    1 +
>  4 files changed, 19 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index a04433da..e25967d9 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4631,6 +4631,15 @@ _require_use_local_uidgid()
>  	esac
>  }
>  
> +_require_unix_perm_checking()
> +{
> +	case $FSTYP in
> +	afs)
> +		_notrun "$FSTYP doesn't perform traditional UNIX perm checking"
> +		;;
> +	esac
> +}
> +
>  init_rc
>  
>  ################################################################################
> diff --git a/doc/requirement-checking.txt b/doc/requirement-checking.txt
> index c945e16a..9be7a84c 100644
> --- a/doc/requirement-checking.txt
> +++ b/doc/requirement-checking.txt
> @@ -20,6 +20,7 @@ they have.  This is done with _require_<xxx> macros, which may take parameters.
>  	_has_mknod
>  	_require_sgid_inheritance
>  	_require_use_local_uidgid
> +	_require_unix_perm_checking
>  
>   (3) System call requirements.
>  
> @@ -121,6 +122,13 @@ _require_use_local_uidgid
>       filesystems, for example, may choose other settings or not even have these
>       concepts available.  The test will be skipped if not supported.
>  
> +_require_unix_perm_checking
> +
> +     The test requires that the $TEST_DEV filesystem performs traditional UNIX
> +     file permissions checking.  A remote filesystem, for example, might use
> +     some alternative distributed permissions model involving authentication
> +     tokens rather than the local fsuid/fsgid.
> +
>  
>  ========================
>  SYSTEM CALL REQUIREMENTS
> diff --git a/tests/generic/123 b/tests/generic/123
> index d2362e72..99ee4b9b 100755
> --- a/tests/generic/123
> +++ b/tests/generic/123
> @@ -33,6 +33,7 @@ _supported_fs generic
>  
>  _require_test
>  _require_user
> +_require_unix_perm_checking
>  
>  my_test_subdir=$TEST_DIR/123subdir
>  
> diff --git a/tests/generic/128 b/tests/generic/128
> index c1eae77a..91fdca1e 100755
> --- a/tests/generic/128
> +++ b/tests/generic/128
> @@ -25,6 +25,7 @@ _supported_fs generic
>  _require_scratch
>  _require_user
>  _require_chmod
> +_require_unix_perm_checking
>  
>  _scratch_mkfs >/dev/null 2>&1
>  _scratch_mount "-o nosuid"
> 
> 
