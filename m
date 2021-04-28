Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD0AC433ED
	for <linux-fstests@archiver.kernel.org>; Wed, 28 Apr 2021 18:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3264161418
	for <linux-fstests@archiver.kernel.org>; Wed, 28 Apr 2021 18:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243406AbhD1SFZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 28 Apr 2021 14:05:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22791 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243404AbhD1SFY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 28 Apr 2021 14:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619633079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rZtiAWBHQmlkFXmHoUSv+mteyIcHUJe0sGH0UK7yFt4=;
        b=KUD2AsB/xL0i1ZFJeFtAbDlD2R8BZj50HnRiRJE+3BbDcQ8ObcsFqrVYZZSY9i5JJHror1
        buE9WbDX30jlI2CQlS11CPdp8aaaaG76xWp23qBfSTZTkKvJ1nKRHvCWj4HORBk0YFkc0a
        iPOgc47DcDmvfbZdPfliRTogcB5lO+I=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-kYqeaUmQNF-QMHrRyDzlJg-1; Wed, 28 Apr 2021 14:04:28 -0400
X-MC-Unique: kYqeaUmQNF-QMHrRyDzlJg-1
Received: by mail-qt1-f198.google.com with SMTP id u16-20020ac86f700000b02901baa6e2dbfcso6984742qtv.20
        for <fstests@vger.kernel.org>; Wed, 28 Apr 2021 11:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rZtiAWBHQmlkFXmHoUSv+mteyIcHUJe0sGH0UK7yFt4=;
        b=PChtXy8t40m+sKRn7x+Newegs2p1tK8jPaHtzzre/26qjfKNbQZBfHRczurJr+AqkX
         RxszxYbNOw/2HHOeVBNGcEGG02Bn0SQXn3V98Zo57C2Q4jzMp0X3kTeQo6/OzxOTN2ow
         JhMhOvMkLKMJDBqFtFK/wEEz63Z+zB1IfxbPKaXnJ3yEXDBX6+ggZi1cSTKJ/HYs21h+
         wPVCl8VhRxOhBVNgMNSsNeay2QLL9fzWHXa6aJjSHtrPN7Gl3DGCtGOmVe0mEvoAqjRx
         huO8UZkrUAEkhODc+SXr7C26S94Wn5ZjukdJ4HIfTos8BZarb6chsVtDmc8lraLCYc5i
         Hjrw==
X-Gm-Message-State: AOAM533Ol1ZsZNLBeBQ6476NIWEszciiWFK13aav1Mil+oLkgxxPlcxL
        qgFRcpzordngUX6Za7YjFQT+dEHEArp9BjQ/OxQBQdsdw39TFWv6GNkVw3prQf/uu9dxCtR1IrA
        V2OA0Imf8MXvhdZEjvg==
X-Received: by 2002:a37:61c1:: with SMTP id v184mr30277367qkb.466.1619633067535;
        Wed, 28 Apr 2021 11:04:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUiouegHY4bsE3/QNp7SwurCaSEGDzlLe0GbT6DDiGfdbHdr57yVpqzMhmTQkmlOFjLfo+yA==
X-Received: by 2002:a37:61c1:: with SMTP id v184mr30277348qkb.466.1619633067333;
        Wed, 28 Apr 2021 11:04:27 -0700 (PDT)
Received: from bfoster ([98.216.211.229])
        by smtp.gmail.com with ESMTPSA id r125sm367969qkf.24.2021.04.28.11.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 11:04:27 -0700 (PDT)
Date:   Wed, 28 Apr 2021 14:04:25 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     guaneryu@gmail.com, linux-xfs@vger.kernel.org,
        fstests@vger.kernel.org, guan@eryu.me
Subject: Re: [PATCH 3/3] common/rc: relax xfs swapfile support checks
Message-ID: <YImjqdwBfnhhIJ84@bfoster>
References: <161958296906.3452499.12678290296714187590.stgit@magnolia>
 <161958298729.3452499.11374046947109958849.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161958298729.3452499.11374046947109958849.stgit@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Apr 27, 2021 at 09:09:47PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> In commit 725feeff, I forgot that xfs has *not* always supported all
> swap file configurations -- the bmap swapfile activation prior to the
> introduction of iomap_swapfile_activate did not permit the use of
> unwritten extents in the swap file.  Therefore, kick xfs out of the
> always-supported list.
> 
> Fixes: 725feeff ("common/rc: swapon should not fail for given FS in _require_scratch_swapfile()")
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  common/rc |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> 
> diff --git a/common/rc b/common/rc
> index 429cc24d..7882355a 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2494,10 +2494,10 @@ _require_scratch_swapfile()
>  	statx_attr="$($XFS_IO_PROG -c 'statx -r' $SCRATCH_MNT/swap 2>/dev/null | grep 'stat.attributes = ' | awk '{print $3}')"
>  	test "$((statx_attr & 0x200000))" -gt 0 && _notrun "swapfiles not supported on DAX"
>  
> -	# ext* and xfs have supported all variants of swap files since their
> +	# ext* has supported all variants of swap files since their
>  	# introduction, so swapon should not fail.
>  	case "$FSTYP" in
> -	ext2|ext3|ext4|xfs)
> +	ext2|ext3|ext4)
>  		if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
>  			_scratch_unmount
>  			_fail "swapon failed for $FSTYP"
> 

