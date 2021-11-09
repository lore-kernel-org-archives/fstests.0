Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E1FC433F5
	for <linux-fstests@archiver.kernel.org>; Tue,  9 Nov 2021 03:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E95C611ED
	for <linux-fstests@archiver.kernel.org>; Tue,  9 Nov 2021 03:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238843AbhKIDxK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 8 Nov 2021 22:53:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31383 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236843AbhKIDxK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 8 Nov 2021 22:53:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636429824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=52xvd6FJCoRP4YDviqgjzjOEIQtPU/pg2XosC/q0zQ8=;
        b=A76lFRtrGS09NwuuaDlLYzV02+i30/HymM6S9X+1T17oS8hSA/GYpnApNJeyLAhV/NFwhj
        24XJYWiUNYF2+cBvhNLw+P+JNkNCs+t5tTYlLl9lK8chbbG8S0IATL9smtNf4Wk9Z4zfli
        rvDdKNBvvmfGmkpMVfBmITz+LvmRPf4=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-6J8iKxQ3OHqFpMqZUkt40Q-1; Mon, 08 Nov 2021 22:50:23 -0500
X-MC-Unique: 6J8iKxQ3OHqFpMqZUkt40Q-1
Received: by mail-pf1-f197.google.com with SMTP id g142-20020a625294000000b004946d789d14so9094759pfb.3
        for <fstests@vger.kernel.org>; Mon, 08 Nov 2021 19:50:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=52xvd6FJCoRP4YDviqgjzjOEIQtPU/pg2XosC/q0zQ8=;
        b=QtYNU33M+ey7EckY3PqGrUGQBY3fbjsv7ULJb5FWblTY3FMdnbX7tP+7cka+tHfbm/
         tecijBwmuaB8iU5L1C2Tr2+JyuuTg7k3Rx351cZfapkD08kiEYg0FicMlQl0dfwr4gPW
         zFg8WRmSbBlCF8APxQE3jZ48yTJKUzAyoq2pY2/5iOt0JoYGoIOYpAp7HAKI93JQj87y
         VPlZjyskjakWpo/lUebaSMpRLDgjNa/anOEIplybap9elz3sIUODWdVfZ/3lU9sJrmDa
         15ip2S4CMdMYODuWHD+ddp51B3Zg6defi2YeZ0N7CA09IJYhOiQszNhmRFC/awMjIw6k
         FlqQ==
X-Gm-Message-State: AOAM531DjjFR6XnijLvv99iHFlB8QpqgjIFMtV1cBVTiYRwS598ick+1
        jIthRijLw7Tcm3xbIwfUlIAcCN/CfkTco/keQ6v4e/EqM3znMj+IcuG68VkoZ+tFD3QKxBxXLyE
        FZzeOUXN5FQan4sI8JMspFVpcNjZ7sHjuzV540rJcWeQeavfLHM0clkPysPfTvBmAzQ==
X-Received: by 2002:a17:902:ba85:b0:13e:c846:c92e with SMTP id k5-20020a170902ba8500b0013ec846c92emr4200243pls.57.1636429822107;
        Mon, 08 Nov 2021 19:50:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJywgizOCKumzdf+yFNzKjPYS3+NCQjMnhy7ZrmPdYHuKd5YPBObawEaRqSFUoYZ9m1VgeLnvA==
X-Received: by 2002:a17:902:ba85:b0:13e:c846:c92e with SMTP id k5-20020a170902ba8500b0013ec846c92emr4200208pls.57.1636429821593;
        Mon, 08 Nov 2021 19:50:21 -0800 (PST)
Received: from fedora ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l21sm17077159pfu.213.2021.11.08.19.50.20
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 19:50:21 -0800 (PST)
Date:   Tue, 9 Nov 2021 12:09:13 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic/648: dmerror must be unmounted
Message-ID: <20211109040913.kq6icdhwdf5mfs7n@fedora>
Mail-Followup-To: fstests@vger.kernel.org
References: <20211024120512.2383377-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211024120512.2383377-1-zlang@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Oct 24, 2021 at 08:05:12PM +0800, Zorro Lang wrote:
> Sometimes g/648 fail to unmount dmerror with this error:
> 
>    umount: /mnt/xfstests/scratch: target is busy.
> 
> Even worse, it will cause all later test cases fail as:
> 
>   mount: bad usage
>   Try 'mount --help' for more information.
>   check: failed to mount $SCRATCH_DEV using specified options
>   Interrupted!
> 
> So we shouldn't _fail directly if dmerror_unmount fails, use a while
> loop to try to unmount it enough times.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---

Ping, it's been 2+ weeks passed, any more review points about this?

Thanks,
Zorro

> 
> As Darrick's review point, V2 brings the "iteration XXX scratch
> unmount failed" _fail back.
> 
> Thanks,
> Zorro
> 
>  tests/generic/648 | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/648 b/tests/generic/648
> index 83dd111d..e5c743c5 100755
> --- a/tests/generic/648
> +++ b/tests/generic/648
> @@ -104,7 +104,7 @@ for i in $(seq 1 $((25 * TIME_FACTOR)) ); do
>  		wait > /dev/null 2>&1
>  		ps -e | grep fsstress > /dev/null 2>&1
>  	done
> -	for ((i = 0; i < 10; i++)); do
> +	for ((j = 0; j < 10; j++)); do
>  		test -e "$snap_aliveflag" || break
>  		sleep 1
>  	done
> @@ -112,7 +112,21 @@ for i in $(seq 1 $((25 * TIME_FACTOR)) ); do
>  	# Mount again to replay log after loading working table, so we have a
>  	# consistent fs after test.
>  	$UMOUNT_PROG $loopmnt
> -	_dmerror_unmount || _fail "iteration $i scratch unmount failed"
> +	is_unmounted=1
> +	# We must unmount dmerror at here, or whole later testing will crash.
> +	# So try to umount enough times, before we have no choice.
> +	for ((j = 0; j < 100; j++)); do
> +		sleep 1
> +		_dmerror_unmount > $tmp.unmount.err 2>&1
> +		if [ $? -eq 0 ];then
> +			is_unmounted=0
> +			break
> +		fi
> +	done
> +	if [ $is_unmounted -ne 0 ];then
> +		cat $tmp.unmount.err
> +		_fail "iteration $i scratch unmount failed"
> +	fi
>  	_dmerror_load_working_table
>  	if ! _dmerror_mount; then
>  		_metadump_dev $DMERROR_DEV $seqres.scratch.$i.md
> -- 
> 2.31.1
> 

