Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8460EC433EF
	for <linux-fstests@archiver.kernel.org>; Fri,  3 Jun 2022 07:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbiFCHoF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 3 Jun 2022 03:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238457AbiFCHoD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 3 Jun 2022 03:44:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7938038B1
        for <fstests@vger.kernel.org>; Fri,  3 Jun 2022 00:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654242241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3NFR17KqSiA1Cv/9OF/SD8mUQpa5Kr1/3JIDc75JsUk=;
        b=EvtZpfQqdRpxEl/+CXH/lUJelg0hjFBvUBkrGDxtuClucQFGjfB4w61plN9+BPMIr4XR6B
        NfS38JsxUTn15LcIUUKmzjzvs1i4n+3f1u7Q/azb0jGQ4V6r2YUqGUgeJvuxZAQCwWlbsZ
        Ue3mKas3EwpsFMoVQpYBkwT5hfPvXRM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-443-VTROs3x6Nly5YFfXa7ZtGg-1; Fri, 03 Jun 2022 03:41:03 -0400
X-MC-Unique: VTROs3x6Nly5YFfXa7ZtGg-1
Received: by mail-qt1-f197.google.com with SMTP id l20-20020ac81494000000b002f91203eeacso5352811qtj.10
        for <fstests@vger.kernel.org>; Fri, 03 Jun 2022 00:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3NFR17KqSiA1Cv/9OF/SD8mUQpa5Kr1/3JIDc75JsUk=;
        b=PZ1gHCd2vt1n1UKCmpHwN/E0QhAefYf68wlpUd5h0ptmmRkcZ7BJ7yUxJi4xrAs3NJ
         BjBCaXnn1ytL024Lj8NIZnnus3Ios2liBgqr6oD8r/GAf/6s6WdY3EQbMMF/T+Qm7CTi
         5VWMCR27++eq9tg6lisPFRD++TszatC3TSms7Hpjd6yQM9x+QdIDG04MqcAiUPoYzbuk
         Jakodw556eIdEuzJr9Tq9fHfAVz1bonHNCeCWYfUkPZ9Cp4SWJ7tEQZO4/wHeY0k5Exy
         coOUes9Nbd1clsj4PNswAcP/I1BJ/NkK1THnHmWn17pB6MphpNNyagHsYbKeKgIvxkLx
         8ENg==
X-Gm-Message-State: AOAM533HcmdN5/IFpPXVkg/iMeY9G8OVTehkB/FbWOjnx1BiISorUNtl
        QL4WCT0aZi+vQPS2uRDs8gwTW2f8pG7jkxUzBTvfYNx2SRYqbH9bGiRH3ztNrkdMqX21lCOPNp7
        y8jw57rFIU/40w+90DQ==
X-Received: by 2002:a37:2fc4:0:b0:6a6:494e:475d with SMTP id v187-20020a372fc4000000b006a6494e475dmr5934583qkh.102.1654242063291;
        Fri, 03 Jun 2022 00:41:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwd+761mLalCzth1wMYYZ/8jeGqiIQL3PL5SrqyGa2xf7m+maJqg+W2BR4hynzRsE6pv5DcOw==
X-Received: by 2002:a37:2fc4:0:b0:6a6:494e:475d with SMTP id v187-20020a372fc4000000b006a6494e475dmr5934575qkh.102.1654242062972;
        Fri, 03 Jun 2022 00:41:02 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n12-20020a05622a11cc00b003022cdcd28bsm4586450qtk.2.2022.06.03.00.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 00:41:02 -0700 (PDT)
Date:   Fri, 3 Jun 2022 15:40:57 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] ext4/053: update the test_dummy_encryption tests
Message-ID: <20220603074057.5l63o3opgouczueb@zlang-mailbox>
References: <20220530173044.156375-1-ebiggers@kernel.org>
 <20220603053143.ud42tcsxrdkr3mj2@zlang-mailbox>
 <YpmgrJHnrMR8BcOG@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpmgrJHnrMR8BcOG@sol.localdomain>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jun 02, 2022 at 10:48:28PM -0700, Eric Biggers wrote:
> On Fri, Jun 03, 2022 at 01:31:43PM +0800, Zorro Lang wrote:
> > On Mon, May 30, 2022 at 10:30:44AM -0700, Eric Biggers wrote:
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > Kernel commit 5f41fdaea63d ("ext4: only allow test_dummy_encryption when
> > > supported") tightened the requirements on when the test_dummy_encryption
> > > mount option is accepted.  Update ext4/053 accordingly.
> > > 
> > > Move the test cases to later in the file to group them with the other
> > > test cases that use do_mkfs to add custom mkfs options instead of using
> > > the "default" filesystem that the test creates at the beginning.
> > > 
> > > Reviewed-by: Lukas Czerner <lczerner@redhat.com>
> > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > > ---
> > > 
> > > v2: mention the commit ID now that it is merged, and add a Reviewed-by
> > 
> > Hi Eric,
> > 
> > If I don't remember wrong, it was a patchset with 2 patches. Now you only
> > send this patch out, do you hope to merge this one only, or merge both?
> > 
> > Thanks,
> > Zorro
> > 
> 
> Just this one for now.  The second patch would add a test for the bug fix
> https://lore.kernel.org/linux-ext4/20220526040412.173025-1-ebiggers@kernel.org,
> but that wasn't applied for 5.19 due to a cross-tree dependency.  I'll be
> resending that test patch later.  One step at a time...

Sure, thanks for clarify that :)

Thanks,
Zorro

> 
> - Eric
> 

