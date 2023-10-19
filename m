Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CB0CDB465
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Oct 2023 06:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbjJSGAs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 Oct 2023 02:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbjJSGAc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 Oct 2023 02:00:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A60324D
        for <fstests@vger.kernel.org>; Wed, 18 Oct 2023 22:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697695106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7h9e+7MVNSCuXHhdJhZ7De7cTPQQ65KWR7SPJr1KBk0=;
        b=bgd+TF5067Gi8B9fV/fhOiCqz+RbwausiRQY8pLF8RTnFUxWosmlywaoUOj6QuAuBM4WCo
        YZRkePZ/VGmBKr8X4oC8eAZd4RSqEGLLbfL99n8bmtLF4tYAWbEISzpPxo+YYue16PCudF
        ywcW+SmrDoXTE5ODPiLXYl6/IprCP+E=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-mVeEJ6cFPW2ju0SX9G_tMA-1; Thu, 19 Oct 2023 01:58:23 -0400
X-MC-Unique: mVeEJ6cFPW2ju0SX9G_tMA-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6b31cb3cc7eso381740b3a.0
        for <fstests@vger.kernel.org>; Wed, 18 Oct 2023 22:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697695102; x=1698299902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7h9e+7MVNSCuXHhdJhZ7De7cTPQQ65KWR7SPJr1KBk0=;
        b=EN1v1NWa2h0WxDkIRS3KIKKBwt2y5n93BtJ6OZ6oS11qf6z8YAyNIWKIywiQuAFr4b
         IQnRIA0RszXzvYUwmoCdPwtodPmdRMgYch2F6zGtXBaH9FdyB090cKibddHCg3VcebuM
         N053Oz5Rf7BUnfAe6UbLCyVxw9kE37z3fCOLTisT/s8sXl5zYS3OfkXVjdtjI0rpSv01
         JMQzUjCu8eDLUwN/CJncKmtFqO5BVoUuJuLX5MM4X4/75NGe3752P7clT9XQ8WIYe5Zy
         R/odKYsufqjCtCzltYmibzK4hobzBWISLerd9f18/4mvsTr+kvMZ4dKDXbyy0q/KtrTm
         X20A==
X-Gm-Message-State: AOJu0YxgbXSKH1RH8/vfQ3gwY9iuaoI8xWHpyhbrGFmbAL5W+sOKv67Z
        KK05eDa5uRjI8yhvtXjgK9wr8ASdOoXa/4QAGPB4v6b3lngwl4ff0DB5jBm7muDff/uEbEP1zcV
        8ITq4Q7p4BC3sgZD8KQ==
X-Received: by 2002:a05:6a00:23c6:b0:690:f877:aa1e with SMTP id g6-20020a056a0023c600b00690f877aa1emr1546522pfc.12.1697695102713;
        Wed, 18 Oct 2023 22:58:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHC0tphMh/qoXrWLAFWS2B4PNrqkeIsBiLrVZSoHL4MPce2G9jC89TQS1GvSnFnb8ZjkT/9dw==
X-Received: by 2002:a05:6a00:23c6:b0:690:f877:aa1e with SMTP id g6-20020a056a0023c600b00690f877aa1emr1546504pfc.12.1697695102371;
        Wed, 18 Oct 2023 22:58:22 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g12-20020aa79dcc000000b0068c90e1ec84sm4283542pfq.167.2023.10.18.22.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 22:58:22 -0700 (PDT)
Date:   Thu, 19 Oct 2023 13:58:19 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Su Yue <glass.su@suse.com>
Cc:     fstests@vger.kernel.org, l@damenly.org
Subject: Re: [PATCH v2] generic/245: Filter mv error message
Message-ID: <20231019055819.lxymwrorjubrtg2o@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20231019015356.23648-1-glass.su@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019015356.23648-1-glass.su@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Oct 19, 2023 at 09:53:56AM +0800, Su Yue wrote:
> Coreutils commit 3cb862ce5f10 ( mv: better diagnostic for 'mv dir x' failure)
> was released in v9.4, changed the error message from
> 'mv: cannot move 'b/t' to 'a/t': Directory not empty' to
> 'mv: cannot overwrite 'a/t': Directory not empty' in case of
> EDQUOT/EEXIST/EISDIR/EMLINK/ENOSPC/ENOTEMPTY/ETXTBSY.
> 
> The change breaks generic/245 due to the mismatched output:
> 
> generic/245 1s ... - output mismatch (see /root/xfstests-dev/results//generic/245.out.bad)
>     --- tests/generic/245.out   2023-10-05 11:15:21.124295738 +0800
>     +++ /root/xfstests-dev/results//generic/245.out.bad 2023-10-05 11:15:23.456315468 +0800
>     @@ -1,2 +1,2 @@
>     QA output created by 245
>     -mv: cannot move 'TEST_DIR/test-mv/ab/aa/' to 'TEST_DIR/test-mv/aa': File exists
>     +mv: cannot overwrite 'TEST_DIR/test-mv/aa': File exists
>     ...
>     (Run 'diff -u /root/xfstests-dev/tests/generic/245.out /root/xfstests-dev/results//generic/245.out.bad'  to see the entire diff)
> 
> Filter out and replace mv error messages to fix the test.
> 
> Signed-off-by: Su Yue <glass.su@suse.com>
> ---
> v2:
>   change sed regrex expression as Zorro suggested.
> ---
>  tests/generic/245     | 5 ++++-
>  tests/generic/245.out | 2 +-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/245 b/tests/generic/245
> index e2d5c926e906..8e0f22366db3 100755
> --- a/tests/generic/245
> +++ b/tests/generic/245
> @@ -29,9 +29,12 @@ _cleanup()
>  # According to the rename(2) manpage you can get either EEXIST or ENOTEMPTY as an
>  # error for trying to rename a non-empty directory, so just catch the error for
>  # ENOTMEMPTY and replace it with the EEXIST output so that either result passes
> +# Also, mv v9.4+ modified error message when a nonempty destination directory fails
> +# to be overwriteen
>  _filter_directory_not_empty()
>  {
> -	sed -e "s,Directory not empty,File exists,g"
> +	sed -e "s,Directory not empty,File exists,g" \
> +		-e "s,cannot move .* to \(.*\):\(.*\),cannot overwrite \1:\2,g"

This version looks good to me, just the alignment problem, I'll change it a bit
when I merge it.

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

>  }
>   
>  
> diff --git a/tests/generic/245.out b/tests/generic/245.out
> index f5b5f182619d..19b598e4a175 100644
> --- a/tests/generic/245.out
> +++ b/tests/generic/245.out
> @@ -1,2 +1,2 @@
>  QA output created by 245
> -mv: cannot move 'TEST_DIR/test-mv/ab/aa/' to 'TEST_DIR/test-mv/aa': File exists
> +mv: cannot overwrite 'TEST_DIR/test-mv/aa': File exists
> -- 
> 2.41.0
> 

