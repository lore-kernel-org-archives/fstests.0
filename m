Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DC5C433B4
	for <linux-fstests@archiver.kernel.org>; Thu,  6 May 2021 14:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 769AF61157
	for <linux-fstests@archiver.kernel.org>; Thu,  6 May 2021 14:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbhEFOql (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 6 May 2021 10:46:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52968 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234888AbhEFOqk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 6 May 2021 10:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620312342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jXu9bu121WPRtwXFS5O/+/gh8Ts+WxkI31oJKaqGVog=;
        b=MLqwZtXnlOJHCnC/qvUMpz09lR7hlvVEIEST0CpFrgjPQNDpIqFkm8swTD7aAP94Dj8UZY
        +eRJHMyHMQ98YLVIMteNOSw2C1u7mlFiCKkjz2rT6w3mPQ7dTtNZgISC/UUfHoYcSLxo44
        QUjRW6pg57BBdyuKBpjyj3YQlLpdn9A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-8C-3uVMlPPeVs3KEn3aJpw-1; Thu, 06 May 2021 10:45:40 -0400
X-MC-Unique: 8C-3uVMlPPeVs3KEn3aJpw-1
Received: by mail-wr1-f72.google.com with SMTP id x10-20020adfc18a0000b029010d83c83f2aso2297528wre.8
        for <fstests@vger.kernel.org>; Thu, 06 May 2021 07:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jXu9bu121WPRtwXFS5O/+/gh8Ts+WxkI31oJKaqGVog=;
        b=ZwQbvB4yVnTh28m3tHEXub2TpUKOSRmz7BU0KFsc10C5xu75140Y6/UafZ3R8c7uvd
         pj7fdZyn39YNpFeN6AWfItlMlW3Jo7sLDdhaAP56r2c/d1TVRfyfFyQe4dWeZzq4sqWz
         uYtv1eGt470ZjIHTpiVVyooUAtavfW0LpmgYaSIpTNB+bxypaSCIWGSdfTuP40kiEYEP
         zyK5YM1tIQfBArKn184SOpU5tXnWJ1iqNwbswRvBATjPFjue+JiSvWovdhPtYQbehJMZ
         O/CR4OtouaLA378cOx9jyRl0+uKrTQZ2JjQVbxBNkkyBkq1Hll3NVkC5qIhjKer+Nm+r
         +ybg==
X-Gm-Message-State: AOAM5304LX0lJ3QDuDbiUMjx6S5ZMOVpqlcO7JCGZtZcBVJu2jVfzt5w
        nE/MsM1BrFf6f5pvOP822pD88emxLS2c9FMIRti2HEAytZC8fs8R7r22OlzNNWZ/G3spyYxQsgB
        ZDZEPA5OKyigGpmW8a/6MpOKW2nSj2TzjhQ==
X-Received: by 2002:a5d:53c3:: with SMTP id a3mr5397975wrw.376.1620312339219;
        Thu, 06 May 2021 07:45:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxz1PUFDI0zrflRoJEKBAjJxn30dp9qgK2/gEGle0R+/Id5dtgvx0BRwncB67LNeoUzRoadMshVf52wfFOazEI=
X-Received: by 2002:a5d:53c3:: with SMTP id a3mr5397940wrw.376.1620312338946;
 Thu, 06 May 2021 07:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210506142658.1077906-1-agruenba@redhat.com>
In-Reply-To: <20210506142658.1077906-1-agruenba@redhat.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 6 May 2021 16:45:27 +0200
Message-ID: <CAHc6FU4Wkutsj8Ud-oDnt=4Qu_8Pc5swc0-jx4+N5VP+w9SaPw@mail.gmail.com>
Subject: Re: [PATCH v2] gfs2: Fix mmap + page fault deadlock
To:     fstests <fstests@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, May 6, 2021 at 4:27 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> Commit 20f829999c38 has moved the inode glock taking from gfs2_readpage and
> gfs2_readahead into gfs2_file_read_iter and gfs2_fault.

Oops, sorry for posting this to the wrong list.

Andreas

