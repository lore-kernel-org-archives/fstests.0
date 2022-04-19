Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EA1C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 19 Apr 2022 18:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357256AbiDSSe4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 19 Apr 2022 14:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358376AbiDSSeU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 19 Apr 2022 14:34:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72C6D1F636
        for <fstests@vger.kernel.org>; Tue, 19 Apr 2022 11:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650392692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rV/oIJuSRdXlpNeXhKh3voKtPfZZuFMZJqZv7uChGPs=;
        b=TMkyrEz9WNx+SEH4k/J4kWcYePkPINJw+vfzteQuawUJP6YDYtL2EQu3xhKgqGCGEHlaDa
        /TVcyZLJJqBJYzuiKbIJoLW3OwTAcOviEZYP+m6x9D17z54VGijsocxOIQUsMtCGY/rJbl
        hZlqa8Pv5l7IpZjnPOd/Dm4NDaXwdTQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-575-AyAbVH-cN-q_DTwLAyrhqg-1; Tue, 19 Apr 2022 14:24:51 -0400
X-MC-Unique: AyAbVH-cN-q_DTwLAyrhqg-1
Received: by mail-qv1-f72.google.com with SMTP id p3-20020a05621421e300b0044427d0ab90so15054173qvj.17
        for <fstests@vger.kernel.org>; Tue, 19 Apr 2022 11:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=rV/oIJuSRdXlpNeXhKh3voKtPfZZuFMZJqZv7uChGPs=;
        b=jJyQUaCmyL/dJFANeW/c18f/DQKvKBCYxuA+vnxyqp1UZe/DFdtQhP0lF5NzFUeNf5
         Kgx6p48kH2NEwnzCtl1j1fGJQodgF/VFV4f/0wD78uSwo8VhHs9+6BkLk+of4cKxHR99
         oysXJ4Nbv8Tj+WCvxhvPL5WQoxu8OK6cQcUtZC3c+N2mle/klNkaZ/R61PqEPX2gknVV
         msL/rqtxs2xkuVng9RZXd/Novu4XNvXajlcAnYB/thnQzq5L+zCyCZZwrcObEN8ZURrX
         2a7laJHpGvqNrq9efRptb+mb5NhSvUgGU9gUHtUZV4D3IOjM8+6HPdellvacJxQlZCGy
         sS0g==
X-Gm-Message-State: AOAM531Y/uVprAwMAUBvX0jhjz8/vaseQe8MOsME7aBQhFgAtVQc+Fsy
        sz8KpFutJWb4ZXBMvJytFHycWWfPnFC5A6JPg6F+bS6e3XW4f+GMqvmGWrIKoTCOYz3i9mxJgV0
        PWy94OPS+okVYlw8DnQ==
X-Received: by 2002:a05:622a:1cf:b0:2f1:f542:7083 with SMTP id t15-20020a05622a01cf00b002f1f5427083mr10407340qtw.78.1650392690807;
        Tue, 19 Apr 2022 11:24:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjlMSwcEu5KUZHOTHgBsSDXDcqXU/0PQuRFBBTFgGeOyBwtZiTiopRYZl/C+vMZSCONSB6UA==
X-Received: by 2002:a05:622a:1cf:b0:2f1:f542:7083 with SMTP id t15-20020a05622a01cf00b002f1f5427083mr10407325qtw.78.1650392690625;
        Tue, 19 Apr 2022 11:24:50 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id l9-20020a05622a174900b002ee2fed0583sm449867qtk.27.2022.04.19.11.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:24:50 -0700 (PDT)
Message-ID: <49c115447ffb0b9e8d18c1e1064cbe55589f37da.camel@redhat.com>
Subject: Re: [PATCH] cephfs: add ceph-fuse suport for ceph-fuse
From:   Jeff Layton <jlayton@redhat.com>
To:     Rishabh Dave <ridave@redhat.com>
Cc:     fstests@vger.kernel.org, Rishabh Dave <rishabhddave@gmail.com>
Date:   Tue, 19 Apr 2022 14:24:49 -0400
In-Reply-To: <CA+jMu4RUhWa7CSeeXeymy-k9B00XmgLsgyH85Trv-wqjc+1aSQ@mail.gmail.com>
References: <20220419175811.602126-1-ridave@redhat.com>
         <b80030d5be5158115dd71cb953701e86d9fc5621.camel@redhat.com>
         <CA+jMu4RUhWa7CSeeXeymy-k9B00XmgLsgyH85Trv-wqjc+1aSQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, 2022-04-19 at 23:50 +0530, Rishabh Dave wrote:
> Hi Jeff,
> 
> Thanks for the review!
> 
> On Tue, 19 Apr 2022 at 23:34, Jeff Layton <jlayton@redhat.com> wrote:
> > 
> > > -     # find $dev as the source, and print result in "$dev $mnt" format
> > > -     local mount_rec=`findmnt -rncv -S $dev -o SOURCE,TARGET`
> > > -     [ -n "$mount_rec" ] || return 1 # 1 = not mounted
> > > +     # this check doesn't work on ceph-fuse
> > > +     if [ "$dev" != "ceph-fuse" ]; then
> > > +             _check_if_dev_already_mounted $dev $mnt
> > > +             dev_already_mounted=$?
> > > 
> > 
> > Shouldn't there be a "fi" above?
> > 
> > > -     # if it's mounted, make sure its on $mnt
> > > -     if [ "$mount_rec" != "$dev $mnt" ]; then
> > > -             echo "$devname=$dev is mounted but not on $mntname=$mnt - aborting"
> > > -             echo "Already mounted result:"
> > > -             echo $mount_rec
> > > -             return 2 # 2 = mounted on wrong mnt
> > > +             if [ $dev_already_mounted -ne 0 ]; then
> > > +                     return $dev_already_mounted
> > > +             fi
> > >       fi
> > 
> 
> Here's the "fi" for the "if" you referred to above.
> 

Oops, I misread the patch! This looks fine to me:

Reviewed-by: Jeff Layton <jlayton@redhat.com>

