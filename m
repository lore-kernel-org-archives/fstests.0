Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73B1C433F5
	for <linux-fstests@archiver.kernel.org>; Sat,  7 May 2022 08:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344519AbiEGI4I (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 7 May 2022 04:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiEGI4E (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 7 May 2022 04:56:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41CB94199F
        for <fstests@vger.kernel.org>; Sat,  7 May 2022 01:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651913538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ciSZ83kEJsDE3Sa5MWACbwccq8QNxUBeEt2oeFsfks=;
        b=TsuL37sFmSB/FaYw2HCPmnNu1/Ucjzqi5rd+stjfslEYlMcCCD1uq79UDayq5GdImf7mJh
        PHhFBmkcnIumNtaULzWdQnXT12jiNlW3P1qcbsCtIVcFCt3spBKycLq46yrnoipJCtibjs
        uB/YHneb55G/o5kNicTp1EostNqJFyU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-376-2xmwToILOjyjb_g8neWkDA-1; Sat, 07 May 2022 04:52:17 -0400
X-MC-Unique: 2xmwToILOjyjb_g8neWkDA-1
Received: by mail-qt1-f197.google.com with SMTP id f12-20020a05622a1a0c00b002f3b5acc2e7so7889905qtb.1
        for <fstests@vger.kernel.org>; Sat, 07 May 2022 01:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=0ciSZ83kEJsDE3Sa5MWACbwccq8QNxUBeEt2oeFsfks=;
        b=VbUEVja3jX47riX9/omnwJNb3guims8zBRgZEWhl3/Vt7ZvNaYf4K/qpHrYam4AWO4
         n8NFQDggSsvCg/zjFNQmEW7LDVHlo9SaM/CuKXqs1olZTk8AWlfjBFnnT4s83TRfglR2
         IG1Ra2GgB8jznXQTMU3RdTpQ5azieWp7XVZtz0D947wkdnDos5sCx0SXl2aQzvy2XchC
         zfgWfvjryUywR8lHvUCFvPIKbZ7epY/w1VSZ5hprWgcE5fPurInWA/4rOkJAMl2B/vVs
         NCk0fqmc5LRnIJvvr4qckdQQvn2Llr+kYK0ylDm4kkcUajAc+n9ds6RDXrqjyBmeTF8v
         IldQ==
X-Gm-Message-State: AOAM532kZ4NmmzsXk6DTxht5QkFufZ0JGBUS1ZqWHbOyzOpRAtYl0GQs
        HxWMsOYgQyzPOQ2MMUEG3pnjhMLMaK5UVOfqHpZG3h6sLb/k8cQGeR+kYo4iSPdGdWuPyo+A6+R
        0xcB8v7q5AgVohWzMLg==
X-Received: by 2002:ad4:5f05:0:b0:45a:b123:c790 with SMTP id fo5-20020ad45f05000000b0045ab123c790mr5717724qvb.105.1651913536594;
        Sat, 07 May 2022 01:52:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIBzHQ9MAQUy0qbjalqPMAKavi34yRXzOZQ7RrVrBdVX+bNk5poqDGDCGKjpoueT6Mn6ly6Q==
X-Received: by 2002:ad4:5f05:0:b0:45a:b123:c790 with SMTP id fo5-20020ad45f05000000b0045ab123c790mr5717712qvb.105.1651913536379;
        Sat, 07 May 2022 01:52:16 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p184-20020a378dc1000000b0069fc13ce1e1sm3747116qkd.18.2022.05.07.01.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 01:52:15 -0700 (PDT)
Date:   Sat, 7 May 2022 16:52:09 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Cc:     "david@fromorbit.com" <david@fromorbit.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] idmapped-mounts: Reset errno to zero after detect
 fs_allow_idmap
Message-ID: <20220507085209.ortk2ybj3t2nemkc@zlang-mailbox>
Mail-Followup-To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
References: <1649763226-2329-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <6275DAB9.5030700@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6275DAB9.5030700@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, May 07, 2022 at 01:33:33AM +0000, xuyang2018.jy@fujitsu.com wrote:
> Hi Zorro
> 
> Since  Christian doesn't send  a new patchset(for rename idmap-mount)
> based on lastest xfstests, should I send a v4 patch for the following
> patches today?
> "idmapped-mounts: Reset errno to zero after detect fs_allow_idmap"
> " idmapped-mounts: Add mknodat operation in setgid test"
> "idmapped-mounts: Add open with O_TMPFILE operation in setgid test"
> 
> So you can merge these three patches if you plan to announce a new
> xfstests version in this weekend.
> 
> What do you think about it?

Sure, you can send V4 of patch 1/5 ～ 3/5 (base on latest for-next branch
please), as they have been reviewed and tested. Christian's patch (about
refactor idmapped testing) might need more review, he just sent it out to
get some review points I think (cc Christian).

If you'd like to catch up the release of this weekend, please send your
v4 patch ASAP. Due to I need time to do regression test before pushing.
It'll wait for next week if too late.

Thanks,
Zorro

> 
> Best Regards
> Yang Xu
> > If we run case on old kernel that doesn't support mount_setattr and
> > then fail on our own function before call is_setgid/is_setuid function
> > to reset errno, run_test will print "Function not implement" error.
> > 
> > Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
> > ---
> >   src/idmapped-mounts/idmapped-mounts.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
> > index 4cf6c3bb..8e6405c5 100644
> > --- a/src/idmapped-mounts/idmapped-mounts.c
> > +++ b/src/idmapped-mounts/idmapped-mounts.c
> > @@ -14070,6 +14070,8 @@ int main(int argc, char *argv[])
> >   		die("failed to open %s", t_mountpoint_scratch);
> > 
> >   	t_fs_allow_idmap = fs_allow_idmap();
> > +	/* don't copy ENOSYS errno to child process on older kernel */
> > +	errno = 0;
> >   	if (supported) {
> >   		/*
> >   		 * Caller just wants to know whether the filesystem we're on

