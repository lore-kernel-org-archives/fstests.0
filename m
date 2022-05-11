Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160C7C433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 11 May 2022 09:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbiEKJ06 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 11 May 2022 05:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240126AbiEKJ0t (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 11 May 2022 05:26:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 037AF33A21
        for <fstests@vger.kernel.org>; Wed, 11 May 2022 02:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652261199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kO50a3ZMGqy36vUEXB5sJxbvfk9EgWkkvWo6Ed3qPTw=;
        b=Rk4ehb/SdS3Q9FoTad/w8DYPL1tFzx1jeXOpyXcUNBIZwn26iJpMt0v+guF4xtl+NrMSK9
        EW4FMTSU0eq9HMF53czFnAJse2LeSFq+2sH+uHHLvFVogRUlX83SiMu/n7Wc03UZRCrL2b
        nk6ynX3LMbbZoxWzP3B20hqI11JPNdw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-247-ohJz1Sh-Npq4QcxyLkbrvg-1; Wed, 11 May 2022 05:26:38 -0400
X-MC-Unique: ohJz1Sh-Npq4QcxyLkbrvg-1
Received: by mail-qk1-f198.google.com with SMTP id m1-20020a05620a24c100b006a060e0e241so1392264qkn.17
        for <fstests@vger.kernel.org>; Wed, 11 May 2022 02:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=kO50a3ZMGqy36vUEXB5sJxbvfk9EgWkkvWo6Ed3qPTw=;
        b=cXUedAYbdUjpBubAHZtVSQeJy9lqBRPz1Msv1ThiVrohrLS1+2AkwseFnsCL/wdurD
         hNDt9hxvLSEqvqHTwxmWyNM0vvRESPPOXbsHn5tVxV+uPMCRV4BPthRF/+vwxyKZbqCi
         Ykr/Ddn38qELNQxLc30DviZzU9iH6wMi1znYaJIM5AU3vsL8qYyOaIudOvqwQLvqcKQD
         zx5T99+2U8NDxkd6uL3uSC+1PDSoTe4u53in+27DeTPaH94B9TciROTIrVrI8FdK7RE8
         klcHaMC+rHdnD9VKBYIm1eaLDI6JvLemRlIpjnf/X0QcB2425SaDKgWi9siO5h5d5tCD
         unMg==
X-Gm-Message-State: AOAM530mIbFGGbFmK9eLoIXdBFfmcYX3rdvdqcr94zcspk7yVO2dYkt/
        p0ovF3/S9cX1Pav5JJXIvPExCKvLgtF1tgkZqDFj5QqGbqRPdPvM5L/fqMHIo8pn4JYLOxixhmo
        dYGxCTSq6PZJcTuYYCA==
X-Received: by 2002:a0c:f3d2:0:b0:456:34aa:5978 with SMTP id f18-20020a0cf3d2000000b0045634aa5978mr21406302qvm.59.1652261197355;
        Wed, 11 May 2022 02:26:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9DdSDA/hx8JTNLJ4q/Q0Cghpa4F7z/Yb30ndeCV2xIF327qcyo8dLa9mbqpVe+mI/T3jrEA==
X-Received: by 2002:a0c:f3d2:0:b0:456:34aa:5978 with SMTP id f18-20020a0cf3d2000000b0045634aa5978mr21406293qvm.59.1652261197117;
        Wed, 11 May 2022 02:26:37 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p6-20020a05620a056600b0069fc13ce226sm859989qkp.87.2022.05.11.02.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 02:26:36 -0700 (PDT)
Date:   Wed, 11 May 2022 17:26:31 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] casefold: Fix expansion of seqres variable
Message-ID: <20220511092631.xejpwka3x7u6uozj@zlang-mailbox>
Mail-Followup-To: Gabriel Krisman Bertazi <krisman@collabora.com>,
        fstests@vger.kernel.org
References: <20220511002520.352812-1-krisman@collabora.com>
 <20220511045537.GF2306852@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511045537.GF2306852@dread.disaster.area>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, May 11, 2022 at 02:55:37PM +1000, Dave Chinner wrote:
> On Tue, May 10, 2022 at 08:25:20PM -0400, Gabriel Krisman Bertazi wrote:
> > seqres is not properly expanded on these error paths, causing a file
> > called seqres.full to be created instead.
> > 
> > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> > ---
> >  common/casefold | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/common/casefold b/common/casefold
> > index 9172d818125a..7e8f941211db 100644
> > --- a/common/casefold
> > +++ b/common/casefold
> > @@ -25,7 +25,7 @@ _require_scratch_casefold()
> >  		_notrun "$FSTYP does not support casefold feature"
> >  	fi
> >  
> > -	if ! _scratch_mkfs_casefold &>>seqres.full; then
> > +	if ! _scratch_mkfs_casefold &>>$seqres.full; then

By running `grep -rsn seqres|grep -v \$seqres`, I think this's only one file
we missed '$' for 'seqres'. So this fix is good to me. And...

> 
> PLease add a space between the &>> and $seqres.full while you are
> fixing this. It's unreadable without proper whitespace separation...

I'll merge your V2 patch, after you change it as Dave suggested above.

Thanks,
Zorro

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

