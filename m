Return-Path: <SRS0=Jsw6=3G=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA09C33CB1
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Jan 2020 09:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A072083E
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Jan 2020 09:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tMgT/AdC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgAQJJZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 17 Jan 2020 04:09:25 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:36453 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgAQJJZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 17 Jan 2020 04:09:25 -0500
Received: by mail-il1-f195.google.com with SMTP id b15so20741319iln.3
        for <fstests@vger.kernel.org>; Fri, 17 Jan 2020 01:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dn5tQagB3gLpHkrHNhCdyZMf++B+IAXL3lPlqkbIQ6s=;
        b=tMgT/AdCnsmYD2th7CKOX+h7VCSUlrdKhcS1/W+cDJ6AwqcH+Alw4NeuINrmByN+pJ
         0eBhqaCrv/J8KJSKYJ8Vx8Z5jBJ9EkuACYsuhrmOmVI5PTwPdjer4u4A/vBJhpLMKtkO
         w5hkaK8aRlZdWiHagKA2wsO9w3QGkBa90FL3e+RLSMGZsunQMimFE18q1Wu53w4UX0V6
         x5Tr1T6mNEbR7yblatkHQWRjikHE+scXPWhTGigG6ItOTV8i0Xg5lFvFjNVU87Y5zkjt
         TW0GOO9UcVnAeyhaj5wS9t6EAJoBhFdKiPB/UVYJshTdPkGVYWQsA9pJewyzzAADoK/X
         XN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dn5tQagB3gLpHkrHNhCdyZMf++B+IAXL3lPlqkbIQ6s=;
        b=HOGub8E9ZLI80ekQIu1ndc1uEN8a1gR2gUeP/6/kmRU+6gbmnFOJbGSfS/KdHSEvbx
         5SSHqrC7fUlsx4sZ78QveCVVQZO5YXem/Ey5gRc5u+EpDIO4RI0Z2IajThQKPtXDIkX1
         9jtFHbxFKP/qZHsniHvl4bJPke+G7Y1A8pWdVFazPSmSpxA5SfmjkFbV86hNRqvnwcfd
         j7BGj60w2RpKsty4wwgyYudPkqJ6D4mKxYEYVl48o2Qm7tZZR1M5iIFzE3EhF6EA59fZ
         pONrFcxfJcv4CmJ/qxgGQflHVFozewvRvlhtqWHlbcDpLsOot3R+35P6MUZ9uShB/Zkn
         NxKg==
X-Gm-Message-State: APjAAAUmVir4zwcCChx+Je6+quXtSntbAvu0sSs6CWF5NTnfjuXkHZzj
        ajU0FIjJLtKOIDPRYuwksrsbIplBpGwhtJWlh0UPJA==
X-Google-Smtp-Source: APXvYqzIGdjAckL7spDggpb+fbSXrZSu8pmtwQntbi3cxToDyDb2IP5EjeiW2MvDlB9naVZZIMzwdz81Ry2sxE1UTxo=
X-Received: by 2002:a92:9f1a:: with SMTP id u26mr2256403ili.72.1579252164319;
 Fri, 17 Jan 2020 01:09:24 -0800 (PST)
MIME-Version: 1.0
References: <CABeXuvr74C0DS-K4_us4CdPPFxp=7RHmCHAZQQmJrh=PZfux-w@mail.gmail.com>
 <20191228221317.16654-1-deepa.kernel@gmail.com> <CAOQ4uxifpjjirTyUsCm03TFx8LOvkt0xX+RNyFZU5sHNU+bfqA@mail.gmail.com>
 <20200108080936.GG893866@desktop> <CAOQ4uxhOGZfLch1HDFACD9fLczpLHxVMoY50ZyJDOyAJBp-WyQ@mail.gmail.com>
 <20200108095021.GH893866@desktop>
In-Reply-To: <20200108095021.GH893866@desktop>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 17 Jan 2020 11:09:13 +0200
Message-ID: <CAOQ4uxg7cu5eYskPAEhGrB6MWrt9rzdg1+EadGBOBSmw7iN6hA@mail.gmail.com>
Subject: Re: [PATCH v2] generic/402: Make timestamp range check conditional
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Eryu Guan <guaneryu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

> > I understand why you dislike the ext2+loop test, but please hear me out.
> >
> > From all the fs types that are supported by the test, only btrfs and ext4 with
> > large inode size are y2038 ready.
> > For the rest of the cases, we actually have a way to detect kernel support
> > from the dmesg warning, without the need for hacky ext2 loop mount.
> >
> > So how about just:
> > 1. moving  _scratch_mount before _require_timestamp_range
> > 2. in _require_timestamp_range (untested):
> >         if [ $tsmax -lt $((1<<32)) ] && ! _check_dmesg_for "supports
>
> Yeah, this looks fine. I thought about searching for dmesg warning after
> _scratch_mount as well, but that would _notrun if the fs is 2038-safe.
> This $tsmax check fixes my concern. Thanks!
>

Deepa,

Do you intend to post the simplified version or would you like me
to re-spin your patch?

Thanks,
Amir.
