Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56178C76196
	for <linux-fstests@archiver.kernel.org>; Tue, 28 Mar 2023 18:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjC1SET (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 28 Mar 2023 14:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjC1SES (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 28 Mar 2023 14:04:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040F6E05B
        for <fstests@vger.kernel.org>; Tue, 28 Mar 2023 11:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680026611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6IPPfE7CYTQ7ijpaw9d76qa9EhyWhtaUWmHYKPSThO0=;
        b=exBUdUvBph0LWdEU/7iSqHQ5FrnQ2bU1t0UB9mMCinV9VXOg1wilWwFgGWH/S7ReOB7zft
        +AUOnpva45T1SCJwG7DG8HjhL4uFqB5G3YYZ+rg9ytOnpb8dKvqeus9DYOymn63pZEX7gj
        bZ7YQaHytAiZVOUSk0Od+zpoMa3ot+4=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-9lyIWpgDMMO14xGtpv7G4w-1; Tue, 28 Mar 2023 14:03:22 -0400
X-MC-Unique: 9lyIWpgDMMO14xGtpv7G4w-1
Received: by mail-pl1-f197.google.com with SMTP id w14-20020a170902e88e00b001a238a5946cso5504427plg.11
        for <fstests@vger.kernel.org>; Tue, 28 Mar 2023 11:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680026601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IPPfE7CYTQ7ijpaw9d76qa9EhyWhtaUWmHYKPSThO0=;
        b=xmrIhYI70GuoIkReXmu/mC25MhssSCAeUJdbeHv2b7VHgW6oV2UQ9JDGJtCNwwJc5w
         1fa1ApYIcZKRmSqaaH7Xds2lZNy7qTsuR+nVrX2bYL6KSvPHJWjf1qc7xmYNAiu039tn
         pkCY3p6V5uktR4MtFIf+DSlro/jm/dfWoOmBgps8Su5uKrWhOtS36FrUa6++IRspnxAj
         0ELFnda1BQTXubZ756/OeWO7ceJIAPH8Bwa47byyOh6OcXOSBvV9KEsgvQ6QbKBgcnfr
         4c8mb3S++5dlFN7jnhCCDiekr8J9wixzB37XCDRF8g+10BqVH9QHLEgdClsCcYBCkwCy
         86ew==
X-Gm-Message-State: AAQBX9dgXv5Mf4qYdSxBxL0b2JhJB3+JSrbS0LMR2r/16Nzqzu1QXjjX
        JXn2XyGyaAnU4BN9Jq29gIaMSR9zfeoeOXwnaQlbzo8UszmIZQHx87Nl4twIZVW52kmeggFJcvZ
        6lRXGsGIDezXkHVk66lYeje9+2bE0
X-Received: by 2002:a17:902:f08d:b0:1a1:8d4e:a70d with SMTP id p13-20020a170902f08d00b001a18d4ea70dmr13037345pla.38.1680026601583;
        Tue, 28 Mar 2023 11:03:21 -0700 (PDT)
X-Google-Smtp-Source: AKy350a4C7NUdS2gEzqxilXrFhhzznkL7TxbvcMSZm/KrqnVcIaAi/xXPuRTSvSQGcjGrn8+5PHdwA==
X-Received: by 2002:a17:902:f08d:b0:1a1:8d4e:a70d with SMTP id p13-20020a170902f08d00b001a18d4ea70dmr13037327pla.38.1680026601114;
        Tue, 28 Mar 2023 11:03:21 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q20-20020a170902bd9400b001a2574813b8sm3044274pls.278.2023.03.28.11.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 11:03:20 -0700 (PDT)
Date:   Wed, 29 Mar 2023 02:03:17 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anthony Iliopoulos <ailiop@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common: switch _get_available_space accounting to units
 of 512 bytes
Message-ID: <20230328180317.qwwr632dhmhbrmii@zlang-mailbox>
References: <20230328150104.129486-1-ailiop@suse.com>
 <20230328160225.GB16170@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328160225.GB16170@frogsfrogsfrogs>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 28, 2023 at 09:02:25AM -0700, Darrick J. Wong wrote:
> On Tue, Mar 28, 2023 at 05:01:04PM +0200, Anthony Iliopoulos wrote:
> > xfs/220 relies on detecting free space changes after truncation of
> > single filesystem blocks, and this fails when the fs block size is 512b.
> > 
> > By default df is counting 1024b block units and as such is not reporting
> > any change in the number of available blocks after freeing just a 512b
> > block.
> > 
> > Switch the df reporting block size from units of 1024b blocks to 512b
> > blocks to accommodate accounting for smaller granularity fs block sizes.
> > 
> > Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
> > ---
> >  common/rc | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/common/rc b/common/rc
> > index 90749343f3c4..a32bbe3c0b5f 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -4209,8 +4209,8 @@ _get_available_space()
> >  		exit 1
> >  	fi
> >  	local avail_kb;
> > -	avail_kb=`$DF_PROG $1 | tail -n1 | awk '{ print $5 }'`
> > -	echo $((avail_kb * 1024))
> > +	avail_kb=`$DF_PROG --block-size=512 $1 | tail -n1 | awk '{ print $5 }'`
> > +	echo $((avail_kb * 512))
> 
> Why not have df report the free space in bytes?
> 
> $DF_PROG -B 1 $1 | tail -n 1 | awk '{print $5}'

Agree, if we finally hope to get "bytes", and we can get it at beginning, why
take a long way?

If you'd like to send a V2 to do that, you can do the same change on
_get_total_space() too.

Thanks,
Zorro

> 
> --D
> 
> >  }
> >  
> >  # get the total space in bytes
> > -- 
> > 2.35.3
> > 
> 

