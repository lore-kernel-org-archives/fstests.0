Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27BEECAAA1
	for <linux-fstests@archiver.kernel.org>; Mon,  5 Sep 2022 09:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbiIEJIX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 5 Sep 2022 05:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237790AbiIEJIW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 5 Sep 2022 05:08:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A077E520B6
        for <fstests@vger.kernel.org>; Mon,  5 Sep 2022 02:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662368897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AEFeJD2ndTirB+xQ56lkbiYe6LofADrROqtJbJfuWSE=;
        b=bQW6Wp+yfXJgHXNm0nUH/FKFqUygcfCT9LlS7bHRly1z2sV+qw/NNlcxYyrWFf3QgVZlWk
        IweGRR82uJa7WHs5x0iZafxGCBDl0L15fp+xmlcP4HANv9IPT2Nq2T1mnB3fAANCpcOuVz
        4Xz1wUjd7AcDFeBYbJEDSMaI1odH7r0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-48-1l3Hh5-INa6vy8W6oDa2Eg-1; Mon, 05 Sep 2022 05:08:16 -0400
X-MC-Unique: 1l3Hh5-INa6vy8W6oDa2Eg-1
Received: by mail-qt1-f197.google.com with SMTP id v5-20020ac873c5000000b003434ef0a8c7so6564326qtp.21
        for <fstests@vger.kernel.org>; Mon, 05 Sep 2022 02:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=AEFeJD2ndTirB+xQ56lkbiYe6LofADrROqtJbJfuWSE=;
        b=g4Tjv5WqLTxIzb2TXtOCbp5hlcLFHHJ7r/by9Fwh8SKLrMBoSBQ63BZ2uu4XKnLQ9D
         cagyV0ONz/gWWDp2x6xeFFKGHfvAmGrW2ajtp5EUavlBfTphIPxKCWVcKHmJzgU/gY1C
         SlQ8bxr41gRHkwaVN24fPSRZ7mYTSJZyZiORjfaw3w0RQRHPBK0W8tNOOjSK5LfWj2zc
         jkGdYXE48Re/ds0fozwoafgZR1aCcicoK4ideo5iXWvAPznIHDJunyyBmjtLne30oJdM
         xxuL9252AEX2oibJWHEmK9obv3dA9sIR9zn1JmG/ZyJAidFyk7M6K/edrrIH7yS6LlEx
         Xg8Q==
X-Gm-Message-State: ACgBeo0e7h/EB/Hz2Vjc9X+gyf2Qije1C2aFH/Fl8uow4kaOCAx65aGH
        IpHNXtEdn9rfqNCkmDXzbPxwRKV1glLAW9O3uGF1TCPSuZo9vzfGCff0oQOrZgQjYPNE+KWBNFA
        xC+4uDPyNHuMa+RRdYQ==
X-Received: by 2002:a05:620a:1709:b0:6bb:85a4:4e8f with SMTP id az9-20020a05620a170900b006bb85a44e8fmr31584552qkb.184.1662368895593;
        Mon, 05 Sep 2022 02:08:15 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4BZmjGbZguy1/0bwv5WY/fF6Qt+5SK7h57MJV7j26pRtqH2lgCxTk5U3u/1T/maorwuF7Ifw==
X-Received: by 2002:a05:620a:1709:b0:6bb:85a4:4e8f with SMTP id az9-20020a05620a170900b006bb85a44e8fmr31584536qkb.184.1662368895337;
        Mon, 05 Sep 2022 02:08:15 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id dm53-20020a05620a1d7500b006b9815a05easm8178907qkb.26.2022.09.05.02.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 02:08:14 -0700 (PDT)
Date:   Mon, 5 Sep 2022 17:08:09 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, dsterba@suse.cz,
        fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: remove 'seek' group from btrfs/007
Message-ID: <20220905090809.54feouoalvrzmaao@zlang-mailbox>
References: <bc7149309a8eca5999f22477a838602023094cb8.1662048451.git.fdmanana@suse.com>
 <20220902020030.oho6ssdrdzjy66pw@zlang-mailbox>
 <20220902094424.GQ13489@twin.jikos.cz>
 <20220905063539.GA2092@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905063539.GA2092@lst.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Sep 05, 2022 at 08:35:39AM +0200, Christoph Hellwig wrote:
> On Fri, Sep 02, 2022 at 11:44:24AM +0200, David Sterba wrote:
> > >   commit 6fd9210bc97710f81e5a7646a2abfd11af0f0c28
> > >   Author: Christoph Hellwig <hch@lst.de>
> > >   Date:   Mon Feb 18 10:05:03 2019 +0100
> > > 
> > >       fstests: add a seek group
> > > 
> > > So I'd like to let Christoph help to double check it.
> > 
> > It's quite obvious from the test itself that it tests only send/receive,
> > which is mentioned in the changelog. The commit adding the seek group
> > does not provide any rationale so it's hard to argue but as it stands
> > now the 'seek' group should not be there.
> 
> Probably.  Unless it somehow exercised seeks through the userspace
> seek code I can't see any good rationale for this addition, and the
> patch was far too long ago for me to remember.

Hi,

I just tried to learn about the history of this *problem*:

At first, Jan Schmidt added src/fssum.c into fstests by df0fd18101b6 ("xfstests:
add fssum tool"). In this original version, fssum does SEEK_DATA in both
sum_file_data_permissive() and sum_file_data_strict(), that means it always
does SEEK_DATA. So all cases run fssum, need SEEK_DATA/HOLE support.

Then 5 years later, Filipe removed SEEK_DATA operations from the 
sum_file_data_permissive(), by 1deed13f69b2 ("fstests: fix fssum to actually
ignore file holes when supposed to"). And fssum run sum_file_data_permissive()
by default. So that cause fssum don't need SEEK_DATA support by default (except
you use "-s" option).

Then 1 year later, Christoph added btrfs/007 into seek group, I think that might
because btrfs/007 still keeps the *_require_seek_data_hole*, which runs the
src/seek_sanity_test.

So, now, if we all agree that btrfs/007 isn't a seek related test, we can remove
the seek group and the *_require_seek_data_hole*.

Thanks,
Zorro

> 

