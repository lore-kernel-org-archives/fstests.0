Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35E8ECAAD8
	for <linux-fstests@archiver.kernel.org>; Tue, 20 Sep 2022 15:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiITPLS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 20 Sep 2022 11:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiITPLJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 20 Sep 2022 11:11:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD3426122
        for <fstests@vger.kernel.org>; Tue, 20 Sep 2022 08:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663686668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eQvolEoHkjppWhWN2mJNJk/jZqz5GTsenRCYWGFqWis=;
        b=S+gdsxaAkHxmnrK7s5US9hssV6mKYoNoY4/vcKfzgbgePDON1QLVTtrPIpfcGyFqTfAw8I
        epO21QF0atrzKlukII/mhxaQTlGdAvMsC81oomRaAjiuwj2w/jDjyX9Sh0eew+TZG8wHY1
        lRfDcbPR4uKKphEAp49N/K7mQaUvJtg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-597-iKwQpfmUPgyEkUfHJ4TnMw-1; Tue, 20 Sep 2022 11:11:06 -0400
X-MC-Unique: iKwQpfmUPgyEkUfHJ4TnMw-1
Received: by mail-qt1-f200.google.com with SMTP id cb22-20020a05622a1f9600b0035bb51792d2so2045890qtb.5
        for <fstests@vger.kernel.org>; Tue, 20 Sep 2022 08:11:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=eQvolEoHkjppWhWN2mJNJk/jZqz5GTsenRCYWGFqWis=;
        b=HgCgNE7PaNqEKf3XicRufqbVCvXT/p8fPnb20OQqsOT0nEzzNOAJk4OXBNjyT+Z9uh
         CA8LZPLgEgzNS1ewNGyTqVjWRKzQvIc41albi5NTHVgCgpZ0Vg04i6nzJc4rpvI9scXa
         4UrdCwS0Fqo7HIyxxVjKJwVqQ+jiiKbXlNoWDEHdwSP4qpWBykoshHmCqeqEudgkCNjh
         wiU4qUmjAvyvQR21+MZti7poTSURIhDS5X52CqcxAsTFO6d79fLP/iIbMlrqm2IH/Hfw
         6TWDllwuBI4SJTa0hmnbGFRMSa3Dw6NtPh/PsIoY4vE5h14FywNFuO/zG84SeLteWrj3
         bqUA==
X-Gm-Message-State: ACrzQf35lvAEsvHbwx7Z94wGJ1dxk53vCNy9LUGIT+1b9sQflTjQODzP
        myLgfD/yQD26udSSS2uGXBaeJwXr6kQvE7v00lyK3Xe1HEH5rF3xgZB7yo6snZ1ly/wTdEat9vB
        A+rcMzTK9pzTBoJoA5g==
X-Received: by 2002:a05:620a:4145:b0:6ce:a326:44e2 with SMTP id k5-20020a05620a414500b006cea32644e2mr16771630qko.1.1663686666383;
        Tue, 20 Sep 2022 08:11:06 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM60v5AOh6PD2U/UymGlfgyyNm5hY4NOnUJXjKhJuN64r+lug4+KIu8XjioXENQBjD8801GU5w==
X-Received: by 2002:a05:620a:4145:b0:6ce:a326:44e2 with SMTP id k5-20020a05620a414500b006cea32644e2mr16771605qko.1.1663686666113;
        Tue, 20 Sep 2022 08:11:06 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id c10-20020a05620a11aa00b006bb83c2be40sm6956qkk.59.2022.09.20.08.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 08:11:05 -0700 (PDT)
Date:   Tue, 20 Sep 2022 23:11:00 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
        sforshee@digitalocean.com, amir73il@gmail.com, hch@lst.de,
        cyphar@cyphar.com
Subject: Re: [PATCH v4 0/2] group ownership changing test
Message-ID: <20220920151100.achmijzszaln4tl6@zlang-mailbox>
References: <20220920115035.2472076-1-zlang@kernel.org>
 <20220920145006.bsrinbmqwrk5kl7w@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920145006.bsrinbmqwrk5kl7w@wittgenstein>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Sep 20, 2022 at 04:50:06PM +0200, Christian Brauner wrote:
> On Tue, Sep 20, 2022 at 07:50:33PM +0800, Zorro Lang wrote:
> > Hi Christian,
> > 
> > It's been 3 month past, since your patch [1] was reviewed last time. I'm still
> > waititng for this test coverage for fs. According to the review points last
> > time, I split your v3 patch [1] to 2 separated cases, one basic testing for
> > covering that fix, one extend testing for overlay part.
> > 
> > I only did below changes (compare with v3):
> > 1) Split one case to two cases.
> > 2) Move "_supports_filetype" line under the _scratch_mount.
> > 
> > I still keep the patch Author as you, and signed-off-by you, due to I just
> > hope to bring this discussion back, and push the proceeding of this patch
> > be merged.
> > 
> > (CC the old cc list to get more review)
> > 
> > Thanks,
> > Zorro
> > 
> > [1]
> > https://lore.kernel.org/fstests/20220615092826.2333847-1-brauner@kernel.org/
> 
> Zorro,
> 
> Thank you for picking this patchset up! I just didn't have the time.
> I've applied it, reviewed, and tested it:
> 
> Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> Tested-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> 
> We really need this regression test!

Np, I'd like to have this testing coverage too, so I keep it in my queueing list
long time. I'd like to add your RVB, but it's weird to be reviewed by yourself,
due to I keep the author and signed-off-by to you :) And this patchset is sent
by me now, so it might be weird too if I ack it :-D

Anyway, if there's no objection or more review points from others, I'd like to
merge this patchset (signed-off-by you, reviewed by me) this week.

Thanks,
Zorro

> 
> Christian
> 

