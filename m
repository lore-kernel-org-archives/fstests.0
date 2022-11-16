Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C04C4332F
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Nov 2022 06:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbiKPGxB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 16 Nov 2022 01:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiKPGw5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 Nov 2022 01:52:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C3B2872F
        for <fstests@vger.kernel.org>; Tue, 15 Nov 2022 22:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668581526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vq7VhhIioEkBpyEyo7DjXd2G6elh/0ZIzPMU9tWeQtI=;
        b=SNSh472gsBVQm99cem8t5p6eyyY7srxDVy+bzqzAP2gOXhv3YtmknHq2P2Ukwko7iLLGmT
        Z5KqJIipF4J3hY+Fw1nNrkeRoXhmXTxvS0UDjnjX2FlhEh4ur45+8GzqTLXXe4aAYaKAeS
        OPAiZyaCY5D2g0AeBIumy7ojhtw94ag=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-586-5yVLfo4eOGG2R2wiUP3lRw-1; Wed, 16 Nov 2022 01:52:05 -0500
X-MC-Unique: 5yVLfo4eOGG2R2wiUP3lRw-1
Received: by mail-pg1-f200.google.com with SMTP id j21-20020a63fc15000000b00476d6932baeso1518131pgi.23
        for <fstests@vger.kernel.org>; Tue, 15 Nov 2022 22:52:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vq7VhhIioEkBpyEyo7DjXd2G6elh/0ZIzPMU9tWeQtI=;
        b=QxH0NYVcIYiHZEXuGzJsPzAgau+vSBrdDL8OKr5Z2UA5bj/ghp4VFddQdKdWuD9BTa
         wV035olRrmH2+Rod75LwVZ8EWqYGnvkM9gUntKBIbfqPI4fiLZeXxgw1s/nOdAwzEzU7
         0C7qUatgxpAvX/cB4caRTuNQhM3BGl+llxbNIBmPmViZmAmvecUlRlorFgDMd429EtT4
         ysR2wI3G42vCgt4qlzFydiuvsyqZeH/Y645gaLBUVo/heh1jldxBuW14aRFO9WQb+0bl
         nqo9QPD7zifNDW62jrIPRKF4qyacJvcTshh2WEMuvQuMDc8x0LbLSYpmGGrepFA5eOSR
         1gHw==
X-Gm-Message-State: ANoB5pll0q475HxXBkxSS4pZFAjPoV5spcOX8S+V/PeqKuRjxzoNge5+
        tmUfCIuBA97RbYlPNX5pz7gZKC9JTwgwLt4Ko/VGonaDSMRWaKFOops9pNDhN+U6+N1frkWE7TO
        ZlhxZBfTbAz2HJasfmg==
X-Received: by 2002:a63:5424:0:b0:437:e9f3:8add with SMTP id i36-20020a635424000000b00437e9f38addmr19760065pgb.438.1668581524279;
        Tue, 15 Nov 2022 22:52:04 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7+0OfWBbrari+7dV4zBDsFtuPije+sFKtUBkTUreEdTCQahUh3c8waFkHfFyhFgatJ7IM7KA==
X-Received: by 2002:a63:5424:0:b0:437:e9f3:8add with SMTP id i36-20020a635424000000b00437e9f38addmr19759826pgb.438.1668581518680;
        Tue, 15 Nov 2022 22:51:58 -0800 (PST)
Received: from [10.72.12.148] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id t12-20020a1709027fcc00b00186a6b63525sm11114188plb.120.2022.11.15.22.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 22:51:58 -0800 (PST)
Subject: Re: [PATCH] ceph/005: skip test if using "test_dummy_encryption"
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        fstests@vger.kernel.org
Cc:     Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org
References: <20221115144500.10015-1-lhenriques@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <b6df573a-4760-d9bc-8085-0e2a1c0ad119@redhat.com>
Date:   Wed, 16 Nov 2022 14:51:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20221115144500.10015-1-lhenriques@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


On 15/11/2022 22:45, Luís Henriques wrote:
> When using the "test_dummy_encryption" mount option, new file and directory
> names will be encrypted.  This means that if using as a mount base directory
> a newly created directory, we would have to use the encrypted directory name
> instead.  For the moment, ceph doesn't provide a way to get this encrypted
> file name, thus for now simply skip this test.
>
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
>   tests/ceph/005 | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/tests/ceph/005 b/tests/ceph/005
> index fd71d91350db..015f6571b098 100755
> --- a/tests/ceph/005
> +++ b/tests/ceph/005
> @@ -13,6 +13,7 @@ _begin_fstest auto quick quota
>   
>   _supported_fs ceph
>   _require_scratch
> +_exclude_test_mount_option "test_dummy_encryption"
>   
>   _scratch_mount
>   mkdir -p "$SCRATCH_MNT/quota-dir/subdir"
>
Reviewed-by: Xiubo Li <xiubli@redhat.com>

