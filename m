Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE92EC2B9F8
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 16:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB9E66140E
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 16:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhEYQTB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 May 2021 12:19:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231204AbhEYQTA (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 25 May 2021 12:19:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78421611C2;
        Tue, 25 May 2021 16:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621959450;
        bh=TbKyj6xKcUOJQJfIHGXPq4RdaHvsIlC0DRN28gHzaEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bDl4jR9yT/8c0KklS4qvSV7pVndLIdG1sOqtOqqsQx7KchIPTAMR3SArtKDhX7VUW
         crz6PAAs2sJCclXx/gzNVVKo/Le3Ni2izQ6D3D19025ybyT2rpBXJrH04G6CeNsEPZ
         C0SzpojiYvk+t9bU5w0GyxUEIHsjfXgqb9TbmyPi7FOCbGRchXLf3IswfZPcJJl731
         0Snw9brH/q537ril0pzrjQySJrHxMajm8kAEn3TDgD/Lvh9Uj9OtK3IZZMYbvqDJ8l
         D2AGZTucFqJMWBDeyb6pNG36ADQv7/Ehotp3RV/I4jBvKjopTlv9b0WkPABc+DLPwP
         V3ETgqpxHJH4w==
Date:   Tue, 25 May 2021 09:17:30 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     fstests@vger.kernel.org, linux-afs@lists.infradead.org
Subject: Re: [PATCH 4/9] generic/317, afs: Allow for a filesystem not to
 honour the local uid/gid
Message-ID: <20210525161730.GE202095@locust>
References: <162194962878.4011860.5561077785368723619.stgit@warthog.procyon.org.uk>
 <162194965595.4011860.7333324355639736586.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162194965595.4011860.7333324355639736586.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 25, 2021 at 02:34:15PM +0100, David Howells wrote:
> Each AFS cell has it's own set of user IDs that is uses internally, in its
> ACL system and in its protection management protocol.  The user ID used by
> the fileserver is selected from the set belonging to the fileserver's cell
> according to the authentication token associated with an RPC operation -
> and this is set as a file's user ID when it is created.
> 
> This means that tests that expect to set a UID and see the same UID still
> set afterwards will fail.
> 
> Add a "_require_use_local_uidgid" clause to indicate that a test expects
> internal UID/GID information to be seen in the stat output and should be
> skipped if AFS's case.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-afs@lists.infradead.org
> ---
> 
>  common/rc                    |    9 +++++++++
>  doc/requirement-checking.txt |    8 ++++++++
>  tests/generic/317            |    1 +
>  3 files changed, 18 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 4d4b0280..a04433da 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4622,6 +4622,15 @@ _require_sgid_inheritance()
>  	esac
>  }
>  
> +_require_use_local_uidgid()

I find "local uid" to be misleading here -- I read it as "requires
system to use local user/group ids", as opposed to getting user and
group data from an external service like NIS/YP/AD.

What you're really testing for is that new files inherit the fs[ug]id of
the process.  How about we make that explicit in the name:

_require_inherit_process_fsuid()
_require_inherit_process_fsgid()

?

--D

> +{
> +	case $FSTYP in
> +	afs)
> +		_notrun "$FSTYP doesn't honour local uid and gid"
> +		;;
> +	esac
> +}
> +
>  init_rc
>  
>  ################################################################################
> diff --git a/doc/requirement-checking.txt b/doc/requirement-checking.txt
> index 6efc8dc8..c945e16a 100644
> --- a/doc/requirement-checking.txt
> +++ b/doc/requirement-checking.txt
> @@ -19,6 +19,7 @@ they have.  This is done with _require_<xxx> macros, which may take parameters.
>  	_require_mknod
>  	_has_mknod
>  	_require_sgid_inheritance
> +	_require_use_local_uidgid
>  
>   (3) System call requirements.
>  
> @@ -113,6 +114,13 @@ _require_sgid_inheritance
>       of the SGID bit and the GID from a marked directory.  The test will be
>       skipped if not supported.
>  
> +_require_use_local_uidgid
> +
> +     The test requires that the $TEST_DEV filesystem sets the uid and gid of a
> +     newly created file to the creating process's fsuid and fsgid.  Remote
> +     filesystems, for example, may choose other settings or not even have these
> +     concepts available.  The test will be skipped if not supported.
> +
>  
>  ========================
>  SYSTEM CALL REQUIREMENTS
> diff --git a/tests/generic/317 b/tests/generic/317
> index 289dfabe..112e2e97 100755
> --- a/tests/generic/317
> +++ b/tests/generic/317
> @@ -46,6 +46,7 @@ _require_user
>  _require_ugid_map
>  _require_userns
>  _require_chown
> +_require_use_local_uidgid
>  qa_user_id=`id -u $qa_user`
>  
>  _filter_output()
> 
> 
