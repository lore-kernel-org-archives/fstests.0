Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDD6C6FD1F
	for <linux-fstests@archiver.kernel.org>; Sat, 25 Mar 2023 04:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCYEhW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 25 Mar 2023 00:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjCYEhV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 25 Mar 2023 00:37:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D52BDFC
        for <fstests@vger.kernel.org>; Fri, 24 Mar 2023 21:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679718994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y5qPKGmeJLRq4H/sWaugxhIkihelx6JO1ZWIpbGqYDI=;
        b=BnqPGqPcI7+H7EEEPAaYPNWaEcpNhFA70tMmSKH0VNtaamLafOp0U/eOBZ+cBWoEUcEBq8
        zUeyBFq7TupgNOxV2S+DHKSRcYf2at+TWXd8/kDks+p58pAeK4xTN8CC5uJB4AIa8RNlec
        N39SBVQwuUXpM3LcHk/mSy8Wph6+g1c=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-2fd7THROPdeCE77OfQbAPQ-1; Sat, 25 Mar 2023 00:36:30 -0400
X-MC-Unique: 2fd7THROPdeCE77OfQbAPQ-1
Received: by mail-pf1-f198.google.com with SMTP id x68-20020a628647000000b0062624c52117so1905142pfd.14
        for <fstests@vger.kernel.org>; Fri, 24 Mar 2023 21:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679718989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5qPKGmeJLRq4H/sWaugxhIkihelx6JO1ZWIpbGqYDI=;
        b=3mEfLF93MP67AwFf6LZ5igqAdYOWVMjN60cHImBsOVIcyvk9M9Ti5hX/tHD1yhUM+/
         YUeBnUYT17Lu6DoxJX0vfpVlYQvDpe7UOhr6Jym8A7dVFsK5zqa1AfQ8eer9Z9ttPVZy
         APUl0bO0bwREPBKAxM77TUwtm9xZPRL2hiibxynMIUHThuTSjv3tAB4T52RZFtDp6tCM
         UXaqD/TJEk33vDYPJ/5lccEclKaFxi+VWa5joDkrAYfNRhuQcjmRxbMVwRS3Opm4EmBv
         6RaXbp9vj6EziQOKnSlg/+eh10BFEgPVm3ZJ0hePgqD2A+40myArIGd8TR9lV8AXthcu
         SMeQ==
X-Gm-Message-State: AO0yUKXhwEuoBdoWkv3yLXI+RBFOFokUvYDIfWBz6zNdmBGtAzyyqL/U
        c7Qms3FWz8sW7pME8tfopN7Rdkvx6XU2WipHCETS0DEvKiRY+ONX94KUo2equkt03kIBCPuYPdR
        PwM7dvx3qh7+X1oZ/6Q==
X-Received: by 2002:a05:6a20:4a13:b0:d8:afd4:4ac7 with SMTP id fr19-20020a056a204a1300b000d8afd44ac7mr4738796pzb.4.1679718989645;
        Fri, 24 Mar 2023 21:36:29 -0700 (PDT)
X-Google-Smtp-Source: AK7set/lE7nftz3cP9O6orQxf6eDARJPZQN/NwzQpZUv1HpXjtY5GIUa8oyHfI94j/Zhg7lojxtP4Q==
X-Received: by 2002:a05:6a20:4a13:b0:d8:afd4:4ac7 with SMTP id fr19-20020a056a204a1300b000d8afd44ac7mr4738781pzb.4.1679718989199;
        Fri, 24 Mar 2023 21:36:29 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h17-20020aa786d1000000b00627fafe49f9sm10410603pfo.106.2023.03.24.21.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 21:36:28 -0700 (PDT)
Date:   Sat, 25 Mar 2023 12:36:24 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Roman Mamedov <rm@romanrm.net>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] fstests: btrfs/012 don't follow symlinks for populating
 $SCRATCH_MNT
Message-ID: <20230325043624.6mtmz4tjkyfors7u@zlang-mailbox>
References: <8d1ac146d94eec8c77f08a6d04cd8d5248dc8dc8.1679688780.git.josef@toxicpanda.com>
 <20230325014628.0b18621b@nvm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230325014628.0b18621b@nvm>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Mar 25, 2023 at 01:46:28AM +0500, Roman Mamedov wrote:
> On Fri, 24 Mar 2023 16:13:19 -0400
> Josef Bacik <josef@toxicpanda.com> wrote:
> 
> > /lib/modules/$(uname -r)/ can have symlinks to the source tree where the
> > kernel was built from, which can have all sorts of stuff, which will
> > make the runtime for this test exceedingly long.  We're just trying to
> > copy some data into our tree to test with, we don't need the entire
> > devel tree of whatever we're doing, so use -P to not follow symlinks
> > when copying.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  tests/btrfs/012 | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tests/btrfs/012 b/tests/btrfs/012
> > index d9faf81c..1b6e8a6b 100755
> > --- a/tests/btrfs/012
> > +++ b/tests/btrfs/012
> > @@ -43,7 +43,7 @@ mount -t ext4 $SCRATCH_DEV $SCRATCH_MNT
> >  
> >  _require_fs_space $SCRATCH_MNT $(du -s /lib/modules/`uname -r` | ${AWK_PROG} '{print $1}')
> >  
> > -cp -aR /lib/modules/`uname -r`/ $SCRATCH_MNT
> > +cp -aPR /lib/modules/`uname -r`/ $SCRATCH_MNT
> 
> But did you face the described problem in actual operation?

Same question, due to from what I tested[1], current options "-aR" don't
follow the symbolic. Is there any different on your system, or your fs?
Can you show more details about the issue you hit?

Thanks,
Zorro

[1]
$ mkdir testdir
$ cd testdir
$ ln -s ../xfstests link-dir
$ ln -s ../img link-file
$ cd ..
$ cp -aR testdir/ copydir
$ ls -l copydir/
total 0
lrwxrwxrwx. 1 zorro zorro 11 Mar 25 12:29 link-dir -> ../xfstests
lrwxrwxrwx. 1 zorro zorro  6 Mar 25 12:29 link-file -> ../img




> 
> "man cp" says 
> 
>        -a, --archive
>               same as -dR --preserve=all
> ...
>        -d     same as --no-dereference --preserve=links
> ...
>        -P, --no-dereference
>               never follow symbolic links in SOURCE
> 
> So -a includes -d, which already includes -P that is now being added.
> 
> Moreover, even -R is redundant in the original line and could be removed.
> 
> -- 
> With respect,
> Roman
> 

