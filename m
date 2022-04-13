Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC585C433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 13 Apr 2022 18:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbiDMSKG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 13 Apr 2022 14:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237599AbiDMSKE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 13 Apr 2022 14:10:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB13E4D270
        for <fstests@vger.kernel.org>; Wed, 13 Apr 2022 11:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649873260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zkvFgHSy+p/+KBEEQgNiFainpv/nh+lMrXOaRVKo6l4=;
        b=JfCIcWgsZvN3bhCflfelSrjQVBbvut+kHKDUSiifNks60Hg/VOLDVrQVIzHj+s3RC8h0Uw
        803aZHzMQwVag7rlYnJF5e6uYcQxiYYMF2dTVM3C/xjv1axgjyOVJDVgIxpO/Eyq2tHNNX
        X9lU8p3CVsk57oLyemdDYOIWMdTI4NE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-1fVGCyn1OSabLhorXhTyXQ-1; Wed, 13 Apr 2022 14:07:39 -0400
X-MC-Unique: 1fVGCyn1OSabLhorXhTyXQ-1
Received: by mail-qv1-f71.google.com with SMTP id jx11-20020a0562142b0b00b0044444479dcbso2390106qvb.9
        for <fstests@vger.kernel.org>; Wed, 13 Apr 2022 11:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=zkvFgHSy+p/+KBEEQgNiFainpv/nh+lMrXOaRVKo6l4=;
        b=KHbWbybkpodi32VFWXbOb/kcu6GKPZgX1HAbzNJLaknTwUeze2XM9fnsLU9ERkx3ee
         trePGnqz4lkH//TfZM7JfKx8s1ZZEW6EwxcO4ZvnouvzroQyI95k9T0l4d/wWLwkS67m
         51ykqLl8PYR3r1rUwPUiXnMVt27aTaZ4ZmWqD5vEOiEwHdgX2DPk6BR5EL51NI6ItDkA
         U7sNYAxK+mO78wB/SjEgPa7OBvEfXHMVrY6sobm7K8/CxZd5jQiKqEweeOVGUlq6arYz
         p+Y7UBIH8BevTzBjkek/R9w6XZAT838FgBCC7a556mJj6Ec5RXUYu86I7p6JRNcIAyjr
         r2QQ==
X-Gm-Message-State: AOAM533/qFM3YqXIAdUnIUlnmt/ykHriP6pvBAcEiDMb4tGx7K3nhnbM
        mwOKjdbiF+aIRBUmB2lOyc1THyQQZCOEJ0hwywB60h27IpV/ktkaJjLEGXnSkZcbLW8gm471HfO
        xPdCVNmEv1iAfGPSM3g==
X-Received: by 2002:a37:389:0:b0:69b:f56e:1672 with SMTP id 131-20020a370389000000b0069bf56e1672mr7967147qkd.614.1649873258904;
        Wed, 13 Apr 2022 11:07:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxPxpOnQDKrz6xF5IAmCYMQ4BIkafl4yvTLmofQQ2cVFwF6i1ccZfy2zFW+EEFGWfx1po5wA==
X-Received: by 2002:a37:389:0:b0:69b:f56e:1672 with SMTP id 131-20020a370389000000b0069bf56e1672mr7967128qkd.614.1649873258602;
        Wed, 13 Apr 2022 11:07:38 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id t19-20020ac85893000000b002e1afa26591sm32974412qta.52.2022.04.13.11.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 11:07:38 -0700 (PDT)
Date:   Thu, 14 Apr 2022 02:07:32 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/3] common/rc: let xfs_scrub tell us about its unicode
 checker
Message-ID: <20220413180732.6a356gzxv7n6nin2@zlang-mailbox>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
        linux-xfs@vger.kernel.org, fstests@vger.kernel.org
References: <164971769710.170109.8985299417765876269.stgit@magnolia>
 <164971770270.170109.8871111464246200861.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164971770270.170109.8871111464246200861.stgit@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 11, 2022 at 03:55:02PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Now that xfs_scrub can report whether or not it was built with the
> Unicode name checker, rewrite _check_xfs_scrub_does_unicode to take
> advantage of that.  This supersedes the old method of trying to observe
> dynamic library linkages and grepping the binary, neither of which
> worked very well.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/rc |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> 
> diff --git a/common/rc b/common/rc
> index 17629801..ec146c4e 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4800,6 +4800,18 @@ _check_xfs_scrub_does_unicode() {
>  
>  	_supports_xfs_scrub "${mount}" "${dev}" || return 1
>  
> +	# Newer versions of xfs_scrub advertise whether or not it supports
> +	# Unicode name checks.
> +	local xfs_scrub_ver="$("${XFS_SCRUB_PROG}" -VV)"
> +
> +	if echo "${xfs_scrub_ver}" | grep -q -- '-Unicode'; then
> +		return 1
> +	fi
> +
> +	if echo "${xfs_scrub_ver}" | grep -q -- '+Unicode'; then
> +		return 0
> +	fi
> +
>  	# If the xfs_scrub binary contains the string "Unicode name.*%s", then
>  	# we know that it has the ability to complain about improper Unicode
>  	# names.
> 

