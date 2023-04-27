Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DD9C77B73
	for <linux-fstests@archiver.kernel.org>; Thu, 27 Apr 2023 05:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242675AbjD0Fjv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 27 Apr 2023 01:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjD0Fju (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 27 Apr 2023 01:39:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8A9E65
        for <fstests@vger.kernel.org>; Wed, 26 Apr 2023 22:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682573942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3IRv0xcvCBGXo8Vx75fT1GgV0k3FMDpkeMz40XQE2go=;
        b=Oy7t9mtNwjHblOM+xWGGZSBk1dUWZMEeDT3uc60EyIVgSa/25Ps0l8q7hKDL8L0AcOI15n
        pm+xnk5cwQsTSVCJLbISbVqW0Mp4fLEb+dNoTerKgYpUTGbBCPrupadJfgZLeQqSGJF6Vu
        Gc+NIqxdbLwH/Huhy/4oZOzvBIl5EQU=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-0A7Z8aLUPtOP-L50QXdiuw-1; Thu, 27 Apr 2023 01:39:01 -0400
X-MC-Unique: 0A7Z8aLUPtOP-L50QXdiuw-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-63b86fc03fcso5437628b3a.1
        for <fstests@vger.kernel.org>; Wed, 26 Apr 2023 22:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682573940; x=1685165940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IRv0xcvCBGXo8Vx75fT1GgV0k3FMDpkeMz40XQE2go=;
        b=BIbbX9jtTqi2fCXgu0TgLBKLqza9Re/QiCT5Q8KmEKOdVruyJRKpvKUsKbxklZByGj
         NbxqOS5TMk+DiR76q2IfmDZi4SbVmOTZ26ZkThowxPjaIEws8t3RQnsjMLLe21fh8YlQ
         RQY5cQ5lNywdruhZRMEMSPv04wkkQMQuN2iKvI/8XmrdeQMI1VvlulgMJqbUD194YS9g
         HitkWh2KnGkfJkVh8tClZntYlNPXJ+UfoUr12rkTZLS8jcV9EjUqTIoBeJRgk5AkcTvt
         cg1eEzqo6iMc48jIbrKHagT8Lxx8cANEAU9VUjlK695QHvqkaTUt5MlEjPtw3AOnoHdU
         PiQQ==
X-Gm-Message-State: AC+VfDyg8EYVGJCE8YGUYQQaPi/uQR1g48FA8RrkcmN3WZcmTaU40/+M
        eoyUvbEp3SvVbi8tkkb/Xh55uQtzqTTGydmlIH4EkhunhOI5RS7H/OhDQGupyVb56Tp19PDY8+t
        O5fQMb0kv6Vx0QTVREg==
X-Received: by 2002:a05:6a20:9183:b0:ee:bfc0:2bfe with SMTP id v3-20020a056a20918300b000eebfc02bfemr438600pzd.60.1682573940232;
        Wed, 26 Apr 2023 22:39:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6MIqLUlGUvl5/P7TIxRPX3bIvx2EsU8GV5In4op/WwaWcV1pBkN9CdtSguiX7QvZwfdcfGyA==
X-Received: by 2002:a05:6a20:9183:b0:ee:bfc0:2bfe with SMTP id v3-20020a056a20918300b000eebfc02bfemr438572pzd.60.1682573939795;
        Wed, 26 Apr 2023 22:38:59 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id i14-20020a655b8e000000b0051f14839bf3sm10834387pgr.34.2023.04.26.22.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 22:38:59 -0700 (PDT)
Date:   Thu, 27 Apr 2023 13:38:54 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
        Eryu Guan <guan@eryu.me>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jeffrey Altman <jaltman@auristor.com>,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v2 1/6] Add AFS support
Message-ID: <20230427053854.gyccwirg7wwsy5ft@zlang-mailbox>
References: <20230426194018.hrq3pme5wkxia5pm@zlang-mailbox>
 <20230426143011.lktpz46bytvub6kh@zlang-mailbox>
 <20230424141042.450535-1-dhowells@redhat.com>
 <20230424141042.450535-2-dhowells@redhat.com>
 <868873.1682524402@warthog.procyon.org.uk>
 <883621.1682541160@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <883621.1682541160@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Apr 26, 2023 at 09:32:40PM +0100, David Howells wrote:
> Zorro Lang <zlang@redhat.com> wrote:
> 
> > > The in-kernel afs fs takes a string in afs mountpoint format as its source.
> > 
> > So do we need to change the below line:
> > 
> >   echo $SCRATCH_DEV | grep -q "^%" > /dev/null 2>&1
> > 
> > to
> > 
> >   echo "$SCRATCH_DEV" | grep -q ^[%#] 
> > 
> > ?
> 
> I think we want to require '%' to force a RW volume.  xfstests probably won't
> work on a RO or backup volume.

OK, thanks for this explanation, maybe we can you add this to be a comment of
grep -q "^%". (I can help that when I merge it, if no more other changes).

Now most (5/6) of patches of this patchset are reviewed, if you'd like to add
more things in README or README.config-sections or other docs, I'll wait
the v2 of this patch. Or I'll merge this patchset in next fstests release
(might be this weekend).

Thanks,
Zorro

> 
> David
> 

