Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF94EC433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 24 Jul 2022 15:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbiGXP1t (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 24 Jul 2022 11:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiGXP1s (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 24 Jul 2022 11:27:48 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D423812622
        for <fstests@vger.kernel.org>; Sun, 24 Jul 2022 08:27:47 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id a7so2718669vkl.0
        for <fstests@vger.kernel.org>; Sun, 24 Jul 2022 08:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vbv61s1vrjYjRBTMPfiEutBCjtxP51/Y2nBOUMrxFyc=;
        b=mEziVueCE/p5fq7pEvTMZvdKpk8QDqL10egd9QfjUuPEmcYFVbz1cuare8WoLISe3y
         pmB29S/LRXbnGtGZpI/9va9HmMDogKSQZ7Kji/gKso/qOdfuOZitULt9Enw2/AMqPlrP
         ZO0SNjE2lu+13pd97BBVajT4K9nGMeni9QppbznRbGzPvAI5hubId7noW6MY0QQSce+S
         BlpYSxkLIx74mFfsiRdselWybxNGBlF90Bjzg/E2HUoeUlVxldUG+dbhZ3JDLUpBxguH
         dM3Mx3oRoByQaEH5mDZ4faHa/WyI2Wx1ONxhmq36hvypUMydYgpZO2TskpJIe2N8jj5M
         Wyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vbv61s1vrjYjRBTMPfiEutBCjtxP51/Y2nBOUMrxFyc=;
        b=XM8OanGHTwd0w2qpYISFXY2bm1gLUj1QJXf/9h53xlkQAiuQ5zvakTi2U3mZo9KmyV
         CuVbQa4OdamOuN4ljqyuLwXGwU3LcYwNIba7Wwc3UxFslEf6j6+HaLIO2gdu7n4nDQHm
         WEAEPrM869IIiTsbYD0PVnVVQaeWrMSHR8N2QmH2ULW1mrA78txLtO+LWSjl5+YeigWF
         uS1BvRGDGNTiBHO4c5gY/rkKw+vDB6I1pOzN3VG8mjuP1tbtjInMe7OW5M6Y3gB7sQUy
         Vqeba6ySgRx8uGj8tkj5UHhAyRIXvJi3xgnekZd9EZwSBvkRIgATHkUA5bPrKpznwilZ
         erJQ==
X-Gm-Message-State: AJIora8jWSnalYluO3Nh4w4swK2FvhxuQquu6J0ARu075LhonHcSI5KG
        1KV1xHijtdcd8H86qJnDWq9oPft1adD3LIAU9JY8u6ytNw1kOg==
X-Google-Smtp-Source: AGRyM1ulLQShpWi0TR7q+/ECyVlbvYWSvlcTQ89njRa+VLyt29+PSwfe5f7JF3VM9NpYysO8gxyXP88y0iMaQHqKHtg=
X-Received: by 2002:a1f:19cf:0:b0:375:6144:dc41 with SMTP id
 198-20020a1f19cf000000b003756144dc41mr2237159vkz.3.1658676466941; Sun, 24 Jul
 2022 08:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220714145632.998355-1-zlang@kernel.org> <CAOQ4uxj-qMpoen+QVKqRRZrGjyOY6RoA7xOHWy_BEymJZi5yTw@mail.gmail.com>
 <20220724150729.qwjaenuumsevzqyg@zlang-mailbox>
In-Reply-To: <20220724150729.qwjaenuumsevzqyg@zlang-mailbox>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 24 Jul 2022 17:27:35 +0200
Message-ID: <CAOQ4uxhEfN+vnYEFSNZqQ=rotntzjMNttZodSYrmA5cqLcV62g@mail.gmail.com>
Subject: Re: [PATCH] generic: new test to verify selinux label of whiteout inode
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests <fstests@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Jul 24, 2022 at 5:07 PM Zorro Lang <zlang@kernel.org> wrote:
>
> On Thu, Jul 14, 2022 at 06:30:10PM +0200, Amir Goldstein wrote:
> >    Sorry for off list email
> >    Please add to whiteout group
>
> Oh, sure, thanks!
>
> The "whiteout" group name is described as (in doc/group-names.txt):
>
>   whiteout                overlayfs whiteout functionality
>
> I think it's not an overlayfs specific group, how about remove the
> "overlayfs" prefix?

The whiteout inode is a vfs construct that was introduced for overlayfs:

       RENAME_WHITEOUT (since Linux 3.18)
              This operation makes sense only for overlay/union filesystem
              implementations.

There is no other known usage for whiteout inode.
You could remove the "overlayfs" prefix, but that would just make the
whiteout context less clear IMO.

>
> BTW, is there anything wrong (about secret?) with this test case, to make
> you have to off list email. This looks like a normal review point ;)
>

Nope, just a technical issue when replying from my mobile.

Thanks,
Amir.
