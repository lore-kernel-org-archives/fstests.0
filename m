Return-Path: <SRS0=hV/x=3N=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A02EC2D0DB
	for <linux-fstests@archiver.kernel.org>; Fri, 24 Jan 2020 13:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D3C920718
	for <linux-fstests@archiver.kernel.org>; Fri, 24 Jan 2020 13:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="jVwGumTH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387970AbgAXNzj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 24 Jan 2020 08:55:39 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34975 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388266AbgAXNzj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 24 Jan 2020 08:55:39 -0500
Received: by mail-qt1-f194.google.com with SMTP id e12so1551511qto.2
        for <fstests@vger.kernel.org>; Fri, 24 Jan 2020 05:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nbuQC0x+Ebr4oDWOtwaDYEWK9YrkOelQsBbA+umI/zo=;
        b=jVwGumTHcAVmlIY131KKM3Gw1VFNbgync3f5Fs4p34RmxeuIMn0dDPXxMbCA75r8kJ
         B57Omvy7qe5oC5iDbk8fZXLOzdoCmo5LNf5nHoqw3xE73oNrChmMzr3rrm0s2DnHOdxb
         N+vfIrctFzfpQf0t2oTehhmysRV14C+iUNyCA8WWFHMFOZTGzvIdDekaQuu8VZVNmHc1
         tneE2/syk6kkjETJU7W6/JO+WL8UtWPOxqDn+aQFtGzyYYlRDxpYVW13Gsfthj4oc7qe
         ASncGfjA6Sw1HIN/bWWjU9i0j5fTBSVm7x0d5KauFQ7JQknkc2Ni5h15n8GAR4p+vzyE
         lv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nbuQC0x+Ebr4oDWOtwaDYEWK9YrkOelQsBbA+umI/zo=;
        b=eXZIy434WbKRRYRZQpA/Z6yWtXcBk0BsXFyySI8haAf+q2fG8LNpSThL+eLpa7nS+b
         ulmQC9u+f2KnIre6Al0FS8xr08Wg52+jR2b6wMNCWreeVjea26oU6Nkg5sfH6igojuiD
         rnzlTuAaZBmlxSx543s51ZNzqfa01HK4ccpK5SHfvF3B8jCsXVFfdzUwgcJxQXPLQiPk
         QSxF+vFv6/EKuxabCEPfBmBfjxD+8Vi1pwTjE8YhEoOJSThumF2dFkQflLTBQgrSU7VZ
         54kNRsE6jDuP46qBbAnm5x59qMogwHxg82LbVSH4B5LSBlwx1pxkwFSU91R4QkFal1lT
         DwpQ==
X-Gm-Message-State: APjAAAVrtlhEdVWOjPcVfQ6mMh26lJvuhuECHwvw4mrlLiypNSPSCmXY
        wV9Ke5wRYKCy/avfn7ALIrfgzw==
X-Google-Smtp-Source: APXvYqzyNCtjydKLwx69vNvU6PSamyU8mCxWzrh8dhp3WKVA5eRZyPX9qbdDTLiKOwMRFnnvmw1Svg==
X-Received: by 2002:ac8:3886:: with SMTP id f6mr2183114qtc.160.1579874138363;
        Fri, 24 Jan 2020 05:55:38 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::68b4])
        by smtp.gmail.com with ESMTPSA id k22sm3091117qkg.80.2020.01.24.05.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2020 05:55:37 -0800 (PST)
Subject: Re: [PATCH] btrfs: add test for incremental send for file with shared
 extents
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <20200124115213.4133-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <3863949a-5d64-9919-877d-0ee02be1b02c@toxicpanda.com>
Date:   Fri, 24 Jan 2020 08:55:36 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200124115213.4133-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 1/24/20 6:52 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that an incremental send operation works correctly when a file has
> shared extents with itself in the send snapshot, with a hole between them,
> and the file size has increased in the send snapshot.
> 
> This currently fails in 5.5-rc kernels (regression) but is fixed by a
> patch that has the following subject:
> 
>    Btrfs: send, fix emission of invalid clone operations within the same file
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
