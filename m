Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36593C4332F
	for <linux-fstests@archiver.kernel.org>; Tue, 19 Apr 2022 18:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348006AbiDSS3J (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 19 Apr 2022 14:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357452AbiDSS2I (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 19 Apr 2022 14:28:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 213673CFE2
        for <fstests@vger.kernel.org>; Tue, 19 Apr 2022 11:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650392462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a28r6CXk1dF6ggHv70CyU0aAfAAfP8gcMLnxiGOL6to=;
        b=ZsQDF2FBz4tvmSlQ9ICrZ/y08zQiOUQ11x2AoKFSaK2mefW5Vs2bunrk8LzagFjQuSjP6f
        JLXGuUg08uBcMlWmzD3PzZILVr2hYowA/OjDg1IX2bGyFx0Czk2ufw/z7Da4j6YgikXOe5
        4ss2WEDB7RqIw8342v3sGBnA7tPVpcA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-408-5CIgkfcYMnmsUQnN1QCf3Q-1; Tue, 19 Apr 2022 14:21:00 -0400
X-MC-Unique: 5CIgkfcYMnmsUQnN1QCf3Q-1
Received: by mail-lj1-f197.google.com with SMTP id c12-20020a2ebf0c000000b0024af8f2794bso4041686ljr.12
        for <fstests@vger.kernel.org>; Tue, 19 Apr 2022 11:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a28r6CXk1dF6ggHv70CyU0aAfAAfP8gcMLnxiGOL6to=;
        b=g8dxQV/YVYokqVP4MgeMS0wVVjcQlYxFL2qouRCs3Il6eght9mTPruJEbShe+5dSuD
         l8pT+YAeM9QLYHSNTPWdBBKXozkg1WhTGKV4iTlLt9XgoQbFIf0g1fCjFYSCMwj/l5W8
         yGZ81Dr3mEfQ1K7wkse1iM3FQWgH2c0XSse+GhAXoygj1FqmWZHF5gLJF9jk1FK3XXM6
         BmoJ3RNY+TQ6ZRBd14KalZU1TwVwa+moskhw0xbdwsndH+TB4061UW6fcALRiz0pSBKt
         ODjs+IC9e4MkhKrJ/4lRZBPE/VZzkjHboD8HBRa5NygeYq6KtgU2PHjyeSlr2FI3qHmP
         COBw==
X-Gm-Message-State: AOAM530k0OiIA0D5F5NxGGIYfFD967+XoraXahljGvAOkYxB/HOOQOeb
        9Kbq6yOTxqN1K/H2pZQDA18WBXIyxGCPplfRLz/2iN1O50/KQgHYevZid2KSsa1aBt9gSHs2Fv4
        hyryDWhrUYB0VlXTQ1IrDD81yu91uVdyiSA==
X-Received: by 2002:a05:651c:54c:b0:249:9d06:24ef with SMTP id q12-20020a05651c054c00b002499d0624efmr10684081ljp.331.1650392458923;
        Tue, 19 Apr 2022 11:20:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyepgr11rBbrAnNCFfiav2AiL9sLRYgvwhJCRiKKFCYanoZLuPWbZqzA8dMPDP2LrlvF1ubbnBRbmyoWXz0m48=
X-Received: by 2002:a05:651c:54c:b0:249:9d06:24ef with SMTP id
 q12-20020a05651c054c00b002499d0624efmr10684056ljp.331.1650392458396; Tue, 19
 Apr 2022 11:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220419175811.602126-1-ridave@redhat.com> <b80030d5be5158115dd71cb953701e86d9fc5621.camel@redhat.com>
In-Reply-To: <b80030d5be5158115dd71cb953701e86d9fc5621.camel@redhat.com>
From:   Rishabh Dave <ridave@redhat.com>
Date:   Tue, 19 Apr 2022 23:50:47 +0530
Message-ID: <CA+jMu4RUhWa7CSeeXeymy-k9B00XmgLsgyH85Trv-wqjc+1aSQ@mail.gmail.com>
Subject: Re: [PATCH] cephfs: add ceph-fuse suport for ceph-fuse
To:     Jeff Layton <jlayton@redhat.com>
Cc:     fstests@vger.kernel.org, Rishabh Dave <rishabhddave@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Jeff,

Thanks for the review!

On Tue, 19 Apr 2022 at 23:34, Jeff Layton <jlayton@redhat.com> wrote:
>
> > -     # find $dev as the source, and print result in "$dev $mnt" format
> > -     local mount_rec=`findmnt -rncv -S $dev -o SOURCE,TARGET`
> > -     [ -n "$mount_rec" ] || return 1 # 1 = not mounted
> > +     # this check doesn't work on ceph-fuse
> > +     if [ "$dev" != "ceph-fuse" ]; then
> > +             _check_if_dev_already_mounted $dev $mnt
> > +             dev_already_mounted=$?
> >
>
> Shouldn't there be a "fi" above?
>
> > -     # if it's mounted, make sure its on $mnt
> > -     if [ "$mount_rec" != "$dev $mnt" ]; then
> > -             echo "$devname=$dev is mounted but not on $mntname=$mnt - aborting"
> > -             echo "Already mounted result:"
> > -             echo $mount_rec
> > -             return 2 # 2 = mounted on wrong mnt
> > +             if [ $dev_already_mounted -ne 0 ]; then
> > +                     return $dev_already_mounted
> > +             fi
> >       fi
>

Here's the "fi" for the "if" you referred to above.

