Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EF5C2B9F8
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 16:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C60376141C
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 16:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhEYQVZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 May 2021 12:21:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230511AbhEYQVY (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 25 May 2021 12:21:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E540161408;
        Tue, 25 May 2021 16:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621959595;
        bh=5Z+q9YHktV4oAtJwfWHuZExjziLdy88vLPKmrWWU1yY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M9lgrYd4hWp0VoCqqoqVOPxFBTMpGlc0PHjFSfjfH3raG2MO2eKSzfCyuZSuqWk2/
         sLXLQZqJxqIWOb2yT5k7lj14UN17IA9n/i6Ep7ar/dbSYMFOOyEZyirS3DCEHWJcqB
         bJI7QMa2v7nJRBm9BEi85PxC0eVrOk+gZoJKz3yrCkTUcMpe5MMZNLm9g1eZAtrUc8
         VkqHIqTrLTbTHXNnNv50ZFQZsVMF5fVQIeGiafag/hHTYZEGNNfXBOiXYXHQofouQo
         oG5alqwDD5cWWUbOkTK0deRyyRG5F2Z07MA1cjyiCmp7NjUlw/vYVWLsn7KhFPT2fd
         PBY9R7EAo/hhA==
Date:   Tue, 25 May 2021 09:19:54 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     fstests@vger.kernel.org, linux-afs@lists.infradead.org
Subject: Re: [PATCH 6/9] Add the ability to require O_TMPFILE to be supported
 for a test
Message-ID: <20210525161954.GG202095@locust>
References: <162194962878.4011860.5561077785368723619.stgit@warthog.procyon.org.uk>
 <162194966940.4011860.15702357969023449902.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162194966940.4011860.15702357969023449902.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 25, 2021 at 02:34:29PM +0100, David Howells wrote:
> Provide a '_require_o_tmpfile' clause so that a test can require than
> O_TMPFILE be supported by the filesystem being tested.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-afs@lists.infradead.org

Looks good to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
> 
>  common/rc                    |    9 +++++++++
>  doc/requirement-checking.txt |    7 +++++++
>  tests/generic/531            |    1 +
>  3 files changed, 17 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index e25967d9..c0659215 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4640,6 +4640,15 @@ _require_unix_perm_checking()
>  	esac
>  }
>  
> +_require_o_tmpfile()
> +{
> +	case $FSTYP in
> +	afs)
> +		_notrun "O_TMPFILE is not supported on $FSTYP"
> +		;;
> +	esac
> +}
> +
>  init_rc
>  
>  ################################################################################
> diff --git a/doc/requirement-checking.txt b/doc/requirement-checking.txt
> index 9be7a84c..b708887b 100644
> --- a/doc/requirement-checking.txt
> +++ b/doc/requirement-checking.txt
> @@ -21,6 +21,7 @@ they have.  This is done with _require_<xxx> macros, which may take parameters.
>  	_require_sgid_inheritance
>  	_require_use_local_uidgid
>  	_require_unix_perm_checking
> +	_require_o_tmpfile
>  
>   (3) System call requirements.
>  
> @@ -129,6 +130,12 @@ _require_unix_perm_checking
>       some alternative distributed permissions model involving authentication
>       tokens rather than the local fsuid/fsgid.
>  
> +_require_o_tmpfile
> +
> +     The test requires that O_TMPFILE is supported by open() on that
> +     filesystem, thereby allowing the creation of temporary files to be used or
> +     tested.
> +
>  
>  ========================
>  SYSTEM CALL REQUIREMENTS
> diff --git a/tests/generic/531 b/tests/generic/531
> index e76418ca..2f3b1dc6 100755
> --- a/tests/generic/531
> +++ b/tests/generic/531
> @@ -32,6 +32,7 @@ _cleanup()
>  _supported_fs generic
>  _require_scratch
>  _require_test_program "t_open_tmpfiles"
> +_require_o_tmpfile
>  
>  rm -f $seqres.full
>  _scratch_mkfs >> $seqres.full 2>&1
> 
> 
