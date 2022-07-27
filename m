Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C4FC19F2B
	for <linux-fstests@archiver.kernel.org>; Wed, 27 Jul 2022 18:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbiG0SXB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 27 Jul 2022 14:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbiG0SWl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Jul 2022 14:22:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1128F3E2A
        for <fstests@vger.kernel.org>; Wed, 27 Jul 2022 10:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658942507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UGUGZhW4k8nRJSg75dcQueiLpxgVMIuD/ExUJNKKcwI=;
        b=A7eoLwVu+Y6x6GiTmxthYylH5SiHJBh5Icd93saVY+vm/xCS7SA8/41dQ1Y+ncFvWpX+dm
        AzgYTrx9IgvLqyyac2p1Jy9SYcd0bwj1hfE/YjOp0j8WwK7f2lybxeycd/TuWVdF8tMBS3
        BzIdMtxnLt7+N4jHHaUr498kxeGOwfU=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-542-vHXYq8z7MBC-vkIFKEHP2A-1; Wed, 27 Jul 2022 13:21:44 -0400
X-MC-Unique: vHXYq8z7MBC-vkIFKEHP2A-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-10d6ce04410so9493148fac.23
        for <fstests@vger.kernel.org>; Wed, 27 Jul 2022 10:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UGUGZhW4k8nRJSg75dcQueiLpxgVMIuD/ExUJNKKcwI=;
        b=KCa+cGy92knt5N+C4o8H45q/e9wHQ2lliuXVBqd/U1S7grUduKtf8zXtTA76eqN+bs
         IkRA3NnSYQN8tjKsoBfejraP1nec3m/O+MHTpF7d+iUo2oQkwy51sbhf2EugTwPTM1Em
         Ce0u9AWJoJf+OgboiwUGTIA7eR3hcaqS7Ev/Jw5QP1KmWecZGfKbWCHY6p47PXDiNmms
         ilEyXZY42ty8AS1jh/Mx+KSs+aJlKIxWuA9hWmbuCKQqGaA7pdP89nhysiVjSCE9ZBQd
         +HbhmwDvG9dTU1PiMyulTLsHGFC61zMX/UxvWmv6QTQ/iB4RTOV4le3i9DSY3ZlVOrMq
         JRhw==
X-Gm-Message-State: AJIora8Ee5M3FTAcbLGKl4DlZ3rMtcs5vbRGcrtX75/A8Alm5WCzidaC
        izGqnWNrsR7DWYRD5L9PXyTnwq2m3Sqo0neuhuzDQsFpsH4yjrXXgKOqjBaOlxhV2QsHUMMcpFe
        cE6KGzj5E/TpFQt95qg==
X-Received: by 2002:a05:6808:170b:b0:333:53cf:8022 with SMTP id bc11-20020a056808170b00b0033353cf8022mr2464780oib.28.1658942503676;
        Wed, 27 Jul 2022 10:21:43 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1snR5Bo9C94vgrTDzr1mvGHFkQscYsBxW2LRZi9Nlyyta8pmBqh29KxO/ZLRN3enMzNl3vagg==
X-Received: by 2002:a05:6808:170b:b0:333:53cf:8022 with SMTP id bc11-20020a056808170b00b0033353cf8022mr2464774oib.28.1658942503320;
        Wed, 27 Jul 2022 10:21:43 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f2-20020a4ae602000000b004288e69cac2sm7519361oot.23.2022.07.27.10.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 10:21:42 -0700 (PDT)
Date:   Thu, 28 Jul 2022 01:21:37 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/432: fix this test when external devices are in use
Message-ID: <20220727172137.7vsspxca764ma5xj@zlang-mailbox>
References: <YuBFw4dheeSRHVQd@magnolia>
 <20220727122142.ktp5loclqazchncw@zlang-mailbox>
 <YuFS6/9iMXzjv/YX@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuFS6/9iMXzjv/YX@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 27, 2022 at 07:59:55AM -0700, Darrick J. Wong wrote:
> On Wed, Jul 27, 2022 at 08:21:42PM +0800, Zorro Lang wrote:
> > On Tue, Jul 26, 2022 at 12:51:31PM -0700, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > This program exercises metadump and mdrestore being run against the
> > > scratch device.  Therefore, the test must pass external log / rt device
> > > arguments to xfs_repair -n to check the "restored" filesystem.  Fix the
> > > incorrect usage, and report repair failures, since this test has been
> > > silently failing for a while now.
> > > 
> > > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > > ---
> > >  tests/xfs/432 |   11 ++++++++++-
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tests/xfs/432 b/tests/xfs/432
> > > index 86012f0b..5c6744ce 100755
> > > --- a/tests/xfs/432
> > > +++ b/tests/xfs/432
> > > @@ -89,7 +89,16 @@ _scratch_xfs_metadump $metadump_file -w
> > >  xfs_mdrestore $metadump_file $metadump_img
> > >  
> > >  echo "Check restored metadump image"
> > > -$XFS_REPAIR_PROG -n $metadump_img >> $seqres.full 2>&1
> > > +repair_args=('-n')
> > > +[ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ] && \
> > > +	repair_args+=('-l' "$SCRATCH_LOGDEV")
> > > +
> > > +[ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_RTDEV" ] && \
> > > +	repair_args+=('-r' "$SCRATCH_RTDEV")
> > > +
> > > +$XFS_REPAIR_PROG "${repair_args[@]}" $metadump_img >> $seqres.full 2>&1
> > > +res=$?
> > > +test $res -ne 0 && echo "xfs_repair on restored fs returned $res?"
> > 
> > Make sense to me, I don't have better idea. One question, is xfs_metadump
> > and xfs_mdrestore support rtdev? Due to I didn't find xfs_metadump have
> > a "-r" option, although it has "-l logdev" :)
> 
> Oops, no it doesn't, so I'll remove that.

Hmm... it doesn't for now or won't for future?

So all test cases about xfs_metadump can't run with SCRATCH_RTDEV? Do we need
something likes _require_nortdev?

> 
> > About the "$res", I don't know why we need this extra variable, as it's
> > not used in other place.
> 
> If you don't pass the correct arguments to xfs_repair or the metadump
> trashes the fs, it'll exit with a nonzero code.  All the output goes to
> $seqres.full, which means the test runner has no idea anything went
> wrong and marks the test passed even though repair failed.

Oh, I mean why not use the "$?" directly? Or :
$XFS_REPAIR_PROG "${repair_args[@]}" $metadump_img >> $seqres.full 2>&1 || \
	echo "xfs_repair on restored fs returned $res?"

Looks like we don't need to save this return status and use it on other place.
The "$res" looks redundant, although it's not wrong :)

Thanks,
Zorro

> 
> --D
> 
> > Thanks,
> > Zorro
> > 
> > >  
> > >  # success, all done
> > >  status=0
> > > 
> > 
> 

