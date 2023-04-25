Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611CDC77B61
	for <linux-fstests@archiver.kernel.org>; Tue, 25 Apr 2023 04:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjDYEvu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 Apr 2023 00:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjDYEvt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 Apr 2023 00:51:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6429B7DA9
        for <fstests@vger.kernel.org>; Mon, 24 Apr 2023 21:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682398266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zn5U4cki3qL13ZRoSm6iMw9J7l1g3UeZmkZdZOszEX0=;
        b=OQgEsnL2/Pqc1HvaGVba1vk5IZj9kKwAIgU95fm2LGcrBVuyAlXqMaOPfIe03vu3HltNz1
        jVe5R5tqgYYO13Q9qtg+sc0rQ+o1kflQqeUvpIoKEelok0Gi+d37e6lSUrk5QEef3wXqfy
        SsdZGFcPYOfTaZAuNgk35eWa/1tf49c=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-wFBQtqHROTCb0lEA80yBNQ-1; Tue, 25 Apr 2023 00:51:04 -0400
X-MC-Unique: wFBQtqHROTCb0lEA80yBNQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2470e26b570so3031637a91.3
        for <fstests@vger.kernel.org>; Mon, 24 Apr 2023 21:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682398263; x=1684990263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zn5U4cki3qL13ZRoSm6iMw9J7l1g3UeZmkZdZOszEX0=;
        b=mGE9AP5zLclCsJzdR/2FDqe/7TMeoFJHzlwVjutZjpsoXbffyYFbgCHAar8P2xdcSJ
         6WBWeZhaT9vqwxEKWYkfa3adr+l56PFsPLoENMo5x6DspngofvrumV9LoGcDILTBnDA8
         LTChKu2rQd1a7DwJOUU15w/OrViPf1leILl1lyVqtoUxHLqrFoyx/34/hrn/NYp6CJI4
         rg5qoRTf+KT1gUfyk/WKOggSAd6+FnAfYGh8SRPLTFTITzR1lISxNs+aTQyh2Jn3jaAl
         ORWjDF9k0l/VNuFGQ4W9YgsHHmehUijigDue6h93OtSkXP0DwIqQ/4R6l2joCMjqANXp
         Yptg==
X-Gm-Message-State: AAQBX9c0eTn78G6Xb/yazgMoM8v1HpU7/tOtO55xl1ExXTeW3PjADJdq
        taiKsDfDJ3HoWE4O90PqCbZO8Dtchy2EF70+vZhdZ10B3PoDhzgouk44P7zrUnGrxchXzpXO0qe
        OjT4C8Rys9TfcHLtXHA==
X-Received: by 2002:a17:90b:388f:b0:23d:1143:c664 with SMTP id mu15-20020a17090b388f00b0023d1143c664mr15762557pjb.31.1682398263630;
        Mon, 24 Apr 2023 21:51:03 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y55j3LnBzFBfrpgSxkZiLcxvgR86N73VrSUO5Cyj2lIq4B71VHKDXAktFhCDdigMRp4HwWQw==
X-Received: by 2002:a17:90b:388f:b0:23d:1143:c664 with SMTP id mu15-20020a17090b388f00b0023d1143c664mr15762542pjb.31.1682398263088;
        Mon, 24 Apr 2023 21:51:03 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g3-20020a1709026b4300b00199193e5ea1sm7323810plt.61.2023.04.24.21.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 21:51:02 -0700 (PDT)
Date:   Tue, 25 Apr 2023 12:50:58 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/3] generic/476: reclassify this test as a long running
 soak stress test
Message-ID: <20230425045058.s5kcgecjis24ktxd@zlang-mailbox>
References: <168123682679.4086541.13812285218510940665.stgit@frogsfrogsfrogs>
 <168123683265.4086541.1415706130542808348.stgit@frogsfrogsfrogs>
 <20230422082456.6nsk5ve756j37jas@zlang-mailbox>
 <20230424181725.GG360885@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424181725.GG360885@frogsfrogsfrogs>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 24, 2023 at 11:17:25AM -0700, Darrick J. Wong wrote:
> On Sat, Apr 22, 2023 at 04:24:56PM +0800, Zorro Lang wrote:
> > On Tue, Apr 11, 2023 at 11:13:52AM -0700, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > This test is a long(ish) running stress test, so add it to those groups.
> > > 
> > > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > > ---
> > >  tests/generic/476 |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > 
> > > diff --git a/tests/generic/476 b/tests/generic/476
> > > index 212373d17c..edb0be7b50 100755
> > > --- a/tests/generic/476
> > > +++ b/tests/generic/476
> > > @@ -8,7 +8,7 @@
> > >  # bugs in the write path.
> > >  #
> > >  . ./common/preamble
> > > -_begin_fstest auto rw
> > > +_begin_fstest auto rw soak long_rw stress
> > 
> > Sorry for late reviewing. I thought a bit more about this change. I think
> > the "soak", "long_rw" and "stress" tags are a bit overlap. If the "stress"
> > group means "fsstress", then I think the fsstress test can be in soak
> > group too, and currently the test cases in "soak" group are same with the
> > "long_rw" group [1].
> 
> Hm.  Given the current definitions of each group:
> 
> long_rw                 long-soak read write IO path exercisers
> rw                      read/write IO tests
> soak                    long running soak tests of any kind
> stress                  fsstress filesystem exerciser
> 
> I think these all can apply to generic/476 -- it's definitely a
> read-write IO test; it's definitely one that does RW for a long time;
> and it uses fsstress.
> 
> > So I think we can give the "soak" tag to more test cases with random I/Os
> > (fsstress or fsx or others). And rename "long_rw" to "long_soak" for those
> > soak group cases which need long soaking time. Then we have two group tags
> > for random loading/stress test cases, the testers can (decide to) run these
> > random load test cases seperately with more time or loop count.
> 
> I have a counterproposal -- what do you think about redefining 'soak' to
> mean "all tests where SOAK_DURATION can be used to control the test
> runtime directly"?  This shouldn't break anyone's scripts, since the
> only members of 'soak' are the ones that get modified by this patchset.

Sure, we can check if more cases can use the SOAK_DURATION later, then we add
them to soak group.

Thanks,
Zorro

> 
> --D
> 
> > Anyway, above things can be done in another patchset, I just speak out to
> > get more talking:) For this patch:
> > 
> > Reviewed-by: Zorro Lang <zlang@redhat.com>
> > 
> > 
> > 
> > Thanks,
> > Zorro
> > 
> > [1]
> > # ./check -n -g soak
> > SECTION       -- simpledev
> > FSTYP         -- xfs (non-debug)
> > PLATFORM      -- Linux/x86_64
> > MKFS_OPTIONS  -- -f -m rmapbt=1 /dev/sda3
> > MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sda3 /mnt/scratch
> > 
> > generic/521
> > generic/522
> > generic/642
> > 
> > # ./check -n -g long_rw
> > SECTION       -- simpledev
> > FSTYP         -- xfs (non-debug)
> > PLATFORM      -- Linux/x86_64
> > MKFS_OPTIONS  -- -f -m rmapbt=1 /dev/sda3
> > MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sda3 /mnt/scratch
> > 
> > generic/521
> > generic/522
> > generic/642
> > 
> > 
> > >  
> > >  # Override the default cleanup function.
> > >  _cleanup()
> > > 
> > 
> 

