Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0377C64ED8
	for <linux-fstests@archiver.kernel.org>; Mon, 27 Feb 2023 09:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjB0Jm1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 27 Feb 2023 04:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjB0Jm0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 27 Feb 2023 04:42:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E8BD529
        for <fstests@vger.kernel.org>; Mon, 27 Feb 2023 01:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677490903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7wRxOtFs1agaSCqaBeVM7mGGf4S+32vV+Ksknvvsif0=;
        b=Am0A2mVqodbi4R/bCYXpqBfkmDPyVWEd+LTfbZ6l2fJt3EqF8dd6SUdiHXiAshmXQy7yBh
        Zs07w5hKwbGecUxxdPItEWnQIBkZJt1H+leMDJ0uz/YlSTSce94v8FdzTS6M25Pe26tFyq
        MhCSEmeIa3MKzpIHv9Qoz50NESSP5M8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-375-kv19I-iIPlWeBQrjSpNYTA-1; Mon, 27 Feb 2023 04:41:41 -0500
X-MC-Unique: kv19I-iIPlWeBQrjSpNYTA-1
Received: by mail-pj1-f72.google.com with SMTP id q9-20020a17090a9f4900b00237d026fc55so2657230pjv.3
        for <fstests@vger.kernel.org>; Mon, 27 Feb 2023 01:41:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wRxOtFs1agaSCqaBeVM7mGGf4S+32vV+Ksknvvsif0=;
        b=sU4vVlNY4KZ0vdNwrCiJBQrtY8cCXbnq1ktbJzgf5nWybTAPk0VQE3FrGj7yvI8QQI
         WKXuOtE7UVdMOs0G5pUOs88kO0RWjaxnVob0+WznuIbVfGcx2GMaJD71IEjEcofdm+UT
         wZPoHXa9F87VCpSjC9uKe82pROXHxE+fbS9CDw+Elgy8MbdQ1QyvpS2jWLwoKPVmDmTg
         G1oigI15dU59E4OLNOC2R5SrqBc26EAR4sKzxQJ+swf6FY1KU6d9e3WACPIfap3oOVH7
         HnrEq0nk8dbaFks9ge/q682a/ODth57SNx48Rf+vLqEuzzovJI/KLxPOOtCEkEOwq25g
         1Ksw==
X-Gm-Message-State: AO0yUKWBiPUCQaF4AdCjbhJFfOzsX6AbV06Q8+saMG4LavPOphZ7GicK
        Ph4hdm6dlObKLO1AD/+mUEO0520c3FSQWs1s5ZG8KkdKkgkh4NRJw4ynd434csHg/Y2tL43Hza+
        qfNvLy0IBG9BPHuXeMyQkmH3IWg==
X-Received: by 2002:a17:902:e851:b0:19b:c2d:1222 with SMTP id t17-20020a170902e85100b0019b0c2d1222mr29503257plg.52.1677490900623;
        Mon, 27 Feb 2023 01:41:40 -0800 (PST)
X-Google-Smtp-Source: AK7set+a8XkuK/qdBs5cqH6EbV1PoH59Jo4XihABo+akVd840bOVrDHaz1LjFB/9tvHvX6wlE7Zmjw==
X-Received: by 2002:a17:902:e851:b0:19b:c2d:1222 with SMTP id t17-20020a170902e85100b0019b0c2d1222mr29503240plg.52.1677490900130;
        Mon, 27 Feb 2023 01:41:40 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e23-20020a170902ed9700b001964c8164aasm4139189plj.129.2023.02.27.01.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 01:41:39 -0800 (PST)
Date:   Mon, 27 Feb 2023 17:41:35 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     xiubli@redhat.com
Cc:     fstests@vger.kernel.org, ceph-devel@vger.kernel.org
Subject: Re: [PATCH v2] generic/020: fix really long attr test failure for
 ceph
Message-ID: <20230227094135.yh7t6hfxgqkw2qcr@zlang-mailbox>
References: <20230227041358.350309-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227041358.350309-1-xiubli@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Feb 27, 2023 at 12:13:58PM +0800, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> If the CONFIG_CEPH_FS_SECURITY_LABEL is enabled the kernel ceph
> itself will set the security.selinux extended attribute to MDS.
> And it will also eat some space of the total size.
> 
> Fixes: https://tracker.ceph.com/issues/58742
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---

This version looks good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> V2:
> - make the 'size' and the 'selinux_size' to be local
> 
>  tests/generic/020 | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/020 b/tests/generic/020
> index be5cecad..538a24c6 100755
> --- a/tests/generic/020
> +++ b/tests/generic/020
> @@ -150,9 +150,11 @@ _attr_get_maxval_size()
>  		# it imposes a maximum size for the full set of xattrs
>  		# names+values, which by default is 64K.  Compute the maximum
>  		# taking into account the already existing attributes
> -		max_attrval_size=$(getfattr --dump -e hex $filename 2>/dev/null | \
> +		local size=$(getfattr --dump -e hex $filename 2>/dev/null | \
>  			awk -F "=0x" '/^user/ {len += length($1) + length($2) / 2} END {print len}')
> -		max_attrval_size=$((65536 - $max_attrval_size - $max_attrval_namelen))
> +		local selinux_size=$(getfattr -n 'security.selinux' --dump -e hex $filename 2>/dev/null | \
> +			awk -F "=0x" '/^security/ {len += length($1) + length($2) / 2} END {print len}')
> +		max_attrval_size=$((65536 - $size - $selinux_size - $max_attrval_namelen))
>  		;;
>  	*)
>  		# Assume max ~1 block of attrs
> -- 
> 2.31.1
> 

