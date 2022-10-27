Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7636DC38A2D
	for <linux-fstests@archiver.kernel.org>; Thu, 27 Oct 2022 03:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbiJ0DU7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 26 Oct 2022 23:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbiJ0DUt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 Oct 2022 23:20:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A9A3BC48
        for <fstests@vger.kernel.org>; Wed, 26 Oct 2022 20:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666840832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vVtv2gEOXwWxsxQ2dXTwNAFxDEUlqDwGil1CtfjnUKE=;
        b=epGDlAAoyldozKxyuFsGl/AnY8lqufgcIjNFuj54Wyzf88heXqigBAjA7FHtLSaUBp876D
        CpVXlJD3bb/mzzALf8OUfMJ0w09YbOqYA8dpETzcNcV5JTsJX5t7Ptm4UmpJl+s2nExuwu
        LugcTiSK2hJePou7h0QSb69Fnf1xSKk=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-424-mQHWM7zaNb-mCWAXQ9R0UA-1; Wed, 26 Oct 2022 23:20:31 -0400
X-MC-Unique: mQHWM7zaNb-mCWAXQ9R0UA-1
Received: by mail-pg1-f200.google.com with SMTP id r126-20020a632b84000000b004393806c06eso11026pgr.4
        for <fstests@vger.kernel.org>; Wed, 26 Oct 2022 20:20:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVtv2gEOXwWxsxQ2dXTwNAFxDEUlqDwGil1CtfjnUKE=;
        b=qJ3TL1q/73PgEt9NP4iQHOj2jSw7siVKPdMvZF4PrVh2KBRJgSbXwsWVj9rQ7mOEHm
         YJLgPubDZxWssTkJx4oCDpjbrVcSd8o46GNG8M+726M3EBHnYSX1B+6TdrPn5bdGbQ+L
         l5EzN2J8b43zTys/1cahGBN3itG4OISD/8oiHbecK1+oGl6phW3YyFWHOlX9jsyjR87M
         3oYyfTxBOfg+VEd1PIdHA3ctu8gnn9myFlpbC4Cg83lJ2OxOkbt2f0afGVg8bpoljgKv
         2irHHEIy/HMeKWH2+d4XO0bddyTiBmWqlUOUu9mXqznpWyoazHaOFy7KoAUDocJCCxeB
         98YA==
X-Gm-Message-State: ACrzQf0CjWA9e8rhCgsEfLS4Y+dot8hduQK3oX55N+mkc743ibkk3Oxo
        WwpvFm65OYK3l2kigau01hLxO8gAwajiTH9O7Vou57WU7h7IijIWWs/xaf70dC/Q9wwEZNwiVkW
        mnvUCd6iQCmG2EF9KIQ==
X-Received: by 2002:a65:6e0d:0:b0:42d:707c:94ee with SMTP id bd13-20020a656e0d000000b0042d707c94eemr39077999pgb.260.1666840829499;
        Wed, 26 Oct 2022 20:20:29 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5+yfBAoCp6uyp6o7TVEPeswC5zUFURA/lckrWVruS6dCVyEKinOQHL7qjva5ixmmf+0ZCF4w==
X-Received: by 2002:a65:6e0d:0:b0:42d:707c:94ee with SMTP id bd13-20020a656e0d000000b0042d707c94eemr39077986pgb.260.1666840829242;
        Wed, 26 Oct 2022 20:20:29 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id sf5-20020a17090b51c500b0020adab4ab37sm107358pjb.31.2022.10.26.20.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 20:20:28 -0700 (PDT)
Date:   Thu, 27 Oct 2022 11:20:23 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     xiubli@redhat.com
Cc:     fstests@vger.kernel.org, david@fromorbit.com, djwong@kernel.org,
        lhenriques@suse.de, ceph-devel@vger.kernel.org, jlayton@kernel.org,
        mchangir@redhat.com
Subject: Re: [PATCH v2] encrypt: add ceph support
Message-ID: <20221027032023.6arvnrkl7fymdjqj@zlang-mailbox>
References: <20221027030021.296548-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027030021.296548-1-xiubli@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Oct 27, 2022 at 11:00:21AM +0800, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>  common/encrypt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/common/encrypt b/common/encrypt
> index 45ce0954..1a77e23b 100644
> --- a/common/encrypt
> +++ b/common/encrypt
> @@ -153,6 +153,9 @@ _scratch_mkfs_encrypted()
>  		# erase the UBI volume; reformated automatically on next mount
>  		$UBIUPDATEVOL_PROG ${SCRATCH_DEV} -t
>  		;;
> +	ceph)
> +		_scratch_cleanup_files
> +		;;

Any commits about that?

Sorry I'm not familar with cephfs, is this patch enough to help ceph to test
encrypted ceph? Due to you tried to do some "checking" job last time.

Can "./check -g encrypt" work on ceph? May you paste this test result to help
to review? And welcome review points from ceph list.

Thanks,
Zorro

[1]
$ grep -rsn _scratch_mkfs_encrypted tests/generic/
tests/generic/395:22:_scratch_mkfs_encrypted &>> $seqres.full
tests/generic/396:21:_scratch_mkfs_encrypted &>> $seqres.full
tests/generic/580:23:_scratch_mkfs_encrypted &>> $seqres.full
tests/generic/581:36:_scratch_mkfs_encrypted &>> $seqres.full
tests/generic/595:35:_scratch_mkfs_encrypted &>> $seqres.full
tests/generic/613:29:_scratch_mkfs_encrypted &>> $seqres.full
tests/generic/621:57:_scratch_mkfs_encrypted &>> $seqres.full
tests/generic/429:36:_scratch_mkfs_encrypted &>> $seqres.full
tests/generic/397:28:_scratch_mkfs_encrypted &>> $seqres.full
tests/generic/398:28:_scratch_mkfs_encrypted &>> $seqres.full
tests/generic/421:24:_scratch_mkfs_encrypted &>> $seqres.full
tests/generic/440:29:_scratch_mkfs_encrypted &>> $seqres.full
tests/generic/419:29:_scratch_mkfs_encrypted &>> $seqres.full
tests/generic/435:33:_scratch_mkfs_encrypted &>> $seqres.full
tests/generic/593:24:_scratch_mkfs_encrypted &>> $seqres.full
tests/generic/576:34:_scratch_mkfs_encrypted_verity &>> $seqres.full

>  	*)
>  		_notrun "No encryption support for $FSTYP"
>  		;;
> -- 
> 2.31.1
> 

