Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F502C7EE23
	for <linux-fstests@archiver.kernel.org>; Thu,  1 Jun 2023 09:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjFAJwC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 1 Jun 2023 05:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbjFAJwA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 1 Jun 2023 05:52:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA29412F
        for <fstests@vger.kernel.org>; Thu,  1 Jun 2023 02:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685613076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OzIlMFRG7JVgyYici9Bt6+3TtN9Mm4P63XnmoTugrLk=;
        b=PLGpcG6NlKaAuWCLAM9Bi7uIqw0BYhKOHobG1aplzXo1TA6jsCvh9mbckiW/Kv3DefSvp1
        UNQ4t+G8/6Uq/hpD6alg5XStApTcAw1IB59T2t4s0W7QqAWc6yZzGEzCCShWgLcOHOkoYP
        ojJGJv6FMQ8IEGxvuYobwvceg779wQI=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-TJWFKeYvMLu9buUlbx4HSQ-1; Thu, 01 Jun 2023 05:51:14 -0400
X-MC-Unique: TJWFKeYvMLu9buUlbx4HSQ-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-33b88241696so5474155ab.1
        for <fstests@vger.kernel.org>; Thu, 01 Jun 2023 02:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685613074; x=1688205074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OzIlMFRG7JVgyYici9Bt6+3TtN9Mm4P63XnmoTugrLk=;
        b=f8BN1GVuiTLpDpnk2gGdH2wGC32XnGAM6tjON25Tj0t+rAbhNPsDkCIoAi7+MPV8Gn
         UvLxaYHDSRdTutW8U9MnjgjGNnEyzTRoS+4HyQ1QUFBDEk6EcUB8fVszmof4JTG609I/
         zJDt2Oj71mmNnA9V+nmzW0ikky5LDwyE+KtXS7+BoBgLg0ywyW/0pKwaPhGUOurFPv2c
         Q0ce6LS5zdSw5YQQUgfedfq9iPU0jtAuYm6B31Jkqwb+oGemRljjQn89TjLCnV04xk9e
         VKftXI9EVDxIS7jUFlq028rzS+JTyB9OARM0L3TPA2cNajTnKLcrWAiXH/fMMj3csirb
         IqzA==
X-Gm-Message-State: AC+VfDyxrBDPtVWIXRVd0LdChKGwG055RMoMwmJjaVVMdXb+4FRry9A3
        z3jhx+OhcWqBa8bqrC4eIPcvblXin78r51F4sNbVghpT/v7nVfw5ubRYkQIGGYtIltqioLPlQab
        yHjPPv+hkwRmVSMF4wvfOjuz4pYXNG6M=
X-Received: by 2002:a92:c708:0:b0:33b:abaf:d493 with SMTP id a8-20020a92c708000000b0033babafd493mr5590431ilp.16.1685613073959;
        Thu, 01 Jun 2023 02:51:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7qPXazSRAYRxqRw6piwj80oKyUTmO7apVm4+a2/Fd4B4wcVr99CGP2dt0Y2TsYe7FsVLE+DQ==
X-Received: by 2002:a92:c708:0:b0:33b:abaf:d493 with SMTP id a8-20020a92c708000000b0033babafd493mr5590423ilp.16.1685613073692;
        Thu, 01 Jun 2023 02:51:13 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id l7-20020a656807000000b0051416609fb7sm2521765pgt.61.2023.06.01.02.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 02:51:12 -0700 (PDT)
Date:   Thu, 1 Jun 2023 17:51:09 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     xiubli@redhat.com
Cc:     fstests@vger.kernel.org, ceph-devel@vger.kernel.org
Subject: Re: [PATCH] common/rc: skip ceph-fuse when atime is required
Message-ID: <20230601095109.bzdb2nithqngngwd@zlang-mailbox>
References: <20230601025207.857009-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601025207.857009-1-xiubli@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jun 01, 2023 at 10:52:07AM +0800, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> Ceph won't maintain the atime, so just skip the tests when the atime
> is required.
> 
> Fixes: https://tracker.ceph.com/issues/61551
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 37074371..f3b92741 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4089,7 +4089,7 @@ _require_atime()
>  	nfs|afs|cifs|virtiofs)
>  		_notrun "atime related mount options have no effect on $FSTYP"
>  		;;
> -	ceph)
> +	ceph|ceph-fuse)
>  		_notrun "atime not maintained by $FSTYP"
>  		;;
>  	esac
> -- 
> 2.40.1
> 

