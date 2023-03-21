Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636CFC6FD1D
	for <linux-fstests@archiver.kernel.org>; Tue, 21 Mar 2023 14:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjCUO32 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 21 Mar 2023 10:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjCUO3X (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 21 Mar 2023 10:29:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63456E8E
        for <fstests@vger.kernel.org>; Tue, 21 Mar 2023 07:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679408805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O4jIFKWJ7SQI7m658zRDkXZ0H8i+ZzhD1x6hqFYzqA0=;
        b=epzt/hO/GZxG92YLEz7yb033aN/aqqQmoGc9lAS41FS6lBB5ey6oRSrBuZ7LL44cn77m5E
        KwF4bupmCCV6hUWZB/KFDNlgSwFCnXMp+YZHtuHTSyBGtf5G+Kfb9e0c+LE0b86YPAbuDQ
        P3c0s4c0x1heRZnAZ32rsyFIYqm664M=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-HiB1a1zBNqS88TaMR608FA-1; Tue, 21 Mar 2023 10:26:43 -0400
X-MC-Unique: HiB1a1zBNqS88TaMR608FA-1
Received: by mail-pj1-f70.google.com with SMTP id ml17-20020a17090b361100b0023f9e99ab95so2906611pjb.1
        for <fstests@vger.kernel.org>; Tue, 21 Mar 2023 07:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679408802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4jIFKWJ7SQI7m658zRDkXZ0H8i+ZzhD1x6hqFYzqA0=;
        b=heoBPIDWfwl3jQ0CCk7oTdqqIy1P7sDnHpQX2NjLo2yicZWtL5c7xxSAKUIVf/rQXf
         kwBXNTtMffJVmDLsscLDuEqKOsaq95ECGdC/hWvvPaZZYOnjgrvS5yDJptXt9bqT5Sw1
         vY5CLymvNY08jjsgZJ2MFt9KO7psJxf9W3XQHQ3Gz197STJ6fKU4ZwrWo9gd57prnQEe
         /H7M+bl7mV0o7fey47lQaXeQ2kzxHpb35oTzUTT1ey8CSqKeF835k4rqxemVhaL9UuSk
         Tz9F9hKbZDWVMkbcwyfkFRZMHgioR1j79AgPr7Pi8BmSPNXNmwJ6xPqGfZd4wJdMExju
         daXg==
X-Gm-Message-State: AO0yUKXaWDgL75Ir7LKt35+efS7Fzn6GLswPao0AJ5IserHGS2tY971z
        QFe9/qGDSs9zFQ/w/m6VZkMajdUEr7mLS1MN3t7mtY1RPhX0BSlVURh60M2q+JigalFlpPakck4
        1bilhCZziEegNMcSOOw==
X-Received: by 2002:a17:90a:304:b0:233:feb4:895f with SMTP id 4-20020a17090a030400b00233feb4895fmr2822563pje.44.1679408802555;
        Tue, 21 Mar 2023 07:26:42 -0700 (PDT)
X-Google-Smtp-Source: AK7set/sWUhEPTfuqJB7GzmP2Dy1D/saNevsiZvy+6hBuW5V+KoVpmL7SLNuNAs3mC9pCjoVF7Td9g==
X-Received: by 2002:a17:90a:304:b0:233:feb4:895f with SMTP id 4-20020a17090a030400b00233feb4895fmr2822546pje.44.1679408802219;
        Tue, 21 Mar 2023 07:26:42 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q2-20020a170902edc200b001a1a18a678csm8853059plk.148.2023.03.21.07.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 07:26:40 -0700 (PDT)
Date:   Tue, 21 Mar 2023 22:26:36 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     xiubli@redhat.com
Cc:     fstests@vger.kernel.org, ceph-devel@vger.kernel.org
Subject: Re: [PATCH] generic/020: fix another really long attr test failure
 for ceph
Message-ID: <20230321142636.epdz3wtbksmnsumk@zlang-mailbox>
References: <20230319062928.278235-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230319062928.278235-1-xiubli@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Mar 19, 2023 at 02:29:27PM +0800, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> If the CONFIG_CEPH_FS_SECURITY_LABEL is disabled the kernel ceph
> the 'selinux_size' will be empty and then:
> max_attrval_size=$((65536 - $size - $selinux_size - $max_attrval_namelen))
> will be:
> max_attrval_size=$((65536 - $size - - $max_attrval_namelen))
> which equals to:
> max_attrval_size=$((65536 - $size + $max_attrval_namelen))
> 
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---

Makes sense to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/020 | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tests/generic/020 b/tests/generic/020
> index 538a24c6..e00365a9 100755
> --- a/tests/generic/020
> +++ b/tests/generic/020
> @@ -154,6 +154,12 @@ _attr_get_maxval_size()
>  			awk -F "=0x" '/^user/ {len += length($1) + length($2) / 2} END {print len}')
>  		local selinux_size=$(getfattr -n 'security.selinux' --dump -e hex $filename 2>/dev/null | \
>  			awk -F "=0x" '/^security/ {len += length($1) + length($2) / 2} END {print len}')
> +		if [ -z $size ]; then
> +			size=0
> +		fi
> +		if [ -z $selinux_size ]; then
> +			selinux_size=0
> +		fi
>  		max_attrval_size=$((65536 - $size - $selinux_size - $max_attrval_namelen))
>  		;;
>  	*)
> -- 
> 2.31.1
> 

