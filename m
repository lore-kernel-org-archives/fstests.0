Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEDAC77B7A
	for <linux-fstests@archiver.kernel.org>; Thu, 18 May 2023 04:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjERES5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 18 May 2023 00:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjERES4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 18 May 2023 00:18:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7B840C0
        for <fstests@vger.kernel.org>; Wed, 17 May 2023 21:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684383473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uEA6AqpS0DyDBVyYLNGbg8ocSWRehXw6vg4bEH8ZuPY=;
        b=XT1mAFTwUaKnzdmepy6IqK4vrP6WkOALxPZrzGC6hnjwTGMt/6ID/WLwQlgQqhzkM7w0HW
        i4ESmgu+QISIGwV88Un+OItN0i+L2fRDgRbCdFdLJLRD5PcH3KY1hnwdRqtxbEAdWC1doz
        Eqb9b3Lmu3EK4ZazNUgM+j1grcqomSA=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-ivqnt_6GP4uzBSMG2CtiFg-1; Thu, 18 May 2023 00:17:51 -0400
X-MC-Unique: ivqnt_6GP4uzBSMG2CtiFg-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5289ce45f11so419988a12.0
        for <fstests@vger.kernel.org>; Wed, 17 May 2023 21:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684383470; x=1686975470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEA6AqpS0DyDBVyYLNGbg8ocSWRehXw6vg4bEH8ZuPY=;
        b=MbmnfS6vIgmHmfBj113dqk0sUakx2gOD2dXiwims4TqI7lP2q+I7Wf7UHsJJwfjnCC
         FpP9c7F0DhojgDZqvKqA82r11L0A2rsdBzz5HCemckdyFhqDlLs5vG1QuMoi9QdT/77k
         4AYaYhUx/ledt2rMh4Vj57N3EWySNokWUB/FyTq65n8yRaKhaVVFq3CAt9f8N/KprUs1
         CLwvBvn2r1jNZPE6Et2QocOdmobIFQrVwKKfSn/ytmusC+CalUrxfCkywnpVWItsHNK7
         454fbnyt+FmV6zLjO6xM3aAdOwvxvqFXiScsfCW+XsZYFh3SYH3kB1WfSpFA0FaB1tqg
         SuWQ==
X-Gm-Message-State: AC+VfDy2UctP4y+6bop4KPfU/DhYZsRa5wl17GCVA6RR1Tl5r13PzpPX
        A1oboKr7YnChIXf4I2LTuEVSkyZ4iKLI/gCQIn6BE3wQgfL9qMbiqgFKNU+56B/zDPG3Iemm2Mu
        QPD0XoJPJveKJEZBS0JJkt7HhJSdQPEA=
X-Received: by 2002:a05:6a20:2450:b0:105:2e9e:b13a with SMTP id t16-20020a056a20245000b001052e9eb13amr531001pzc.8.1684383470063;
        Wed, 17 May 2023 21:17:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7LqQhlBRuithVBal+RjVm2+D8dzNCs/v9uokVBq8dHN3/D360xF6ps6XAPWaOrOB4xhiUJYg==
X-Received: by 2002:a05:6a20:2450:b0:105:2e9e:b13a with SMTP id t16-20020a056a20245000b001052e9eb13amr530985pzc.8.1684383469650;
        Wed, 17 May 2023 21:17:49 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y22-20020aa78056000000b006413e6e7578sm326453pfm.5.2023.05.17.21.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 21:17:49 -0700 (PDT)
Date:   Thu, 18 May 2023 12:17:45 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] common/{filter,quota}, xfs/1{06,52}: fix grep pattern
Message-ID: <20230518041745.ypufjdbaujl73wyx@zlang-mailbox>
References: <20230517120111.2231544-1-jencce.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517120111.2231544-1-jencce.kernel@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, May 17, 2023 at 08:01:11PM +0800, Murphy Zhou wrote:
> Newer(3.9) grep is complaining about these unnecessary
> backslashes before # and -, and breaking the golden output.
> 
> Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> ---
> v2:
>    Apply Zorro's suggestion, removing all backslashes.

Thanks, this version looks good to me, I'll merge it after testing done.

And if you don't mind I'd like to change the subject from:

  "common/{filter,quota}, xfs/1{06,52}: fix grep pattern"

to:
  "fstests: fix the stray backslash warning from grep"

when I merge it.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
>  common/filter | 2 +-
>  common/quota  | 2 +-
>  tests/xfs/106 | 4 ++--
>  tests/xfs/152 | 4 ++--
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/common/filter b/common/filter
> index 3e3fea7e..f10ba78a 100644
> --- a/common/filter
> +++ b/common/filter
> @@ -293,7 +293,7 @@ _filter_project_quota()
>  	# until the GETNEXTQUOTA ioctl came into use.  Filter it out.
>  	# But if you specify a name for ID 0, that means you want to
>  	# deal with it by yourself, this function won't filter it out.
> -	_filter_quota | grep -v "^\#0 \|^(null) "
> +	_filter_quota | grep -v "^#0 \|^(null) "
>  }
>  
>  # Account for different "ln" failure messages
> diff --git a/common/quota b/common/quota
> index 96b8d044..6b529bf4 100644
> --- a/common/quota
> +++ b/common/quota
> @@ -191,7 +191,7 @@ _scratch_enable_pquota()
>  _require_setquota_project()
>  {
>  	setquota --help 2>&1 | \
> -		grep -q "\-P, \-\-project[[:space:]]*set limits for project"
> +		grep -q -- "-P, --project[[:space:]]*set limits for project"
>  	if [ "$?" -ne 0 ];then
>  		_notrun "setquota doesn't support project quota (-P)"
>  	fi
> diff --git a/tests/xfs/106 b/tests/xfs/106
> index fc2281af..388873bd 100755
> --- a/tests/xfs/106
> +++ b/tests/xfs/106
> @@ -59,13 +59,13 @@ clean_files()
>  
>  filter_quot()
>  {
> -	_filter_quota | grep -v "root \|\#0 " \
> +	_filter_quota | grep -v "root \|#0 " \
>  		| sed -e '/#[0-9]*/s/#[0-9]*/#ID/g'
>  }
>  
>  filter_report()
>  {
> -	_filter_quota | grep -v "^root \|^\#0 " \
> +	_filter_quota | grep -v "^root \|^#0 " \
>  		| sed -e '/^#[0-9]*/s/^#[0-9]*/#ID/g'
>  }
>  
> diff --git a/tests/xfs/152 b/tests/xfs/152
> index dd33801d..325a05c1 100755
> --- a/tests/xfs/152
> +++ b/tests/xfs/152
> @@ -98,13 +98,13 @@ clean_files()
>  
>  filter_quot()
>  {
> -	_filter_quota | grep -v "root \|\#0 " \
> +	_filter_quota | grep -v "root \|#0 " \
>  		| sed -e '/#[0-9]*/s/#[0-9]*/#ID/g'
>  }
>  
>  filter_report()
>  {
> -	_filter_quota | grep -v "^root \|^\#0 " \
> +	_filter_quota | grep -v "^root \|^#0 " \
>  		| sed -e '/^#[0-9]*/s/^#[0-9]*/#ID/g'
>  }
>  
> -- 
> 2.31.1
> 

