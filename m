Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE6AC77B7A
	for <linux-fstests@archiver.kernel.org>; Wed, 17 May 2023 01:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjEQB3K (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 16 May 2023 21:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjEQB3K (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 16 May 2023 21:29:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358AC1BEA
        for <fstests@vger.kernel.org>; Tue, 16 May 2023 18:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684286904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nqlzeT6uK076I9elY81HCF9KXLDPXKh9OFSFS0bJjgA=;
        b=f/ZMPS+mwbZ6JQJW4l1nonm97Zmtlv9m9jaw4zEiIO0e1kVwbUPKVxEYCdXb0PbNOfvqjt
        C8PalylU0R3JCjI853cg1I9bO4/b9iYz/DNHcNxQCi6NI0JlwXXk/7JpRH+KkWTV5LL3VL
        4PzTd2uJuQIAusz1qXnYfU3e94jpDmE=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-dzyXe3hQNqO4tWPsstAP9Q-1; Tue, 16 May 2023 21:28:17 -0400
X-MC-Unique: dzyXe3hQNqO4tWPsstAP9Q-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-51b51394f32so77330a12.1
        for <fstests@vger.kernel.org>; Tue, 16 May 2023 18:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684286896; x=1686878896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqlzeT6uK076I9elY81HCF9KXLDPXKh9OFSFS0bJjgA=;
        b=LSTUkTLMe5LT6zCZlsar1NhWBiLj6V5+4PRkzO1ykuhgjwllo6M7ciVUxotjgjdZhT
         fYkr1ZvRoHBSHEqwqwGwoV50n9HEqFJLRd+AGe44WtlCJCDEIbLUK+ZjBli2dNCMuUle
         KGExxs2m7P7GUrr0te/RoOscjif/WlnCclAZUSTo8wX6VSOg0wAlwWjmvO6zyx45kpmS
         FgtmX5vcqt07jSG6j5Xn/Mt9gL0ByiZfP/HeeIpOvTNdppj+QmShrGuydV9ukWZNZknV
         bMXLgICUobgCmWc+Trtn8R26lC+TLpQEp3V5bTPPRUDPKa8jBXQgHBKLbDTJTpx5au9H
         U0XA==
X-Gm-Message-State: AC+VfDyXi05n3NnkQC11v9I/S7hBy3tUe82BC9xRUtRw1tQIwcOK1p1n
        fFaaHfDY6prlcf1SqjN5VVZdn5C1xyDRmE6h9pn603b+vWjGbkdxFQb1OwBKob+5NZ/QdyJL+nl
        4ZJ9OihZ/latw8xKkrR5o8KFvNrSn
X-Received: by 2002:a17:90b:618:b0:24e:56e4:9718 with SMTP id gb24-20020a17090b061800b0024e56e49718mr39294716pjb.15.1684286895693;
        Tue, 16 May 2023 18:28:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ44kmyS3l6EEjDB/oZUbWhEvBbJQur/iTBWymE9OD1pmrVtG4I3cryjeiYnN/4JhPVBRkG6Vw==
X-Received: by 2002:a17:90b:618:b0:24e:56e4:9718 with SMTP id gb24-20020a17090b061800b0024e56e49718mr39294702pjb.15.1684286895260;
        Tue, 16 May 2023 18:28:15 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id fu11-20020a17090ad18b00b0024df400a9e6sm230469pjb.37.2023.05.16.18.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 18:28:14 -0700 (PDT)
Date:   Wed, 17 May 2023 09:28:10 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/{filter,quota}, xfs/1{06,52}: fix grep pattern
Message-ID: <20230517012810.ygctwrbrms4cnyt4@zlang-mailbox>
References: <20230516081935.2208793-1-jencce.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516081935.2208793-1-jencce.kernel@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 16, 2023 at 04:19:35PM +0800, Murphy Zhou wrote:
> Newer(3.9) grep is complaining about these unnecessary
> backslashes before # and -, and breaking the golden output.

Better to show what kind of warning output breaks the golden image
at here.

> 
> Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> ---
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
> index 96b8d044..0a526e07 100644
> --- a/common/quota
> +++ b/common/quota
> @@ -191,7 +191,7 @@ _scratch_enable_pquota()
>  _require_setquota_project()
>  {
>  	setquota --help 2>&1 | \
> -		grep -q "\-P, \-\-project[[:space:]]*set limits for project"
> +		grep -q "\-P, \--project[[:space:]]*set limits for project"

I think this change isn't enough, might still trigger the "grep: warning:
stray \ before -" warning. Better to change this line as:

  grep -q -- "-P, --project[[:space:]]*set limits for project"

Please confirm if it helps.

Thanks,
Zorro

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

