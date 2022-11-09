Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B39C4332F
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Nov 2022 15:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiKIPjI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Nov 2022 10:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiKIPjH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Nov 2022 10:39:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE511FF7
        for <fstests@vger.kernel.org>; Wed,  9 Nov 2022 07:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668008286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i1movnRqeUiSUaPBdyR4UD6IKNUM5EsJmslMyB9trwo=;
        b=Vkd0SjNA5oxd7/5hk3TGRE7W4+OqWlJY9KNty95cmNZfGowhpY3BETNbERMm3dQVy6nVmb
        lutTnaN3Y0Q571XzJUEvk3Tl+mv3Tpn6bY0kC+Esdl12+DfPlCNDVqQYR1RFZ5kX1tfixg
        ID9YILsrqByUh8ul7gEJr7cxpUARBp4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-502-Rd0hCA67Ot-9AZLf7HyyRw-1; Wed, 09 Nov 2022 10:37:57 -0500
X-MC-Unique: Rd0hCA67Ot-9AZLf7HyyRw-1
Received: by mail-pl1-f199.google.com with SMTP id d18-20020a170902ced200b001871dab2d59so13755358plg.22
        for <fstests@vger.kernel.org>; Wed, 09 Nov 2022 07:37:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1movnRqeUiSUaPBdyR4UD6IKNUM5EsJmslMyB9trwo=;
        b=j67uvTUPJs37RVVvgQ4m3GXKoEWjJAq5E4JE8szAiOY3IXk9rEyf3ryLPuVCFr3O1a
         XRZt+ikZo7+dyBIIRfUZmxbHRSm5c8BI4me7rrbEKEHGh1wz3ZsNntLXamyA/jZ7Lpu4
         XfRMwYyviTS3HCv+5OYb5K3qGFVI2UhWcNspZN2WL+HRQvBpUcbw4P4TPP9n/cWu/GLQ
         T2Ms4CDVua+fXvCdHCzVdxODXwTl653xgnf0ExUAN0I7RZhU2O+CxxgzPlB5PBj2GeeB
         o9i1VNLM+skNp5oc0xsRTMQrATMrgtwvcERBnCYPAu4M4ZOPupgrDykBZRfWIYBdw0cF
         7IVg==
X-Gm-Message-State: ACrzQf0u+U94ZbXq4j7oM2zHMXPp61+dDjiPbX9ztek/EPeJDS2sQzYe
        dZQcmUBc4ia5KL/59jzrbSiqD2llTLjTFqZNDODxCGGOb27uk7raljpIv0+T88L4Z5X48A3leHt
        Qr12E+dmpuVALhQ11dw==
X-Received: by 2002:a05:6a00:1582:b0:56d:4bc6:68c7 with SMTP id u2-20020a056a00158200b0056d4bc668c7mr54749657pfk.31.1668008275557;
        Wed, 09 Nov 2022 07:37:55 -0800 (PST)
X-Google-Smtp-Source: AMsMyM74zuHNNzMlLuEzXK3S5MxIvdQKQhUOwOYeYamK2jixRTgK4yA60CSXXkV1W6v9qorHlj1F1Q==
X-Received: by 2002:a05:6a00:1582:b0:56d:4bc6:68c7 with SMTP id u2-20020a056a00158200b0056d4bc668c7mr54749637pfk.31.1668008275244;
        Wed, 09 Nov 2022 07:37:55 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id iw17-20020a170903045100b00186a6b63525sm9203068plb.120.2022.11.09.07.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 07:37:54 -0800 (PST)
Date:   Wed, 9 Nov 2022 23:37:50 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 1/3] btrfs/003: fix failure on new btrfs-progs versions
Message-ID: <20221109153750.p6jgtm5a2zc4id7f@zlang-mailbox>
References: <cover.1667993961.git.fdmanana@suse.com>
 <62ef22111c9cb654e6e5e50f7337105b9ef804d7.1667993961.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62ef22111c9cb654e6e5e50f7337105b9ef804d7.1667993961.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Nov 09, 2022 at 11:43:34AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Starting with btrfs-progs version 5.19, the output of 'filesystem show'
> command changed when we have a missing device. The old output was like the
> following:
> 
>     Label: none  uuid: 139ef309-021f-4b98-a3a8-ce230a83b1e2
>             Total devices 2 FS bytes used 128.00KiB
>             devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
>             *** Some devices missing
> 
> While the new output (btrfs-progs 5.19+) is like the following:
> 
>     Label: none  uuid: 4a85a40b-9b79-4bde-8e52-c65a550a176b
>             Total devices 2 FS bytes used 128.00KiB
>             devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
>             devid    2 size 0 used 0 path /dev/loop1 MISSING
> 
> More specifically it happened in the following btrfs-progs commit:
> 
>     957a79c9b016 ("btrfs-progs: fi show: print missing device for a mounted file system")
> 
> This is making btrfs/003 fail with btrfs-progs 5.19+. Update the grep
> filter in btrfs/003 so that it works with both output formats.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

OK, make sense,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/003 | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/btrfs/003 b/tests/btrfs/003
> index cf605730..fae6d9d1 100755
> --- a/tests/btrfs/003
> +++ b/tests/btrfs/003
> @@ -141,8 +141,9 @@ _test_replace()
>  	_devmgt_remove ${removed_dev_htl} $ds
>  	dev_removed=1
>  
> -	$BTRFS_UTIL_PROG filesystem show $SCRATCH_DEV | grep "Some devices missing" >> $seqres.full || _fail \
> -							"btrfs did not report device missing"
> +	$BTRFS_UTIL_PROG filesystem show $SCRATCH_DEV | \
> +		grep -ie '\bmissing\b' >> $seqres.full || \
> +		_fail "btrfs did not report device missing"
>  
>  	# add a new disk to btrfs
>  	ds=${devs[@]:$(($n)):1}
> -- 
> 2.35.1
> 

