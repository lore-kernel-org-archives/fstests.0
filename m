Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02092C77B78
	for <linux-fstests@archiver.kernel.org>; Wed, 26 Apr 2023 14:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239361AbjDZOgS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 26 Apr 2023 10:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241427AbjDZOgR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 Apr 2023 10:36:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C50FE69
        for <fstests@vger.kernel.org>; Wed, 26 Apr 2023 07:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682519732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9mSW7Om0LFpOfN5OtpynDq2Kn2/xv+bBCDg4fRx6a3A=;
        b=Q4vs3tDGOn5VhCuU3m291+1iaXM1EOmIQFb80O0mKFKdaucq9GdyysCSRXt9YYoPvWabJI
        wgVGOQxNfyvu6apUdtq6bQQbJ2qz3Ix/RDNfwH7sCgqZJuWXCJVfYaTC1yUdgw9PXkX9M6
        pznRoObaOhJKr8GRXqrHWtB+6usPg9o=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-gUDqtQuhP4eWJ8CZ_6ehEA-1; Wed, 26 Apr 2023 10:35:31 -0400
X-MC-Unique: gUDqtQuhP4eWJ8CZ_6ehEA-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-640f5191c79so7252820b3a.1
        for <fstests@vger.kernel.org>; Wed, 26 Apr 2023 07:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682519730; x=1685111730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mSW7Om0LFpOfN5OtpynDq2Kn2/xv+bBCDg4fRx6a3A=;
        b=fMosHePnRK7fiCJDRlISGeRGIwyTGOHcm7j6B1Cc8+0Dk0wKmoUGa+hZ278FRfZE0+
         73n1W56qsbI12rkYxR4i3Shmcz0uhNlkEjhhLCq2XN0dIpMq5teA9Q5IYuUw+Gx08/h5
         KGWF7KF0J6COzGEJ27SorKm0FA4gA1XZuH2J45KQ7ACdNAJhnRRLj+RKILRYUKyabP2S
         QwJNtK56L1hHJbXiXi7NoVm1xVBznRhWCveCo89rxGozQRoGjUNEx4PJDC6e2n9DfcrQ
         Y+IKZxnmvLXirpISYhd/iWaS+jKCFWmXPJyPRVv7xI68zmcVstxSXiG5MS0WeuILgsTV
         S4QA==
X-Gm-Message-State: AC+VfDx4b6E9hcR6LC/r8LlDsGrvEEWDpQbmdbU7+inrV9u0YwXTrKWu
        x8OTtUNwdyLRWwzXt0sVqxoraUG/FTTfJRovqfejlg++A9tSuSoo+JQxiTymupFV+7skeHFc2Iu
        Vs9Vsdpav8uY5o2nY0g==
X-Received: by 2002:a05:6a00:2e92:b0:63b:54e4:871b with SMTP id fd18-20020a056a002e9200b0063b54e4871bmr3181858pfb.8.1682519729841;
        Wed, 26 Apr 2023 07:35:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ68hf+HO0rz5nw/J4p1fly1VgJOzMCLwUYABapzIPQg5wUceUonpS8G+k5vUHvHeeyI34lcMA==
X-Received: by 2002:a05:6a00:2e92:b0:63b:54e4:871b with SMTP id fd18-20020a056a002e9200b0063b54e4871bmr3181816pfb.8.1682519729434;
        Wed, 26 Apr 2023 07:35:29 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id f9-20020a056a001ac900b00640d80c8a2bsm5374709pfv.50.2023.04.26.07.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 07:35:29 -0700 (PDT)
Date:   Wed, 26 Apr 2023 22:35:24 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
        Eryu Guan <guan@eryu.me>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jeffrey Altman <jaltman@auristor.com>,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v2 2/6] generic/314, afs: Allow for a filesystem that
 doesn't honour SGID inheritance
Message-ID: <20230426143524.rqwf2viwxygtbled@zlang-mailbox>
References: <20230424141042.450535-1-dhowells@redhat.com>
 <20230424141042.450535-3-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424141042.450535-3-dhowells@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 24, 2023 at 03:10:38PM +0100, David Howells wrote:
> The AFS filesystem doesn't do any special handling for the SUID, SGID and
> SVTX bits and doesn't perform any sort of propagation.  Further, only a
> user with cell admin rights can set non-0777 bits.
> 
> Handle this by adding a "_require_sgid_inheritance" clause and labelling
> the test with it, thereby skipping for filesystems that don't support it.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> cc: linux-afs@lists.infradead.org
> ---

Make sense to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/rc                    | 9 +++++++++
>  doc/requirement-checking.txt | 7 +++++++
>  tests/generic/314            | 1 +
>  3 files changed, 17 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 8b8cb714..00c5fcfe 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5097,6 +5097,15 @@ _save_coredump()
>  	$COREDUMP_COMPRESSOR -f "$out_file"
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
> index 45d2756b..a3588ee9 100644
> --- a/doc/requirement-checking.txt
> +++ b/doc/requirement-checking.txt
> @@ -16,6 +16,7 @@ they have.  This is done with _require_<xxx> macros, which may take parameters.
>  
>  	_require_chattr <letters>
>  	_require_exportfs
> +	_require_sgid_inheritance
>  
>   (3) System call requirements.
>  
> @@ -97,6 +98,12 @@ _require_exportfs
>       The test also requires the use of the open_by_handle_at() system call and
>       will be skipped if it isn't available in the kernel.
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
> index 9449d30f..dd617089 100755
> --- a/tests/generic/314
> +++ b/tests/generic/314
> @@ -17,6 +17,7 @@ _supported_fs generic
>  _require_test
>  _require_user
>  _require_chown
> +_require_sgid_inheritance
>  
>  rm -rf $TEST_DIR/$seq-dir
>  
> 

