Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF10ECAAD8
	for <linux-fstests@archiver.kernel.org>; Tue, 20 Sep 2022 14:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiITOfg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 20 Sep 2022 10:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiITOff (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 20 Sep 2022 10:35:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827BD2F66A
        for <fstests@vger.kernel.org>; Tue, 20 Sep 2022 07:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663684532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pqI78RUgjc+DFTKUcUydT8yc6Qi0sfN0Rwsnzb/3giE=;
        b=aN3OE2kiYvQjWJKxief0DmHVMxmTIyn3J1BkkQjxK/Q663xJdrdeKHcIGhx4wvF6q8PKFQ
        QoJL5j6bEdaiYx0dYJZe+fjT8NYQ1tvuGC9AnwCsHaFqUo00NB0eyfa5dD7KUaOJDLqrJu
        BejKk4n0w8lM23jQ3F32Xpu+XQxM4y4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-607-K4vGQdseP6uSbezH5NeWBw-1; Tue, 20 Sep 2022 10:35:30 -0400
X-MC-Unique: K4vGQdseP6uSbezH5NeWBw-1
Received: by mail-qv1-f70.google.com with SMTP id y7-20020ad45307000000b004ac7fd46495so2120837qvr.23
        for <fstests@vger.kernel.org>; Tue, 20 Sep 2022 07:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=pqI78RUgjc+DFTKUcUydT8yc6Qi0sfN0Rwsnzb/3giE=;
        b=Bph4N6IYldNsyfENS1ee7TnES3c1n0sMmkF1+ru4Ilm36XuONxVnJ/Gzffp7e45sta
         /QS6KbctWimLc1PztI/f2BWcsJheYCAmyo+9tyBN2WrHL3UatBbprc/KAtk/1kGEYfua
         rT/zBro3XMvyjTYGofTquYLx6QegHtHb6BUmo8tnPCYwkyjfkPm7Pqej07ppiKbdYQuS
         GD3VE0UIn+70aeur3b8scCr6A3ucFmMGxQTaXGQ/At5TiLy5S2olhAm5THVVH1xpkozA
         yvvNAU1NrH0rx4GAu3wtR+LvFHwYiyip3G2zFx0VPX7FTw/LlrjDvsAg9LgCpc8+t2bQ
         nFGg==
X-Gm-Message-State: ACrzQf275qczxQWOSRVPF4GsXI5+ROlUWv8fEga0d19dEns5ubkKhNjR
        dAc+WfD/gbWxhpPh6LdQ+TN38ccFd01bBIZn/IAKCcGkqJz1Llc6ZUk8dgbf4mHz1dDBeGLReC3
        Z3G4P788sFKIL5As/oA==
X-Received: by 2002:a05:622a:13c7:b0:35b:ba86:17b1 with SMTP id p7-20020a05622a13c700b0035bba8617b1mr19357859qtk.33.1663684530095;
        Tue, 20 Sep 2022 07:35:30 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5JtCkPrdiLSct/TPaYaYwwMrj/e9s5pWkxUJuEfMkm80Y3UerBc53dsmM/w/caC9OW7HIuGQ==
X-Received: by 2002:a05:622a:13c7:b0:35b:ba86:17b1 with SMTP id p7-20020a05622a13c700b0035bba8617b1mr19357840qtk.33.1663684529860;
        Tue, 20 Sep 2022 07:35:29 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x22-20020a05620a259600b006ce7316f361sm194539qko.118.2022.09.20.07.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:35:29 -0700 (PDT)
Date:   Tue, 20 Sep 2022 22:35:25 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] ext4/044: Add missing check for return value
Message-ID: <20220920143525.y6o5mf36sczn7rut@zlang-mailbox>
References: <20220920083810.288984-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920083810.288984-1-preichl@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Sep 20, 2022 at 10:38:10AM +0200, Pavel Reichl wrote:
> When calling _within_tolerance either return value or text output
> should be checked. Otherwise the function is useless for a test.
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>
> ---

Make sense,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/ext4/044     | 8 +++-----
>  tests/ext4/044.out | 4 +++-
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/ext4/044 b/tests/ext4/044
> index 158e2ac5..50de5a40 100755
> --- a/tests/ext4/044
> +++ b/tests/ext4/044
> @@ -18,8 +18,6 @@ _require_scratch
>  _require_test_program "t_get_file_time"
>  _require_metadata_journaling
>  
> -echo "Silence is golden"
> -
>  echo "Test timestamps with 256 inode size one device $SCRATCH_DEV" >$seqres.full
>  _scratch_mkfs -t ext3 -I 256 >> $seqres.full 2>&1
>  _scratch_mount
> @@ -49,9 +47,9 @@ nsec_mtime: $nsec_mtime, nsec_ctime: $nsec_ctime, cur_time[ns]: $nsec)"
>  fi
>  
>  # Check difference between file time and current time
> -_within_tolerance "sec_atime" $sec_atime $sec 1
> -_within_tolerance "sec_mtime" $sec_mtime $sec 1
> -_within_tolerance "sec_ctime" $sec_ctime $sec 1
> +_within_tolerance "sec_atime" $sec_atime $sec 1 -v
> +_within_tolerance "sec_mtime" $sec_mtime $sec 1 -v
> +_within_tolerance "sec_ctime" $sec_ctime $sec 1 -v
>  
>  _scratch_unmount >> $seqres.full 2>&1
>  
> diff --git a/tests/ext4/044.out b/tests/ext4/044.out
> index 12a61dc4..8a3a8072 100644
> --- a/tests/ext4/044.out
> +++ b/tests/ext4/044.out
> @@ -1,2 +1,4 @@
>  QA output created by 044
> -Silence is golden
> +sec_atime is in range
> +sec_mtime is in range
> +sec_ctime is in range
> -- 
> 2.37.3
> 

