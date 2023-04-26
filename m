Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D127C7618E
	for <linux-fstests@archiver.kernel.org>; Wed, 26 Apr 2023 14:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241012AbjDZOlF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 26 Apr 2023 10:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240836AbjDZOlE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 Apr 2023 10:41:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B1A59FB
        for <fstests@vger.kernel.org>; Wed, 26 Apr 2023 07:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682520022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=byOOcjZiDxWHApSomlqtTYrrNXC05udl/JfSDFfIbn8=;
        b=b5ma68aW3dliS5nTNJ6f8jC7H0jxARkC7xzoZGZtDyF8YRETWgh6il/p2APXn+OyOG3zMu
        wNSfXgHLefX8i8KqEbatBSWmnnZNT1Eo4JbWN5rb9qn1ktSv2La6rgdDvlXrLAvPvhy3Th
        u+azwAM29SEpqKGGCV10eFHt0r4YaqE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-EW5p3iBkNKeGx1hbvZKIVA-1; Wed, 26 Apr 2023 10:40:20 -0400
X-MC-Unique: EW5p3iBkNKeGx1hbvZKIVA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2475e9ec1c5so3944128a91.0
        for <fstests@vger.kernel.org>; Wed, 26 Apr 2023 07:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682520020; x=1685112020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byOOcjZiDxWHApSomlqtTYrrNXC05udl/JfSDFfIbn8=;
        b=CqDlsiwwvxxLvpXZjCaKREyUpnQA1VCy3pJmukodzxTW0RlgrqMZSxxTrHvWjOx6yi
         3COSLbqB2OKTktNhEQGlxDma04cpxU4vIkzI5LJz7rLyVVbKC/dnAzKcc6/Lxv9yAi+j
         4VGIiQqgC+sKDWJ3Nhh++q8GgFLGb7YHBHsnP5LTCSVTs4Wg3xROIEQdr1Onr0LdkQwi
         /bm6g/LnQpWlOIFxEngSh+RQnruGYChMeIMEDEzlf2mvADWp/b+VqRqvllVWeRMJml8Z
         Ea3mxer77vSHOjNrjFF4tDv7MG8fRaAVgYWH222AtbjjlvAqovdkajAeDohC8sDHVOSg
         RSYA==
X-Gm-Message-State: AAQBX9eXTO2yFQvrP/dIaUdC8vFQYhFo0UxLEOYxIovxBfEQXoxFhxV7
        mDH5dhQkqmiP8Sjg0JNWfta/UxnoDxN61lWGERPS+m53tT8s75LyaaRjPByoW0cGrTMs4oFpseA
        WC3NdOBaAJ8zBl0hY4A==
X-Received: by 2002:a17:90a:bb0f:b0:246:63c8:6abf with SMTP id u15-20020a17090abb0f00b0024663c86abfmr21667535pjr.20.1682520019696;
        Wed, 26 Apr 2023 07:40:19 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y/4a2/peWv28zF15eEnA/yQ8zqV/l2wVIMLKbomPhRAsQr5V+/yqCpcsOJ5oxHS0Xd5aHxzg==
X-Received: by 2002:a17:90a:bb0f:b0:246:63c8:6abf with SMTP id u15-20020a17090abb0f00b0024663c86abfmr21667515pjr.20.1682520019321;
        Wed, 26 Apr 2023 07:40:19 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id a7-20020a17090acb8700b00246b5a609d2sm9884520pju.27.2023.04.26.07.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 07:40:18 -0700 (PDT)
Date:   Wed, 26 Apr 2023 22:40:14 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
        Eryu Guan <guan@eryu.me>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jeffrey Altman <jaltman@auristor.com>,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v2 3/6] generic/317, afs: Allow for a filesystem not to
 honour the local uid/gid
Message-ID: <20230426144014.x73py4loqo6qkahz@zlang-mailbox>
References: <20230424141042.450535-1-dhowells@redhat.com>
 <20230424141042.450535-4-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424141042.450535-4-dhowells@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 24, 2023 at 03:10:39PM +0100, David Howells wrote:
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

Make sense. Maybe not only AFS need this, but that's another story in other
patches. For this one:

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/rc                    | 9 +++++++++
>  doc/requirement-checking.txt | 8 ++++++++
>  tests/generic/317            | 1 +
>  3 files changed, 18 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 00c5fcfe..e0978a03 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5106,6 +5106,15 @@ _require_sgid_inheritance()
>  	esac
>  }
>  
> +_require_use_local_uidgid()
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
> index a3588ee9..f24ecf5c 100644
> --- a/doc/requirement-checking.txt
> +++ b/doc/requirement-checking.txt
> @@ -17,6 +17,7 @@ they have.  This is done with _require_<xxx> macros, which may take parameters.
>  	_require_chattr <letters>
>  	_require_exportfs
>  	_require_sgid_inheritance
> +	_require_use_local_uidgid
>  
>   (3) System call requirements.
>  
> @@ -104,6 +105,13 @@ _require_sgid_inheritance
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
> index 134d5e3f..39cccc8b 100755
> --- a/tests/generic/317
> +++ b/tests/generic/317
> @@ -38,6 +38,7 @@ _require_user
>  _require_ugid_map
>  _require_userns
>  _require_chown
> +_require_use_local_uidgid
>  qa_user_id=`id -u $qa_user`
>  
>  _filter_output()
> 

