Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2287EC47089
	for <linux-fstests@archiver.kernel.org>; Wed, 26 May 2021 08:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08C876143E
	for <linux-fstests@archiver.kernel.org>; Wed, 26 May 2021 08:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbhEZIEY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 26 May 2021 04:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbhEZIES (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 May 2021 04:04:18 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5B1C06175F
        for <fstests@vger.kernel.org>; Wed, 26 May 2021 01:02:46 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id j10so200971edw.8
        for <fstests@vger.kernel.org>; Wed, 26 May 2021 01:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W1KMLksfoOETmfA+TFEjfKJxKRe65++yP/OLR847GlU=;
        b=sZngSuOSe0AHDpb6+buUPlxjgFlTgc1O+YNnzBuTFj8R41tYWgSUlZyVHWYPWtVQEr
         AHbY2akuDn+65QOY+nCNq3jmwnLJ6x2E7HEhRlHX5AkIKqIlxyoYMGnl5gYK7vOYkEKP
         LDFMJ55ijPYQLV4e8Tk9Itl2re5S/1+IVrFuG+VRe/RWdbLGi2gQG4djBusstDvj0mzy
         k3N+mTqC7ENn1g5X2+JRKxesE/mRD4TkdiC2n9pNFHG5LA61fk7HRGI96e2Ba/en3p9W
         mb+nGeF5Ama1kK7tq8NUS7WR5uK4AdZvpBj195nhiGIgoLoZFMVaSDVFAYV5xepqGA3X
         qXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W1KMLksfoOETmfA+TFEjfKJxKRe65++yP/OLR847GlU=;
        b=MLWQi4OlShOuY2oi+YLwYlfpKo354pM7ORwQeubSIH4VhZ8hy1Zyw0Hh1zj9ITXy9Q
         vgNsZhLYZjDXGUvLm/GyhKIJhDzrtKJoGUJEVsQUndpGJn0UWxitAf2Kw5ZVhIIrK2Rb
         PwZ7ZdiT+byzxGk8nL6b5CwcYWjQOQS124lX4rQQLcX1w+mf2n6qjQZwAXfqc2oI3nAf
         uQFm9Yp0a8piudyA0T/CAJ6UapztOzuOvxV5a3Lo2OZMY9v3kgP22RfxfiaP052s6Db4
         nUTf7MCdFYEQdiXagpjTGw/vfZpmPSkB21TAvKoxaIHwXOdXTbak07xe1KDMDOf0Xrd8
         w/Qw==
X-Gm-Message-State: AOAM530fXAC7hBgDg3pxt8TuxVyEtQ3ko25PjMZp0g+n5J3gc4WEPRqk
        /QKX2puSBK3puWTG7aZbjWLT0p5k4inWtxXSCBk=
X-Google-Smtp-Source: ABdhPJzEhkQDHMEHTr8dGW87Xji2pqc0YbKBLrCun8M2tRh8YaxzhDQ9G792oUK2rLDOJ0lhwRD6x2CkmhsBVM1wnzU=
X-Received: by 2002:aa7:d70e:: with SMTP id t14mr36181371edq.377.1622016165430;
 Wed, 26 May 2021 01:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210522184814.95802-1-jakobunt@gmail.com> <YKoa7dtkdmu8hp+/@desktop>
 <CAPv9ZmkirKWThgE7q2oHFFMtk0bQ7A9xG8i+RGqgyLnCkCJJZg@mail.gmail.com>
 <20210526032037.GF60846@e18g06458.et15sqa> <20210526034139.GL202095@locust>
In-Reply-To: <20210526034139.GL202095@locust>
From:   Jakob Unterwurzacher <jakobunt@gmail.com>
Date:   Wed, 26 May 2021 10:02:34 +0200
Message-ID: <CAPv9Zmk0sfMM=wPuNPRvHhUmsHC9fxTO-wUiQG_OFXiDpj4cHA@mail.gmail.com>
Subject: Re: [PATCH] generic/286: fix integer underflow on block sizes != 4096
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Eryu Guan <eguan@linux.alibaba.com>, Eryu Guan <guan@eryu.me>,
        fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

> > Ah, that makes sense to me now. Would you please include the detailed
> > explaination in commit log as well?
>
> ...and maybe a sample output of a seek_data/seek_hole scan between a
> gocryptfs file and the ext4fs underneath it?  I'm still trying to wrap
> my head around what the problem here is.
>
> It might also help to describe where the 32 bytes of overhead goes --
> are you interleaving the overhead inline with 4k of encrypted content?

Yes, it's all inline, the file format is like this [2]:

file header  ... 18 bytes
data block 1 ... 16 bytes block header  (IV)
                 1-4096 bytes user data
                 16 bytes block trailer (MAC)
[more data blocks...]

I am attaching the SEEK_DATA/SEEK_HOLE trace below [1]. One seek goes like this:
(1) gocryptfs gets a seek() call via FUSE
(2) translate plaintext to ciphertext offset
(3) call ext4 seek
(4) translate back to plaintext offset and return

Actually Eryu's first comment had me start thinking about this, and
what gocryptfs
does is a little stupid, because the offsets that get returned to userspace may
point in the middle of a block, but gocryptfs reads or writes in
blocks of 4128 bytes (= 4096 bytes of user data)
(*except at EOF), so it may as well round up at seek already.

This would also mean that the offsets returned to userspace get
aligned to 4096 bytes,
and generic/286 would just work as is. Another filesystem not aligning
to 4096 bytes may hit
the underflow, but it won't be gocryptfs :)

Thanks, Jakob

[1]:
gocryptfs seek(        0, SEEK_DATA) -> translate -> ext4 seek(
0, SEEK_DATA) =         0 -> translate -> return         0
gocryptfs seek(        0, SEEK_HOLE) -> translate -> ext4 seek(
0, SEEK_HOLE) =   1060864 -> translate -> return   1052622
gocryptfs seek(  1052622, SEEK_DATA) -> translate -> ext4 seek(
1060864, SEEK_DATA) =   5283840 -> translate -> return   5242862
gocryptfs seek(  5242862, SEEK_HOLE) -> translate -> ext4 seek(
5283840, SEEK_HOLE) =   6344704 -> translate -> return   6295502
gocryptfs seek(  6295502, SEEK_DATA) -> translate -> ext4 seek(
6344704, SEEK_DATA) =  10567680 -> translate -> return  10485742
gocryptfs seek( 10485742, SEEK_HOLE) -> translate -> ext4 seek(
10567680, SEEK_HOLE) =  11628544 -> translate -> return  11538382
gocryptfs seek( 11538382, SEEK_DATA) -> translate -> ext4 seek(
11628544, SEEK_DATA) =  15851520 -> translate -> return  15728622
gocryptfs seek( 15728622, SEEK_HOLE) -> translate -> ext4 seek(
15851520, SEEK_HOLE) =  16912384 -> translate -> return  16781262
gocryptfs seek( 16781262, SEEK_DATA) -> translate -> ext4 seek(
16912384, SEEK_DATA) =  21135360 -> translate -> return  20971502
gocryptfs seek( 20971502, SEEK_HOLE) -> translate -> ext4 seek(
21135360, SEEK_HOLE) =  22196224 -> translate -> return  22024142
gocryptfs seek( 22024142, SEEK_DATA) -> translate -> ext4 seek(
22196224, SEEK_DATA) =  26419200 -> translate -> return  26214382
gocryptfs seek( 26214382, SEEK_HOLE) -> translate -> ext4 seek(
26419200, SEEK_HOLE) =  27480064 -> translate -> return  27267022
gocryptfs seek( 27267022, SEEK_DATA) -> translate -> ext4 seek(
27480064, SEEK_DATA) =  31703040 -> translate -> return  31457262
gocryptfs seek( 31457262, SEEK_HOLE) -> translate -> ext4 seek(
31703040, SEEK_HOLE) =  32763904 -> translate -> return  32509902
gocryptfs seek( 32509902, SEEK_DATA) -> translate -> ext4 seek(
32763904, SEEK_DATA) =  36986880 -> translate -> return  36700142
gocryptfs seek( 36700142, SEEK_HOLE) -> translate -> ext4 seek(
36986880, SEEK_HOLE) =  38047744 -> translate -> return  37752782
gocryptfs seek( 37752782, SEEK_DATA) -> translate -> ext4 seek(
38047744, SEEK_DATA) =  42270720 -> translate -> return  41943022
gocryptfs seek( 41943022, SEEK_HOLE) -> translate -> ext4 seek(
42270720, SEEK_HOLE) =  43331584 -> translate -> return  42995662
gocryptfs seek( 42995662, SEEK_DATA) -> translate -> ext4 seek(
43331584, SEEK_DATA) =  47554560 -> translate -> return  47185902
gocryptfs seek( 47185902, SEEK_HOLE) -> translate -> ext4 seek(
47554560, SEEK_HOLE) =  48615424 -> translate -> return  48238542
gocryptfs seek( 48238542, SEEK_DATA) -> translate -> ext4 seek(
48615424, SEEK_DATA) =  52838400 -> translate -> return  52428782
gocryptfs seek( 52428782, SEEK_HOLE) -> translate -> ext4 seek(
52838400, SEEK_HOLE) =  53899264 -> translate -> return  53481422
gocryptfs seek( 53481422, SEEK_DATA) -> translate -> ext4 seek(
53899264, SEEK_DATA) =  58122240 -> translate -> return  57671662
gocryptfs seek( 57671662, SEEK_HOLE) -> translate -> ext4 seek(
58122240, SEEK_HOLE) =  59183104 -> translate -> return  58724302
gocryptfs seek( 58724302, SEEK_DATA) -> translate -> ext4 seek(
59183104, SEEK_DATA) =  63406080 -> translate -> return  62914542
gocryptfs seek( 62914542, SEEK_HOLE) -> translate -> ext4 seek(
63406080, SEEK_HOLE) =  64466944 -> translate -> return  63967182
gocryptfs seek( 63967182, SEEK_DATA) -> translate -> ext4 seek(
64466944, SEEK_DATA) =  68689920 -> translate -> return  68157422
gocryptfs seek( 68157422, SEEK_HOLE) -> translate -> ext4 seek(
68689920, SEEK_HOLE) =  69750784 -> translate -> return  69210062
gocryptfs seek( 69210062, SEEK_DATA) -> translate -> ext4 seek(
69750784, SEEK_DATA) =  73973760 -> translate -> return  73400302
gocryptfs seek( 73400302, SEEK_HOLE) -> translate -> ext4 seek(
73973760, SEEK_HOLE) =  75034624 -> translate -> return  74452942
gocryptfs seek( 74452942, SEEK_DATA) -> translate -> ext4 seek(
75034624, SEEK_DATA) =  79257600 -> translate -> return  78643182
gocryptfs seek( 78643182, SEEK_HOLE) -> translate -> ext4 seek(
79257600, SEEK_HOLE) =  80318464 -> translate -> return  79695822
gocryptfs seek( 79695822, SEEK_DATA) -> translate -> ext4 seek(
80318464, SEEK_DATA) =  84541440 -> translate -> return  83886062
gocryptfs seek( 83886062, SEEK_HOLE) -> translate -> ext4 seek(
84541440, SEEK_HOLE) =  85602304 -> translate -> return  84938702
gocryptfs seek( 84938702, SEEK_DATA) -> translate -> ext4 seek(
85602304, SEEK_DATA) =  89825280 -> translate -> return  89128942
gocryptfs seek( 89128942, SEEK_HOLE) -> translate -> ext4 seek(
89825280, SEEK_HOLE) =  90886144 -> translate -> return  90181582
gocryptfs seek( 90181582, SEEK_DATA) -> translate -> ext4 seek(
90886144, SEEK_DATA) =  95109120 -> translate -> return  94371822
gocryptfs seek( 94371822, SEEK_HOLE) -> translate -> ext4 seek(
95109120, SEEK_HOLE) =  96169984 -> translate -> return  95424462
gocryptfs seek( 95424462, SEEK_DATA) -> translate -> ext4 seek(
96169984, SEEK_DATA) = 100392960 -> translate -> return  99614702
gocryptfs seek( 99614702, SEEK_HOLE) -> translate -> ext4
seek(100392960, SEEK_HOLE) = 101453824 -> translate -> return
100667342
gocryptfs seek(100667342, SEEK_DATA) -> translate -> ext4
seek(101453824, SEEK_DATA) = 105676800 -> translate -> return
104857582
gocryptfs seek(104857582, SEEK_HOLE) -> translate -> ext4
seek(105676800, SEEK_HOLE) = 106733586 -> translate -> return
105906176

[2]: https://github.com/rfjakob/gocryptfs/blob/master/Documentation/file-format.md
