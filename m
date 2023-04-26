Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F24C7618E
	for <linux-fstests@archiver.kernel.org>; Wed, 26 Apr 2023 14:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240555AbjDZOsG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 26 Apr 2023 10:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjDZOsF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 Apr 2023 10:48:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86088D8
        for <fstests@vger.kernel.org>; Wed, 26 Apr 2023 07:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682520437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=loMCfPH/VYakfQmyKjfwXgGLWC1qMbq/grP5s/gHDhk=;
        b=dyoahDDnvff9dmkBlBo4ObgLleUCn3CjB7YANnqK1QB4KMC02wd98qwjpvPRLDXAMI3HRD
        egBbkSXsZsYS+ipcxpLHo2JY76vIDKdhLEyLczjQH4Bw4lZmRIljAq8SwQ0O0m2KJwZRtj
        KX5gIMsrexD8UZIMFBLr6sUACX5WNVU=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-0GPZ4LH7Nly3VkLy7aYnBw-1; Wed, 26 Apr 2023 10:47:15 -0400
X-MC-Unique: 0GPZ4LH7Nly3VkLy7aYnBw-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-52855ba7539so2068340a12.3
        for <fstests@vger.kernel.org>; Wed, 26 Apr 2023 07:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682520435; x=1685112435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loMCfPH/VYakfQmyKjfwXgGLWC1qMbq/grP5s/gHDhk=;
        b=IhP+UkfntN9NsBHXgBmyFNfoMvXDqi9qCghHfJ9UNt3nAG9xl2bZQfe1IC//4PTBst
         CxY4sQ7GqAmdFnVof9MQJKZ7UCUnzm5Fb1hL/DD87GZWIicCFQjBbbWPM5eiWNCldfbm
         BwMEOJYk9eoOWw9qbbONYupAuJyo4eH6BfPYHpOeKW4+ezP2ZnqG79LuHReOpXk8WAep
         mvs2+3REa9J77GuRHi3o/kLcjqs3PeeRdZ8rblZIohunZVG3JZudyX/ygDuwWCeiyFXi
         tCVP1wZuDVzappzvASWDLCY298xadIRLAjrMP9EYjK3MLE0r2+xBHEBjV7iJvjI9ZADL
         E4mA==
X-Gm-Message-State: AAQBX9cIv4pwhb/wmUoKecN3L+TUcEgCelw2kLuCVdipeCFYFckd+SBL
        NhBERY+put5ITRFI4gk28T8fmuygHWeLHp9YnL1DbjKbRjT+ZVPwSrKM3m4yz2aYq8a7WLdzR87
        QcshsNh5j0ed4rsPAnQ==
X-Received: by 2002:a17:90a:4741:b0:249:6a63:7b8e with SMTP id y1-20020a17090a474100b002496a637b8emr19920038pjg.5.1682520434243;
        Wed, 26 Apr 2023 07:47:14 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZacCAdvjV9tFBV8NVWih4PJYyhU31iSGwBfjp91hjynhYn+a43SWgIE7kqQMxB/V+a0WmG0A==
X-Received: by 2002:a17:90a:4741:b0:249:6a63:7b8e with SMTP id y1-20020a17090a474100b002496a637b8emr19920016pjg.5.1682520433858;
        Wed, 26 Apr 2023 07:47:13 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090adc0400b00246aba3ebabsm11567214pjv.45.2023.04.26.07.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 07:47:13 -0700 (PDT)
Date:   Wed, 26 Apr 2023 22:47:08 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
        Eryu Guan <guan@eryu.me>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jeffrey Altman <jaltman@auristor.com>,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v2 4/6] generic/123, generic/128, afs: Allow for an fs
 that does its own perm management
Message-ID: <20230426144708.gxptshtwhw6wrubp@zlang-mailbox>
References: <20230424141042.450535-1-dhowells@redhat.com>
 <20230424141042.450535-5-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424141042.450535-5-dhowells@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 24, 2023 at 03:10:40PM +0100, David Howells wrote:
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
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/rc                    | 9 +++++++++
>  doc/requirement-checking.txt | 8 ++++++++
>  tests/generic/123            | 1 +
>  tests/generic/128            | 1 +
>  4 files changed, 19 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index e0978a03..4dfc3301 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5115,6 +5115,15 @@ _require_use_local_uidgid()
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
> index f24ecf5c..802bf2a3 100644
> --- a/doc/requirement-checking.txt
> +++ b/doc/requirement-checking.txt
> @@ -18,6 +18,7 @@ they have.  This is done with _require_<xxx> macros, which may take parameters.
>  	_require_exportfs
>  	_require_sgid_inheritance
>  	_require_use_local_uidgid
> +	_require_unix_perm_checking
>  
>   (3) System call requirements.
>  
> @@ -112,6 +113,13 @@ _require_use_local_uidgid
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
> index f9b28abb..43f90b46 100755
> --- a/tests/generic/123
> +++ b/tests/generic/123
> @@ -28,6 +28,7 @@ _supported_fs generic
>  
>  _require_test
>  _require_user
> +_require_unix_perm_checking
>  
>  my_test_subdir=$TEST_DIR/123subdir
>  
> diff --git a/tests/generic/128 b/tests/generic/128
> index dc1d43f4..924d6aa8 100755
> --- a/tests/generic/128
> +++ b/tests/generic/128
> @@ -18,6 +18,7 @@ _supported_fs generic
>  _require_scratch
>  _require_user
>  _require_chmod
> +_require_unix_perm_checking
>  
>  _scratch_mkfs >/dev/null 2>&1
>  _scratch_mount "-o nosuid"
> 

