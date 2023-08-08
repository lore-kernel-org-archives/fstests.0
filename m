Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DEDC04FE0
	for <linux-fstests@archiver.kernel.org>; Tue,  8 Aug 2023 18:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbjHHSR1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 8 Aug 2023 14:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbjHHSQt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 8 Aug 2023 14:16:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508B87A0F3
        for <fstests@vger.kernel.org>; Tue,  8 Aug 2023 10:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691515356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EHTAm8tgK23T9lwlx7F15uMf05zmd6L8FbmonQcZyes=;
        b=YPaJhEUo60v8kUW/BtTycWiKA9HPFrNvIcxL6Z+43rEsnGWzDBplGEQg+bGkWmTl9MdUZk
        zYkYYNh3t2f3EEjTVE/Nbsn7j3EjoJdl1KHnSh+XA5Zo48nVfZTTJdG95wHwP5AuA8QaGi
        W6fwpSrfSDnAskdLgggtajmz/YWrMv4=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-YzafrZxnNii2XQa0pmKifA-1; Tue, 08 Aug 2023 05:15:01 -0400
X-MC-Unique: YzafrZxnNii2XQa0pmKifA-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1bbbf96ebe1so44614975ad.1
        for <fstests@vger.kernel.org>; Tue, 08 Aug 2023 02:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691486099; x=1692090899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHTAm8tgK23T9lwlx7F15uMf05zmd6L8FbmonQcZyes=;
        b=Nv5MVp3voaThsPxPY5PqDzcZ7DKmtNoPEdzLBzZLhJ0EwiGw0Tr5g9Gqa6NGo/Nw6t
         /ijg5abbanrtvOJ+7n0PDBukZuJ/8AFY5SQ5ciV0tGpxBjAymWD/l0tMSb+MklM1GjBS
         rRUDq+3ZqCxVtTK0h3VZx41Uk5dMbtH1QeHz2njn/PEBIj/Cii4e7Qz4p61PeHzMjrh2
         PY45SuHYe2dVYr+0B3eYkrCu/a3OrwrqMZxSjpAJXCFek/FAhZ00dx7LepDI3eatDlst
         /jUYWdCILBx6XyGYPRc/blWabmBeaQMOkQQyHIwhoaRokOKgmKqHS76gYlsAvaE+y7qr
         4Qog==
X-Gm-Message-State: AOJu0YyPdjMkuBlAAUZiVkGvVQ1EN2pF7yuU+GfWzGJoCKieF4wazHwj
        F3wEw6bL9Znb4oHzvRLrYxOYYzLXLkjfMV1UuJ8TKoR4pL6X+iJfmaogkBROQ+ISwcFAVln/8iC
        qECOotJ09W/7giVuY4jOLl0RKvD1daCw=
X-Received: by 2002:a17:902:f547:b0:1bc:4df5:8bfe with SMTP id h7-20020a170902f54700b001bc4df58bfemr10200245plf.20.1691486099068;
        Tue, 08 Aug 2023 02:14:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXxgLzgsbLhdis1yB1Trk8yO0aTqi7mrda/ZRDWXXZBlF/GWELIc0wDecY/HykAl3iK4p4rg==
X-Received: by 2002:a17:902:f547:b0:1bc:4df5:8bfe with SMTP id h7-20020a170902f54700b001bc4df58bfemr10200230plf.20.1691486098717;
        Tue, 08 Aug 2023 02:14:58 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id w21-20020a170902a71500b001b558c37f91sm8431882plq.288.2023.08.08.02.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 02:14:58 -0700 (PDT)
Date:   Tue, 8 Aug 2023 17:14:54 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     David Disseldorp <ddiss@suse.de>
Cc:     fstests@vger.kernel.org, linkinjeon@kernel.org,
        sj1557.seo@samsung.com, "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] common/rc: drop '-f' parameter from fsck.exfat
Message-ID: <20230808091454.4skdyjnaxjqa7zyi@zlang-mailbox>
References: <20230807112850.9198-1-ddiss@suse.de>
 <20230807174835.moxyuvx4mp47pvky@zlang-mailbox>
 <20230808003449.760508f1@echidna.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808003449.760508f1@echidna.fritz.box>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Aug 08, 2023 at 12:34:49AM +0200, David Disseldorp wrote:
> Thanks for the feedback, Zorro...
> 
> On Tue, 8 Aug 2023 01:48:35 +0800, Zorro Lang wrote:
> 
> > On Mon, Aug 07, 2023 at 01:28:50PM +0200, David Disseldorp wrote:
> > > fsck.exfat doesn't support the '-f' flag, so add a special case to
> > > _repair_test_fs().  
> > 
> > I'm wondering why _repair_scratch_fs() doesn't have the '-f', but the
> > _repair_test_fs() has it. Looks like the '-f' option was for extN fs
> > originally, it's not a fsck common option, but in fsck.ext4.
> > 
> > So I think the '-f' might not be a necessary option. As _repair_scratch_fs
> > works without it, can we just remove the '-f' from _repair_test_fs()?
> 
> The fsck.ext4 usage states:
>  -f    Force checking even if filesystem is marked clean
> 
> As _repair_test_fs() is only called on _check_test_fs() failure, I
> suppose '-f' removal should be fine. Still, to avoid any behavioural
> changes I could also just add an explicit ext case with '-f'.
> 
> There's also a question of what btrfs should do here, as calling the
> "fsck.btrfs" no-op script following btrfs check failure likely
> doesn't make much sense.

Hmm, I think you're right. I just checked the commit log, the code (check
calls _repair_test_fs if TEST_DEV is corrupted) is added by this commit:

commit c7d81cdecbefd5768163a195e8d5257279216a34
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Fri Apr 21 10:51:31 2023 -0700

    check: try to fix the test device if it gets corrupted

That commit cares about xfs and extN more, didn't think about other fs
likes btrfs. If btrfs would like to call btrfs-check, not fsck.btrfs,
we should do that.

And as the "-f" isn't a common option of fsck, so we'd better to not use
it in " *)" branch. If extN hope to use it, we'd better to have a "ext4)"
branch.

If btrfs would like to call btrfs-check in _repair_test_fs(), we need
to do the same thing in _repair_scratch_fs(). CC btrfs list to get more
review/suggestion about that.

Thanks,
Zorro

> 
> Cheers, David
> 

