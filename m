Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C70AC433F5
	for <linux-fstests@archiver.kernel.org>; Sat, 16 Apr 2022 14:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbiDPOEm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 16 Apr 2022 10:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiDPOEl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 16 Apr 2022 10:04:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8ECBA29CB2
        for <fstests@vger.kernel.org>; Sat, 16 Apr 2022 07:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650117728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2eab5pwpVUUNnvTqv8Y5HjsonUzluxIv5EMk3f51C5w=;
        b=dHn+Jv41mYWn8tKl0nqXjNyDD5ZHU2kVWhG1M0ToflkICDt5GaA3RcDBb5XndF6Mnhwh8X
        54bNs7sdBN2idHvL2cKrH/oWn3WBT34/6hgHr7FkFryOek2HXFUIJ3ovJZQ+cVKksDfL0j
        elY1PT0qk38YuEWFqvQkvUj34QhUb7Q=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-hD7uVXITPH65vFxf7eBUbQ-1; Sat, 16 Apr 2022 10:02:06 -0400
X-MC-Unique: hD7uVXITPH65vFxf7eBUbQ-1
Received: by mail-qk1-f200.google.com with SMTP id l20-20020a05620a28d400b0069c63137970so6404264qkp.10
        for <fstests@vger.kernel.org>; Sat, 16 Apr 2022 07:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=2eab5pwpVUUNnvTqv8Y5HjsonUzluxIv5EMk3f51C5w=;
        b=AQV1KLsKpDi0+CGknmHtEAa+PIpfMSYpTT/la14NckvCOWxXg4ffI1Yxk9d4u+qgx+
         WT2vouwJBXHUSC02tbfPrQjPROZXP5MUf1FcgWiCF+z1l2cHF3EkSYFpaZ8GQuOO3gy8
         iorwtf5Df+qzRbgcfXeNEd5oA4T3d0c6wbKjQwJt/Lsz7q3wOYWH2MGetybcrGCjE9A2
         OZunkCR7tdZ68/LZn7KSzEZfVNQgdlFrtGqZkdSxDguCPP6v/MpZ7wSV1qclJMgh0+Oe
         vFGawcyFWWzv0l4NFIZwGp+BXNM5Oo5th56ULHe3msc6ujhPjT1dr4Nwe8C0KLtKt9sl
         7RyQ==
X-Gm-Message-State: AOAM531/6i2uU3H0R5YSoa7/fUhocy4kJOJauNL1qqSW731WyD7msPBw
        sA9fGqIRRA6eAXL80ABtVhS6amSiZPpOt9bevJdD21qjRv23QFpevv+2Z/UbK6WLqmb+xo77fXB
        dY5TqK9C73OxQKzJYBg==
X-Received: by 2002:a05:6214:1cc4:b0:435:35c3:f0f1 with SMTP id g4-20020a0562141cc400b0043535c3f0f1mr2401748qvd.0.1650117726305;
        Sat, 16 Apr 2022 07:02:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxX7IeQg3xMoqw8YuJ6Itf74oCrikUpbeQlIA1f2CIP4lkHJsYefEPmiHZLustH25+zgUzhEw==
X-Received: by 2002:a05:6214:1cc4:b0:435:35c3:f0f1 with SMTP id g4-20020a0562141cc400b0043535c3f0f1mr2401733qvd.0.1650117726082;
        Sat, 16 Apr 2022 07:02:06 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y25-20020a05620a09d900b0069e82fb9310sm236237qky.15.2022.04.16.07.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 07:02:05 -0700 (PDT)
Date:   Sat, 16 Apr 2022 22:01:58 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Eryu Guan <guaneryu@gmail.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>, Eryu Guan <guan@eryu.me>
Subject: Re: [PATCH 2/4] generic: ensure we drop suid after fallocate
Message-ID: <20220416140158.fd7jjle5aeomg6cp@zlang-mailbox>
Mail-Followup-To: Amir Goldstein <amir73il@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Eryu Guan <guaneryu@gmail.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>, Eryu Guan <guan@eryu.me>
References: <164971767143.169983.12905331894414458027.stgit@magnolia>
 <164971768254.169983.13280225265874038241.stgit@magnolia>
 <20220412115205.d6jjudlkxs72vezd@zlang-mailbox>
 <CAOQ4uxiDW6=qgWtH8uHkOmAyZBR7vfgwgt-DA_Rn0QVihQZQLw@mail.gmail.com>
 <20220413154401.vun2usvgwlfers2r@zlang-mailbox>
 <20220414155007.GC17014@magnolia>
 <20220414191017.jmv7jmwwhfy2n75z@zlang-mailbox>
 <CAOQ4uxgSmxaOHCj1RdCOX2p1Zmu5enkc4f_fkOLC_muPiMk=PA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgSmxaOHCj1RdCOX2p1Zmu5enkc4f_fkOLC_muPiMk=PA@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Apr 15, 2022 at 04:42:33PM +0300, Amir Goldstein wrote:
> > Hi Darrick, that's another story, you don't need to worry about that in this case :)
> > I'd like to ack this patch, but hope to move it from generic/ to shared/ . Maybe
> > Eryu can help to move it, or I can do that after I get the push permission.
> >
> > The reason why I intend moving it to shared is:
> > Although we are trying to get rid of tests/shared/, but the tests/shared/ still help to
> > remind us what cases are still not real generic cases. We'll try to help all shared
> > cases to be generic. When the time is ready, I'd like to move this case to generic/
> > and change _supported_fs from "xfs btrfs ext4" to "generic".
> >
> 
> Sorry, but I have to object to this move.
> I do not think that is what tests/shared should be used for.
> 
> My preferences are:
> 1. _suppoted_fs generic && _require_xfs_io_command "finsert"

There is:
"verb=finsert
 _require_xfs_io_command $verb"

This patch has not only one case, different cases test different mode of fallocate,
and I think Darrick has given them different _require_xfs_io_command.

> 2. _suppoted_fs generic
> 3. _supported_fs xfs btrfs ext4 (without moving to tests/shared)

There's not any generic cases write like this, only shared cases like that. My personal
opinion is *(2)* or make it shared if it insists "_supported_fs xfs btrfs ext4" (then
will move it back to generic and "_suppoted_fs generic" when Darrick think it's time).

Thanks,
Zorro

> 
> Thanks,
> Amir.
> 

