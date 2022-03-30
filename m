Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B15C433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 30 Mar 2022 04:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241835AbiC3E7P (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 30 Mar 2022 00:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236198AbiC3E7O (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 30 Mar 2022 00:59:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7812D433A3
        for <fstests@vger.kernel.org>; Tue, 29 Mar 2022 21:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648616249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8w2xTmeDVVw4A4jlAeHkNcGTN7E05rfGVtYfTifR1e4=;
        b=UN/GQ5h+E4Ap/0YyYTIytxrGa2kAu2TTVSUYWLTy91RGVtyjygzagBpXN949/VagnnvbjH
        xteQkUGqAVz4jVCR9oAqpoh1hCQSJsiFlSKl0jvyw6Wj98ibNhiWRvZThYyGz32V12oX6O
        IFXjz9W1ShX/ZSNwvbI7QfICTyJA7vY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-375-UrELTUXfMbqvo-B9HEVLng-1; Wed, 30 Mar 2022 00:57:26 -0400
X-MC-Unique: UrELTUXfMbqvo-B9HEVLng-1
Received: by mail-pj1-f69.google.com with SMTP id oj16-20020a17090b4d9000b001c7552b7546so824475pjb.8
        for <fstests@vger.kernel.org>; Tue, 29 Mar 2022 21:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=8w2xTmeDVVw4A4jlAeHkNcGTN7E05rfGVtYfTifR1e4=;
        b=sELws0pvbp2xiQar2+VmuSbFP0EBCe9PCof5qR0mrSB5c1kBTJxQRVHulR4qWn+WOu
         LALBTQfdawnYPzh2TFO7WzJmkA6iuPsvPjPMn4jLYUMEUE+QWdyIB0BhYXUOFsEDsub2
         JapH/lL6quoVUAmVERanFSnzp2BJYzIf0lgj5kj18+5pONkd3eoijTKgrv1Eu6JwF7bh
         8wV3+VX7wk/wVcJckI4yC7cd2YT9pveyKVhtlxr+je935pjrwYW9iZXrB+UtmDsEOvQ1
         qMKpvZM7L0Z42vGeIwCC8IESCv+XhVg2L1GU79OZvU/jZOi7RRMvSJymn0JaRpa3Jpdv
         4pCw==
X-Gm-Message-State: AOAM533mdZTD9JcvxhFyGWxVNH1vXAOi/yfycKuVoCyVsfEpkcWBJtFm
        JzzI+DnBWt1cPOdJG0XxYiHnx9gPgVkXPyX+UzQW0u9M1EEMEChkcag55yICTxcb7oZM6dCArbx
        ALZoR1RHLSAjPbffhcQ==
X-Received: by 2002:a17:90a:578c:b0:1c9:e362:d109 with SMTP id g12-20020a17090a578c00b001c9e362d109mr2926079pji.237.1648616245577;
        Tue, 29 Mar 2022 21:57:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0efyJDlNiSYasPmTneP7z01hNflccHzzNpU4AB/julmTQPFG9D+1ezLQgrKF9Yy3Yau3B1A==
X-Received: by 2002:a17:90a:578c:b0:1c9:e362:d109 with SMTP id g12-20020a17090a578c00b001c9e362d109mr2926051pji.237.1648616245154;
        Tue, 29 Mar 2022 21:57:25 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090adac100b001c67cedd84esm4548427pjx.42.2022.03.29.21.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 21:57:24 -0700 (PDT)
Date:   Wed, 30 Mar 2022 12:57:18 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "liuyd.fnst@fujitsu.com" <liuyd.fnst@fujitsu.com>
Subject: Re: [Question] About allocsp_calls not implemented
Message-ID: <20220330045718.wqrarqorslzaeks5@zlang-mailbox>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "liuyd.fnst@fujitsu.com" <liuyd.fnst@fujitsu.com>
References: <1b0b8627-0d30-018b-4a98-b69f5a8033f1@fujitsu.com>
 <20220329113521.56ks64wanu5kreur@zlang-mailbox>
 <20220329201421.GF27713@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220329201421.GF27713@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 29, 2022 at 01:14:21PM -0700, Darrick J. Wong wrote:
> On Tue, Mar 29, 2022 at 07:35:21PM +0800, Zorro Lang wrote:
> > On Tue, Mar 29, 2022 at 09:59:02AM +0000, liuyd.fnst@fujitsu.com wrote:
> > > Hi, all.
> > > 
> > > We noticed below tests failed due to fsx issue introduced by a32fb1bb 
> > > fsx: add support for XFS_IOC_ALLOCSP.
> > > 
> > > generic/075  generic/091  generic/112  generic/127  generic/263
> > > 
> > > The log shows "do_allocsp: allocsp: Function not implemented".
> > 
> > Hmm... Darrick, I think we'd better to disable IOC_ALLOCSP operation
> > in fsx.c by default, and use another option to allow user to enable it
> > if they need. Or use another option to disable it, leave -F for fallocate
> > only.
> > 
> > What do you think?
> 
> I'd remove ALLOCSP support from fsx entirely.

OK... So we took a roundabout way and back :) I have no objection to
revert it, due to it cause some of my testing has to use "fsx -F" to
continue.

I'll revert two related commits:
Revert "fsx: add support for XFS_IOC_ALLOCSP"
Revert "fsx: disable allocsp_calls if -F is specified"

I'll combine them into one patch, and send out to review. To check what
others think about that :)

Thanks,
Zorro

> 
> --D
> 
> > Thanks,
> > Zorro
> > 
> > > 
> > > 
> > > The error has been around for a while so I want to know whether upstream 
> > > has got this info. As of now, we revert cd99a499 and a32fb1bb to test.
> > > 
> > > -- 
> > > Best Regards.
> > > Yiding Liu
> > 
> 

