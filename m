Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BB4ECAAD3
	for <linux-fstests@archiver.kernel.org>; Wed,  7 Sep 2022 04:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiIGEtu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 7 Sep 2022 00:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiIGEtu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 7 Sep 2022 00:49:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453D9193F3
        for <fstests@vger.kernel.org>; Tue,  6 Sep 2022 21:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662526186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/NUzpzzzpmrEaWSu6velNEpl4C2tkcMQR67exgjA4bY=;
        b=EdbyIXmV3klEPEVX4cI7rTdlKsm046GerpAEuBAfwCKbjNnzTFf5qIX0LoCCi2cIWToPId
        3Rqx5mEOYxDo5xOnJJw1K+CnHNwuJQnmVvEd4cAGZ4AxGCZvkLnVKYBO4nfxH5ScpY1K+F
        GRpOaL+nrcqzupxe8bo37y3vsFHArwY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-146-ZRElPUXgMW6SFFjw8D-3yA-1; Wed, 07 Sep 2022 00:49:44 -0400
X-MC-Unique: ZRElPUXgMW6SFFjw8D-3yA-1
Received: by mail-qv1-f71.google.com with SMTP id g4-20020ad45424000000b004a9bb302c85so4198128qvt.22
        for <fstests@vger.kernel.org>; Tue, 06 Sep 2022 21:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=/NUzpzzzpmrEaWSu6velNEpl4C2tkcMQR67exgjA4bY=;
        b=O5yyMwNx0qD7EtTcrL3EAkKwRa4A+r3RimQE/hpvtHtxUSOxEbGBaWdpNCk8yRAaPj
         aBTwKuKA1pj2R7HjL2n1ISxZ7VYFUhDj2xX0ghxMUUwLaZmMILc55ItyJIqNvK+SvakI
         0ARbREZ8zZxemqWZcKUonDyqdE7EcPqlGMELe6Nn7yM/6rVbh//Km5/NxyzWBzw+R08f
         rBmJmzOhPPtr9BSVGLZ6S3TJWSn48Nbhjds5xamyyuqjRlNc31dRxkIar0cxEhdKvvKI
         DCNxT2PnkPAPIRDPG50EaDn0tJjQHfQKTdZRsLIeAfRIbGkv6il5d+TZujt249ZFzaux
         Lf7A==
X-Gm-Message-State: ACgBeo3dYk4pI0Y6lrK9/VI3SETU9k/q6ZeQ0nuBmb6+tD6np66cOhXG
        prRsjUAGacaFqbQACYw7P4R0S818C3+RCvjwRc3jyD30A0KUm5fvWKHCcOLQjbd0y7IaZXdXu4B
        pF/onrgLJq5nK9kC6sg==
X-Received: by 2002:ac8:5ac5:0:b0:343:6d5a:43d9 with SMTP id d5-20020ac85ac5000000b003436d5a43d9mr1763025qtd.10.1662526184279;
        Tue, 06 Sep 2022 21:49:44 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6uHZjbnbcn+xS/zmXSpMhYn2eDYL4BDwQhobVeAZrQf9VdPIg+anmbkW71YjiUPhacccgE7g==
X-Received: by 2002:ac8:5ac5:0:b0:343:6d5a:43d9 with SMTP id d5-20020ac85ac5000000b003436d5a43d9mr1763018qtd.10.1662526184044;
        Tue, 06 Sep 2022 21:49:44 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id br13-20020a05620a460d00b006b9bf03d9c6sm13228427qkb.104.2022.09.06.21.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 21:49:43 -0700 (PDT)
Date:   Wed, 7 Sep 2022 12:49:39 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic: test i_blocks for truncated large files
Message-ID: <20220907044939.lnjeqtllmc4hjs4r@zlang-mailbox>
References: <20220906155320.952636-1-preichl@redhat.com>
 <20220907010559.uees5jhn33wfk3zn@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907010559.uees5jhn33wfk3zn@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Sep 07, 2022 at 09:05:59AM +0800, Zorro Lang wrote:
> On Tue, Sep 06, 2022 at 05:53:20PM +0200, Pavel Reichl wrote:
> > This is a regression test for an incorrect computation of i_blocks for
> > truncated files larger than 4 GiB. Bug was filed for exFAT.
> > 
> > Test is based on reproducer provied by Christophe Vu-Brugier as part
> > of kernel patch-fix submission.
> > 
> > Signed-off-by: Pavel Reichl <preichl@redhat.com>
> > ---
> 
> Hi Pavel,
> 
> Your patch has been merged as generic/694,

Oh, ignore this line ^^ :)

> 
> >  tests/generic/698     | 47 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/698.out |  2 ++
> >  2 files changed, 49 insertions(+)
> >  create mode 100755 tests/generic/698
> >  create mode 100644 tests/generic/698.out
> > 
> > diff --git a/tests/generic/698 b/tests/generic/698
> > new file mode 100755
> > index 00000000..217641e6
> > --- /dev/null
> > +++ b/tests/generic/698
> > @@ -0,0 +1,47 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2022  Red Hat Inc. All Rights Reserved.
> > +#
> > +# FS QA Test 698
> > +#
> > +# Verify that i_blocks for truncated files larger than 4 GiB have correct
> > +# values.
> > +#
> > +# This test verifies the problem fixed in kernel with commit
> > +# 92fba084b79e exfat: fix i_blocks for files truncated over 4 GiB
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto
> > +
> > +# Override the default cleanup function.
> > +_cleanup()
> > +{
> > +	cd /
> > +	rm -r -f $tmp.* $junk_dir
> > +}
> > +
> > +_supported_fs generic
> > +_require_test
> > +_require_fs_space $TEST_DIR $((5 * 1024 * 1024)) #kB
> 
> _fixed_by_kernel_commit 92fba084b79e \
> 	exfat: fix i_blocks for files truncated over 4 GiB
> 
> > +
> > +echo "Silence is golden"
> > +
> > +junk_dir=$TEST_DIR/$seq
> > +junk_file=$junk_dir/junk
> > +mkdir -p $junk_dir
> > +
> > +$XFS_IO_PROG -f -c "pwrite -W 0 5G" $junk_file > /dev/null
> > +
> > +
> 
> Useless empty lines
> 
> > +truncate -s $((4 * 1024 * 1024 * 1024)) $junk_file
> > +
> > +iblocks_after_truncate=`stat -c '%b' $junk_file`
> > +iblocks_expected=$((4 * 1024 * 1024 * 2))
> 
> I think you suspect that the `stat -c %B xxx` always be 512. I don't know if
> it's always 512 on Linux, or better to check %B size at first.
> 
> Thanks,
> Zorro
> 
> > +
> > +if [ "$iblocks_expected" != "$iblocks_after_truncate" ]; then
> > +	echo "Number of blocks needs to be same: $iblocks_expected, $iblocks_after_truncate"
> > +fi
> > +
> > +status=0
> > +
> > +exit
> > diff --git a/tests/generic/698.out b/tests/generic/698.out
> > new file mode 100644
> > index 00000000..222db0de
> > --- /dev/null
> > +++ b/tests/generic/698.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 698
> > +Silence is golden
> > -- 
> > 2.37.3
> > 

