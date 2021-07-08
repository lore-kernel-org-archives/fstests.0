Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9315AC07E96
	for <linux-fstests@archiver.kernel.org>; Thu,  8 Jul 2021 06:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AFDC61CE3
	for <linux-fstests@archiver.kernel.org>; Thu,  8 Jul 2021 06:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhGHGTC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 8 Jul 2021 02:19:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34831 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229658AbhGHGTC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 8 Jul 2021 02:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625724981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R8uFlHpACqMs3QYaGTp7zJWgMAFcSrKsvVGrVTn1px4=;
        b=YuR9UjP3PfcvHpUEILZ+OELtiGxvztlN3cbpzdTRLasMt7sADvy5GD13/lVWOrrRmZzCbz
        Cj9knFlxiuYOZhsWYjOz9+MVmJA1buHH6S+/SgN17JgoMqWZ6pENFpl6JNSARhpkJgBZ7w
        V7n2ndO/6fJG0sK1mLak5/epRCgtCP0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-_ZO4agh-P_qeSLUDAyNWlg-1; Thu, 08 Jul 2021 02:16:19 -0400
X-MC-Unique: _ZO4agh-P_qeSLUDAyNWlg-1
Received: by mail-ej1-f69.google.com with SMTP id q14-20020a1709066aceb029049fa6bee56fso1338904ejs.21
        for <fstests@vger.kernel.org>; Wed, 07 Jul 2021 23:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=R8uFlHpACqMs3QYaGTp7zJWgMAFcSrKsvVGrVTn1px4=;
        b=jaw9ljx7ROXHjIMgNWztcM19wKafzRCokL7+lhrcz72tIOtyP4JaqHYM6A+S1zWKtx
         37jB9vQd88iT7ckV5I/JmOyI5PPeXtuWbtZM20JnSCWzJFBd2PzzIwb/Ng/8xRw1fmXx
         snA92Xlfvx+U61hR6QOs2UWsHau0YXm/RwPnF5JLOKM7N9KsO4BIpaLqCDmrVNhZNa8z
         WJUE7z+AFYrQq41x8rWXhYDHmtNHOvoTnJjL9XRz3EGJn2n3b6vHqo0L0QbTbv0IJFUr
         vu9/Of88royMeexWZXqZrIVX4DsDpsupYQmhcwqJuOxtvBOb5v6yiJVZ4K4s1IwyaF3U
         InJg==
X-Gm-Message-State: AOAM531WN8AI/ugX4ktTAgFTXIfloZEk7kj8+4it7m3leQJKAqwq/MGX
        2mHCD/y11gDBt3fyLYLOSa0U0qH1oBbdoqyOqnxwMzZ+t3yu/jPWXj9gsBH4e6rFSQg8j09yWeT
        qHN/CFBK/SOmH611E5w==
X-Received: by 2002:aa7:c952:: with SMTP id h18mr34166712edt.18.1625724978385;
        Wed, 07 Jul 2021 23:16:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRfwAfx3ZDETo/um1xEJcCFdzPKA3dm3isdfsLoPTSkr+JmlloaGdZFpQGsQqyLlHL44nuXQ==
X-Received: by 2002:aa7:c952:: with SMTP id h18mr34166697edt.18.1625724978257;
        Wed, 07 Jul 2021 23:16:18 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id s10sm386767ejc.39.2021.07.07.23.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 23:16:17 -0700 (PDT)
Subject: Re: [PATCH 1/1] generic/453: Do NOT run for FSs restricting names
To:     Theodore Ts'o <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org, shreeya.patel@collabora.com
References: <20210707102007.66774-1-preichl@redhat.com>
 <20210707102007.66774-2-preichl@redhat.com> <20210707145158.GC11571@locust>
 <YOYtRXrc5EdOqcHp@mit.edu>
From:   Pavel Reichl <preichl@redhat.com>
Message-ID: <7ea4d0d4-89f9-66a0-72a9-d4c46745c5a6@redhat.com>
Date:   Thu, 8 Jul 2021 08:16:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOYtRXrc5EdOqcHp@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


On 7/8/21 12:40 AM, Theodore Ts'o wrote:
> BTW, we should probably include f2fs as a file system which normally
> allow unrestricted byte streams.  F2fs also supports casefolding, but
> again, like ext4, it's only enabled when the per-directory casefold
> flag is enabled.  So:
>
> +        case "$FSTYP" in
> +        ext2|ext3|ext4|f2fs|xfs|btrfs)
>
> I've verified that generic/453 passes on f2fs today.
>
> 				- Ted
>
Hi Ted, thanks for the info. I'll update the patch to contain f2fs.

